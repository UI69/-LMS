package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;


// 게시판
@Data
public class BoardVO {

	private int brdNo;
	private int memNo;
	private String brdTitle;
	private String brdCont;
	private String brdWriter;
	private String writeDate;
	private int brdHitCount;
	private String brdType;
	private int fileNo;
	
	private String filePath;
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
