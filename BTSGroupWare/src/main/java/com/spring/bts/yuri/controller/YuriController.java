package com.spring.bts.yuri.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

public class YuriController {

	/* ***** bts 그룹웨어 파이널 프로젝트 용 컨트롤러 시작 **************************************************************/
	
	// === bts 전자결재 홈 페이지 === //
	@RequestMapping(value="/test/edmsHome.bts")
	public ModelAndView requiredLogin_edmsHome(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		mav.setViewName("edmsHome.tiles3");
		// /WEB-INF/views/tiles3/{1}.jsp
		// /WEB-INF/views/tiles3/edmsHome.jsp 페이지를 만들어야 한다.
		return mav;
		
	}
	
	// === bts 게시판 글쓰기 폼페이지 요청 === //
	@RequestMapping(value="/test/edmsAdd.bts")
	public ModelAndView requiredLogin_addEdms(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsAdd.tiles3");
		//	/WEB-INF/views/tiles3/edmsAdd.jsp 파일을 생성한다
		
		return mav;
	}
	
	
	// === bts 내문서함 페이지 === //
	@RequestMapping(value="/test/edmsMydoc.bts")
	public ModelAndView requiredLogin_edmsMydoc(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsMydoc.tiles3");
		//	/WEB-INF/views/tiles3/edmsMydoc.jsp 파일을 생성한다
		
		return mav;
	}
	
	// === bts 결재하기 페이지 === //
	@RequestMapping(value="/test/edmsApprove.bts")
	public ModelAndView requiredLogin_edmsApprove(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsApprove.tiles3");
		//	/WEB-INF/views/tiles3/edmsApprove.jsp 파일을 생성한다
		return mav;
	}
	
	
	
	
	/* ***** bts 그룹웨어 파이널 프로젝트 용 컨트롤러 종료 **************************************************************/
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	
}