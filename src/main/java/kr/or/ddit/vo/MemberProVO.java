package kr.or.ddit.vo;

import java.util.List;

import kr.or.ddit.entity.MemRole;
import lombok.Data;

// 대학인원
@Data
public class MemberProVO {

	private int memNo;
	private int dprtNo;
	private String memId;
	private String memPw;
	private String memName;
	private String memGen;
	private String memBir;
	private String memPh;
	private String memEmail;
	private int memPostcode;
	private String memAddr1;
	private String memAddr2;
	private String otpKey;
	private String memProfile;
	private String memRole;
	private String memTempPw;
	

	private String memJoinDate;
	private String memEndDate;
	private String memProCode;

//	public String getMemRole() {
//		return memRole.getValue();
//	}
//	
//	public void setMemRole(String code) {
//		this.memRole = MemRole.getCode(code);
//	}
	
}
