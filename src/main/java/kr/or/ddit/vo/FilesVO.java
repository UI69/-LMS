package kr.or.ddit.vo;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

// 파일
@Data
public class FilesVO{
	
	private MultipartFile item;
	private String fileName;
	private long fileSize;
	private String fileMime;
	private String fileFancysize;
	
	private int fileNo;
	private int fileGroupNo = 1;
	private String filePath;
	private String fileUuid;
	private int fileDownCnt;
	private String fileUploadDate;
	
	private String thumbnail;
	
	public FilesVO() {}
	
	public FilesVO(MultipartFile item) {
		this.item = item;
		this.fileName = item.getOriginalFilename();
		this.fileSize = item.getSize();
		this.fileMime = item.getContentType();
		this.fileFancysize = FileUtils.byteCountToDisplaySize(fileSize);
		
	}
}
