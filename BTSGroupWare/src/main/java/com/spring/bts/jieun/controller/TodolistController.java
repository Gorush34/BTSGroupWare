package com.spring.bts.jieun.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.common.AES256;
import com.spring.bts.common.MyUtil;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.jieun.model.CalendarVO;
import com.spring.bts.jieun.model.ScheduleVO;
import com.spring.bts.jieun.service.InterCalendarService;
import com.spring.bts.jieun.service.InterTodolistService;


//=== #30. 컨트롤러 선언 ===
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
 그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
 즉, 여기서 bean의 이름은 boardController 이 된다. 
 여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/

@Controller
public class TodolistController {
	
	
	@Autowired    // Type에 따라 알아서 Bean 을 주입해준다.
    private InterTodolistService service;
	
	// === 투두 페이지 === //	
	@RequestMapping(value="/todo/todolistMain.bts")
	public ModelAndView todolistMain(ModelAndView mav) {
		
		mav.setViewName("todolistMain.todo");
		
		return mav;		
	}
	
	// 투두 소분류 추가 
	@ResponseBody
	@RequestMapping(value="/todo/todoPlus.bts")
	public String todoPlus(HttpServletRequest request) {
		
		String todoSubject = request.getParameter("todoSubject");
		
		int n = service.todoPlus(todoSubject);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
}
