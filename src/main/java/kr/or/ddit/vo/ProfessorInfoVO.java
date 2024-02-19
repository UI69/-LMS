package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

// 교수 정보
@Data
public class ProfessorInfoVO {
	
	private int memNo;
	private String memJoinDate;
	private String memOutDate;
	private String memProCode;
	
	private DepartmentVO departmentVO;
	
}