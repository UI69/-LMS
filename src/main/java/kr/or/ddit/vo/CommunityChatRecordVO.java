package kr.or.ddit.vo;

import lombok.Data;

// 채팅 기록
@Data
public class CommunityChatRecordVO {

	
	private int chatNo;
	private int cmNo;
	private int memNo;
	private String chatMsg;
	private String chatSender;
	private String chatDate;
	private int fileNo;
	
	private String resString;
}
