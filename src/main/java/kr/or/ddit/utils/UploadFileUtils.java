package kr.or.ddit.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.entity.FileType;
import kr.or.ddit.vo.FilesVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UploadFileUtils {
	
	/**
	 * 
	 * @param file		파일 데이터
	 * @param fileType	파이 타입 열거형
	 * @param req		
	 * @param typeNo	저장 타입에 따른 번호. 강의 과제파일, 과제 제출파일, 커뮤니티 채팅방, 채팅방은 해당 데이터를 저장하는 데이터의 PK를 이용해야한다.
	 * 					예시) 501번 강의 > typeNo = 501, 101번 채팅방 > typeNo = 101
	 * @return			저장 파일 경로
	 * @throws Exception
	 */
	
	// 저장 타입이 없을때
	public static FilesVO uploadFile(MultipartFile file, FileType fileType, HttpServletRequest req) throws Exception {
		return uploadFile(file, fileType, req, 0);
	}
	
	//저장 타입이 필요할때
	public static FilesVO uploadFile(MultipartFile file, FileType fileType, HttpServletRequest req, int typeNo) throws Exception {
		
		String realPath = req.getServletContext().getRealPath("/resources/files");
		String originalName = file.getOriginalFilename();
		byte[] fileData = file.getBytes();
		
		log.info("fileType : " + fileType);
		log.info("realPath : " + realPath);
		log.info("typeNo : " + typeNo);
		log.info("originalName : " + originalName);
		
		// UUID 생성
		UUID uuid = UUID.randomUUID();
		
		// UUID_원본파일명
		String savedName = uuid.toString() + "_" + originalName.replace(" ", "_");	//공백을 '_'로 치환

		// 2023/12/04 폴더 경로를 만들고, 2023/12/04 폴더 경로를 리턴한다.
		String savedPath = calcPath(realPath, fileType, typeNo);
		
		// 배포된 서버 업로드 경로 + /2023/12/04/ + UUID_원본파일명으로 File target을 하나 만들어준다. 
		File target = new File(realPath + savedPath, savedName);
		
		FileCopyUtils.copy(fileData, target);	// 경로와 파일명을 가지고 파일 복사를 진행한다.
		
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);	// 확장자 추출
		
		// \2023\12\04 경로를 '/' 경로로 변경 후 원본 파일명을 붙인다
		String uploadedFileName = savedPath.replace(File.separatorChar, '/')+"/"+savedName;
		
		log.info("originalName : " + originalName);
		log.info("savedName : " + savedName);
		log.info("savedPath : " + savedPath);
		log.info("formatName : " + formatName);
		log.info("uploadedFileName : " + uploadedFileName);
		
		FilesVO filesVO = new FilesVO(file);
		filesVO.setFilePath(uploadedFileName);
		filesVO.setFileUuid(uuid.toString());

		// 확장자가 이미지 파일이면 s_가 붙은 파일의 썸네일 이미지 파일을 생성한다.
		if(MediaUtils.getMediaType(formatName) != null) {	//  확장자를 통한 이미지 파일인지 검증
			makeThumbnail(realPath, savedPath, savedName);	// 썸네일 이미지 생성
			filesVO.setThumbnail(savedPath + File.separator + "s_" + savedName);
		}
		
		log.info("filesVO : " + filesVO);
		
		return filesVO;
	}
	
	// 썸네일 이미지 만들기
	private static void makeThumbnail(String uploadPath, String path, String fileName) throws Exception {
		// 썸네일 이미지를 만들기 위해 원본 이미지를 읽는다.
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));
		
		// 썸네일 이미지를 만들기 위한 설정
		// Method.AUTOMATIC : 최소 시간 내에 가장 잘 보이는 이미지를 얻기 위한 사용 방식
		// Mode.FIT_TO_HEIGHT : 이미지 방향과 상관없이 주어진 높이 내에서 가장 잘 맞는 이미지로 계산
		// targetSize : 값 100, 정사각형 사이즈로 100*100
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 220);
		
		// 업로드 한 원본 이미지를 가지고 's_'를 붙여서 
		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;
		
		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
		// 's_'가 붙은 썸네일 이미지를 만든다.
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
	}
	
	
	// 파일 저장 경로 생성
	private static String calcPath(String uploadPath, FileType fileType, int typeNo) {
		
		String path = null;
		
		// 파일의 타입 별로 저장 위치 설정
		switch (fileType) {
		
			//날짜별 폴더 밑에 저장
		case BOARD:
		case COMMUNITY_BOARD:
		case CLUB_BOARD:
		case REST_APPLY:
		case SCHOLARSSHIP:
		case UNIV_VOLUNTEER:
		case VOLUNTEER:
		case REPORT:
			
			Calendar cal = Calendar.getInstance();
			String yearPath = File.separator + cal.get(Calendar.YEAR); // 2023

			// DecimalFormat("00") :: 두자리에서 빈자리는 0으로 채움
			String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1); // /2023/12
			path = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE)); // /2023/12/04

			// 연월일 폴더 구조에 의한 폴더 생성
			makeDir(uploadPath, path);
			break;
			
			//해당 강의 번호 폴더 밑에 저장
		case CLASS_BOARD:
		case HOMEWORK:
		case HOMEWORK_SUBMIT:
			path = "/class/"+typeNo;
			makeDir(uploadPath, path);
			break;
			
			//해당 커뮤니티 번호 폴더 밑에 저장
		case COMMUNITY_CHAT:
			path = "/cmChat/"+typeNo;
			makeDir(uploadPath, path);
			break;
			
			//해당 채팅방 번호 폴더 밑에 저장
		case CHAT:
			path = "/chat/"+typeNo;
			makeDir(uploadPath, path);
			break;
			
			//지정된 폴더 밑에 저장
		case CLUP_PROFILE:	//동아리 프로필 이미지
			path = "/clubProfile";
			makeDir(uploadPath, path);
			break;
			
		case SHUTTLE:		//셔틀버스 관련 이미지
			path = "/shuttle";
			makeDir(uploadPath, path);
			break;
			
		case MEMBER_PROFILE:	//회원 프로필 이미지
			path = "/memberProfile";
			makeDir(uploadPath, path);
			break;
		
		case LECTURE:			//교과목 강의 계획서
			path = "/lecture";
			makeDir(uploadPath, path);
			break;
			
		case CLASS:				//강의 계획서
			path = "/class";
			makeDir(uploadPath, path);
			break;
			
		default:
			break;
		}
		
		return path;
	}

	// 가변인자
	// 키워드 '...' 을 사용한다.
	// 순서대로 yearPath, monthPath, datePath가 배열로 들어가 처리
	private static void makeDir(String uploadPath, String... paths) {
		// /2023/12/04 폴더 구조가 존재한다면 return
		// 만들려면 폴더 구조가 이미 만들어져 있는 형태니까 return
		if (new File(paths[paths.length - 1]).exists()) {
			return;
		}
		
		for (String path : paths) {
			File dirPath = new File(uploadPath + path);

			// /2023/12/04와 같은 경로에 각 폴더가 없으면 각각 만들어준다.
			if (!dirPath.exists()) {
				dirPath.mkdirs();
			}

		}
	}
}
