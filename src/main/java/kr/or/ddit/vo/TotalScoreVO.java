package kr.or.ddit.vo;

import java.util.List;
import java.util.Map;

import lombok.Data;

@Data
public class TotalScoreVO {
	private List<ListenerVO> listenerList;
	private List<ListenerVO> examScoreList;
	private List<ListenerVO> hwScoreList;
	private List<Map<String, Object>> atScoreMap;
	
	private Integer examStandardScore;
	private Integer hwStandardScore;
	
	private ScoreValueVO scoreValueVO;
}
