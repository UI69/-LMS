package kr.or.ddit.service;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.MemberVO;

public interface ILoginService {

	MemberVO login(MemberVO memberVO);

	MemberVO findId(MemberVO memberVO);
	
	ServiceResult findPw(MemberVO memberVO);

	public ServiceResult sendEmail(MemberVO memberVO, String div);

	
}
