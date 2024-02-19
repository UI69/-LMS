package kr.or.ddit.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
public class FileConfig implements WebMvcConfigurer {
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/mcimg/**")             // 웹 접근 경로, 웹에서 이경로로 접근시 파일을 반환
		        .addResourceLocations("file:///c:/myUpload/");  // 서버내 실제 저장 경로
		
		//저장 방법
		//(MultipartFile) file.transferTo(new File("c:/myUpload/"+ mc.getOriginalFilename()));
	}
}
