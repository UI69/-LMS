package kr.or.ddit.vo;

import lombok.Data;

// 댓글
@Data
public class ReplyVO {

	private int rpNo;
	private int memNo;
	private int brdNo;
	private String rpWriter;
	private String rpCont;
	private String rpDate;
	
}
