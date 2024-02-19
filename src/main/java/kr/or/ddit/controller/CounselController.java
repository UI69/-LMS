package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.formula.ptg.MemErrPtg;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.IClassService;
import kr.or.ddit.service.ICounselService;
import kr.or.ddit.service.IMemberService;
import kr.or.ddit.vo.CalendarVO;
import kr.or.ddit.vo.ChatRecordVO;
import kr.or.ddit.vo.CounselVO;
import kr.or.ddit.vo.FacilityRentVO;
import kr.or.ddit.vo.MemberStdVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ScheduleDataVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class CounselController {
	// 상담 관련

	// 상담 신청 목록 v
	// 상담 신청 v
	// 채팅 상담 페이지 v

	// 상담 일정 등록
	// 상담 일정 취소
	// 상담 신청 취소
	// 상담 결과 입력

	// 이 밑으로 구현 ============================================

	@Inject
	private ICounselService counselService;

	@Inject
	private IClassService classService;

	/*
	 * // 학생 > 상담 신청 목록
	 * 
	 * @GetMapping("/counsel/counselList.do") public String stdCounselList(Model
	 * model, HttpServletRequest req) { log.info("counselList() run...");
	 * 
	 * //회원 번호 MemberVO member = (MemberVO) req.getSession().getAttribute("member");
	 * int studentMemNo = member.getMemNo();
	 * 
	 * List<CounselVO> counselList = counselService.getCounselList(studentMemNo);
	 * model.addAttribute("counselList", counselList);
	 * 
	 * log.info(counselList.toString());
	 * 
	 * return "student/counselList"; }
	 */

	// 상담 신청 목록 : 교수,학생
	@GetMapping("/counsel/counselList.do")
	public String proCounselList(Model model, HttpServletRequest req) {
		log.info("counselList() run...");

		// 회원 번호
		MemberVO member = (MemberVO) req.getSession().getAttribute("member");
		model.addAttribute("member", member);

		String memRole = member.getMemRole();
		String url = "";
		List<CounselVO> counselList;

		if (memRole.equals("ROL002")) {
			int proMemNo = member.getMemNo();
			counselList = counselService.getProCounselList(proMemNo);
			model.addAttribute("counselList", counselList);

			url = "professor/counselList";
		} else if (memRole.equals("ROL001")) {
			int studentMemNo = member.getMemNo();
			counselList = counselService.getCounselList(studentMemNo);
			model.addAttribute("counselList", counselList);

			url = "student/counselList";
		}

		return url;
	}

	// 채팅 상담 페이지
	@GetMapping("/counsel/csRoom/{chatRoomNo}")
	public String csRoom(Model model, @PathVariable("chatRoomNo") int chatRoomNo, HttpServletRequest req) {
		log.info("csRoom() run...");

		log.info("chatRoomNo : " + chatRoomNo);

		HttpSession
		session = req.getSession();
		session.setAttribute("chatRoomNo", chatRoomNo);
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		int memNo = member.getMemNo();
		
		model.addAttribute("member", member);
		model.addAttribute("chatRoomNo", chatRoomNo);

		// 채팅방 정보 가져오기, 채팅방 참가자 인지 확인
		CounselVO counselVO = counselService.getCounselInfo(chatRoomNo);
		if (memNo != counselVO.getMemNo1() && memNo != counselVO.getMemNo2()) {
			return "redirect:/DYUniv/mainpage.do";
		}

		MemberVO CounselMember = null;
		if (member.getMemRole().equals("ROL001")) {
			int csMemNo = counselVO.getMemNo1();
			CounselMember = classService.getMyMember(csMemNo);
		} else {
			int csMemNo = counselVO.getMemNo2();
			CounselMember = classService.getMyMember(csMemNo);
		}

		model.addAttribute("counselVO", counselVO);
		model.addAttribute("CounselMember", CounselMember);

		// 방의 채팅 목록 가져오기
		List<ChatRecordVO> recordList = counselService.getRecordList(chatRoomNo);
		model.addAttribute("recordList", recordList);
		log.info(recordList.toString());

		// 방의 채팅 참여자 가져오기
		// ?

		String memRole = member.getMemRole();
		String url = "";
		if (memRole.equals("ROL002")) {
			url = "professor/counselChatRoom";
		} else if (memRole.equals("ROL001")) {
			url = "student/counselChatRoom";
		}

		return url;
	}

	// 화상 상담 페이지 : 교수, 학생
	@GetMapping("/counsel/vsRoom/{chatRoomNo}")
	public String vsRoom(Model model, @PathVariable("chatRoomNo") int chatRoomNo, HttpServletRequest req) {

		log.info("vsRoom() run...");

		MemberVO member = (MemberVO) req.getSession().getAttribute("member");
		int memNo = member.getMemNo();

		model.addAttribute("member", member);
		model.addAttribute("chatRoomNo", chatRoomNo);

		// 채팅방 정보 가져오기, 채팅방 참가자 인지 확인
		CounselVO counselVO = counselService.getCounselInfo(chatRoomNo);
		if (memNo != counselVO.getMemNo1() && memNo != counselVO.getMemNo2()) {
			return "redirect:/DYUniv/mainpage.do";
		}

		String memRole = member.getMemRole();
		String url = "";
		MemberVO CounselMember = null;

		if (memRole.equals("ROL002")) {
			int csMemNo = counselVO.getMemNo2();
			CounselMember = classService.getMyMember(csMemNo);
			url = "professor/counselVideoChatRoom";
		} else if (memRole.equals("ROL001")) {
			int csMemNo = counselVO.getMemNo1();
			CounselMember = classService.getMyMember(csMemNo);
			url = "student/counselVideoChatRoom";
		}

		model.addAttribute("counselVO", counselVO);
		model.addAttribute("CounselMember", CounselMember);

		return url;
	}

	// 상담 내용 업데이트 : 교수
	@PostMapping("/counsel/updateCnslDetail")
	public String updateCnslDetail(@RequestParam int cnslNo, @RequestParam String cnslDetail, Model model,
			RedirectAttributes ra) {
		CounselVO counselVO = new CounselVO();
		counselVO.setCnslNo(cnslNo);
		counselVO.setCnslDetails(cnslDetail);

		int success = counselService.updateCnslDetail(counselVO);
		if (success == 1) {
			return "redirect:/DYUniv/counsel/counselList.do";
		} else {
			ra.addFlashAttribute("error", "저장에 실패했습니다. 다시 시도하십시오.");
			/* return "redirect:/DYUniv/counsel/counselDetail.do?cnslNo=" + cnslNo; */
			return null;
		}
	}

	// 상담 신청 페이지 (목록) : 학생
	@RequestMapping(value = "/counsel/counselReserve.do")
	public String counselReservList(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "memName") String searchType,
			@RequestParam(required = false) String searchWord, Model model) {

		PaginationVO<MemberVO> pagingVO = new PaginationVO<MemberVO>();

		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}

		pagingVO.setCurrentPage(currentPage);

		int totalRecord = counselService.getCounselorCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<MemberVO> counselorList = counselService.getCounselor(pagingVO);
		pagingVO.setDataList(counselorList);

		model.addAttribute("pagingVO", pagingVO);

		return "student/counselReservList";
	}

	// 상담 신청 폼 : 학생
	@RequestMapping(value = "/counsel/counselReserveForm.do/{memNo}")
	public String counselReservForm(@PathVariable int memNo, Model model) throws Exception {

		String counsorName = counselService.getMemName(memNo);
		Map<String, String> counsorMap = new HashMap<String, String>();
		counsorMap.put("memNo", Integer.toString(memNo));
		counsorMap.put("counsorName", counsorName);

		List<ScheduleDataVO> scData = counselService.counselSchDataList(memNo);
		List<CalendarVO> calendarList = new ArrayList<CalendarVO>();

		for (ScheduleDataVO sd : scData) {
			CalendarVO cal = new CalendarVO();
			cal.setId(sd.getSchDataNo());
			cal.setTitle(sd.getSchName());
			cal.setStart(sd.getSchStart());
			cal.setEnd(sd.getSchEnd());

			if (!sd.getSchName().equals("상담")) {
				cal.setClassName("bg-warning");
			} else {
				cal.setClassName("bg-info");
			}

			calendarList.add(cal);
		}

		ObjectMapper objectMapper = new ObjectMapper();

		String calListJson = objectMapper.writeValueAsString(calendarList);

		model.addAttribute("calendarList", calendarList);
		model.addAttribute("calListJson", calListJson);
		model.addAttribute("counsorMap", counsorMap);

		return "student/counselReservForm";
	}

	@PostMapping("/counsel/counselReservForm.do")
	public String counselReservForm(
			CounselVO counselVO, 
			ScheduleDataVO dataVO,
			HttpServletRequest req
			) {
		log.info("counselReservForm() run...");
		log.info(counselVO.toString());
		log.info(dataVO.toString());

		MemberVO member = (MemberVO) req.getSession().getAttribute("member");
		String memId = member.getMemId();
		String memName = member.getMemName();

		dataVO.setSchName("상담 신청 : " + memName + "(" + memId + ")");

		ServiceResult res = counselService.addReserveCousel(counselVO, dataVO);

		return "redirect:/DYUniv/counsel/counselList.do";
	}

	// 비동기 처리 ========================
	@ResponseBody
	@PostMapping("/counsel/getSchData.do")
	public ResponseEntity<List<CalendarVO>> getSchData(@RequestBody Map<String, String> data) {

		int memNo = Integer.parseInt(data.get("memNo"));
		List<ScheduleDataVO> scData = counselService.counselSchDataList(memNo);

		List<CalendarVO> calendarList = new ArrayList<CalendarVO>();

		log.info(scData.toString());

		for (ScheduleDataVO sd : scData) {
			CalendarVO cal = new CalendarVO();
			cal.setId(sd.getSchDataNo());
			cal.setTitle(sd.getSchName());
			cal.setStart(sd.getSchStart());
			cal.setEnd(sd.getSchEnd());
			

			if (!sd.getSchName().equals("상담")) {
				cal.setClassName("bg-warning");
			} else {
				cal.setClassName("bg-info");
			}

			calendarList.add(cal);
		}

		return new ResponseEntity<List<CalendarVO>>(calendarList, HttpStatus.OK);
	}

	// 상담 일정 설정  : 교수
	@GetMapping("/counsel/counselorSchedule.do")
	public String counselRsvSch() {
		return "professor/counselReservSch";
	}
	
	@ResponseBody
	@PostMapping("/counsel/addCounselSchedule")
	public ServiceResult addCounselSchedule(@RequestBody Map<String, String> data, HttpServletRequest req) {
		
		String schStart = data.get("schStart");
		String schEnd = data.get("schEnd");
		
		MemberVO member = (MemberVO) req.getSession().getAttribute("member");
		int memNo = member.getMemNo();
		
		log.debug("schStart : ", schStart);
		log.debug("schEnd : ", schEnd);
		
		ScheduleDataVO scheduleDataVO = new ScheduleDataVO();
		scheduleDataVO.setMemNo(memNo);
		scheduleDataVO.setSchStart(schStart);
		scheduleDataVO.setSchEnd(schEnd);		
		
		ServiceResult res = counselService.addCounselSchedule(scheduleDataVO);
		
		return res;
	}
	
	@ResponseBody
	@PostMapping("/counsel/deleteCounselSchedule")
	public int deleteCounselSchedule(@RequestBody Map<String, Integer> data) {
		int schDataNo = data.get("schDataNo");
		int success = counselService.deleteCounselSchedule(schDataNo);
		
		return success;
	}
}
