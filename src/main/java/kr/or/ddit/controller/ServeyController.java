package kr.or.ddit.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.ISurveyService;
import kr.or.ddit.utils.excel.ExcelRead;
import kr.or.ddit.utils.excel.ExcelReadOption;
import kr.or.ddit.vo.ExampleQuestionVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.SurveyQuestionChoiceVO;
import kr.or.ddit.vo.SurveyQuestionVO;
import kr.or.ddit.vo.SurveyResultVO;
import kr.or.ddit.vo.SurveyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class ServeyController {
	//설문조사 관련
	
	// 설문조사 목록
	// 설문조사 상세?
	// 설문조사 참여
	// 설문조사 등록
	// 설문조사 결과
	
	// 이 밑으로 구현 ============================================
	
	
	@Inject
	private ISurveyService surveyService;
	
	// 설문조사 리스트 
	@RequestMapping("/surveyList.do")
	public String surveyList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "name") String searchType,
			@RequestParam(required = false) String searchType2,
			@RequestParam(required = false) String searchWord, 
			HttpServletRequest req, Model model) {

		
		HttpSession session = req.getSession();
		
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		log.debug("searchType2 :"+searchType2);
		log.debug("searchWord :"+searchWord);
		log.debug("searchType :"+searchType);
	
		PaginationVO<SurveyVO> pagingVO = new PaginationVO<SurveyVO>();

		pagingVO.setMemNo(member.getMemNo());
		
		// 검색
		if (StringUtils.isNotBlank(searchWord)) {
			if(StringUtils.isNotBlank(searchType2)) {
				pagingVO.setSearchType(searchType2);
			}else {
				pagingVO.setSearchType(searchType);
			}
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchType2", searchType2);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = surveyService.surveyListCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<SurveyVO> datList = surveyService.surveyList(pagingVO);
		pagingVO.setDataList(datList);
		
		String memRole = member.getMemRole();
		
		model.addAttribute("memRole",memRole);
		model.addAttribute("pagingVO", pagingVO);
		
		log.info("srv : " + pagingVO.getDataList());
		
		return "student/surveyList";
	}
	
	// 설문조사 리스트
	@RequestMapping("/surveyResult.do")
	public String surveyResult(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "name") String searchType,
			@RequestParam(required = false) String searchWord, 
			HttpServletRequest req, Model model) {

		
		HttpSession session = req.getSession();
		
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		
		log.debug("searchWord :"+searchWord);
		log.debug("searchType :"+searchType);
		
		PaginationVO<SurveyVO> pagingVO = new PaginationVO<SurveyVO>();

		// 검색
		if (StringUtils.isNotBlank(searchWord)) {
				pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = surveyService.srvMntListCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<SurveyVO> datList = surveyService.srvMntList(pagingVO);
		pagingVO.setDataList(datList);
		
		String memRole = member.getMemRole();
		
		model.addAttribute("memRole",memRole);
		model.addAttribute("pagingVO", pagingVO);
		
		return "employer/surveyList";
	}
	
	// 설문조사 상세 / 차트
	@GetMapping("/surveyResultDetail.do/{srvNo}")
	public String srvResDetail(@PathVariable("srvNo") int srvNo, Model model ) {
		
		//SurveyVO surveyVO = surveyService.getSurveyResult(srvNo);
		model.addAttribute("srvNo", srvNo);
		
		return "employer/surveyChart";
	}
	
	
	@RequestMapping("/surveyView.do")
	public String surveyDetailtForm (HttpServletRequest req, 
			Model model, int srvNo) {		
		log.debug("srvNo : " +srvNo);
		
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		HttpSession session = req.getSession();		
		MemberVO member = (MemberVO) session.getAttribute("member");
		String memRole = member.getMemRole();

		SurveyVO surveyVO = surveyService.getSurvey(srvNo);
		
		model.addAttribute("surveyVO", surveyVO);
		
		int maxQstChLen = 2;
		for(SurveyQuestionVO srvQst : surveyVO.getSrvQstList()) {
			if(maxQstChLen < srvQst.getSrvQstChList().size()) {
				maxQstChLen = srvQst.getSrvQstChList().size();
			}
		}
		model.addAttribute("maxQstChLen", maxQstChLen);
		model.addAttribute("memRole", memRole);
		return "student/surveyView";
	
	}

	//설문 조사 등록 페이지
	@GetMapping("/surveyManagementForm.do")
	public String serveyForm() {
		
		return "employer/surveyManagementForm";
	}
	
	
	
	
	// 비동기 처리 =========================================
	
	
	//차트 데이터 가져오기
	@ResponseBody
	@GetMapping("/surveyDetail.ajax")
	public ResponseEntity<SurveyVO> srvDetail(int srvNo) {
		log.info("srvNo : " + srvNo);
		
		SurveyVO surveyVO = surveyService.getSurveyResult(srvNo);
		int srvRegCount = surveyService.getResultTotalCnt(srvNo);
		surveyVO.setSrvRegCount(srvRegCount);
		
		return new ResponseEntity<SurveyVO>(surveyVO, HttpStatus.OK);
	}
	
	
	//설문 조사 등록 폼
	@ResponseBody
	@PostMapping("/surveyUpload")
	public String serveyUpload(@RequestBody SurveyVO surveyVO,
			HttpServletRequest req) {
		log.info("exampleUpload() run...");
		log.info("ExampleVO : " + surveyVO);
		
		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");
		int memNo = memberVO.getMemNo();
		surveyVO.setMemNo(memNo);
		
		ServiceResult res = surveyService.addSurvey(surveyVO);
		
		return res.toString();
	}
	
	
	//설문 일괄 생성
	@ResponseBody
	@RequestMapping(value = "/surveyExcelUpload.do", method = RequestMethod.POST)
	public ResponseEntity<List<SurveyQuestionVO>> excelUploadAjax(MultipartHttpServletRequest request) throws Exception{
		log.info("excelUploadAjax() run...");
		
		String result = "failed";
	    MultipartFile excelFile = request.getFile("excelFile");
	    List<SurveyQuestionVO> examQstList = new ArrayList<SurveyQuestionVO>();
	    
	    try {
	        if(excelFile != null || !excelFile.isEmpty()) {
	            File destFile = new File("D:\\"+excelFile.getOriginalFilename()); // 파일위치 지정
	            excelFile.transferTo(destFile); // 엑셀파일 생성
	            
	            ExcelReadOption excelReadOption = new ExcelReadOption();
	            excelReadOption.setFilePath(destFile.getAbsolutePath()); //파일경로 추가
	            excelReadOption.setOutputColumns("A", "B", "C", "D", "E", "F", "G", "H", "I"); //추출할 컬럼명 추가
	            excelReadOption.setStartRow(2); //시작행(헤더부분 제외)
	            
	            List<Map<String, String>> excelContent  = ExcelRead.read(excelReadOption);
	            //log.info("excelContent : " + excelContent);
	            
	            if(excelContent.isEmpty()) {
	            	return new ResponseEntity<List<SurveyQuestionVO>>(examQstList, HttpStatus.OK);
	            }
	            
	            for(Map<String, String> article : excelContent){
	            	log.info("article : " + article);
	            	
	            	SurveyQuestionVO examQstVO = new SurveyQuestionVO();
	            	examQstVO.setSrvQst(article.get("B"));
	            	
	            	List<SurveyQuestionChoiceVO> qstChList = new ArrayList<SurveyQuestionChoiceVO>();
	            	
	            	qstChList.add(new SurveyQuestionChoiceVO(article.get("C")));
	            	qstChList.add(new SurveyQuestionChoiceVO(article.get("D")));
	            	qstChList.add(new SurveyQuestionChoiceVO(article.get("F")));
	            	qstChList.add(new SurveyQuestionChoiceVO(article.get("G")));
	            	qstChList.add(new SurveyQuestionChoiceVO(article.get("H")));
	            	qstChList.add(new SurveyQuestionChoiceVO(article.get("I")));
	            	
	            	examQstVO.setSrvQstChList(qstChList);
	            	
	            	examQstList.add(examQstVO);
	            }        

	            destFile.delete(); // 업로드된 엑셀파일 삭제
	        }else {
	        	return new ResponseEntity<List<SurveyQuestionVO>>(HttpStatus.BAD_REQUEST);
	        }
	    }catch(Exception e) {
	        e.printStackTrace();
	    } 
		
	    return new ResponseEntity<List<SurveyQuestionVO>>(examQstList, HttpStatus.OK);
	}
	
	

	// 학생 설문 응답
	@ResponseBody
	@PostMapping("/suryAnswerForm.do")
	public String suryAnswer (
			HttpServletRequest req ,
			@RequestBody List<SurveyResultVO> surveyResultList ) {
		log.debug("surveyResultList ::"+ surveyResultList);
		
		MemberVO member = (MemberVO) req.getSession().getAttribute("member");
		
		int memNo = member.getMemNo();
		
		ServiceResult res = surveyService.addSurveyAnswer(memNo,surveyResultList);
		
		return res.toString();
	}
	
	
	
}
