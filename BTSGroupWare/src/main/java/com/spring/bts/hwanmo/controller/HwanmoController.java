package com.spring.bts.hwanmo.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.bts.hwanmo.service.InterHwanmoService;
import com.spring.bts.service.InterBtsService;

//=== #30. 컨트롤러 선언 === // 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
즉, 여기서 bean의 이름은  btsController 이 된다. 
여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BtsController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller
public class HwanmoController {

	@Autowired
	private InterHwanmoService service;
	
	// ========== 서버 테스트 시작.. ================= //
	@RequestMapping(value="/test/test_form_2.action", method = {RequestMethod.GET}) // GET방식만 허가함!
	public String test_form_2() {
		return "test/test_form_2"; // view 단 페이지를 띄워라
		// /WEB-INF/views/test/test_form_2.jsp
	}
	
	
	@RequestMapping(value="/test/test_form_2.action", method = {RequestMethod.POST}) // POST방식만 허가함!
	public String test_form_2(HttpServletRequest request) {
		
		String no = request.getParameter("no");
		String name = request.getParameter("name");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("no", no);
		paraMap.put("name", name);
		
		int n = service.test_insert_2(paraMap);
		
		if(n == 1) {
			
			return "redirect:/test/test_select.bts";
			// /test/test_select.action 페이지로 redirect 페이지이동해라.
			
		}
		else {
			
			return "redirect:/test/test_form.bts";
			// /test/test_form.action 페이지로 redirect 페이지이동해라.
		}
	}
	
	// ========== 서버 테스트 끝.. ================= //
	
	@RequestMapping(value = "/mailList.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
	   public String mailList(HttpServletRequest request) {

	      // 메일 기능 시작
	      
	      return "mailList.tiles1";
	      //  return "/tiles1/mailList.jsp";
    }

	
}
