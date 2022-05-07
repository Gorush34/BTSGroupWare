package com.spring.bts.yuri.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.common.Sha256;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.yuri.model.ApprVO;
import com.spring.bts.yuri.service.InterEdmsService;

//=== 컨트롤러 선언 === //
@Component
/* 
	XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
	그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
	즉, 여기서 bean의 이름은 boardController 이 된다. 
	여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller /* Bean + controller 기능을 모듀 포함 */
public class EdmsController {

	@Autowired    // Type에 따라 알아서 Bean 을 주입해준다.
    private InterEdmsService service;
	
/*
	// === 전자결재 테스트 페이지 === //
	@RequestMapping(value="/edms/edmsTest.bts")
	public ModelAndView edmsTest(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		mav.setViewName("edms_test.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edms_test.jsp 페이지를 만들어야 한다.
		return mav;	
	}
*/
	

	
	// === 전자결재 홈 페이지 === //
	@RequestMapping(value="/edms/edmsHome.bts")
	public ModelAndView requiredLogin_edmsHome(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		mav.setViewName("edmsHome.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsHome.jsp 페이지를 만들어야 한다.
		return mav;		
	}

	
	
	// === 전자결재 문서작성 폼페이지 요청 === //
	@RequestMapping(value="/edms/edmsAdd.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView requiredLogin_addEdms(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		String userid = request.getParameter("pk_emp_no");
		String pwd = request.getParameter("emp_pwd");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("pwd", Sha256.encrypt(pwd));
		
		EmployeeVO loginuser = service.getLoginMember(paraMap);

		mav.setViewName("edmsAdd.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsAdd.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	
	// === (파일첨부가 있는)전자결재 문서작성 완료 요청 === //
	@RequestMapping(value="/edms/edmsAddEnd.bts", method= {RequestMethod.POST})
	public ModelAndView edmsAddEnd(Map<String,String> paraMap, ModelAndView mav, ApprVO apprvo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기 및 파일 첨부하기
		
		// 파일첨부가 없는 전자결재 문서작성
		int n = service.edmsAdd(apprvo);
		
		if(n==1) {
			mav.setViewName("redirect:/edmsList.action");
			// /list.action 페이지로 redirect(페이지이동)해라는 말이다.
		}
		else {
			mav.setViewName("edms/error/add_error.tiles1");
		//  /WEB-INF/views/tiles1/edms/error/add_error.jsp 파일을 생성한다.
		}
		
		return mav;
		
	}
	
	
	// === 전자결재 문서 상세보기 페이지 === //
	@RequestMapping(value="/edms/edmsView.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView viewEdms(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsView.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsView.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	
	// === 전자결재 내문서함(전체문서함) 페이지 === //
	@RequestMapping(value="/edms/edmsMydoc.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsMydoc(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsMydoc.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsMydoc.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	
	// === 전자결재 내문서함(대기문서함) 페이지 === //
	@RequestMapping(value="/edms/edmsMydoc_wait.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsMydoc_wait(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsMydoc_wait.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsMydoc_wait.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	
	// === 전자결재 내문서함(승인문서함) 페이지 === //
	@RequestMapping(value="/edms/edmsMydoc_accepted.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsMydoc_accepted(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsMydoc_accepted.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsMydoc_accepted.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	
	// === 전자결재 내문서함(반려문서함) 페이지 === //
	@RequestMapping(value="/edms/edmsMydoc_rejected.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsMydoc_rejected(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsMydoc_rejected.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsMydoc_rejected.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	
	// === 전자결재 결재하기 페이지 === //
	@RequestMapping(value="/edms/edmsApprove.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsApprove(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsApprove.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsApprove.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
}