package kr.or.ddit.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IFileMapper;
import kr.or.ddit.service.IFileService;
import kr.or.ddit.vo.FilesVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FileService implements IFileService {
	
	@Inject
	private IFileMapper fileMapper;
	
	@Override
	public FilesVO fileDownload(int fileNo) {
		FilesVO filesVO = fileMapper.getFile(fileNo);
		
		if(filesVO != null) {
			fileMapper.incrementDownCount(fileNo);
		}
		
		return filesVO;
	}

	@Override
	public int uploadFile(FilesVO filesVO) {
		return fileMapper.createFile(filesVO);
	}
	
}
