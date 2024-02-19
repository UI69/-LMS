package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;


// 알림
@Data
public class AlarmVO {
	private int    almNo         ;
	private int    memNo         ;
	private String almMsg        ;
	private Date   almDate       ;
	private String almCheck_code ;
	private String almConn_url   ;
}
