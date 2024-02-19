package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.entity.BusinessLogicException;
import kr.or.ddit.entity.ExceptionCode;
import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.IKakaopayService;
import kr.or.ddit.service.IMemberService;
import kr.or.ddit.service.IUnivManagementService;
import kr.or.ddit.service.impl.KakaopayServiceImpl;
import kr.or.ddit.vo.CalendarVO;
import kr.or.ddit.vo.FacilityRentVO;
import kr.or.ddit.vo.KakaoApproveResponse;
import kr.or.ddit.vo.KakaoReadyResponse;
import kr.or.ddit.vo.MemberStdVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.UnivScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class UnivManagementController {
	
	// 신고목록, 셔틀버스, 학사일정 등	
	
	// 신고 목록
	// 신고 작성
	
	// 셔틀 버스 정보
	// 셔틀버스 정보 업로드
	
	// 학사일정 목록
	// 학사일정 추가
	
	// 온라인 증명서
	// 온라인 증명서 발급
	
	// 이 밑으로 구현 ============================================
	
	@Inject
	private IUnivManagementService univService;
	
	// 증명서  정보 memberService
	@Inject
	private IMemberService memberService;
	
	// 카카오 결제 
	@Inject
	private IKakaopayService kakaoPayService;

	
	// 학사일정 조회(리스트)
	@GetMapping("/univSchedule.do")
	public String univSchedule(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "univSchName") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest req) {
			
		
		PaginationVO<UnivScheduleVO> pagingVO = new PaginationVO<UnivScheduleVO>();
		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}	
		pagingVO.setMemNo(memberVO.getMemNo());
		
		int totalRecord = univService.univSchCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setScreenSize(5);
		pagingVO.setMainscreenSize(5);
		
		List<UnivScheduleVO> univScheduleList = univService.univScheduleList(pagingVO);	
		pagingVO.setDataList(univScheduleList);
		//model.addAttribute("univScheduleList", univScheduleList);	
		model.addAttribute("pagingVO", pagingVO);	
		
		if(memberVO.getMemRole().equals("ROL003")) {
			return "employer/univSchedule";
		} else if(memberVO.getMemRole().equals("ROL002")) {
			return "professor/univSchedule";
		} else /* (memberVO.getMemRole().equals("학생코드")) */ {
			return "student/univSchedule";
		}
	}
	
	// 학사일정 조회(캘린더)
	@ResponseBody
	@RequestMapping(value="/scheduleList.ajax", method = RequestMethod.POST)
	public List<CalendarVO> selectScheduleList(){
		List<UnivScheduleVO> univScheduleList = univService.univSchedule();
		List<CalendarVO> calendarList = null;
		if(univScheduleList != null && univScheduleList.size() > 0) {
			calendarList = new ArrayList<CalendarVO>();
			for(int i = 0; i < univScheduleList.size(); i++) {
				UnivScheduleVO univVO = univScheduleList.get(i);
				CalendarVO calendarVO = new CalendarVO();
				calendarVO.setStart(univVO.getUnivSchStartDate().substring(0, 10));
				calendarVO.setEnd(univVO.getUnivSchEndDate().substring(0, 10));
				//calendarVO.setClassName("bg-success");
				calendarVO.setUnivSchType(univVO.getUnivSchType());
				calendarVO.setTitle(univVO.getUnivSchName());
				calendarList.add(calendarVO);
			}
		}
		return calendarList;
	}
	
	// 학사일정 생성
	@PostMapping("/employer/addSchedule.do")
	public String addSchedule(UnivScheduleVO scheduleVO, RedirectAttributes ra, Model model, HttpSession session) {
		String goPage = "";
		System.out.println("getUnivSchNo" + scheduleVO.getUnivSchNo());
		System.out.println("getUnivSchName" + scheduleVO.getUnivSchName());
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		// 등록자=관리자 지정
		String admin = scheduleVO.getUnivSchReg();
		admin = "관리자";
		scheduleVO.setUnivSchReg(admin);
		
		// 에러 등록
		Map<String, String> errors = new HashMap<String, String>();
		if(StringUtils.isBlank(scheduleVO.getUnivSchName()))
		{
			errors.put("scheduleTitle", "제목을 입력해주세요.");
		}
		if(errors.size()>0)
		{
			model.addAttribute("errors", errors);
			model.addAttribute("scheduleVO", scheduleVO);
			goPage = "employer/univSchedule";
		}
		// 정상 등록
		else
		{
		
			ServiceResult result = univService.addSchedule(scheduleVO);
			if(result.equals(ServiceResult.OK))
			{
				ra.addFlashAttribute("message", "일정이 등록되었습니다.");
				goPage = "redirect:/DYUniv/univSchedule.do";
			}else
			{
				model.addAttribute("scheduleVO", scheduleVO);
				model.addAttribute("message", "일정 등록 실패, 다시 시도해주세요!");
				goPage = "employer/univSchedule";
			}
		}
		return goPage;
	}
	
	// 학사일정 수정
	@PostMapping("/employer/updateSchedule.do")
	public String updateSchedule1(UnivScheduleVO scheduleVO, Model model, RedirectAttributes ra) {
		scheduleVO.setUnivSchReg("관리자");
		int status = univService.updateSchedule1(scheduleVO);
		
		if(status == 1) {
			ra.addFlashAttribute("message", "일정이 저장되었습니다.");
		} else {
			ra.addFlashAttribute("message", "저장에 실패하였습니다.");
		}		
		return "redirect:/DYUniv/univSchedule.do";
	}
	
	// 학사일정 삭제
	@ResponseBody
	@DeleteMapping("/employer/deleteSchedule/{shcNo}")
	public int deleteSchedule(@PathVariable int shcNo) {
		UnivScheduleVO univScheduleVO = new UnivScheduleVO();
		univScheduleVO.setUnivSchNo(shcNo);
		System.out.println("schNo" + univScheduleVO.getUnivSchNo());
		return univService.deleteSchedule(univScheduleVO);
	}
	
	
	// 온라인 증명서 목록 
	@GetMapping("/certificate")
	public String certificatekind (Model model) {
		return "student/certificate";
	}
	
	/**
	 * 결제요청
	 */
	@ResponseBody
	@PostMapping("/payment/ready")
	public ResponseEntity<KakaoReadyResponse> readyToKakaoPay(@RequestBody Map<String, String> certMap) {
		log.debug("체크 : {}",certMap );
		
		KakaoReadyResponse kakaoReady = kakaoPayService.kakaoPayReady(certMap);
		// 여기에 선택한 증명서 를 같이 넘겨줘야하는건지?
		
		
		return new ResponseEntity<KakaoReadyResponse>(kakaoReady, HttpStatus.OK);

	}
	
	/**
	 * 결제 성공
	 */
	@GetMapping("/payment/success")
	public String afterPayRequest(@RequestParam("pg_token") String pgToken, Model model) {
		
		KakaoApproveResponse kakaoApprove = kakaoPayService.approveResponse(pgToken);
		
		model.addAttribute("kakaoApprove", kakaoApprove);
		System.out.println("kakaoApprove ::"+ kakaoApprove.getItem_name());
		
		// 여기에 선택한 증명서 jsp를 호출 해야하는건지?
		if(kakaoApprove.getItem_name().equals("graduationPrice")) {
			return "redirect:/DYUniv/gradCertificate";
		}else if(kakaoApprove.getItem_name().equals("score")) {
			return "redirect:/DYUniv/scoreCertificate";
		}else {
			return "redirect:/DYUniv/schoolCertificate";
		}
	}

	/**
	 * 결제 진행 중 취소
	 * 
	 * @throws BusinessLogicException
	 */
	@GetMapping("/payment/cancel")
	public void cancel() throws BusinessLogicException {
		throw new BusinessLogicException(ExceptionCode.PAY_CANCEL);
	}

	/**
	 * 결제 실패
	 * @throws BusinessLogicException
	 */
	@GetMapping("/payment/fail")
	public void fail() throws BusinessLogicException {
		throw new BusinessLogicException(ExceptionCode.PAY_FAILED);

	}
	

	
	// 졸업증명서
	@GetMapping("/gradCertificate")
	public String gradCrtDetail (Model model, HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();
		
//		//테스트 
//		int memNo = 3;
		
		MemberStdVO member = memberService.gradCrtDetail(memNo);
		model.addAttribute("member",member);
		
		return "certificate/gradCertificate";
	}
	
	// 재학 증명서 
	@GetMapping("/schoolCertificate")
	public String schCrtDetail(Model model, HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();
		
//		//테스트 
//		int memNo = 1;
		
		MemberStdVO member = memberService.schCrtDetail(memNo);
		model.addAttribute("member",member);
		
		return "certificate/schoolCertificate";
	}
	
	// 성적 증명서 
	@GetMapping("/scoreCertificate")
	public String scoreCrtDetail (Model model, HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();

		MemberStdVO memberStdVO = memberService.scoreCrtDetail(memNo);
		model.addAttribute("memberStdVO", memberStdVO);
		
		return "certificate/scoreCertificate";
	}
	
}


