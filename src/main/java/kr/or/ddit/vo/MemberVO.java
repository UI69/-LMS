package kr.or.ddit.vo;

import java.util.List;

import kr.or.ddit.entity.MemRole;
import lombok.Data;

// 대학인원
@Data
public class MemberVO {

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
	private String memNationCode;

	private DepartmentVO departmentVO;
	private LectureVO lectureVO;
	
	private StudentInfoVO studentInfo;
	private ProfessorInfoVO professorInfo;
	private StaffInfoVO staffInfo;
	private List<DepartmentVO> departmentList;
	
	private List<StudentInfoVO> studentList;
	
	private String memRoleStr;
	
	public void setMemRole(String memRole) {
		this.memRole = memRole;
		
		if("ROL001".equals(memRole)) {
			memRoleStr = "학생";
		} else if("ROL002".equals(memRole)) {
			memRoleStr = "교수";
		} else if("ROL003".equals(memRole)) {
			memRoleStr = "교직원";
		}
	}
	
}
