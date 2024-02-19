package kr.or.ddit.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.ICommunityService;
import kr.or.ddit.vo.CommunityChatRecordVO;
import kr.or.ddit.vo.CommunityMemberVO;
import kr.or.ddit.vo.CommunityVO;
import kr.or.ddit.vo.MemberStdVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.MyClassVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ScheduleDataVO;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;


@Slf4j
@Controller
//@RestController
@RequestMapping("/DYUniv")
public class CommunityController {
	//커뮤니티 관련
	
	
	// 커뮤니티 그룹 목록
	// 커뮤니티 그룹 개설
	// 커뮤니티 그룹 상세
	// 커뮤니티 그룹 시간표
	// 커뮤니티 일정 추가
	
	// 커뮤니티 채팅
	
	// 커뮤니티 게시판?
	
	// 이 밑으로 구현 ============================================
	
	
	@Inject
	private ICommunityService communityService;
	
	// 아작스로 데이터 따로 페이징 따로?
	//  목록 
	@RequestMapping(value="/student/communityHome.do")
	public String communityList(
			HttpSession session, 
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(name = "page2", required = false, defaultValue = "1") int currentPage2,
			@RequestParam(required = false, defaultValue = "type") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model,
			String tab) {
		
		
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();
		
		model.addAttribute("memberVO", memberVO);
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		PaginationVO<CommunityVO> pagingVO = new PaginationVO<CommunityVO>();
		
		// 검색
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}	
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = communityService.communityAllCount(pagingVO);// 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);

		List<CommunityVO> communityList = communityService.list(pagingVO);
		pagingVO.setDataList(communityList);
		model.addAttribute("pagingVO", pagingVO);
		
		PaginationVO<CommunityVO> pagingVO2 = new PaginationVO<CommunityVO>();

		pagingVO2.setCurrentPage(currentPage2);
		int myCommunList= communityService.myCommunityListCount(pagingVO2);// 총 게시글 수 가져오기
		pagingVO2.setTotalRecord(myCommunList);
		
		paramMap.put("memNo", memNo);
		paramMap.put("pagingVO", pagingVO2);
		
		List<CommunityVO> myCommunity = communityService.myCommunityList(paramMap);
		pagingVO2.setDataList(myCommunity);
		model.addAttribute("pagingVO2", pagingVO2);
		
		model.addAttribute("tab",tab);
		
		List<CommunityMemberVO> regCmList = communityService.myRegCmList(memNo);
		model.addAttribute("regCmList", regCmList);
		
		return "student/communityHome"; // JSP
		
	}

	@GetMapping("/student/myCommunity.do")
	public String myCmList(Model model,HttpServletRequest req,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "type") String searchType,
			@RequestParam(required = false) String searchWord
			) {
		log.info("myCmList() run...");

		PaginationVO<CommunityVO> pagingVO = new PaginationVO<CommunityVO>();
		
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();
		
		// 검색
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setMemNo(memNo);
		int totalRecord = communityService.myCmApplyListCnt(pagingVO);// 총 게시글 수 가져오기
		pagingVO.setTotalRecord(totalRecord);

		List<CommunityVO> communityList = communityService.myCmApplyList(pagingVO);
		pagingVO.setDataList(communityList);
		model.addAttribute("pagingVO", pagingVO);
		
		return "student/communityMine";
	}
	
	
	@GetMapping("/student/community/{cmNo}")
	public String communityHome(Model model, @PathVariable int cmNo, RedirectAttributes ra, HttpServletRequest req) {
		log.info("communityHome() run...");
		
		log.info("cmNo : " + cmNo);
		
		HttpSession session = req.getSession();
		session.setAttribute("cmNo", cmNo);
		
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();
		
		//모임 정보 + 가입자 목록
		CommunityVO communityVO = communityService.getCmDetail(cmNo);
		
		log.info("communityVO : " + communityVO);
		
		if(communityVO == null) {
			ra.addFlashAttribute("message", "해당 커뮤니티가 없습니다.");
			return "redirect:/DYUniv/student/myCommunity.do";
		}
		
		//가입 확인
		List<CommunityMemberVO> cmMemberList = communityVO.getCmMemberList();
		boolean memCheckFlag = false;
		
		if(cmMemberList != null && cmMemberList.size() > 0) {
			for(CommunityMemberVO cmMem : cmMemberList) {
				log.info("cmMem memNo : " + cmMem.getMemNo());
				if(cmMem.getMemNo() == memNo) {
					memCheckFlag = true;
				}
			}
		}
		
		//잘못된 접속 방법일 경우
		if(!memCheckFlag) {
			ra.addFlashAttribute("message", "잘못된 접근입니다.");
			return "redirect:/DYUniv/student/myCommunity.do";
		}
		
		model.addAttribute("memNo", memNo);
		model.addAttribute("cmNo", cmNo);
		model.addAttribute("communityVO", communityVO);
		
		//채팅 기록
		List<CommunityChatRecordVO> cmChatList = communityService.getCmChatList(cmNo);
		model.addAttribute("cmChatList", cmChatList);

		return "student/community";
	}
	
	
	
	
	
	
	
	
	
	
	
	// 비동기 처리 ============================================
	
	// 모임 생성
	@RequestMapping(value ="/commuRegistr" , method = RequestMethod.POST )
	public String communityInsert(Model model, CommunityVO communityVO ,HttpServletRequest req) {
		log.info("communityInsert () run..." );

		HttpSession session = req.getSession();
		
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();
		String memName = memberVO.getMemName();
		
		//테스트용
//		int memNo = 1;
//		String memName = "김고양이";
		
		communityVO.setCmMaster(memName);
		communityVO.setMemNo(memNo);
		
		log.info(communityVO.toString());
		
		communityService.insert(communityVO);
		
		model.addAttribute("communityVO",communityVO);
		
		
		return "redirect:/DYUniv/student/communityHome.do";
	}
	
	
	// 상세보기 ajax
	@ResponseBody
	@RequestMapping(value = "/detailCommu", method = RequestMethod.POST)
	public ResponseEntity<CommunityVO> detail(@RequestBody Map<String, String> map) {
	    log.info("detail () ^오^");

	    int cmNo = Integer.parseInt(map.get("cmNo"));
	    CommunityVO communDetail = communityService.communDetail(cmNo);
    	System.out.println("communDetail" + communDetail);
    	
    	log.info("게시글 번호  () ^오^" + map.get("cmNo"));
	    return new ResponseEntity<CommunityVO>(communDetail, HttpStatus.OK);
	}
	
	
	// 수정 
	@PostMapping("/commuUpdate")
	@ResponseBody
	public int commuUpdateModel(@RequestBody CommunityVO communityVO) {
		log.debug("commuUpdate () {}",communityVO);
			
		return communityService.commuUpdate(communityVO);
	}
	
	
	// 폐쇄 
	@PostMapping("/commuStatus")
	@ResponseBody
	public int commuStatus(@RequestBody CommunityVO communityVO) {
		log.debug("commuUpdate () ",communityVO);
		return communityService.communStatus(communityVO);
	}
	
	
	//커뮤니티 가입
	@ResponseBody
	@PostMapping("/student/applyForCoummnityForm.do")
	public ResponseEntity<ServiceResult> applyForCoummnity(@RequestBody CommunityMemberVO cmMemberVO
			,HttpServletRequest req) {
		log.info("applyForCoummnity() run...");
	
		HttpSession session = req.getSession();
		
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();
		
		//테스트용
//		int memNo = 1;
		
		cmMemberVO.setMemNo(memNo);
		
		ServiceResult res = communityService.applyForCoummnity(cmMemberVO);
		
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
	
	//커뮤니티 탈퇴
	@ResponseBody
	@PostMapping("/student/leaveCommunityForm.do")
	public ResponseEntity<ServiceResult> leaveCommunityForm(@RequestBody CommunityMemberVO cmMemberVO
			,HttpServletRequest req){
		
		HttpSession session = req.getSession();
		
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();
		
//		//테스트용
//		int memNo = 1;

		cmMemberVO.setMemNo(memNo);

		ServiceResult res = communityService.removeApplyCommunity(cmMemberVO);

		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
	
	
	// 내 일정
	@ResponseBody
	@GetMapping("/student/community.ajax")
	public List<MyClassVO> scheduleList(HttpSession session) {
		log.info("classSchedule2().....");
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		log.info("member :: " + member);
		log.info("memNo :: " + member.getMemNo());
		
		MyClassVO myClassVO = new MyClassVO();
		ScheduleDataVO schduleDataVO = new ScheduleDataVO();
		myClassVO.setMemNo(member.getMemNo());
		schduleDataVO.setMemNo(member.getMemNo());
		
		return communityService.scheduleList(myClassVO);
	}
	
	/*
	// 일정 공유
	@ResponseBody
	@GetMapping("/student/classSchShare.ajax")
	public List<MyClassVO> classSchShare(int memNo) {
		log.info("classSchShare().." + memNo);
				
		MyClassVO myClassVO = new MyClassVO();
		myClassVO.setMemNo(memNo);
		
		return communityService.classSchShare(myClassVO);  // return : VO,Map => {}, List=> []		
	}
	*/
	
	// 공유 일정
	@ResponseBody
	@GetMapping("/student/allSchShare.ajax")
	public Map<String, Object> allSchShare(int memNo) {
		log.info("classSchShare().." + memNo);
				
		MyClassVO myClassVO = new MyClassVO();
		ScheduleDataVO scheduleDataVO = new ScheduleDataVO();

		myClassVO.setMemNo(memNo);
		scheduleDataVO.setMemNo(memNo);
		
		List<MyClassVO> classSchShare = communityService.classSchShare(myClassVO);
		List<ScheduleDataVO> scheduleShare = communityService.scheduleShare(scheduleDataVO);
		
		Map<String, Object> result = new HashMap<String, Object>();
	    result.put("classSchShare", classSchShare);
	    result.put("scheduleShare", scheduleShare);
		
		return result;
	}
	
	// 커뮤니티 일정 등록
	@PostMapping("/student/addCommunitySch.do")
	public String addCommunitySch(ScheduleDataVO scheduleDataVO, int cmNo) {
		log.info("scheduleDataVO : " + scheduleDataVO);		
		
		
		ServiceResult res = communityService.addCommunitySch(scheduleDataVO);
		
		
		return "redirect:/DYUniv/student/community/"+cmNo;
	}
	
	
	
	
}
