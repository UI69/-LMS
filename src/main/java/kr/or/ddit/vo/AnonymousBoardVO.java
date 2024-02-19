package kr.or.ddit.vo;

import lombok.Data;


// 익명 게시판
@Data
public class AnonymousBoardVO {
	private int    anonBrdNo    ;
	private int    memNo         ;
	private String anonBrdTitle ;
	private String anonBrdCont  ;
	private String anonWriteDate;
	private int    anonHitCount ;
	
	private int lastWriter = 1;
}
