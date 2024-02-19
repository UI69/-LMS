package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

// 과제 
@Data
public class HomeworkVO {

	private int hwNo;
	private int classNo;
	private String hwTitle;
	private String hwUpload;
	private String hwDate;
	private String hwCont;
	private int fileNo;
	
	private String fileName;
	private int hwSubmitCnt;
	
	private List<HomeworkSubmitVO> hwSubList;
	
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
