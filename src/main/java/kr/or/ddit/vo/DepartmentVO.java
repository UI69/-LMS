package kr.or.ddit.vo;

import lombok.Data;

// 학과
@Data
public class DepartmentVO {

	private int dprtNo;
	private String dprtName;
	private String dprtCategory;
	private int dprtTuition;
	private int dprtSrvTime;
	private int dprtLecPoint;
	private int semMaxLecPoint;
	
	private String dprtCategoryStr;
	
	public void setDprtCategory(String dprtCategory) {
	    this.dprtCategory = dprtCategory;
	    
	    if ("DPC001".equals(dprtCategory)) {
	        this.dprtCategoryStr = "인문";
	    } else if("DPC002".equals(dprtCategory)) {
	        this.dprtCategoryStr = "사회";
	    } else if("DPC003".equals(dprtCategory)) {
	        this.dprtCategoryStr = "교육";
	    } else if("DPC004".equals(dprtCategory)) {
	        this.dprtCategoryStr = "공학";
	    } else if("DPC005".equals(dprtCategory)) {
	        this.dprtCategoryStr = "자연";
	    } else if("DPC006".equals(dprtCategory)) {
	        this.dprtCategoryStr = "의약";
	    } else if("DPC007".equals(dprtCategory)) {
	        this.dprtCategoryStr = "예체능";
	    }
	}
	
}
