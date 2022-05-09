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
import com.spring.bts.hwanmo.model.EmployeeVO;

//=== 컨트롤러 선언 === //
/* 
   XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
   그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
   즉, 여기서 bean의 이름은 boardController 이 된다. 
   여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@RestController/* Bean + controller 기능을 모두 포함 */
public class AddBookController {

	@Autowired
	private InterAddBookService service;
 /*  
	// 주소록 메인페이지에서 주소록검색 ajax 쓰기
	@RequestMapping(value="/addBook/test.bts", produces = "application/json; charset=utf-8")
	public Map<String, Object> addBook_test(HttpServletRequest request, HttpServletResponse response, String search) {
	   
	   Map<String, Object> testMap = new HashMap<String, Object>();
	   String a = service.getNameNumber(1);
	   
	   testMap.put("search", search);
	   testMap.put("name", a);
	   
	   System.out.println(search);
	   System.out.println(a);
	   
	   return testMap;
	}
*/	
	
   // 주소록 메인페이지
   @RequestMapping(value="/addBook/addBook_main.bts")
   public ModelAndView addBook_main(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	   
	   List<AddBookVO> adbList = service.addBook_main_select();
	   
	   mav.addObject("adbList", adbList);
	   
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
	   
	   
	   String addb_name = request.getParameter("addb_name");
	   int fk_dept_no = Integer.parseInt(request.getParameter("department"));
	   int fk_rank_no = Integer.parseInt(request.getParameter("rank"));
	   String email = request.getParameter("email");
	   String phone = request.getParameter("phone");
	   String companyname = request.getParameter("company");
	   String com_tel = request.getParameter("com_tel");
	   String company_address = request.getParameter("company_address");
	   String memo = request.getParameter("memo");
	   
	   AddBookVO avo = new AddBookVO();
	   
	   avo.setAddb_name(addb_name);
	   avo.setFk_dept_no(fk_dept_no);
	   avo.setFk_rank_no(fk_rank_no);
	   avo.setEmail(email);
	   avo.setPhone(phone);
	   avo.setCompanyname(companyname);
	   avo.setCom_tel(com_tel);
	   avo.setCompany_address(company_address);
	   avo.setMemo(memo);
	   
	   //성공했는지 확인했는지
	   
	   int n = service.addBook_telAdd_insert(avo);
	   
	   String message = "";
	   String loc = "";
	   
	   if(n == 1) {
		   //성공
		    message = "주소록에 연락처 추가가 완료 되었습니다";
			loc =  request.getContextPath()+"/addBook/addBook_telAdd.bts"; 
	   }else {
		   //실패
		   message = "주소록에 연락처 추가가 실패했습니다";
		   loc =  request.getContextPath()+"/addBook/addBook_telAdd.bts"; 
	   }
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
      
      return mav;
   }
   
   
   // 주소록 메인에서 select 해와서 연락처 update 하기
   @RequestMapping(value="/addBook/addBook_main_telUpdate.bts" , produces = "application/json; charset=utf-8")
   public Map<String,Object> addBook_main_telUpdate(HttpServletRequest request, HttpServletResponse response) {
      
	   Map<String,Object> updateMap = new HashMap<>();
	   
	   int pk_addbook_no = Integer.parseInt(request.getParameter("pk_addbook_no"));
	   
	   AddBookVO avo = service.addBook_main_telUpdate(pk_addbook_no);
	   
	   updateMap.put("name", avo.getAddb_name());
	   updateMap.put("department", avo.getKo_depname());
	   updateMap.put("rank", avo.getKo_rankname());
	   updateMap.put("email", avo.getEmail());
	   updateMap.put("phone", avo.getPhone());
	   updateMap.put("company_name", avo.getCompanyname());
	   updateMap.put("company_tel", avo.getCom_tel());
	   updateMap.put("company_address", avo.getCompany_address());
	   updateMap.put("memo", avo.getMemo());
	   
      return updateMap;
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
	   
	   List<EmployeeVO> empList = service.addBook_depInfo_select();
	   
	   mav.addObject("empList", empList);
	   
	   mav.setViewName("addBook_depInfo.addBook");
	   
	   return mav;
   }
   
   
   // 상세부서정보 페이지에서 사원상세정보 ajax로 select 해오기
	@RequestMapping(value="/addBook/addBook_depInfo_select_ajax.bts", produces = "application/json; charset=utf-8")
	public Map<String,Object> addBook_depInfo_select_ajax(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String,Object> depInfoMap = new HashMap<>();
		
		int pk_emp_no = Integer.parseInt(request.getParameter("pk_emp_no"));
	   
		EmployeeVO evo = service.addBook_depInfo_select_ajax(pk_emp_no);
		
		depInfoMap.put("name",evo.getEmp_name());
		depInfoMap.put("department", evo.getKo_depname());
		depInfoMap.put("rank", evo.getKo_rankname());
		depInfoMap.put("email", evo.getUq_email());
		depInfoMap.put("phone", evo.getUq_phone());
		depInfoMap.put("address", evo.getAddress());
		depInfoMap.put("detailaddress", evo.getDetailaddress());
		depInfoMap.put("extraaddress", evo.getExtraaddress());	   
		
		return depInfoMap;
	}
   
   

   
   

	
	
	
	
	
	

   

}