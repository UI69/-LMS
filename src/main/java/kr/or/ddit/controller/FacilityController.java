package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.IUnivManagementService;
import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.CalendarVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.FacilityRentVO;
import kr.or.ddit.vo.FacilityVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class FacilityController {

	//건물, 시설 예약 관련
	
	// 건물 목록
	// 시설 목록
	// 시설 기준 예약 목록
	// 회원 기준 시설 예약 목록
	// 시설 예약 신청
	// 시설 예약 허가/반려
	
	@Inject
	private IUnivManagementService univService;
		
	
	// 이 밑으로 구현 ============================================
	@GetMapping("/facility/rentMap.do")
	public String test() {		
		return "student/facilityMap";
	}
	
	// 시설 예약 리스트
	@GetMapping("/facility/rentList.do")
	public String facilityRentList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "facRsvStartDate") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		log.info("page : " + currentPage);
		
		PaginationVO<FacilityRentVO> pagingVO = new PaginationVO<FacilityRentVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}	
		pagingVO.setMemNo(member.getMemNo());
		
		int totalRecord = univService.facilityResvCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord); 		
		pagingVO.setCurrentPage(currentPage);
		
		
		List<FacilityRentVO> rentList = univService.facilityRentList(pagingVO);
		pagingVO.setDataList(rentList);

		model.addAttribute("pagingVO", pagingVO);
		
		return "student/facilityRentList";
	}
	
	// 시설 예약 리스트(캘린더)
	@ResponseBody
	@PostMapping("/facility/rentListCal.ajax/{facNo}")
	public List<CalendarVO> facilityRentCal(@PathVariable int facNo){
		log.info("calenarVO");
		List<FacilityRentVO> rentList = univService.facilityRentCal(facNo);
		log.info("rentList : " + rentList);
		
		List<CalendarVO> calenarList = null;
		
		if(rentList != null && rentList.size() > 0) {
			calenarList = new ArrayList<CalendarVO>();
			for(int i = 0; i < rentList.size(); i++) {
				System.out.println("rentList.size()" + rentList.size());
				FacilityRentVO facilityRentVO = rentList.get(i);
//				facilityRentVO.setFacNo(facNo);
				CalendarVO calendarVO = new CalendarVO();
				calendarVO.setStart(facilityRentVO.getFacRsvStartDate().replace(" ", "T"));
				calendarVO.setEnd(facilityRentVO.getFacRsvEndDate().replace(" ", "T"));
				calendarVO.setTitle(facilityRentVO.getFacilityVO().getFacName());
				calenarList.add(calendarVO);
				System.out.println("calenarList~~" + calendarVO);
			}
		}
		return calenarList;
	}
	
	// 시설 예약 폼 
	@GetMapping("/facility/rentForm.do")
	public String facilityRentForm(Model model) {
		// 건물, 시설 리스트
		List<BuildingVO> buildingList = univService.buildingList();
		model.addAttribute("buildingList", buildingList);
		return "student/facilityRent";
	}
	
	// 건물 선택(시설 출력)
	@ResponseBody
	@GetMapping("/facility/buildingSelect.ajax/{buildingNo}")
	public BuildingVO buildingSelect(@PathVariable int buildingNo){
		log.debug("buildingNo:" + buildingNo);
		BuildingVO buildingVO = new BuildingVO();
		buildingVO.setBuildingNo(buildingNo);
		return univService.buildingSelect(buildingVO);
	}
	
	
	// 시설 선택(예약 현황 출력)
	@ResponseBody
	@GetMapping("/facility/facilitySelect.ajax/{facNo}")
	public FacilityVO facilitySelect(@PathVariable int facNo) {
		log.info("facilitySelect ==> " + facNo);
		FacilityVO facilityVO = new FacilityVO();
		facilityVO.setFacNo(facNo);
		return univService.facilitySelect(facilityVO);
	}
	
	// 시설 예약
	@PostMapping("/facility/facReservation.do")
	public String facReservation(FacilityRentVO facilityRentVO, RedirectAttributes ra, Model model, HttpSession session) {
		String goPage = "";
		System.out.println("facilityRentVO => " + facilityRentVO);
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		facilityRentVO.setMemName(member.getMemName());
		facilityRentVO.setMemNo(member.getMemNo());
		ServiceResult result = univService.facReservation(facilityRentVO);
		if(result.equals(ServiceResult.OK))
		{
			ra.addFlashAttribute("message", "일정이 등록되었습니다.");
			goPage = "redirect:/DYUniv/facility/rentList.do";
		}else
		{
			model.addAttribute("facilityRentVO", facilityRentVO);
			model.addAttribute("message", "일정 등록 실패, 다시 시도해주세요!");
			goPage = "student/facilityRent";
		}
		return goPage;
	}
	
	/*
	 * @GetMapping("/facility/rentList.do") public String facilityRentList() {
	 * return "student/facilityRentList"; }
	 */
	
	// 여기부터 교직원 시설 예약 관리
	@GetMapping("/facilityManage.do")
	public String facilityManage (
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "facRsvStartDate") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model) {
		
		PaginationVO<FacilityRentVO> pagingVO = new PaginationVO<FacilityRentVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		List<BuildingVO> buildingDataList = univService.getBuildingData();
		model.addAttribute("buildingDataList", buildingDataList);
		
		int totalRecord = univService.facilityResvCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord); 
		
		List<FacilityRentVO> facilityResvAllList = univService.getfacilityResvData(pagingVO);
		pagingVO.setDataList(facilityResvAllList);
		
		System.out.println("pagingVO"+ pagingVO);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "employer/facilityManage";
	}
	
	
	@PostMapping("/updateFacilityResvStatus.do")
	public String updateFacilityResvStatus(
			@RequestParam(name = "facRentNo") int facRentNo,
			@RequestParam(name = "facRentStatusCode") String facRentStatusCode,
			@RequestParam(name = "facReject") String facReject
		) {
		log.info("updateFacilityResvStatus 실행 !");
		
		FacilityRentVO facilityRentVO = new FacilityRentVO();
		facilityRentVO.setFacRentNo(facRentNo);
		facilityRentVO.setFacRentStatusCode(facRentStatusCode);
		facilityRentVO.setFacReject(facReject);
		
		log.info("facilityRentVO: {}", facilityRentVO);
		int success =  univService.updateFacilityResvStatus(facilityRentVO);
		
		return "redirect: /DYUniv/facilityManage.do";
	}
	
	@PostMapping("/facility/facilityRentCancle.do")
	public String rentCancle(int rentCancleNo, RedirectAttributes ra) {
		
		log.info("rentCancleNo : " + rentCancleNo);
		
		FacilityRentVO facilityRentVO = new FacilityRentVO();
		facilityRentVO.setFacRentNo(rentCancleNo);
		facilityRentVO.setFacRentStatusCode("FAC004");
		
		int cnt = univService.updateFacilityResvStatus(facilityRentVO);
		
		if(cnt > 0) {
			ra.addFlashAttribute("message", "취소되었습니다.");
		} else {
			ra.addFlashAttribute("message", "에러가 발생하였습니다.");
		}
		
		return "redirect:/DYUniv/facility/rentList.do";
	}
}
