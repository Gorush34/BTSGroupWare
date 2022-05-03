package com.spring.bts.hwanmo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.hwanmo.service.InterEmployeeService;

//=== #30. 컨트롤러 선언 === // 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
즉, 여기서 bean의 이름은  btsController 이 된다. 
여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BtsController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller
public class EmployeeController {

	@Autowired
	private InterEmployeeService empService;
	
	// === 사원등록 페이지 ===
	@RequestMapping(value="/emp/registerEmp.bts")
	public ModelAndView requiredLogin_registerEmp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		mav.setViewName("registerEmp.emp");

		return mav;
	}
	
	// 사번중복
	@ResponseBody
	@RequestMapping(value="/emp/idDuplicateCheck.bts", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String idDuplicateCheck(HttpServletRequest request) { 
	
		String pk_emp_no = request.getParameter("pk_emp_no"); 
		// System.out.println(">>> 확인용 pk_emp_no =>"+ pk_emp_no );	// 내가 입력한 아이디 값
			
		boolean isExist = empService.idDuplicateCheck(pk_emp_no);
		
		JSONObject jsonObj = new JSONObject(); 	// {}
		jsonObj.put("isExist", isExist);			// {"isExist":true} 또는 {"isExist":false} 으로 만들어준다. 
			
			String json = jsonObj.toString();	// 문자열 형태인 "{"isExist":true}" 또는 "{"isExist":false}" 으로 만들어준다.
			System.out.println(">>> 확인용 json =>"+ json );	
		//	>>> 확인용 json =>{"isExist":false}
		//	또는	
		//	>>> 확인용 json =>{"isExist":true}
			
		request.setAttribute("json",json);
			
		return json;
	}
}
