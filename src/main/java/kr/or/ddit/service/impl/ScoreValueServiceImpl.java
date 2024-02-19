package kr.or.ddit.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IScoreValueMapper;
import kr.or.ddit.service.IScoreValueService;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.ScoreValueVO;

@Service
public class ScoreValueServiceImpl implements IScoreValueService {

	@Inject
	private IScoreValueMapper scoreValueMapper;
	
	@Override
	public List<ScoreValueVO> getAllScoreValueData() {
		return scoreValueMapper.getAllScoreValueData();
	}

	@Override
	public List<LectureVO> getLectureList(int memNo) {
		return scoreValueMapper.getLectureList(memNo);
	}

}
