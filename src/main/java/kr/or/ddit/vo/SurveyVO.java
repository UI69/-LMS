package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;


// 설문 조사 
@Data
public class SurveyVO {

	private int srvNo;
	private int memNo;
	private String srvName;
	private String srvCategory;
	private String srvEndDate;
	private String srvRegDate;
	
	private String srvCategoryStr;
	
	private int srvRegCount;
	
	private List<SurveyQuestionVO> srvQstList;
	
	private List<SurveyResultVO> srvResultList;

	public void setSrvCategory() {}
	
	public void setSrvCategory(String srvCategory) {
		this.srvCategory = srvCategory;
		
		if(srvCategory.equals("SRV001")) {
			srvCategoryStr = "대학 설문조사";
		} else if(srvCategory.equals("SRV002")) {
			srvCategoryStr = "일반 설문조사";
		}  
	}
}
