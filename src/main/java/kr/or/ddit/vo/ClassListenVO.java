package kr.or.ddit.vo;

import lombok.Data;

@Data
public class ClassListenVO {

	private int memNo;
	private int classNo;
	
	private int classMaxMem;
	
	private int totalMember;
	
	private boolean enabledApply;
	private String applyType;
	
	public boolean getEnabledApply() {
		if(totalMember < classMaxMem) {
			return true;
		} else {
			return false;
		}
	}
	
	public void applySuccessMem() {
		totalMember++;
		applyType = "success";
	}
}
