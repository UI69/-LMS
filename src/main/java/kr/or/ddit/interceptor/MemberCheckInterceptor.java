package kr.or.ddit.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MemberCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("interceptor run...");
		
		MemberVO member = (MemberVO) request.getSession().getAttribute("member");
		
		log.info("member : " + member);
		
		if(member == null) {
			response.sendRedirect("/login.do");
			return false;
		}
		
		return true;
	}
}
