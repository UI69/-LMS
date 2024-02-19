package kr.or.ddit.vo;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

// 학사 일정
@Data
public class UnivScheduleVO {

	private int univSchNo;
	private String univSchName;
	@NotBlank(message="시작 일시를 입력해주세요.")
	private String univSchStartDate;
	@NotBlank(message="종료 일시를 입력해주세요.")
	private String univSchEndDate;
	private String univSchCont;
	private String univSchSem;
	private String univSchReg;
	private String univSchType = "";
	
}
