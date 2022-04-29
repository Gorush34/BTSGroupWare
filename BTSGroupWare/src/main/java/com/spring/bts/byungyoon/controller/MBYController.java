package com.spring.bts.byungyoon.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

//=== 컨트롤러 선언 === //
@Component
/* 
   XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
   그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
   즉, 여기서 bean의 이름은 boardController 이 된다. 
   여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller /* Bean + controller 기능을 모듀 포함 */
public class MBYController {

   
   // 주소록 테스트
   @RequestMapping(value="/addBook/addBook_main.bts")
   public ModelAndView addbook_main(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
      
      mav.setViewName("addBook_main.addBook");
      // /WEB-INF/views/addBook/{1}.jsp
      // /WEB-INF/views/addBook/addbook_main.jsp 페이지를 만들어야 한다.
      return mav;
   }
   
   // 주소록 테스트2
   @RequestMapping(value="/addBook/addBook_telAdd.bts")
   public ModelAndView addbook_teladd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
      
      mav.setViewName("addBook_telAdd.addBook");
      // /WEB-INF/views/addBook/{1}.jsp
      // /WEB-INF/views/addBook/addbook_teladd.jsp 페이지를 만들어야 한다.
      return mav;
   }

}