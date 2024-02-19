package kr.or.ddit.service;

import kr.or.ddit.vo.FilesVO;

public interface IFileService {

	FilesVO fileDownload(int fileNo);

	int uploadFile(FilesVO filesVO);

}
