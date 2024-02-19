package kr.or.ddit.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.mapper.ILectureMapper;
import kr.or.ddit.service.ILectureService;
import kr.or.ddit.vo.ClassListenVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ReserveClassVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class LectureServiceImpl implements ILectureService {

	@Inject
	private ILectureMapper lectureMapper;

	@Override
	public List<ClassVO> getClassList(PaginationVO<ClassVO> pagingVO) {
		return lectureMapper.getClassList(pagingVO);
	}
	
	@Override
	public List<LectureVO> getLectureList(PaginationVO<LectureVO> pagingVO) {
		return lectureMapper.getLectureList(pagingVO);
	}

	@Override
	public ServiceResult addReservClass(ReserveClassVO reserveClassVO) {
		ServiceResult res = null;
		int cnt = lectureMapper.addReservClass(reserveClassVO);
		if(cnt == 1) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		return res;
	}

	@Override
	public ServiceResult ReservClassDuplicateCheck(ReserveClassVO reserveClassVO) {
		ServiceResult res = ServiceResult.FAILED;
		int cnt = lectureMapper.ReservClassDuplicateCheck(reserveClassVO);
		if(cnt == 0) {
			res = ServiceResult.OK;
		}
		return res;
	}

	@Override
	public List<ClassVO> reserveClassList(int memNo) {
		return lectureMapper.reserveClassList(memNo);
	}

	@Override
	public ServiceResult removeReservClass(ReserveClassVO reserveClassVO) {
		ServiceResult res = null;
		int cnt = lectureMapper.removeReservClass(reserveClassVO);
		
		if(cnt == 1) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		return res;
	}

	@Override
	public int addListenClass(ReserveClassVO recVO) {
		
		int cres = 0;
		int ures = 0;
		
		// 수강인원 정보
		int totalClassListener = lectureMapper.totalClassListener(recVO.getClassNo());
		
		log.info("totalClassListener : " + totalClassListener);
		
		if(totalClassListener <= recVO.getClassMaxMem()) {
			// 수강신청
			cres = lectureMapper.addListenClass(recVO);
			
			// 예비수강신청 정보 재설정
			//ures = lectureMapper.updateResClassListenState(recVO);
			ures = lectureMapper.addReservClass(recVO);
		}
		
		if (cres != ures) {
			try {
				throw new Exception();
			} catch (Exception e) {
				 e.printStackTrace();
			}
		}
		
		return cres;
	}

	@Override
	public List<ReserveClassVO> myReserveClassList(int memNo) {
		return lectureMapper.myReserveClassList(memNo);
	}

	@Override
	public List<DepartmentVO> getDprtList(PaginationVO<DepartmentVO> pagingVO) {
		return lectureMapper.getDprtList(pagingVO);
	}

	@Override
	public ServiceResult addDprt(DepartmentVO departmentVO) {
		ServiceResult res = ServiceResult.FAILED;
		
		int cnt = lectureMapper.addDprt(departmentVO);
		
		if(cnt == 1) {
			res = ServiceResult.OK;
		}
		
		return res;
	}

	@Override
	public ClassVO getClassDetail(int classNo) {
		return lectureMapper.getClassDetail(classNo);
	}

	@Override
	public ServiceResult updateClassApply(ClassVO classVO) {
		ServiceResult res = ServiceResult.FAILED;
		int cnt = lectureMapper.updateClassApply(classVO);
		
		if(cnt == 1) {
			res = ServiceResult.OK;
		}
		return res;
	}

	@Override
	public DepartmentVO getdprtInfo(int dprtNo) {
		return lectureMapper.getdprtInfo(dprtNo);
	}

	@Override
	public ServiceResult classDuplCheck(ReserveClassVO reserveClassVO) {
		ServiceResult res = ServiceResult.FAILED;
		
		int cnt = lectureMapper.classDuplCheck(reserveClassVO);
		
		if(cnt == 0) {
			res = ServiceResult.OK;
		}
		
		return res;
	}

	@Override
	public ClassListenVO classMemCntCheck(ReserveClassVO reserveClassVO) {
		return lectureMapper.classMemCntCheck(reserveClassVO);
	}

	@Override
	public int selectDprtCount(PaginationVO<DepartmentVO> pagingVO) {
		return lectureMapper.selectDprtCount(pagingVO);
	}

	@Override
	public List<ClassVO> getLecApplyList(PaginationVO<ClassVO> pagingVO) {
		return lectureMapper.getLecApplyList(pagingVO);
	}

	@Override
	public int getClassListCnt(PaginationVO<ClassVO> pagingVO) {
		return lectureMapper.getClassListCnt(pagingVO);
	}

	@Override
	public int getLecApplyListCnt(PaginationVO<ClassVO> apPagingVO) {
		return lectureMapper.getLecApplyListCnt(apPagingVO);
	}

	@Override
	public List<ClassVO> getAllClassList(PaginationVO<ClassVO> pagingVO) {
		return lectureMapper.getAllClassList(pagingVO);
	}

	@Override
	public int getAllClassListCnt(PaginationVO<ClassVO> pagingVO) {
		return lectureMapper.getAllClassListCnt(pagingVO);
	}

	@Override
	public int getLectureListCnt(PaginationVO<LectureVO> pagingVO) {
		return lectureMapper.getLectureListCnt(pagingVO);
	}

}
