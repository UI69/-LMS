package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.ClassListenVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ReserveClassVO;

public interface ILectureService {

	List<ClassVO> getClassList(PaginationVO<ClassVO> pagingVO);

	ServiceResult addReservClass(ReserveClassVO reserveClassVO);

	ServiceResult ReservClassDuplicateCheck(ReserveClassVO reserveClassVO);

	List<ClassVO> reserveClassList(int memNo);

	ServiceResult removeReservClass(ReserveClassVO reserveClassVO);

	int addListenClass(ReserveClassVO recVO);

	List<ReserveClassVO> myReserveClassList(int memNo);

	List<DepartmentVO> getDprtList(PaginationVO<DepartmentVO> pagingVO);

	ServiceResult addDprt(DepartmentVO departmentVO);

	List<LectureVO> getLectureList(PaginationVO<LectureVO> pagingVO);

	List<ClassVO> getAllClassList(PaginationVO<ClassVO> pagingVO);

	ClassVO getClassDetail(int classNo);

	ServiceResult updateClassApply(ClassVO classVO);

	DepartmentVO getdprtInfo(int dprtNo);

	ServiceResult classDuplCheck(ReserveClassVO reserveClassVO);

	ClassListenVO classMemCntCheck(ReserveClassVO reserveClassVO);

	int  selectDprtCount(PaginationVO<DepartmentVO> pagingVO);

	List<ClassVO> getLecApplyList(PaginationVO<ClassVO> pagingVO);

	int getClassListCnt(PaginationVO<ClassVO> pagingVO);

	int getLecApplyListCnt(PaginationVO<ClassVO> apPagingVO);

	int getAllClassListCnt(PaginationVO<ClassVO> pagingVO);

	int getLectureListCnt(PaginationVO<LectureVO> pagingVO);

}
