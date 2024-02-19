package kr.or.ddit.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.AbstractView;

import kr.or.ddit.entity.FileType;
import kr.or.ddit.service.IFileService;
import kr.or.ddit.utils.UploadFileUtils;
import kr.or.ddit.vo.ExcelVO;
import kr.or.ddit.vo.FilesVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/DYUniv")
public class FileController {

	@Inject
	private IFileService fileService;
	
	
	// 파일 업로드 템플릿
//	@PostMapping("/fileUpload")
//	public String fileUpload(MultipartFile files, HttpServletRequest req) {
//		FilesVO filesVO = null;
//		
//		try {
//			//파일, 파일 타입, HttpServletRequest
//			filesVO = UploadFileUtils.uploadFile(files, FileType.BOARD, req);
//		} catch (Exception e) {
//			e.printStackTrace();
//			//파일 업로드 실패시 처리
//		}
//		
//		if(filesVO != null) {
//			//파일 데이터 저장
//			//int fileNo = fileService.addFile()			
//		}
//		return "redirect:/";
//	}
	
	//파일 다운로드 처리
	@RequestMapping("/fileDownload/{fileNo}")
	public View fileDownload(@PathVariable("fileNo") int fileNo,
			HttpServletRequest req,
			HttpServletResponse res,
			Model model
			) {
		log.info("fileNo : " + fileNo);
		FilesVO filesVO = fileService.fileDownload(fileNo);
		
		Map<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("fileName", filesVO.getFileName());
		fileMap.put("fileSize", filesVO.getFileSize());
		fileMap.put("filepath", req.getServletContext().getRealPath("/resources/files") + filesVO.getFilePath());
		
		model.addAttribute("fileMap", fileMap);
		
		//리턴되는 NoticeDownloadView는 jsp 페이지로 존제하는 페이지 name을 요청하는게 아니라 클래스를 요청
		// 해당 클래스가 스프링에서 제공하는 AbstractView를 상속
		//AbstractView를 상속받아 view로 취급될수 있게 해준다
		
		return new fileDownloadView();
	}
	
	// 시험 출제 폼	
	@RequestMapping("/examTemplateFileDownload")
	public void examTemplateFileDownload(
			HttpServletRequest request, 
			HttpServletResponse response, 
			ExcelVO excelVO, Model model
			) throws IOException {
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("첫번째 시트");
		Row row;
		Cell cell;
		int rowNum = 0;
		row = sheet.createRow(rowNum++);
		
		cell = row.createCell(0);
		cell.setCellValue("/");
		cell = row.createCell(1);
		cell.setCellValue("시험 문제*");
		cell = row.createCell(2);
		cell.setCellValue("점수 *");
		cell = row.createCell(3);
		cell.setCellValue("정답 번호*");
		
		cell = row.createCell(4);
		cell.setCellValue("보기 1번 *");
		cell = row.createCell(5);
		cell.setCellValue("보기 2번 *");
		cell = row.createCell(6);
		cell.setCellValue("보기 3번");
		cell = row.createCell(7);
		cell.setCellValue("보기 4번");
		cell = row.createCell(8);
		cell.setCellValue("보기 5번");
		cell = row.createCell(9);
		cell.setCellValue("보기 6번");
		cell = row.createCell(10);
		cell.setCellValue("보기 7번");
		cell = row.createCell(11);
		cell.setCellValue("보기 8번");
		cell = row.createCell(12);
		cell.setCellValue("보기 9번");
		cell = row.createCell(13);
		cell.setCellValue("보기 10번");
		
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=exampleForm.xlsx");
		wb.write(response.getOutputStream());
	}
	
	// 설문 등록 폼	
	@RequestMapping("/surveyTemplateFileDownload")
	public void surveyTemplateFileDownload(
			HttpServletRequest request, 
			HttpServletResponse response, 
			ExcelVO excelVO, Model model
			) throws IOException {
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("첫번째 시트");
		Row row;
		Cell cell;
		int rowNum = 0;
		row = sheet.createRow(rowNum++);
		
		cell = row.createCell(0);
		cell.setCellValue("/");
		cell = row.createCell(1);
		cell.setCellValue("질문*");
		cell = row.createCell(2);
		cell.setCellValue("보기 1번 *");
		cell = row.createCell(3);
		cell.setCellValue("보기 2번 *");
		cell = row.createCell(4);
		cell.setCellValue("보기 3번");
		cell = row.createCell(5);
		cell.setCellValue("보기 4번");
		cell = row.createCell(6);
		cell.setCellValue("보기 5번");
		cell = row.createCell(7);
		cell.setCellValue("보기 6번");
		cell = row.createCell(8);
		cell.setCellValue("보기 7번");
		
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=surveyForm.xlsx");
		wb.write(response.getOutputStream());
	}
	
}

class fileDownloadView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Map<String, Object> fileMap = (Map<String, Object>)model.get("fileMap");
		
		File saveFile = new File(fileMap.get("filepath").toString());
		String fileName = fileMap.get("fileName").toString();
		String fileSize = fileMap.get("fileSize").toString();
		
		//요청 헤더 정보들 중, user-agent 영역 안에 여러 키워드 정보를 가지고 
		//특정 키워드가 포함되어 있는지 체크, 파일명 인코딩 부분을 설정
		//사용 브라우저 또한 현상에 따라 발생하는 알고리즘이므로  , 내가 사용하게되는 브라우저의 버전이나 헤더 정보에 따라 차이가 발생
		String agent = request.getHeader("User-Agent");
		
		if(StringUtils.containsIgnoreCase(agent, "msie") || StringUtils.containsIgnoreCase(agent, "trident")) {	//IE, chrome
			fileName = URLEncoder.encode(fileName, "UTF-8"); 
		} else {	//firefox, chrome
			fileName = new String(fileName.getBytes(), "ISO-8859-1"); 
		}
		
		response.setHeader("Content-Disposition", "attachement; filename=\"" + fileName + "\"");
		response.setHeader("Content-Length", fileSize);
		
		//try with resource
		//() 안에 명시한 객체는  finally에서 close 처리하지 않아도 자동 close 처리가 이루어진다
		try (
				OutputStream os = response.getOutputStream();
		){
			FileUtils.copyFile(saveFile, os);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
