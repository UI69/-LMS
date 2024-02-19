package kr.or.ddit.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.apache.commons.lang3.StringUtils;
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

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.IBoardService;
import kr.or.ddit.service.IClassManagementService;
import kr.or.ddit.service.IClassService;
import kr.or.ddit.service.IMemberService;
import kr.or.ddit.service.IUnivManagementService;
import kr.or.ddit.service.IWidgetService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.MemberProVO;
import kr.or.ddit.vo.MemberStdInsVO;
import kr.or.ddit.vo.MemberStdVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.UnivScheduleVO;
import kr.or.ddit.vo.WidgetVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class MemberController {

	// 회원 정보 관련
	// 휴복학, 알림, 일정, 위젯 등

	// 학생 목록
	// 신입생 목록
	// 교수 목록

	// 학생 정보 상세
	// 교수 목록
	// 교수 정보 상세

	// 신입생 아이디 생성

	// 등록금 내역
	// 장학금 내역

	// 학적 변경 신청
	// 전과 신청

	// 일정 목록
	// 일정 등록
	// 일정 삭제

	// 이 밑으로 구현 ============================================

	@Inject
	private IMemberService memberService;
	@Inject
	private IBoardService boardService;
	@Inject
	private IUnivManagementService univService;
	@Inject
	private IWidgetService widgetService;
	@Inject
	private IClassService classService;
	
	
	// 신입생 목록
	
	 // @GetMapping("/employer/stuList.do") public String newStuList(Model model) {
	 // List<MemberVO> memList = memberService.newStuList();
	 // model.addAttribute("newStuList", memList);
	  
	//  System.out.println("dddddd" + memList.toString());
	  
 // return "employer/newStudentList"; }
	  
	
	// 신입생 목록
	@GetMapping("/employer/stuList.do")
	public String stdBoard(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "memName") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model) {
		log.info("stuList() run...");
	
		PaginationVO<MemberVO> pagingVO = new PaginationVO<MemberVO>();
		
		// 검색
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
			log.info("searchType:"+searchType);
			log.info("searchWord:"+searchWord);
			
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = memberService.academicPCountStd(pagingVO);	// 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		
		model.addAttribute("totalRecord", totalRecord);
		
		//log.info("tot : " + totalRecord);
		
		List<MemberVO> dataList = memberService.stdacademicPList(pagingVO);
		pagingVO.setDataList(dataList);
		pagingVO.setSearchWord(searchWord);
		
		log.info("dataList 값 => {}", dataList);
		
		
		model.addAttribute("pagingVO", pagingVO);
		
		log.info("pagingVO 값 => {}", pagingVO);
		
		return "employer/newStudentList";
	}
	
	// 교수 목록
	@GetMapping("/employer/proList.do")
	public String proBoard(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "memName") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model) {
		log.info("proBoard() run...");
	
		PaginationVO<MemberVO> pagingVO = new PaginationVO<MemberVO>();
		
		// 검색
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
			log.info("searchType:"+searchType);
			log.info("searchWord:"+searchWord);
			
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = memberService.academicPCountPro(pagingVO);	// 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);
		
		model.addAttribute("totalRecord", totalRecord);
		
		//log.info("tot : " + totalRecord);
		
		List<MemberVO> dataList = memberService.proacademicPList(pagingVO);
		pagingVO.setDataList(dataList);
		pagingVO.setSearchWord(searchWord);
		
		log.info("dataList 값 => {}", dataList);
		
		
		model.addAttribute("pagingVO", pagingVO);
		
		log.info("pagingVO 값 => {}", pagingVO);
		
		return "employer/proList";
	}
	
	// 교수 계정 생성 화면
	@GetMapping("employer/createProIDForm.do")
	public String createProIDForm(Model model) {
		List<MemberVO> dprtList = memberService.departmentList();	// 단과대학 조회	
		model.addAttribute("dprtList", dprtList);
		//System.out.println("dprtList : " + dprtList.toString());
		return "employer/createProID";
	}
	
	// 학생 계정 생성 화면
	@GetMapping("employer/createStuIDForm.do")
	public String createStdIDForm(Model model) {
		List<MemberVO> dprtList = memberService.departmentList();	// 단과대학 조회	
		model.addAttribute("dprtList", dprtList);
		//System.out.println("dprtList : " + dprtList.toString());
		return "employer/createStuID";
	}
	
	// 단과대학 조회
	@ResponseBody
	@GetMapping("/employer/selectDprt/{dprtCategory}")
	public List<DepartmentVO> selectDprt(@PathVariable String dprtCategory) {
		log.info("selectDprt() run...");
		log.info("dprtCategory : " + dprtCategory);
		
		DepartmentVO departmentVO = new DepartmentVO();
		departmentVO.setDprtCategory(dprtCategory);
		//System.out.println("departmentVO : " + departmentVO);
		
		return memberService.selectDprt(departmentVO);
	}
	
  // 교수 계정 생성
   @PostMapping("/employer/createProID.do")
   public String createProID(Model model, MemberProVO memberVO, RedirectAttributes ra) {   
      log.info("createProID() 실행..!");
      
      String goPage = "employer/createProID";
      
      memberVO.setMemRole("ROL002");
      memberVO.setMemProCode("MPR002");
      String bir = memberVO.getMemBir();
      String pwStr = bir.replaceAll("-", "").substring(2,8);
      memberVO.setMemPw(pwStr);
      
      log.info("memberVO : " + memberVO);
      
      ServiceResult res = memberService.createProID(memberVO);
      if(res.equals(ServiceResult.OK))
      {   
         //goPage = "redirect:/DYUniv/employer/createProID.do?memNo="+memberVO.getMemNo();
         goPage = "redirect:/DYUniv/employer/proList.do";
         ra.addFlashAttribute("message", "계정이 생성되었습니다.");
      } else {		// 등록 실패
         model.addAttribute("memberVO", memberVO);
         model.addAttribute("message", "서버에러");
      }
      return goPage;
   }

	// 학생 계정 생성
	@PostMapping("/employer/createStuID.do")
	public String createStuID(Model model, MemberStdInsVO memberVO, RedirectAttributes ra) {	
		String goPage = "redirect:/DYUniv/employer/createStuID.do";
    
	    memberVO.setMemRole("ROL001");
	    memberVO.setMemStatusCode("MEM001");
	    String bir = memberVO.getMemBir();
	    String pwStr = bir.replaceAll("-", "").substring(2,8);
	    memberVO.setMemPw(pwStr);
	    
	    log.info("memberVO : " + memberVO);
	    
	    ServiceResult res = memberService.createStdID(memberVO);
	    if(res.equals(ServiceResult.OK))
	    {   
	       //goPage = "redirect:/DYUniv/employer/createProID.do?memNo="+memberVO.getMemNo();
	       goPage = "redirect:/DYUniv/employer/stuList.do";
	       ra.addFlashAttribute("message", "계정이 생성되었습니다.");
	    } else {		// 등록 실패
	       model.addAttribute("memberVO", memberVO);
	       model.addAttribute("message", "서버에러");
	    }
	    return goPage;
	}

	// 메인페이지 + 위젯(처음 생성해줄때 사용)
	@GetMapping("/mainpage.do")
	public String mainPageStd(Model model, HttpServletRequest request) throws Exception {
		log.info("mainPageStd() run...");
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");

		List<WidgetVO> widgetList = widgetService.widgetList(member.getMemNo());

		if (widgetList == null || widgetList.size() == 0) {
			log.info("신입 등장");

			List<WidgetVO> widget = new ArrayList<>();
			if (!member.getMemRole().equals("ROL003")) { // 관리자에는 수강시간표 위젯이 없음
				widget.add(new WidgetVO(member.getMemNo(), 0, 0, 7, 3, null, "WID001"));
			}
			widget.add(new WidgetVO(member.getMemNo(), 7, 0, 5, 3, null, "WID002"));
			widget.add(new WidgetVO(member.getMemNo(), 0, 3, 6, 3, null, "WID003"));
			widget.add(new WidgetVO(member.getMemNo(), 6, 3, 6, 3, null, "WID004"));

			ServiceResult res = widgetService.createWidget(widget);

			widgetList = widgetService.widgetList(member.getMemNo());
		} else {
			log.info("widget not empty...");
			log.info("w : " + widgetList);
		}

		model.addAttribute("member", member);
		model.addAttribute("widgetList", widgetList);
		

		if(member.getMemRole().equals("ROL001")) { 			// 학생 메인 페이지
			return "student/mainpage";
		} else if (member.getMemRole().equals("ROL002")) { 	// 교수 메인 페이지
			return "professor/mainpage";
		} else if (member.getMemRole().equals("ROL003")) { 	// 관리자 메인 페이지
			return "employer/mainpage";
		} else {                        // 로직상은 필요가 없지만 그냥 안전을 위해서
			return "redirect:/login.do";
		}
	}

	// 비동기 처리 ============================================
	
	@ResponseBody
	@GetMapping("/mainpage.do/widgetList")
	public List<WidgetVO> widgetList(int memNo){
		log.info("위젯리스트");
		List<WidgetVO> widgetList = widgetService.widgetList(memNo);

		return widgetList;
	}
	
	// 공지사항 위젯 비동기
	@GetMapping("/mainpage.do/notice")
	@ResponseBody
	public List<BoardVO> noticeWidget() {
		log.info("공지사항 위젯");
		List<BoardVO> noticeList = boardService.noticeWidget();

		return noticeList;
	}

	// 학사일정 위젯 비동기
	@ResponseBody
	@GetMapping("/mainpage.do/univSchedule")
	public List<UnivScheduleVO> univScheduleWidget() {

		log.info("학사일정 위젯");
		List<UnivScheduleVO> univScheduleList = univService.univScheduleWidget();

		return univScheduleList;
	}
	
	// 강의 시간표 위젯 비동기
	@ResponseBody
	@GetMapping("/mainpage.do/classBoard")
	public List<ClassVO> todayClassWidget (Model model, HttpServletRequest req) {
		log.info("강의 시간표 위젯");
		
		MemberVO member = (MemberVO) req.getSession().getAttribute("member");
		String memRole = member.getMemRole();
		List<ClassVO> myClassList = null;
		
		if(memRole.equals("ROL001")) { // 학생 (수강 중인 해당요일의 강의리스트)
			myClassList = classService.todayProcessClassListStu(member.getMemNo());
		} else if(memRole.equals("ROL002")) { // 교수 (강의 중인 해당요일의 강의리스트)
			myClassList = classService.todayProcessClassListPro(member.getMemNo());
			for(int i = 0; i < myClassList.size(); i++) {
				myClassList.get(i).setMemName(member.getMemName());
			}
		}
		
		return myClassList;
	}

	// 포틀릿 비동기 메소드
	@ResponseBody
	@PostMapping("/mainpage.do/updateWidget")
	public String updateWidget(@RequestBody List<WidgetVO> widget, HttpSession session) {
		// 업데이트 : 기존 데이터 삭제 후 가져온 데이터로 다시 생성...
		log.info("w :" + widget);

		
		//HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");
		ServiceResult deleteRes = widgetService.deleteWidgetData(member.getMemNo());
		
		String result="OK";
		if(widget == null || widget.size() == 0) {
			result="NG";
		}
		
		if(deleteRes.equals(ServiceResult.OK)) {
			ServiceResult CreateRes = widgetService.createWidget(widget);
			if(!CreateRes.equals(ServiceResult.OK)) {
				result="NG";
			} 
		} 
		
		return result;
	}
	
	// 포틀릿 선택 메뉴 메소드
	@ResponseBody
	@PostMapping("/mainpage.do/selectWidget")
	public WidgetVO selectWidget(@RequestBody WidgetVO widgetVO) {
		log.info("selectWidget Data :" + widgetVO);
		
		WidgetVO selectWidget = new WidgetVO();
		selectWidget.setMemNo(widgetVO.getMemNo());
		selectWidget.setWidType(widgetVO.getWidType());
		
		widgetVO = widgetService.selectWidget(selectWidget);
		
		return widgetVO;
	}

	//교수 아이디 일괄 생성
	@ResponseBody
	@RequestMapping(value = "/excelUpload.do", method = RequestMethod.POST)
	public ResponseEntity<String> excelUploadAjax(MultipartHttpServletRequest request) throws Exception{
	    
		String result = "failed";
	    MultipartFile excelFile = request.getFile("excelFile");

	    try {
	        if(excelFile != null || !excelFile.isEmpty()) {
	            File destFile = new File("D:\\"+excelFile.getOriginalFilename()); // 파일위치 지정
	            excelFile.transferTo(destFile); // 엑셀파일 생성
	            
	            ServiceResult res = memberService.excelUpload(destFile); // service단 호출
	            
	            if(res.equals(ServiceResult.OK)) {
	            	result = "success";
	            }
	            
	            destFile.delete(); // 업로드된 엑셀파일 삭제
	        }else {
	        	
	        }
	    }catch(Exception e) {
	        e.printStackTrace();
	    } 
	    return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	//학생 아이디 일괄 생성
	@ResponseBody
	@RequestMapping(value = "/studentUpload.do", method = RequestMethod.POST)
	public ResponseEntity<String> studentUploadAjax(MultipartHttpServletRequest request) throws Exception{
	    
		String result = "failed";
	    MultipartFile excelFile = request.getFile("excelFile");

	    try {
	        if(excelFile != null || !excelFile.isEmpty()) {
	            File destFile = new File("D:\\"+excelFile.getOriginalFilename()); // 파일위치 지정
	            excelFile.transferTo(destFile); // 엑셀파일 생성
	            
	            ServiceResult res = memberService.studentUpload(destFile); // service단 호출
	            
	            if(res.equals(ServiceResult.OK)) {
	            	result = "success";
	            }
	            
	            destFile.delete(); // 업로드된 엑셀파일 삭제
	        }else {
	        	
	        }
	    }catch(Exception e) {
	        e.printStackTrace();
	    } 
	    return new ResponseEntity<String>(result, HttpStatus.OK);
	}
}