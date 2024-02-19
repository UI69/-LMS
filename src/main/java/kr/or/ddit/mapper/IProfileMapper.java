package kr.or.ddit.mapper;

import kr.or.ddit.vo.MemberVO;

public interface IProfileMapper {

	public MemberVO selectMember(String memId);	// 학생 상세 정보 profile

	public MemberVO empselectmember(String memId);	// 관리자 상세 정보 

	public MemberVO proselectmember(String memId);	// 교수 상세 정보 

	public int UpdProfilePro(MemberVO memberVO); // 회원 상세정보 변경

	public MemberVO passCheck(MemberVO member);	// 내정보 2차 인증


}
