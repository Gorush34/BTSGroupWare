package com.spring.bts.hwanmo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

//=== #30. 컨트롤러 선언 === // 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
즉, 여기서 bean의 이름은  btsController 이 된다. 
여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BtsController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller
public class AttendanceController {

	
	// === 근태관리 시작 페이지 ===
	@RequestMapping(value="/att/attMain.bts")
	public ModelAndView attMain(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		mav.setViewName("attMain.att");

		return mav;
	}
	
	// === 연차내역 페이지 ===
	@RequestMapping(value="/att/myAtt.bts")
	public ModelAndView showSchedule(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		mav.setViewName("myAtt.att");

		return mav;
	}
	
	// === 일정관리 시작 페이지 ===
	@RequestMapping(value="/att/reportVacation.bts")
	public ModelAndView reportVacation(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		mav.setViewName("reportVacation.att");

		return mav;
	}
	
	
}
