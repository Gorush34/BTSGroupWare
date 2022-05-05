package com.spring.bts.byungyoon.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.byungyoon.model.AddBookVO;
import com.spring.bts.byungyoon.service.InterAddBookService;

//=== 컨트롤러 선언 === //
/* 
   XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
   그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
   즉, 여기서 bean의 이름은 boardController 이 된다. 
   여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@RestController/* Bean + controller 기능을 모듀 포함 */
public class AddBookController {

	@Autowired
	private InterAddBookService service;
   
   // 주소록 메인페이지
   @RequestMapping(value="/addBook/addBook_main.bts")
   public ModelAndView addBook_main(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
      
	   List<AddBookVO> adbList = service.addBook_select();
	   
	   mav.addObject("adbList", adbList);
	   
	//   System.out.println("여기는 컨트롤러");
	   
	   mav.setViewName("addBook_main.addBook");
	   
	   
      return mav;
   }
   
   // 주소록 연락처 추가 페이지 
   @RequestMapping(value="/addBook/addBook_telAdd.bts")
   public ModelAndView addBook_telAdd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	   
      
	   mav.setViewName("addBook_telAdd.addBook");
	   
      return mav;
   }
   
   
   // 주소록 연락처 추가 페이지에서 데이터 넣기
   @ResponseBody
   @RequestMapping(value="/addBook/addBook_telAdd_insert.bts" , method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
   public ModelAndView addBook_telAdd_insert(HttpServletRequest request, ModelAndView mav) {
	   
	   
	   String addb_name = request.getParameter("name");
	   String companyname = request.getParameter("company");
	   String ko_depname = request.getParameter("department");
	   String ko_rankname = request.getParameter("rank");
	   String email = request.getParameter("email");
	   String phone = request.getParameter("phone");
	   String company_address = request.getParameter("company_address");
	   String memo = request.getParameter("memo");
	  
	   AddBookVO avo = new AddBookVO();
	   
	   //성공했는지 확인했는지
	   int result = 0;
	   
	   result = service.addBook_insert(avo);
	   
	   if(result == 1) {
		   //성공
		  
	   }else {
		   //실패
	   }
	   
	   String message = "";
		String loc = "";
			message = "개발자가 되고싶다";
			loc =  request.getContextPath()+"/addBook/addBook_telAdd.bts"; 
		
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
      
      return mav;
   }
   
   
   
   // 상세개인정보 페이지
   @RequestMapping(value="/addBook/addBook_perInfo.bts")
   public ModelAndView addBook_perInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	   
      mav.setViewName("addBook_perInfo.addBook");
      
      return mav;
   }
   
   
   // 상세부서정보 페이지
   @RequestMapping(value="/addBook/addBook_depInfo.bts")
   public ModelAndView addBook_depInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	   
	   mav.setViewName("addBook_depInfo.addBook");
	   
	   return mav;

   }
   
   
   // 주소록 메인페이지 주소록 검색창 ajax
	@RequestMapping(value="/addBook/test.bts", produces = "application/json; charset=utf-8")
	public Map<String, Object> addBook_test(HttpServletRequest request, HttpServletResponse response, String search) {
	   
	   Map<String, Object> testMap = new HashMap<String, Object>();
	   String a = service.getNameNumber(1);
	   
	   testMap.put("search", search);
	   testMap.put("name", a);
	   
	   return testMap;
	}
	
	
	
	
	
	

   

}