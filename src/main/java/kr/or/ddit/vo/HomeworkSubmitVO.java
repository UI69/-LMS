package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

// 과제 제출
@Data
public class HomeworkSubmitVO {

	private int hwSbNo;
	private int memNo;
	private int hwNo;
	private String hwSbDate;
	private String hwSbStatusCode;
	private String hwContent;
	private int hwScore;
	private int fileNo;
	
	private String memName;
	private String memId;
	
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
