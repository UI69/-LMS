package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.ScoreValueVO;

public interface IScoreValueService {

	public List<ScoreValueVO> getAllScoreValueData();

	public List<LectureVO> getLectureList(int memNo);

}
