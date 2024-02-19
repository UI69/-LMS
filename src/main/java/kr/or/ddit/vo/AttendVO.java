package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;


// 출석관리 
@Data
public class AttendVO {

	private int atNo;
	private int listenNo;
	private int memNo;
	private String atDate;
	private String atStatus;
	
	private List<String> sumAtStatus;
	
	
	
}
