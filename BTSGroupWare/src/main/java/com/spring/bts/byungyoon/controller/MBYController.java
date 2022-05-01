package com.spring.bts.byungyoon.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.byungyoon.service.InterMBYService;

//=== 컨트롤러 선언 === //
@Component
/* 
   XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
   그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
   즉, 여기서 bean의 이름은 boardController 이 된다. 
   여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@RestController/* Bean + controller 기능을 모듀 포함 */
public class MBYController {

	@Autowired
	private InterMBYService mbyService;
   
   // 주소록 메인페이지
   @RequestMapping(value="/addBook/addBook_main.bts")
   public ModelAndView addBook_main(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
      
      mav.setViewName("addBook_main.addBook");
      // /WEB-INF/views/addBook/{1}.jsp
      // /WEB-INF/views/addBook/addbook_main.jsp 페이지를 만들어야 한다.
      return mav;
   }
   
   // 주소록 추가 페이지
   @RequestMapping(value="/addBook/addBook_telAdd.bts")
   public ModelAndView addBook_telAdd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
      
      mav.setViewName("addBook_telAdd.addBook");
      
      return mav;
   }
   
   // 조직도
   @RequestMapping(value="/addBook/addBook_orgChart.bts")
   public ModelAndView addBook_orgChart(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
      
      mav.setViewName("addBook_orgChart.addBook");
     
      return mav;
   }
   
   
   // 상세개인정보
   @RequestMapping(value="/addBook/addBook_perInfo.bts")
   public ModelAndView addBook_perInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	   
      mav.setViewName("addBook_perInfo.addBook");
     
      return mav;
   }
   
	@RequestMapping(value="/addBook/test.bts", produces = "application/json; charset=utf-8")
	public Map<String, Object> addBook_test(HttpServletRequest request, HttpServletResponse response, String search) {
	   
		
	   Map<String, Object> testMap = new HashMap<String, Object>();
	   String a = mbyService.getNameNumber(1);
	   System.out.println("테스트");
	   System.out.println(mbyService.getNameNumber(1));
	   testMap.put("search", a);
	   
	   
	   
	   return testMap;
	}
   

}