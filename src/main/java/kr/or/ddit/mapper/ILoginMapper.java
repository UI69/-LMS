package kr.or.ddit.mapper;

import kr.or.ddit.vo.MemberVO;

public interface ILoginMapper {

	MemberVO login(MemberVO memberVO);

	MemberVO findId(MemberVO memberVO);

	MemberVO findPw(MemberVO memberVO);
	
	int updatePw(MemberVO memberVO);
}
