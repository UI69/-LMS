package kr.or.ddit.service;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.ChangeDepartmentApplyVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.LectureScoreVO;
import kr.or.ddit.vo.MemberProVO;
import kr.or.ddit.vo.MemberStdInsVO;
import kr.or.ddit.vo.MemberStdVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.WidgetVO;
import kr.or.ddit.vo.RestApplyVO;
import kr.or.ddit.vo.ScholarshipHistoryVO;
import kr.or.ddit.vo.TuitionVO;

public interface IMemberService {

	public List<MemberVO> newStuList(); // 신입생 리스트
	public List<MemberVO> proList(); // 교수 리스트
	public ServiceResult excelUpload(File destFile); // 교수 일괄 등록
	public ServiceResult createProID(MemberProVO memberVO); // 교수 계정 생성
	public List<MemberVO> departmentList();	// 단과대학 리스트
	public List<DepartmentVO> selectDprt(DepartmentVO departmentVO); // 단과대학 선택

	public MemberStdVO gradCrtDetail(int memNo); // 졸업 증명서 
	public MemberStdVO schCrtDetail(int memNo);		//재학 증명서
	public MemberStdVO scoreCrtDetail(int memNo);	//성적 증명서
	public MemberStdVO restInfo(int memNo);	// 학적 변동신청 
	public int insertRestApply(RestApplyVO restApplyVO);// 학적변동 신청 요청(등록)
	public MemberStdVO deptInfo(int memNo);	// 전과 신청 
	public List<DepartmentVO> departList();	// 전공 목록 
	public ServiceResult studentUpload(File destFile); // 학생 일괄등록
	public int academicPCountPro(PaginationVO<MemberVO> pagingVO); // 페이징
	public List<MemberVO> proacademicPList(PaginationVO<MemberVO> pagingVO);
	public List<LectureScoreVO> myClassList(int memNo);	// 내 수강 리스트 가져오기
	public int insertDepartApply(ChangeDepartmentApplyVO changeDepartmentApplyVO);	// 전과신청 등록
	public List<ScholarshipHistoryVO> mySchHistoryList(ScholarshipHistoryVO schVO);	// 장학금 받은 내역 
	public List<TuitionVO> myTuitList(int memNo);	// 등록금 납부 내역
	public MemberVO selectMember(String memId);	//  학생 상세 정보 profile
	public MemberVO empselectmember(String memId);	// 관리자 상세 정보 
	public MemberVO proselectmember(String memId);	// 교수 상세 정보 
	public int UpdProfilePro(MemberVO memberVO);// 회원 상세정보 변경
//	public ServiceResult profileImgUpd(HttpServletRequest req, MemberVO memberVO);	// 프로필 이미지 업뎃
	public int academicPCountStd(PaginationVO<MemberVO> pagingVO); // 학생목록
	public List<MemberVO> stdacademicPList(PaginationVO<MemberVO> pagingVO);
	public MemberVO passCheck(MemberVO member);
	public ServiceResult createStdID(MemberStdInsVO memberVO);
	

}
