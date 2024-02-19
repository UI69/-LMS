package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.ClassListenVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.ReserveClassVO;

public interface ILectureMapper {

	List<ClassVO> getClassList(PaginationVO<ClassVO> pagingVO);

	int addReservClass(ReserveClassVO reserveClassVO);

	int ReservClassDuplicateCheck(ReserveClassVO reserveClassVO);

	List<ClassVO> reserveClassList(int memNo);

	int removeReservClass(ReserveClassVO reserveClassVO);

	int addListenClass(ReserveClassVO recVO);

	List<ReserveClassVO> myReserveClassList(int memNo);

	int totalClassListener(int classNo);

	int updateResClassListenState(ReserveClassVO recVO);

	List<DepartmentVO> getDprtList(PaginationVO<DepartmentVO> pagingVO);

	int addDprt(DepartmentVO departmentVO);

	List<LectureVO> getLectureList(PaginationVO<LectureVO> pagingVO);

	List<ClassVO> getAllClassList(PaginationVO<ClassVO> pagingVO);

	ClassVO getClassDetail(int classNo);

	int updateClassApply(ClassVO classVO);

	DepartmentVO getdprtInfo(int dprtNo);

	int classDuplCheck(ReserveClassVO reserveClassVO);

	ClassListenVO classMemCntCheck(ReserveClassVO reserveClassVO);

	int selectDprtCount(PaginationVO<DepartmentVO> pagingVO);

	List<ClassVO> getLecApplyList(PaginationVO<ClassVO> pagingVO);

	int getClassListCnt(PaginationVO<ClassVO> pagingVO);

	int getLecApplyListCnt(PaginationVO<ClassVO> pagingVO);

	int getAllClassListCnt(PaginationVO<ClassVO> pagingVO);

	int getLectureListCnt(PaginationVO<LectureVO> pagingVO);

}
