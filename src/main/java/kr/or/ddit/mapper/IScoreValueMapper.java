package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.ScoreValueVO;

public interface IScoreValueMapper {

	public List<ScoreValueVO> getAllScoreValueData();

	public List<LectureVO> getLectureList(int memNo);

}
