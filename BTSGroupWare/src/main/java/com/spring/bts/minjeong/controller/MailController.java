package com.spring.bts.minjeong.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
    그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
    즉, 여기서 bean의 이름은 boardController 이 된다. 
    여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller	// Bean 기능 + Controller 기능 ( @Component 를 빼도, 안빼도 무방하다. )
public class MailController {

	@RequestMapping(value = "/tiles1/mailList.bts")	
	// URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
	// http://localhost:9090/bts/tiles1/mailList.bts
	public String mailList(HttpServletRequest request) {

		// 메일 기능 시작		
		return "mailList.tiles1";
    //  return "/tiles1/mailList.jsp";	// 아래와 같이 써서 오류가 났음.
	}
}
