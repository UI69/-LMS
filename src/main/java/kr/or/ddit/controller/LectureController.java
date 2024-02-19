package kr.or.ddit.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.ILectureService;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ReserveClassVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class LectureController {
	// 교과목, 수강 신청
	
	// 학과 목록
	// 학과 상세
	// 학과 추가
	// 학과 삭제
	
	// 예비 수강 신청 목록
	// 예비 수강 신청 추가
	// 예비 수강 신청 삭제
	
	// 수강 신청
	// 수강 목록
	
	// 이 밑으로 구현 ============================================

	@Inject
	private ILectureService lectureService;
	
	//강의 목록/예비신청 폼
	@RequestMapping("/student/lecture/lectureList.do")
	public String classList(@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "dprtName") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest req) {
		
		PaginationVO<ClassVO> pagingVO = new PaginationVO<ClassVO>();
		
		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");
		model.addAttribute("memberVO", memberVO);
		
		// 리스트 게시글 수 설정
		pagingVO.setScreenSize(7);
		pagingVO.setMainscreenSize(7);
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = lectureService.getClassListCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ClassVO> classList = lectureService.getClassList(pagingVO);
		pagingVO.setDataList(classList);
		model.addAttribute("pagingVO", pagingVO);
		
		DepartmentVO dprtVO = lectureService.getdprtInfo(memberVO.getDprtNo());
		model.addAttribute("dprtVO", dprtVO);
		
		List<ClassVO> reserveClassList = lectureService.reserveClassList(memberVO.getMemNo());
		model.addAttribute("reserveClassList", reserveClassList);
		
		return "student/reserveClassForm";
	}
	
	// 수강신청
	@PostMapping("/student/lecture/classListenApplyForm.do")
	public String enrollment(Model model, int memNo, RedirectAttributes ra) {
		log.info("enrollment() run...");
		
		//예비 목록 가져오기
		List<ReserveClassVO> reserveClassList = lectureService.myReserveClassList(memNo);
		log.info(reserveClassList.toString());
		
		//수강 신청 하기
		int res = 0;
		
		if(reserveClassList != null && reserveClassList.size() > 0) {
			for (ReserveClassVO recVO : reserveClassList) {
				if(recVO.getResStatusCode().equals("RES001")) {
					res += lectureService.addListenClass(recVO);					
				}
			}
		}
		
		//수강 성공/실패 정보 설정
		ra.addFlashAttribute("message", res + "개의 신청이 완료 되었습니다");
		
		return "redirect:/DYUniv/student/lecture/lectureList.do";		//강의 신청 이후 페이지? 
	}
	
	@RequestMapping(value = "/dprtManagementForm.do") //Get,Post 동시대응(좋치 않은 소스)!!!!!
	public String dprtManagementForm(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "dprtName") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model) {
		
		PaginationVO<DepartmentVO> pagingVO = new PaginationVO<DepartmentVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = lectureService.selectDprtCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<DepartmentVO> departmentList = lectureService.getDprtList(pagingVO);
		pagingVO.setDataList(departmentList);
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("departmentList", departmentList);
		
		return "employer/dprtManagementForm";
	}
	
	@PostMapping("/addDprtForm")
	public String addDprt(DepartmentVO departmentVO, RedirectAttributes ra) {
		log.info("addDprt() run...");
		log.info("departmentVO : " + departmentVO);
		
		ServiceResult res = lectureService.addDprt(departmentVO);
		
		if(res.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "등록 되었습니다.");
		} else {
			ra.addFlashAttribute("message", "등록에 실패하였습니다.");
		}
		
		return "redirect:/DYUniv/dprtManagementForm.do";
	}
	
	
	@RequestMapping("/lectureManagementForm.do")
	public String lectureManagementForm(Model model,
		@RequestParam(required = false, defaultValue = "apply") String tap,
		@RequestParam(name="apPage", required = false, defaultValue = "1") int apCurrentPage,
		@RequestParam(required = false, defaultValue = "apName") String apSearchType,
		@RequestParam(required = false) String apSearchWord,
		@RequestParam(name="classPage", required = false, defaultValue = "1") int classCurrentPage,
		@RequestParam(required = false, defaultValue = "name") String classSearchType,
		@RequestParam(required = false) String classSearchWord,
		@RequestParam(name="lecPage", required = false, defaultValue = "1") int lecCurrentPage,
		@RequestParam(required = false, defaultValue = "name") String lecSearchType,
		@RequestParam(required = false) String lecSearchWord
		
		) {
		
		model.addAttribute("tap", tap);
		
		//신청 목록
		PaginationVO<ClassVO> apPagingVO = new PaginationVO<ClassVO>();
		apPagingVO.setScreenSize(7);
		apPagingVO.setMainscreenSize(7);
		
		if(StringUtils.isNotBlank(apSearchWord)) {
			apPagingVO.setSearchType(apSearchType);
			apPagingVO.setSearchWord(apSearchWord);
			model.addAttribute("apSearchType", apSearchType);
			model.addAttribute("apSearchType", apSearchType);
		}
		
		apPagingVO.setCurrentPage(apCurrentPage);
		
		int apTotalRecord = lectureService.getLecApplyListCnt(apPagingVO);
		apPagingVO.setTotalRecord(apTotalRecord);
		
		List<ClassVO> lecApplyList = lectureService.getLecApplyList(apPagingVO);
		apPagingVO.setDataList(lecApplyList);
		model.addAttribute("apPagingVO", apPagingVO);
		
		//모든 강의 리스트
		PaginationVO<ClassVO> classPagingVO = new PaginationVO<ClassVO>();
		classPagingVO.setScreenSize(7);
		classPagingVO.setMainscreenSize(7);
		
		if(StringUtils.isNotBlank(classSearchWord)) {
			classPagingVO.setSearchType(classSearchType);
			classPagingVO.setSearchWord(classSearchWord);
			model.addAttribute("classSearchType", classSearchType);
			model.addAttribute("classSearchWord", classSearchWord);
		}
		
		classPagingVO.setCurrentPage(classCurrentPage);
		
		int clTotalRecord = lectureService.getAllClassListCnt(classPagingVO);
		classPagingVO.setTotalRecord(clTotalRecord);
		
		List<ClassVO> classList = lectureService.getAllClassList(classPagingVO);
		classPagingVO.setDataList(classList);
		model.addAttribute("classPagingVO", classPagingVO);
		
		

		
		//모든 교과목 리스트
		PaginationVO<LectureVO> lecPagingVO = new PaginationVO<LectureVO>();
		lecPagingVO.setScreenSize(7);
		lecPagingVO.setMainscreenSize(7);
		
		if(StringUtils.isNotBlank(lecSearchWord)) {
			lecPagingVO.setSearchType(lecSearchType);
			lecPagingVO.setSearchWord(lecSearchWord);
			model.addAttribute("lecSearchType", lecSearchType);
			model.addAttribute("apSearchType", lecSearchWord);
		}
		
		lecPagingVO.setCurrentPage(lecCurrentPage);
		
		int lecTotalRecord = lectureService.getLectureListCnt(lecPagingVO);
		lecPagingVO.setTotalRecord(lecTotalRecord);
		
		List<LectureVO> lectureList = lectureService.getLectureList(lecPagingVO);
		lecPagingVO.setDataList(lectureList);
		model.addAttribute("lecPagingVO", lecPagingVO);
		
		
		return "employer/lectureList";
	}
	
	@PostMapping("/lecture/classApplyForm.do")
	public String classApplyForm(ClassVO classVO) {
		log.info("classApplyForm() run...");
		log.info("classVO : " + classVO);
		
		ServiceResult res = lectureService.updateClassApply(classVO);
		
		return "redirect:/DYUniv/lectureManagementForm.do";
	}

	
	// 비동기 처리  컨트롤러 ============================
	
	// 예비 수강 신청 추가
	@ResponseBody
	@PostMapping("/lecture/lectureReserveAdd.do")
	public ResponseEntity<String> ReservAdd(@RequestBody ReserveClassVO reserveClassVO) {
		log.info("ReservAdd() run...");
		//log.info(reserveClassVO.toString());

		// 예비수강목록 중복 체크
		ServiceResult check = lectureService.ReservClassDuplicateCheck(reserveClassVO);
		if(check == ServiceResult.FAILED) {
			//중복시 메시지 반환
			return new ResponseEntity<String>("duplicated", HttpStatus.OK);
		} 
		
		// 예비 수강목록 추가
		ServiceResult res = lectureService.addReservClass(reserveClassVO);
		
		if(res == ServiceResult.OK) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>("failed", HttpStatus.OK);
		}
	}
	
	// 예비 수강 취소
	@ResponseBody
	@PostMapping("/lecture/lectureReserveRemove.do")
	public ResponseEntity<String> ReservRemove(@RequestBody ReserveClassVO reserveClassVO) {
		
		// 예비 수강목록 삭제
		ServiceResult res = lectureService.removeReservClass(reserveClassVO);
		
		if(res == ServiceResult.OK) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>("failed", HttpStatus.OK);
		}
	}
	
	
//	@ResponseBody
//	@PostMapping("/lecture/lectureReserveUpdate.do")
//	public ResponseEntity<List<ReserveClassVO>> ReservRemove(HttpServletRequest req) {
//		
//		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");
//		
//		// 예비 수강목록 리스트
//		List<ReserveClassVO> reserveClassList = lectureService.reserveClassList(memberVO.getMemNo());
//		log.info("reserveClassList : " + reserveClassList);
//		
//		return new ResponseEntity<List<ReserveClassVO>>(reserveClassList, HttpStatus.OK);
//	}
	
	
	@ResponseBody
	@PostMapping("/lecture/classDetail")
	public ResponseEntity<ClassVO> classDetail(@RequestBody Map<String, Integer> map) {
		
		int classNo = map.get("classNo");
		
		ClassVO classVO = lectureService.getClassDetail(classNo);
		System.out.println("classVO : " + classVO);
		
		return new ResponseEntity<ClassVO>(classVO, HttpStatus.OK);
	}
	
}
