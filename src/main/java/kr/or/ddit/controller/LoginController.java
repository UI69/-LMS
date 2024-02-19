package kr.or.ddit.controller;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.entity.CommonCode;
import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.service.ILoginService;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class LoginController {
	//로그인 및 회원 정보 관련

	// 로그인 + OTP + 리캡챠
	// 로그아웃
	// 회원가입
	// 아이디 중복 체크
	// 아이디 찾기
	
	// 비밀번호 찾기 
	// 개인정보 수정
	// OTP 발급
	
	
	
	// 이 밑으로 구현 ============================================
	
	@Inject
	private ILoginService loginService;
	
	@GetMapping("/")
	public String LoginFormLink() {
		return "redirect:/login.do";
	}
	
	@GetMapping("/login.do")
	public String LoginForm() {
		log.info("LoginForm() run...");
		return "login";
	}
	
	// 로그인 + OTP + 리캡챠
	@PostMapping("/login.do")
	public String Login(Model model, MemberVO memberVO, int failCount, 
			boolean idRememberCheckbox, HttpServletRequest req, HttpServletResponse res) {
		log.info("login() run...");
//		log.info("input data : " + memberVO.toString());
//		log.info("failcnt : " + failCount);
//		if(idRememberCheckbox) {
//			log.info("true");
//		} else {
//			log.info("false");
//		}
		
		//아이디 검증
		MemberVO loginMember = loginService.login(memberVO);
		
		if(loginMember == null) {
			log.info("login result is empty...");
			
			// 실패시 검증 카운트 증가
			// 카운트 5회시 리캡챠
			model.addAttribute("failCount", failCount + 1);
			
			return "login";
			
		} else {
			log.info("login result : " + loginMember.toString());
			
			//OTP 설정 확인
				// 설정시 OTP 검증
			
			HttpSession session = req.getSession();
		
			session.setAttribute("member", loginMember);
			
			//아이디 기억 체크 확인
			if(idRememberCheckbox) {
				//session.setAttribute("rememberId", loginMember.getMemId());
//				Cookie cookie = new Cookie("rememberId",loginMember.getMemId());
//				res.addCookie(cookie);
				
			} else {
				//session.removeAttribute("rememberId");
			}
			
			if(loginMember.getMemTempPw().equals("true")) {
				return "redirect:/DYUniv/passCheck.do";
			}
			
			return "redirect:/DYUniv/mainpage.do";

		}
	}
	
	// 아이디 찾기 폼
	@RequestMapping(value="/findId.do" ,method = RequestMethod.GET)
	public String findIdForm() {
		return "/findId";
	}
	
	// 비밀번호 찾기 폼
	@RequestMapping(value="/findPw.do" ,method = RequestMethod.GET)
	public String findPwForm() {
		return "/findPw";
	}
	
	// 아이디 찾기 
	@ResponseBody
	@RequestMapping(value = "/findIdAjax.do", method = RequestMethod.POST)
	public ResponseEntity<String> findId(@RequestBody MemberVO memberVO) {
		
		MemberVO member = loginService.findId(memberVO);
		//log.info("member:" + member.toString());
		
		String findId = "";
		
		if(member != null) {
			findId = member.getMemId();
			log.info("member:" + member.toString());
		} else {
			log.info("member is empty....");
		}
		return new ResponseEntity<String>(findId,HttpStatus.OK);

	}
	
	
	// 비밀번호 찾기
	@ResponseBody
	@PostMapping("/findPwAjax.do")
	public ResponseEntity<String> findPw(@RequestBody MemberVO memberVO) {
		
		log.info("member:" + memberVO.toString());
		
		//아이디 확인 및 결과
		ServiceResult res = loginService.findPw(memberVO);
		
		if(res.equals(ServiceResult.OK)) {
			return new ResponseEntity<String>("success",HttpStatus.OK);
		} else {
			return new ResponseEntity<String>("failed",HttpStatus.OK);
		}
		
	}

		
	
	//로그아웃
	@GetMapping("/logout.do")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.removeAttribute("member");
		return "redirect:/login.do";
	}

	
	
}
