package kr.or.ddit.service.impl;

import java.io.File;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.mapper.IMemberMapper;
import kr.or.ddit.mapper.IProfileMapper;
import kr.or.ddit.service.IMemberService;
import kr.or.ddit.utils.excel.ExcelRead;
import kr.or.ddit.utils.excel.ExcelReadOption;
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
import kr.or.ddit.vo.WidgetVO;
import kr.or.ddit.vo.RestApplyVO;
import kr.or.ddit.vo.ScholarshipHistoryVO;

@Service
@Transactional(rollbackFor = Exception.class)
public class MemberServiceImpl implements IMemberService {
	
	@Inject
	private IMemberMapper memberMapper;

	@Inject
	private IProfileMapper profileMapper;
	
	// 학생 리스트
	@Override
	public List<MemberVO> newStuList() {		
		return memberMapper.newStuList();
	}

	// 교수 리스트
	@Override
	public List<MemberVO> proList() {
		return memberMapper.proList();
	}


	// 교수 일괄 생성
	@Override
	public ServiceResult excelUpload(File destFile) {
		
		ServiceResult res = ServiceResult.FAILED;
		
		ExcelReadOption excelReadOption = new ExcelReadOption();
        excelReadOption.setFilePath(destFile.getAbsolutePath()); //파일경로 추가
        excelReadOption.setOutputColumns("A", "B", "C", "D", "E", "F", "G", "H", "I"); //추출할 컬럼명 추가
        excelReadOption.setStartRow(2); //시작행(헤더부분 제외)
        
        List<Map<String, String>> excelContent  = ExcelRead.read(excelReadOption);
        
        int resCnt = 0;
        int infoCnt = 0;
        int year = Calendar.getInstance().get(Calendar.YEAR);
        
        try {
        	for(Map<String, String> article: excelContent){
            	article.put("memNo", "");
            	article.put("dprtNo", "1");
            	article.put("year", String.valueOf(year).substring(2,4));
            	
            	//System.out.println("excel Data : " + article);
            	
            	resCnt += memberMapper.excelUpload(article);
            	
            	ProfessorInfoVO infoVO = new ProfessorInfoVO();
            	String memNoStr = String.valueOf(article.get("memNo"));
            	infoVO.setMemNo(Integer.parseInt(memNoStr));
            	infoVO.setMemProCode("MPR002");
            	infoCnt += memberMapper.setProInfo(infoVO);        	
            }        
            if(resCnt == excelContent.size() && resCnt == infoCnt) {
            	res = ServiceResult.OK;
            } else {
            	throw new Exception();
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
        
		return res;
	}

   // 교수 계정 생성
   @Override
   public ServiceResult createProID(MemberProVO memberVO) {
      ServiceResult res = ServiceResult.FAILED;
      
      int cnt = 0;
      int result = memberMapper.createMember(memberVO);
      
      //System.out.println("memberVO(service) : " + memberVO);
      
      if(result > 0) {   
         ProfessorInfoVO professorInfo = new ProfessorInfoVO();
         professorInfo.setMemNo(memberVO.getMemNo());
         professorInfo.setMemJoinDate(memberVO.getMemJoinDate());
         professorInfo.setMemProCode(memberVO.getMemProCode());
         
         cnt += memberMapper.createProID(professorInfo);
         //System.out.println("cnt" + cnt);
      } else {
         return res;
      }
      
      if(cnt > 0)
      {
         res = ServiceResult.OK;
      } else {
         try {
            throw new Exception();
         } catch (Exception e) {
            System.out.println("회원 정보 insert error...");
            e.printStackTrace();
         }
      }   
      return res;
   }
	
	// 단과대학 리스트
	@Override
	public List<MemberVO> departmentList() {
		return memberMapper.departmentList();
	}
	
	// 단과대학 선택
	@Override
	public List<DepartmentVO> selectDprt(DepartmentVO departmentVO) {
		return memberMapper.selectDprt(departmentVO);
	}

	// 졸업증명서 
	@Override
	public MemberStdVO gradCrtDetail(int memNo) {
		return memberMapper.gradCrtDetail(memNo);
	}
	
	// 재학증명서
	@Override
	public MemberStdVO schCrtDetail(int memNo) {
		return memberMapper.schCrtDetail(memNo);
	}

	// 성적 증명서 
	@Override
	public MemberStdVO scoreCrtDetail(int memNo) {
		return memberMapper.scoreCrtDetail(memNo);
	}


	// 학적변경 신청
	@Override
	public MemberStdVO restInfo(int memNo) {
		return memberMapper.restInfo(memNo);
	}
	
	// 학생 일괄 등록
	@Override
	public ServiceResult studentUpload(File destFile) {
		ServiceResult res = ServiceResult.FAILED;
		ExcelReadOption excelReadOption = new ExcelReadOption();
	    excelReadOption.setFilePath(destFile.getAbsolutePath()); //파일경로 추가
	    excelReadOption.setOutputColumns("A", "B", "C", "D", "E", "F", "G", "H", "I"); //추출할 컬럼명 추가
	    excelReadOption.setStartRow(2); //시작행(헤더부분 제외)
	    
	    List<Map<String, String>> excelContent  = ExcelRead.read(excelReadOption);
	    
	    int resCnt = 0;
	    int infoCnt = 0;
	    int year = Calendar.getInstance().get(Calendar.YEAR);
	    
	    try {
	    	for(Map<String, String> article: excelContent){
		    	article.put("memNo", "");
		    	article.put("dprtNo", "1");
		    	article.put("pw", "1234");
		    	article.put("year", String.valueOf(year).substring(2,4));
		    	
		    	System.out.println("excel Data : " + article);
		    	
		    	resCnt += memberMapper.studentUpload(article);
		    	
		    	StudentInfoVO infoVO = new StudentInfoVO();
		//    	String memNoStr = String.valueOf(article.get("memNo"));
		//    	infoVO.setMemNo(Integer.parseInt(memNoStr));
		//    	infoVO.setMemProCode("MPR002");
		    	
		    	String memNoStr = String.valueOf(article.get("memNo"));
		    	
		    	infoVO.setMemNo(Integer.parseInt(memNoStr));
		    	infoVO.setMemStatusCode("MEM001");
		    	infoVO.setMemStdGrade(1);
		    	
		    	infoCnt += memberMapper.setStdInfo(infoVO);
		    	
		    }
		    
		    if(resCnt == excelContent.size() && resCnt == infoCnt) {
		    	res = ServiceResult.OK;
		    } else {
		    	throw new Exception();
		    }
		} catch (Exception e) {
			e.printStackTrace();
		}
	    
		return res;
	}


	// 학적변경 신청 요청
	@Override
	public int insertRestApply(RestApplyVO restApplyVO) {
		return memberMapper.insertRestApply(restApplyVO);
	}



	// 전과 신청 
	@Override
	public MemberStdVO deptInfo(int memNo) {
		return memberMapper.deptInfo(memNo);
	}

	// DEPARTMENT 전공 목록 불러오기 
	@Override
	public List<DepartmentVO> departList() {
		return memberMapper.departList();
	}
	@Override
	public int academicPCountPro(PaginationVO<MemberVO> pagingVO) {
		return memberMapper.academicPCountPro(pagingVO);
	}

	@Override
	public List<MemberVO> proacademicPList(PaginationVO<MemberVO> pagingVO) {
		return memberMapper.proacademicPList(pagingVO);

	}

	@Override
	public int academicPCountStd(PaginationVO<MemberVO> pagingVO) {
		return memberMapper.academicPCountStd(pagingVO);
	}
	
	@Override
	public List<MemberVO> stdacademicPList(PaginationVO<MemberVO> pagingVO) {
		return memberMapper.stdacademicPList(pagingVO);
	}
	// 내 수강 리스트 가져오기
	@Override
	public List<LectureScoreVO> myClassList(int memNo) {
		return memberMapper.myClassList(memNo);
	}

	// 전과신청 등록 
	@Override
	public int insertDepartApply(ChangeDepartmentApplyVO changeDepartmentApplyVO) {
		return memberMapper.insertDepartApply(changeDepartmentApplyVO);
	}

	// 장학금 받은내역
	@Override
	public List<ScholarshipHistoryVO> mySchHistoryList(ScholarshipHistoryVO schVO) {
		return memberMapper.mySchHistoryList(schVO);
	}

	// 등록금 납부 내역
	@Override
	public List<TuitionVO> myTuitList(int memNo) {
		return memberMapper.myTuitList(memNo);
	}

	// 학생 상세 정보 profile
	@Override
	public MemberVO selectMember(String memId) {
		return profileMapper.selectMember(memId);
	}
	// 관리자 상세 정보 profile
	@Override
	public MemberVO empselectmember(String memId) {
		// TODO Auto-generated method stub
		return profileMapper.empselectmember(memId);
	}
	// 교수 상세 정보 profile
	@Override
	public MemberVO proselectmember(String memId) {
		// TODO Auto-generated method stub
		return profileMapper.proselectmember(memId);
	}

	// 회원 상세정보 변경
	@Override
	public int UpdProfilePro(MemberVO memberVO) {
		return profileMapper.UpdProfilePro(memberVO);

	}

	@Override
	public MemberVO passCheck(MemberVO member) {
		// TODO Auto-generated method stub
		return profileMapper.passCheck(member);
	}

	@Override
	public ServiceResult createStdID(MemberStdInsVO memberVO) {
		ServiceResult res = ServiceResult.FAILED;
	      
	      int cnt = 0;
	      int result = memberMapper.createStdMember(memberVO);
	      
	      //System.out.println("memberVO(service) : " + memberVO);
	      
	      if(result > 0) {   
	         StudentInfoVO studentInfoVO = new StudentInfoVO();
	         studentInfoVO.setMemNo(memberVO.getMemNo());
	         studentInfoVO.setMemStatusCode(memberVO.getMemStatusCode());
	         
//	         if(memberVO.getMemRegDate() == null || memberVO.getMemRegDate().equals("")) {
//	        	 Calendar cal = Calendar.getInstance();
//	        	 String dateStr = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH) + 1) + "-" + cal.get(Calendar.DAY_OF_MONTH);
//	        	 studentInfoVO.setMemRegDate(dateStr);
//	         } else {
//	        	 studentInfoVO.setMemRegDate(memberVO.getMemRegDate());
//	         }
	         
	         cnt += memberMapper.createStdID(studentInfoVO);
	         //System.out.println("cnt" + cnt);
	      } else {
	         return res;
	      }
	      
	      if(cnt > 0)
	      {
	         res = ServiceResult.OK;
	      } else {
	         try {
	            throw new Exception();
	         } catch (Exception e) {
	            System.out.println("회원 정보 insert error...");
	            e.printStackTrace();
	         }
	      }   
	      return res;
	}

	
}