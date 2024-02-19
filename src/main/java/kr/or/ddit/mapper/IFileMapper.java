package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.FilesVO;

public interface IFileMapper {

	int addFile(List<FilesVO> files);

	int getFileSeq();

	int addfile(FilesVO file);
	
	int createFile(FilesVO file);
	
	//단일 파일 가져오기, 여러개일경우도 처리 
	public default FilesVO getFile(int fileNo) {
		List<FilesVO> fileList = getFileList(fileNo);
        return fileList.isEmpty() ? null : fileList.get(0);
	}
	
	// 여러 파일 가져오기
	List<FilesVO> getFileList(int fileNo);

	void incrementDownCount(int fileNo);
	
	
}
