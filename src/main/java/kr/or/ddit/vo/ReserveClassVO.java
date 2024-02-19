package kr.or.ddit.vo;

import lombok.Data;


//예비 수강 신청 목록
@Data
public class ReserveClassVO {

	private int classNo;
	private int memNo;
	private String resStatusCode;
	
	private String applyType;
	
	private int    lecNo           ;
	private String roomNo          ; 
	private String valueType       ; 
	private String className       ; 
	private int    lecPoint        ; 
	private String semester         ;
	private String classReqCode   ;  
	private int    classMaxMem    ;  
	private int    classTotalTime ;  
	private int    examProprion    ; 
	private int    hwPropotion     ; 
	private int    atPropotion     ; 
	private String classStatusCode	;
	private int    classWeekCnt   	;
	private String classNote       ; 
	private String classReject     ; 
	private int    fileNo          ; 
	
	private String dprtName;
	private String dprtCategory;
	
	
	//'RES001'
}
