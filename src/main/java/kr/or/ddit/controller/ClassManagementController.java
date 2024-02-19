package kr.or.ddit.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.entity.FileType;
import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.IClassManagementService;
import kr.or.ddit.service.IClassService;
import kr.or.ddit.service.IFileService;
import kr.or.ddit.utils.UploadFileUtils;
import kr.or.ddit.utils.excel.ExcelRead;
import kr.or.ddit.utils.excel.ExcelReadOption;
import kr.or.ddit.vo.AttendVO;
import kr.or.ddit.vo.ClassBoardVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.ExamAnswerVO;
import kr.or.ddit.vo.ExampleQuestionVO;
import kr.or.ddit.vo.ExampleVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.HomeworkSubmitVO;
import kr.or.ddit.vo.HomeworkVO;
import kr.or.ddit.vo.LectureRatingVO;
import kr.or.ddit.vo.ListenerRatingVO;
import kr.or.ddit.vo.ListenerVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.MyClassVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.QuestionChoiceVO;
import kr.or.ddit.vo.ScoreValueVO;
import kr.or.ddit.vo.TotalScoreVO;
import kr.or.ddit.vo.TrainingVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class ClassManagementController {

	@Inject
	private IClassManagementService classManagementService;
	
	@Inject
	private IClassService classService;
	
	@Inject
	private IFileService fileService;
	
	//교수 > 내 강의 목록
	@RequestMapping(value = "/myProgressClassList.do")
	public String myProgressClassList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "semester") String searchType,
			@RequestParam(required = false) String searchWord, 
			Model model, HttpServletRequest req
			) {
		
		PaginationVO<ClassVO> pagingVO = new PaginationVO<ClassVO>();
		
		pagingVO.setScreenSize(7);
		pagingVO.setMainscreenSize(7);
		
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		MemberVO member = (MemberVO) req.getSession().getAttribute("member");
		
		int memNo = member.getMemNo();
		
		int totalRecord = classManagementService.managementCnt(pagingVO, memNo);
		pagingVO.setTotalRecord(totalRecord);
		
		List<ClassVO> myClassList = classManagementService.progressClassList(pagingVO, memNo);
		pagingVO.setDataList(myClassList);
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("myClassList", myClassList);
		
		return "professor/myClassList";
	}
	
	// 교수 > 내 강의 상세
	@GetMapping("/managementClassRoom/{classNo}")
	public String progressClassRoom(@PathVariable("classNo") int classNo, Model model) {
		
		//내 강의 정보
		MyClassVO myClassVO = classService.getMyLecture(classNo);
		model.addAttribute("myClassVO", myClassVO);
		
		//강의자료실
		List<ClassBoardVO> classBoardList = classService.getClassBoardList(classNo);
		model.addAttribute("classBoardList", classBoardList);
		
		//강의 과제
		List<HomeworkVO> homeworkList = classService.getHomeworkList(classNo);
		model.addAttribute("homeworkList", homeworkList);
		
		//온라인 시험
		List<ExampleVO> exampleList = classManagementService.getExampleList(classNo);
		model.addAttribute("exampleList", exampleList);
		
		// 출석목록 리스트 
		List<ListenerVO> myClassCheck = classManagementService.myClassCheck(classNo);
		log.debug("myClassCheck::" + myClassCheck);
		model.addAttribute("myClassCheck", myClassCheck);
		
		//현장실습
		List<TrainingVO> trainingList = classService.getTrainingList(classNo);
		model.addAttribute("trainingList", trainingList);
		
		return "professor/classRoom";
	}
	
	//강의 자료 등록
	@PostMapping("/class/classBrdForm.do")
	public String classBrdUpload(ClassBoardVO classBoardVO, HttpServletRequest req,
			RedirectAttributes ra
			) {
		
		log.info("classBrdUpload > classBoardVO : " + classBoardVO);
		
		List<FilesVO> filesList = new ArrayList<FilesVO>();
		
		System.out.println("filesList v : " + classBoardVO.getFileList());
		
		
		//파일 업로드
		try {
			if(classBoardVO.getFileList() != null && classBoardVO.getFileList().size() > 0) {
				for (int i=0; i<classBoardVO.getFiles().length; i++) {
					FilesVO filesVO = UploadFileUtils.uploadFile(classBoardVO.getFiles()[i], FileType.BOARD, req, classBoardVO.getClassNo());
					filesVO.setFileGroupNo(i + 1);
					filesList.add(filesVO);
				}
				if(classBoardVO.getFiles().length != filesList.size()) {
					throw new Exception();
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			ra.addFlashAttribute("message", "파일 등록에 실패하였습니다");
			return "redirect:/DYUniv/managementClassRoom/" + classBoardVO.getClassNo();
		}
		
		classBoardVO.setFileList(filesList);
		
		//자료실 정보 등록
		ServiceResult res = classManagementService.addClassBrd(classBoardVO);
		
		if(res.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "저장에 성공하였습니다");
		} else {
			ra.addFlashAttribute("message", "저장에 실패하였습니다");
		}
		
		return "redirect:/DYUniv/managementClassRoom/" + classBoardVO.getClassNo();
	}
	
	//과제 등록
	@PostMapping("/class/addHomework.do")
	public String addHomework(
			HttpServletRequest req,
			RedirectAttributes ra,
			HomeworkVO hwVO
			) {
		
		log.info("addHomework() run...");
		
		log.info("hwVO : " + hwVO);
		
		List<FilesVO> filesList = new ArrayList<FilesVO>();
		
		try {
			//과제 정보 업로드
			if(hwVO.getFileList() != null && hwVO.getFileList().size() > 0) {
				for (int i=0; i<hwVO.getFiles().length; i++) {
					FilesVO filesVO = UploadFileUtils.uploadFile(hwVO.getFiles()[i], FileType.HOMEWORK, req, hwVO.getClassNo());
					filesVO.setFileGroupNo(i + 1);
					filesList.add(filesVO);
				}
				
				if(hwVO.getFiles().length != filesList.size()) {
					throw new Exception();
				}
			} 
		} catch (Exception e) {
			e.printStackTrace();
			ra.addFlashAttribute("message", "파일 등록에 실패하였습니다");
			return "redirect:/DYUniv/managementClassRoom/" + hwVO.getClassNo();
		}
		
		hwVO.setFileList(filesList);
		
		//자료실 정보 등록
		ServiceResult res = classManagementService.addClassHomework(hwVO);
		
		if(res.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "저장에 성공하였습니다");
		} else {
			ra.addFlashAttribute("message", "저장에 실패하였습니다");
		}
		
		return "redirect:/DYUniv/managementClassRoom/" + hwVO.getClassNo();
	}
	
	//과제 제출 목록
	@GetMapping("/class/homeworkScoreForm/{classNo}")
	public String classScoreForm(@PathVariable int classNo, Model model) {
		log.info("classScoreForm() run...");
		
		//내 강의 정보
		MyClassVO myClassVO = classService.getMyLecture(classNo);
		model.addAttribute("myClassVO", myClassVO);
		
		//과제 목록
		List<HomeworkVO> homeworkList = classService.getHomeworkList(classNo);
		model.addAttribute("homeworkList", homeworkList);
		model.addAttribute("classNo", classNo);
		
		return "professor/homeworkSubmitList";
	}
	
	@RequestMapping("/class/examManagement/{classNo}")
	public String exampleForm(Model model,@PathVariable("classNo") int classNo) {
		
		//내 강의 정보
		MyClassVO myClassVO = classService.getMyLecture(classNo);
		model.addAttribute("myClassVO", myClassVO);
		
		//온라인 시험 목록
		List<ExampleVO> exampleList = classManagementService.getExampleList(classNo);
		model.addAttribute("exampleList", exampleList);
		
		return "professor/exampleManagementForm";
	}
	
	@GetMapping("/student/class/myClassScore.do")
	public String classScore(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		
		MemberVO memberVO = (MemberVO)session.getAttribute("member");
		
		int memNo = memberVO.getMemNo();
		
		List<MyClassVO> listenList = classService.getMyLectureList(memNo);
		model.addAttribute("listenList", listenList);
		
		return "student/myClassScoreList";
	}
	
	//강의 평가
	@GetMapping("/class/rating/{classNo}")
	public String rating(@PathVariable("classNo") int classNo, Model model,
			HttpServletRequest req) {
		
		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");
		int memNo = memberVO.getMemNo();
		
		ListenerVO listenerVO = new ListenerVO();
		listenerVO.setMemNo(memNo);
		listenerVO.setClassNo(classNo);
		listenerVO = classManagementService.getListener(listenerVO);
		//강의 정보
		model.addAttribute("listenerVO", listenerVO);
		
		return "student/classRating";
	}
	
	
	
	
	
	
	// 비동기 처리 ==========================================
	
	//강의 평가 등록
	@PostMapping("/class/ratingForm.do")
	public ResponseEntity<ServiceResult> classRatingForm(@RequestBody ListenerRatingVO listenerRatingVO,
			HttpServletRequest req) {
		log.info("classRatingForm() run...");
		log.info("data :" + listenerRatingVO);
		
		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");
		int memNo = memberVO.getMemNo();
		listenerRatingVO.setMemNo(memNo);
		listenerRatingVO.setLsStatusCode("LSS004");
		
		ServiceResult res = classManagementService.addLectureRating(listenerRatingVO);
		
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
	
	// 출석 체크 등록 
	@ResponseBody
	@PostMapping("/class/attendCheck.do")
	public ResponseEntity<Integer> attendCheck(@RequestBody List<AttendVO> attendList
			,HttpServletRequest req){
		log.debug("A :"+ attendList);
		
		HttpSession session = req.getSession();
		
		int atCnt = classManagementService.attendCheck(attendList);
		
		return new ResponseEntity<Integer>(atCnt, HttpStatus.OK);
	}
	
	
	//과제 제출자 목록
	@ResponseBody
	@PostMapping("/class/hwSubmitList")
	public ResponseEntity<List<HomeworkSubmitVO>> hwSubList(@RequestParam int hwNo) {
		
		List<HomeworkSubmitVO> hwList = classManagementService.getHwSubList(hwNo);
		
		return new ResponseEntity<List<HomeworkSubmitVO>>(hwList, HttpStatus.OK);
	}
	
	//과제 제출자 목록
	@ResponseBody
	@PostMapping("/class/exSubmitList")
	public ResponseEntity<List<ExamAnswerVO>> exSubList(@RequestParam int examNo) {
		
		List<ExamAnswerVO> exList = classManagementService.getExSubList(examNo);
		
		return new ResponseEntity<List<ExamAnswerVO>>(exList, HttpStatus.OK);
	}
	
	// 과제 점수 업로드
	@ResponseBody
	@PostMapping("/class/hwSubmitScoreForm")
	public ResponseEntity<ServiceResult> scoreForm(
			@RequestBody List<Map<String, Integer>> hwDataList) {
		
		log.info("hwDataList : " + hwDataList);
		
		ServiceResult res = ServiceResult.FAILED;
		
		if(hwDataList != null && hwDataList.size() > 0) {
			List<HomeworkSubmitVO> hwSubList = new ArrayList<HomeworkSubmitVO>();
			
			for(int i=0; i<hwDataList.size(); i++) {
				HomeworkSubmitVO hwSubVO = new HomeworkSubmitVO();
				hwSubVO.setHwSbNo(hwDataList.get(i).get("hwSbNo"));
				hwSubVO.setHwScore(hwDataList.get(i).get("hwScore"));
				
				hwSubList.add(hwSubVO);
			}
			
			log.info("hwSubList : " + hwSubList);
			res = classManagementService.updateHwScore(hwSubList);
		}
		
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
	
	//시험 출제 파일 업로드
	@ResponseBody
	@PostMapping(value = "/examFileUpload.ajax")
	public ResponseEntity<Integer> uploadExamFile(MultipartFile files, HttpServletRequest req){
		log.info("uploadExamFile() run...");
		log.info("file : " + files);
		
		FilesVO filesVO;
		try {
			filesVO = UploadFileUtils.uploadFile(files, FileType.CLASS, req);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		fileService.uploadFile(filesVO);
		int fileNo = filesVO.getFileNo();
		
		return new ResponseEntity<Integer>(fileNo, HttpStatus.OK);
	}
	
	//시험 등록
	@ResponseBody
	@PostMapping("/exampleUpload")
	public String exampleUpload(@RequestBody ExampleVO exampleVO) {
		log.info("exampleUpload() run...");
		log.info("ExampleVO : " + exampleVO);
		
		ServiceResult res = classManagementService.addExample(exampleVO);
		
		return res.toString();
	}
	
	//시험 문제 일괄 생성
	@ResponseBody
	@RequestMapping(value = "/examExcelUpload.do", method = RequestMethod.POST)
	public ResponseEntity<List<ExampleQuestionVO>> excelUploadAjax(MultipartHttpServletRequest request) throws Exception{
		log.info("excelUploadAjax() run...");

	    MultipartFile excelFile = request.getFile("excelFile");
	    
	    List<ExampleQuestionVO> examQstList = getExcelData(excelFile);
		
	    return new ResponseEntity<List<ExampleQuestionVO>>(examQstList, HttpStatus.OK);
	}
	
	public List<ExampleQuestionVO> getExcelData(MultipartFile excelFile) {
		List<ExampleQuestionVO> examQstList = new ArrayList<ExampleQuestionVO>();
		try {
	        if(excelFile != null || !excelFile.isEmpty()) {
	            File destFile = new File("D:\\"+excelFile.getOriginalFilename()); // 파일위치 지정
	            excelFile.transferTo(destFile); // 엑셀파일 생성
	            
	            ExcelReadOption excelReadOption = new ExcelReadOption();
	            excelReadOption.setFilePath(destFile.getAbsolutePath()); //파일경로 추가
	            excelReadOption.setOutputColumns("A", "B", "C", "D", "E", "F", "G", 
	            			"H", "I", "J", "K","L", "M", "N"); //추출할 컬럼명 추가
	            excelReadOption.setStartRow(2); //시작행(헤더부분 제외)
	            
	            List<Map<String, String>> excelContent  = ExcelRead.read(excelReadOption);
	            //log.info("excelContent : " + excelContent);
	            
	            if(excelContent.isEmpty()) {
	            	return examQstList;
	            }
	            
	            for(Map<String, String> article : excelContent){
	            	ExampleQuestionVO examQstVO = new ExampleQuestionVO();
	            	examQstVO.setExamQst(article.get("B"));
	            	examQstVO.setQstScore(Integer.parseInt(article.get("C")));
	            	examQstVO.setQstCorrect(article.get("D"));
	            	
	            	List<QuestionChoiceVO> qstChList = new ArrayList<QuestionChoiceVO>();
	            	
	            	qstChList.add(new QuestionChoiceVO(article.get("E")));
	            	qstChList.add(new QuestionChoiceVO(article.get("F")));
	            	qstChList.add(new QuestionChoiceVO(article.get("G")));
	            	qstChList.add(new QuestionChoiceVO(article.get("H")));
	            	qstChList.add(new QuestionChoiceVO(article.get("I")));
	            	qstChList.add(new QuestionChoiceVO(article.get("J")));
	            	qstChList.add(new QuestionChoiceVO(article.get("K")));
	            	qstChList.add(new QuestionChoiceVO(article.get("L")));
	            	qstChList.add(new QuestionChoiceVO(article.get("M")));
	            	qstChList.add(new QuestionChoiceVO(article.get("N")));
	            	
	            	examQstVO.setQstChList(qstChList);
	            	
	            	examQstList.add(examQstVO);
	            }        
	            destFile.delete(); // 업로드된 엑셀파일 삭제
	        }
	    }catch(Exception e) {
	        e.printStackTrace();
	    } 
		return examQstList;
	}
	
	// 성적 확정 화면 
	@GetMapping("/professor/scoreSetting.do")
	public String scoreSetting(Model model, HttpServletRequest req) {
		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");
		
		// 강의List
		List<ClassVO> myClassList = classManagementService.scoreSetting(memberVO.getMemNo());
		model.addAttribute("myClassList", myClassList);	
		
		return "professor/scoreSetting";
	}
	
	// 성적 관리
	@ResponseBody
	@GetMapping(value="/professor/totalScore.ajax/{classNo}", produces = "application/json;charset=utf-8")
	public ResponseEntity<TotalScoreVO> totalScore(@PathVariable int classNo){
		log.info("classNo ==> " + classNo);
		
		List<ListenerVO> listenerList = classManagementService.listenerList(classNo);		// 수강생
		List<ListenerVO> examScoreList = classManagementService.examScoreList(classNo);		// 시험점수
		List<ListenerVO> hwScoreList = classManagementService.hwScoreList(classNo);			// 과제점수
		List<Map<String, Object>> atScoreMap = classManagementService.atScoreList(classNo);	// 출석현황
		
		Integer examStandardScore = classManagementService.examStandartScore(classNo);		// 기준점수(시험)
		Integer hwStandardScore = classManagementService.hwStandartScore(classNo);			// 기준점수(시험)
		
//		Map<String,List<ListenerVO>> totalScore = new HashMap<String, List<ListenerVO>>();
		
//		totalScore.put("listenerList", listenerList);
//		totalScore.put("examScoreList", examScoreList);
//		totalScore.put("hwScoreList", hwScoreList);
//		totalScore.put("atScoreList", atScoreMap);
		
		TotalScoreVO totalScoreVO = new TotalScoreVO();
		totalScoreVO.setListenerList(listenerList);
		totalScoreVO.setHwScoreList(hwScoreList);
		totalScoreVO.setExamScoreList(examScoreList);
		totalScoreVO.setExamStandardScore(examStandardScore);
		totalScoreVO.setHwStandardScore(hwStandardScore);
		
		for(int i = 0; i < atScoreMap.size(); i++) {
			Map<String, Object> params = atScoreMap.get(i);
			if(!params.containsKey("ATS001"))
				params.put("ATS001", "0");
			if(!params.containsKey("ATS002"))
				params.put("ATS002", "0");
			if(!params.containsKey("ATS003"))
				params.put("ATS003", "0");
			if(!params.containsKey("ATS004"))
				params.put("ATS004", "0");
			atScoreMap.set(i, params);
		}
		
		totalScoreVO.setAtScoreMap(atScoreMap);		
		
		
		// 학점 비율 리스트
		ScoreValueVO scoreValueVO = classManagementService.getScoreVal(classNo);
		totalScoreVO.setScoreValueVO(scoreValueVO);
		
		System.out.println("listenerList" + listenerList);
		System.out.println("examScoreList" + examScoreList);
		System.out.println("hwScoreList" + hwScoreList);
		System.out.println("atScoreList" + atScoreMap);
		
		return new ResponseEntity<TotalScoreVO>(totalScoreVO, HttpStatus.OK);
	}
	
	// 학점 저장
	@ResponseBody
	@PutMapping("/professor/updateScore.ajax")
	public ResponseEntity<String> updateScore(@RequestBody Map<String, Object> paramMap) {
		
		log.info("updateScore() run.. ");
		log.info("paramMap : " + paramMap);
		
		List<ListenerVO> listenerList = (List<ListenerVO>) paramMap.get("arrStr");
		
		ServiceResult result = classManagementService.updateScore(listenerList);
		
		return new ResponseEntity<String>(result.toString(), HttpStatus.OK);
	}
	
	
	
}
