package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

// 강의 자료실
@Data
public class ClassBoardVO {

	
	private int classBrdNo;
	private int classNo;
	private String classBrdTitle;
	private String classBrdCont;
	private String classWriteDate;
	private int classBrdHitCount;
	private int fileNo = 0;
	private String fileName;
	
	private MultipartFile[] files;
	private List<FilesVO> fileList;
	
	public void setFiles(MultipartFile[] files) {
		this.files = files;
		
		if(files != null) {
			List<FilesVO> noticeFileList = new ArrayList<FilesVO>();
			
			for(MultipartFile item : files) {
				if(StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				
				FilesVO filesVO = new FilesVO(item);
				noticeFileList.add(filesVO);
			}
			
			this.fileList = noticeFileList;
		}
	}
}
