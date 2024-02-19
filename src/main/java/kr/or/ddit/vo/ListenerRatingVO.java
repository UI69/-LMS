package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class ListenerRatingVO {
	private int classNo;
	private int listenNo;
	private int memNo;
	private String classComment;
	private String lsStatusCode;
	
	List<LectureRatingVO> lecRatingList;
}
