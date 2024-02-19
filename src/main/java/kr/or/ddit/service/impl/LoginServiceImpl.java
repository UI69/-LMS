package kr.or.ddit.service.impl;


import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.mapper.ILoginMapper;
import kr.or.ddit.service.ILoginService;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LoginServiceImpl implements ILoginService {

	@Inject
	private ILoginMapper loginMapper;

	@Inject
	private JavaMailSender mailSender;
	
	@Override
	public MemberVO login(MemberVO memberVO) {
		return loginMapper.login(memberVO);
	}

	@Override
	public MemberVO findId(MemberVO memberVO) {
		return loginMapper.findId(memberVO);
	}

	@Override
	public ServiceResult findPw(MemberVO memberVO) {
		
		//아이디 확인
		MemberVO findMember = loginMapper.findPw(memberVO);
		
		if(findMember == null) {
			// 결과 없음, 
			return ServiceResult.FAILED;
		}
		
		//찾는 아이디가 있을때
		// 임시 비밀번호 생성
		String pw = "";
		for (int i = 0; i < 12; i++) {
			pw += (char) ((Math.random() * 26) + 97);
		}
		
		//임시 비밀번호 저장
		//log.info("비밀번호 => {}", pw);
		memberVO.setMemPw(pw);
		memberVO.setMemTempPw("true");		// 임시비밀번호 확인용
		int cnt = loginMapper.updatePw(memberVO);
		
		if(cnt == 1) {
			ServiceResult res = sendEmail(memberVO,"findpw");
			return res;
			
		} else {
			return ServiceResult.FAILED;
		}
		
		
		
	}

	//비밀번호 찾기 이메일발송
	@Override
	public ServiceResult sendEmail(MemberVO vo, String div) {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP =  "smtp.naver.com";
		String hostSMTPid = "yullstagera@naver.com";
		String hostSMTPpwd = "wlgh123!";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "yullstagram@naver.com";
		String fromName = "대육대학교";
		String subject = "";
		String msg = "";

		if(div.equals("findpw")) {
			subject = "대육대학교 학사관리 임시 비밀번호 입니다.";
			
			msg += "<hr>";
			msg += "<div align='center' font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += vo.getMemName() + "님의 임시 비밀번호가 발급되어었습니다.</h3>";
			
			msg += "<p>임시 비밀번호 : ";
			msg += vo.getMemPw() + "</p><br><hr>";
			msg += "<p> " + vo.getMemName() + "님, 로그인시 비밀번호를 변경하여 사용하세요.</p>";
			msg += "</div>";
			
		}

		MimeMessage message = mailSender.createMimeMessage();
		
		// 받는 사람 E-Mail 주소
		String mail = vo.getMemEmail();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setSubject(subject);
			
			//받는사람
			messageHelper.setTo(vo.getMemEmail());
			//보내는사람
			messageHelper.setFrom(fromEmail, fromName);
			
			messageHelper.setText(msg,true);
			mailSender.send(message);

			return ServiceResult.OK;
			
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
			return ServiceResult.FAILED;
		}
	}



}
