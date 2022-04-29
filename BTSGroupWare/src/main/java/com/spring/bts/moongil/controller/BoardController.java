package com.spring.bts.moongil.controller;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.bts.moongil.service.InterBoardService;
import com.spring.bts.service.InterBtsService;

//=== #30. 컨트롤러 선언 === // 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
즉, 여기서 bean의 이름은  btsController 이 된다. 
여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BtsController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller
public class BoardController {

	@Autowired
	private InterBoardService service;
	
	
	@RequestMapping(value = "/board/main.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
    public String board_main(HttpServletRequest request) {

		      
	       return "board_main.board";
	}

	
	// --- 게시판 시작 ---  -----------------
	@RequestMapping(value = "/board/list.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
    public String board_list(HttpServletRequest request) {

		      
	       return "/board/list.board";
	}

	// --- 게시판 끝 --- -------------------
	
	// --- 자료 게시판 시작 ---  -----------------
	@RequestMapping(value = "/fileboard/list.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
    public String fileboard_list(HttpServletRequest request) {

		      
	       return "/fileboard/list.board";
	}
	// --- 자료 게시판 끝 --- -------------------
	
	
	// --- 공지 게시판 시작 ---  -----------------
	@RequestMapping(value = "/notice/list.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
    public String notice_test(HttpServletRequest request) {

		      
	       return "/notice/list.board";
	}
	// --- 공지 게시판 끝 ---  -----------------
}
