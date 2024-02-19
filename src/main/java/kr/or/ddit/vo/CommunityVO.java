package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;


// 커뮤니티 그룹
@Data
public class CommunityVO {
	
	private int cmNo;
	private int memNo;
	private String cmName;
	private String cmMaster;
	private int cmMaxMem;
	private String cmType;
	private String cmGoal;
	private String cmOpenStatusCode;
	
	private int cmCount;
	
	private List<CommunityMemberVO> cmMemberList;
}
