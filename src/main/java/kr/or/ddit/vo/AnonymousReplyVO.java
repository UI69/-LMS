package kr.or.ddit.vo;

import lombok.Data;


// 익명 게시판 댓글
@Data
public class AnonymousReplyVO {

	
	private int anonRpNo;
	private int anonBrdNo;
	private int memNo;
	private String anonRpWriter;
	private String anonRpCont;
	private String anonRpWriteDate;
	
}
