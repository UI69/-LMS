package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ChangeDepartmentApplyVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.LectureScoreVO;
import kr.or.ddit.vo.MemberProVO;
import kr.or.ddit.vo.MemberStdInsVO;
import kr.or.ddit.vo.MemberStdVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ProfessorInfoVO;
import kr.or.ddit.vo.StudentInfoVO;
import kr.or.ddit.vo.TuitionVO;
import kr.or.ddit.vo.RestApplyVO;
import kr.or.ddit.vo.ScholarshipHistoryVO;

public interface IMemberMapper {
   
	public List<MemberVO> newStuList();
	public List<MemberVO> proList();
	public int excelUpload(Map<String, String> article); // 교수 일괄등록
	public int createMember(MemberProVO memberVO);
	public int createProID(ProfessorInfoVO professorInfo);
	public List<MemberVO> departmentList();
	public List<DepartmentVO> selectDprt(DepartmentVO departmentVO);   // 단과대학 선택
	
	public MemberStdVO gradCrtDetail(int memNo);// 졸업증명서 
	public MemberStdVO schCrtDetail(int memNo);// 재학증명서
	public MemberStdVO scoreCrtDetail(int memNo);   // 성적 증명서 
	public int setProInfo(ProfessorInfoVO infoVO);
   	public int studentUpload(Map<String, String> article); // 학생 일괄등록
	public int setStdInfo(StudentInfoVO infoVO);
	public int academicPCountPro(PaginationVO<MemberVO> pagingVO); // 페이징
	public List<MemberVO> proacademicPList(PaginationVO<MemberVO> pagingVO); // 리스트
	public MemberStdVO restInfo(int memNo);	// 학적변경 신청
	public int insertRestApply(RestApplyVO restApplyVO);// 학적변경 신청 요청
	public MemberStdVO deptInfo(int memNo);	// 전과 변경 신청 
	public List<DepartmentVO> departList(); //전공 목록 불러오기 
	public List<LectureScoreVO> myClassList(int memNo);	// 내 수강 리스트 가져오기
	public int insertDepartApply(ChangeDepartmentApplyVO changeDepartmentApplyVO);	// 전과신청(요청) - 등록
	public List<ScholarshipHistoryVO> mySchHistoryList(ScholarshipHistoryVO schVO);	// 장학금 받은 내역
	public List<TuitionVO> myTuitList(int memNo); // 등록금 납부 내역
	public int academicPCountStd(PaginationVO<MemberVO> pagingVO);
	public List<MemberVO> stdacademicPList(PaginationVO<MemberVO> pagingVO);
	public int createStdMember(MemberStdInsVO memberVO);
	public int createStdID(StudentInfoVO studentInfoVO);
	

   
   
}