package kr.or.ddit.controller;

import java.util.Date;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.entity.FileType;
import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.ILoginService;
import kr.or.ddit.service.IMemberService;
import kr.or.ddit.utils.UploadFileUtils;
import kr.or.ddit.vo.ChangeDepartmentApplyVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.LectureScoreVO;
import kr.or.ddit.vo.MemberStdVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.RestApplyVO;
import kr.or.ddit.vo.ScholarshipHistoryVO;
import kr.or.ddit.vo.TuitionVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class MemberInfoController {

	@Inject
	private IMemberService memberService;
	
	@Inject
	private ILoginService loginService;
	
	
	// 학적 변동 신청 폼  불러오기
	@GetMapping("/restApplyForm.do")
	public String restApply(Model model,HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();
		
		// 정보꺼내오기 위해서 사용
		MemberStdVO memberInfo = memberService.restInfo(memNo);
		
		
		//신청 정보 검색, 중복 신청 방지용
		
		
		// 재학 휴학인 놈들만 들어가게 한다
		if(memberInfo.getStudentInfoVO().getMemStatusCode().equals("MEM001") ||
				memberInfo.getStudentInfoVO().getMemStatusCode().equals("MEM002")) {
			model.addAttribute("memberInfo",memberInfo);
			
			return "student/restApplyForm";
			
		} else {
			return "redirect:/DYUniv/mainpage.do";
		}
		
	}
	
	// 학적 변동  요청 
	@PostMapping("/restApplyForm.do")
	public String restApplyForm(Model model, RestApplyVO  restApplyVO, 
			HttpServletRequest req, RedirectAttributes ra) {
		
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		
		restApplyVO.setMemNo(memberVO.getMemNo());

		//신청 정보 등록
		int res = memberService.insertRestApply(restApplyVO);
		
		if(res == 1) {
			ra.addFlashAttribute("message","신청완료");
			return "redirect:/DYUniv/mainpage.do";
		} else {
			ra.addFlashAttribute("message", "신청에 실패하였습니다");
			return "redirect:/student/restApplyForm";
		}
	}
	
	
	// 전과신청 
	@GetMapping("/departChange.do")
	public String departChange(Model model, HttpServletRequest req ) {
		HttpSession session = req.getSession();
		
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		
		int memNo = memberVO.getMemNo();
		
		
		//전과 신청 중복 검색, 중복 신청 방지용
		
		
		MemberStdVO memberDpart = memberService.deptInfo(memNo);
		System.out.println("memNo ::" +memNo);
		
		// 전과명 리스트 목록 불러오기 
		List<DepartmentVO> departList = memberService.departList();
		
		// 내 수강 리스트 가져오기
		List<LectureScoreVO> myClassList = memberService.myClassList(memNo);

		memberDpart.setLectureScoreList(myClassList);
		
		model.addAttribute("departList", departList);
		System.out.println("departList :::" +departList);
		
		// 총 성적 평균
		int sum = 0;
		int point = 0;
		for(LectureScoreVO lectureScore : memberDpart.getLectureScoreList()) {
			// (과목당 받은 점수 * 학점) + (과목당 받은 점수 * 학점) +  = 총 sum...
			// 총 sum / 과목 당 모든 학점 = 성적의 평균
			sum += lectureScore.getLecScr() * lectureScore.getLecPoint();
			point += lectureScore.getLecPoint();
		}
			
		
		
		double totalGrade = (double)sum / point;
		memberDpart.setMemTotalGrade(totalGrade + "");
		
		if(memberDpart.getStudentInfoVO().getMemStatusCode().equals("MEM001")){
			model.addAttribute("memberDpart",memberDpart);
			
			return "student/departChange";
			
		} else {
			return "redirect:/DYUniv/mainpage.do";
		}
		
	}
	
	// 전과신청 등록 요청 
	@PostMapping("/departChange.do")
	public String dptChangeForm (Model model,  ChangeDepartmentApplyVO changeDepartmentApplyVO,
			HttpServletRequest req, RedirectAttributes ra) {
		
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		
		changeDepartmentApplyVO.setMemNo(memberVO.getMemNo());
		
		// 신청 정보 등록
		int res = memberService.insertDepartApply(changeDepartmentApplyVO);
		
		if(res == 1) {
			ra.addFlashAttribute("message","신청완료");
			return "redirect:/DYUniv/mainpage.do";
		}else {
			ra.addFlashAttribute("message", "신청에 실패하였습니다");
			return "redirect:/student/departChange";
		}
	}
	
	// 등록금 장학금 목록 조회 		// 검색 기능 을 따로넣어야하는데 어케하노...
	@RequestMapping("/scholshipTuition.do")
	public String scholarship(Model model,HttpServletRequest req,
			@RequestParam(required = false) String sclDate,
			@RequestParam(required = false) String semester) {
		
		HttpSession session = req.getSession();
		
		Date date = new Date();
		
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int memNo = memberVO.getMemNo();
		
		ScholarshipHistoryVO schVO = new ScholarshipHistoryVO();
		// 장학금 검색
		if(StringUtils.isNotBlank(sclDate)) {
			schVO.setSclDate(sclDate);
			model.addAttribute("sclDate", sclDate);
		}

		// 등록금 검색
		if(StringUtils.isNotBlank(semester)) {
			schVO.setSchType(semester);
			model.addAttribute("semester", semester);
		}
		
		System.out.println("semester??? ::" + semester);
		System.out.println("sclDate??? :: " + sclDate);
		// 장학금
		schVO.setMemNo(memNo);
		List<ScholarshipHistoryVO> mySchHistoryList = memberService.mySchHistoryList(schVO);
		
		
		// 등록금
		List<TuitionVO> myTuitList = memberService.myTuitList(memNo);
	
		// 로그인 정보 를세션에서 가져오기 위해서  사용
		MemberStdVO memberInfo = memberService.restInfo(memNo);
		
		// 
		if(memberInfo.getStudentInfoVO().getMemStatusCode().equals("MEM001") ||
				memberInfo.getStudentInfoVO().getMemStatusCode().equals("MEM002") ||
				memberInfo.getStudentInfoVO().getMemStatusCode().equals("MEM003") ||
				memberInfo.getStudentInfoVO().getMemStatusCode().equals("MEM004")){
			
			model.addAttribute("memberInfo",memberInfo);
			model.addAttribute("mySchHistoryList", mySchHistoryList);	// 장학금 수여 리스트
			model.addAttribute("myTuitList", myTuitList);	// 등록금 납부 내역
//				model.addAttribute("myTuitList",date);
			System.out.println("myTuitList :::" +myTuitList);
			System.out.println("mySchHistoryList :::" +mySchHistoryList);
			
			return "student/scholshipTuition";
			
		} else {
			
			return "redirect:/DYUniv/mainpage.do";
		}	

		
	}
	
	// 내정보 상세보기 전 비번 인증 
	@GetMapping(value = "/passCheck.do")
	public String pwCertified (Model model, HttpServletRequest req) {
		
		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("member");
		
		if(memberVO.getMemTempPw().equals("true")) {
			model.addAttribute("resetPw", "비밀번호가 초기화 되었습니다.<br>비밀번호를 재설정 해주세요.");			
		}
		return "certificate/pwCertified";
	}

	@RequestMapping(value = "/passCheck.do", method = RequestMethod.POST)
	public String passCheck(Model model,
			HttpServletRequest req,
			RedirectAttributes ra, String memPw) {
		
		HttpSession session = req.getSession();
		
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		
		if(memberVO.getMemPw().equals(memPw)) {
			
			if(memberVO.getMemRole().equals("ROL003")) {
				//관리자 정보
				MemberVO empmember = memberService.empselectmember(memberVO.getMemId());
				model.addAttribute("empmember",empmember);
				System.out.println("empmember 교직원 : "+ empmember);
				return "employer/profile";
			} else if(memberVO.getMemRole().equals("ROL002")) {
				//교수정보
				MemberVO promember = memberService.proselectmember(memberVO.getMemId());
				model.addAttribute("promember",promember);
				System.out.println("promember 교수 : "+ promember);
				return "professor/profile";
			} else /* (memberVO.getMemRole().equals("학생코드")) */ {
				MemberVO stdmember = memberService.selectMember(memberVO.getMemId());
				model.addAttribute("stdmember", stdmember);
				
				return "student/profile";
			}
			
		}else  {
			ra.addFlashAttribute("message", "인증에  실패하였습니다");
			return "redirect:/DYUniv/mainpage.do";
	
		}
		
	}	

	// 교수 개인정보 변경 
	@PostMapping(value = "/updProfile.do")
	public String profileUpdate(Model model, 
			HttpServletRequest req, RedirectAttributes ra , MemberVO memberVO) {	
	
		memberVO.setMemTempPw("false");
		int UpdProfilePro = memberService.UpdProfilePro(memberVO);
		log.info("memberVO :" + memberVO);
		log.info("UpdProfilePro :" + UpdProfilePro);
		
		if(UpdProfilePro == 1) {
			log.info("update success...");
			ra.addFlashAttribute("message", "저장에 성공했습니다");
			return "redirect:/DYUniv/mainpage.do";
		}else {
			ra.addFlashAttribute("message", "저장에 실패 했습니다");
			
			if(memberVO.getMemRole().equals("ROL003")) {
				//관리자 정보
				MemberVO empmember = memberService.empselectmember(memberVO.getMemId());
				model.addAttribute("empmember",empmember);
				System.out.println("empmember 교직원 : "+ empmember);
				return "employer/profile";
			} else if(memberVO.getMemRole().equals("ROL002")) {
				//교수정보
				MemberVO promember = memberService.proselectmember(memberVO.getMemId());
				model.addAttribute("promember",promember);
				System.out.println("promember 교수 : "+ promember);
				return "professor/profile";
			} else /* (memberVO.getMemRole().equals("학생코드")) */ {
				MemberVO stdmember = memberService.selectMember(memberVO.getMemId());
				model.addAttribute("stdmember", stdmember);
				
				return "student/profile";
			}
		}
	}
	
	
	// 프로필 이미지 업뎃
	@ResponseBody
	@RequestMapping(value = "/profileFileUpload.ajax", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> profileImg(
			MultipartFile files,
			HttpServletRequest req,
			RedirectAttributes ra, Model model) {
		
		log.info("files : " + files);
		
		String resultStr = "failed";
		
		try {
			FilesVO filesVO = UploadFileUtils.uploadFile(files, FileType.MEMBER_PROFILE, req);
			resultStr = filesVO.getThumbnail();
			log.info("resultStr" + resultStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<String>(resultStr, HttpStatus.OK);
	}
		
}


