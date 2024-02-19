package kr.or.ddit.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IProfessorInfoMapper;
import kr.or.ddit.service.IProfessorInfoService;
import kr.or.ddit.vo.ProfessorInfoVO;

@Service
public class ProfessorInfoServiceImpl implements IProfessorInfoService {

	@Inject
	private IProfessorInfoMapper professorInfoMapper;
	
	@Override
	public ProfessorInfoVO getAllProfessorInfo(int memNo) {	
		return professorInfoMapper.getAllProfessorInfo(memNo);
	}

}
