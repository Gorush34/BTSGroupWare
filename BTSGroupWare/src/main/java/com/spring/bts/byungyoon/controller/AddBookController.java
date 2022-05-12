package com.spring.bts.byungyoon.controller;

import java.util.Arrays;
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
	      
	   String str_currentShowPageNo = request.getParameter("currentShowPageNo");
	   
	   int totalCount = 0;        // 총 게시물 건수
	   int sizePerPage = 5;       // 한 페이지당 보여줄 게시물 건수 
	   int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
	   int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
	   
	   int startRno = 0; // 시작 행번호
	   int endRno = 0;   // 끝 행번호
	   
	   
	   totalCount = service.addBook_main_totalPage();
	   
	   totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
	   
	   if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
	   }else {
		   try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo); 
				if( currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
	   }
	   
	   
	   //DB에서 얼마나 가져올지 정하는거
	   Map<String, String> paraMap = new HashMap<>();
	   
	   startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
	   endRno = startRno + sizePerPage - 1;
	   
	   paraMap.put("startRno", String.valueOf(startRno));
	   paraMap.put("endRno",  String.valueOf(endRno));
	   
	   List<AddBookVO> adbList = service.addBook_main_select(paraMap);
	   
	   int blockSize = 10;
	   int loop = 1;
	   
	   int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	   
	   String pageBar = "<ul style='list-style: none;'>";
	   String url = "addBook_main.bts";
	   
	   if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
	   
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		
	   mav.addObject("pageBar", pageBar);	
	   
	   mav.addObject("adbList", adbList);
	   mav.setViewName("addBook_main.addBook");
	   
      return mav;
   }
   
   
   // 주소록 연락처 추가 페이지 
   @RequestMapping(value="/addBook/addBook_telAdd.bts")
   public ModelAndView addBook_telAdd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
      
	   /* 유리 줄 부분 시작 */
	   List<EmployeeVO> empList = service.addBook_depInfo_select();
	   
	   mav.addObject("empList", empList);
	   
	   
	   /* 유리 줄 부분 끝 */
	   
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
			loc =  request.getContextPath()+"/addBook/addBook_main.bts"; 
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
   
   
   // 주소록 메인에서 select 해와서 연락처 update 하기 (select)
   @RequestMapping(value="/addBook/addBook_main_telUpdate_select.bts" , produces = "application/json; charset=utf-8")
   public Map<String,Object> addBook_main_telUpdate_select(HttpServletRequest request, HttpServletResponse response) {
      
	   Map<String,Object> updateMap = new HashMap<>();
	   
	   int pk_addbook_no = Integer.parseInt(request.getParameter("pk_addbook_no"));
	   
	   AddBookVO avo = service.addBook_main_telUpdate_select(pk_addbook_no);
	   updateMap.put("pk_addbook_no", avo.getPk_addbook_no());
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
   
   
   // 주소록 메인에서 select 해와서 연락처 update 하기 (update)
   @ResponseBody
   @RequestMapping(value="/addBook/addBook_main_telUpdate_update.bts" , method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
   public ModelAndView addBook_main_telUpdate_update(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	   
	   int pk_addbook_no = Integer.parseInt(request.getParameter("pk_addbook_no"));
	   String addb_name = request.getParameter("name");
	   int fk_dept_no = Integer.parseInt(request.getParameter("department"));
	   int fk_rank_no = Integer.parseInt(request.getParameter("rank"));
	   String email = request.getParameter("email");
	   String phone = request.getParameter("phone");
	   String companyname = request.getParameter("company_name");
	   String com_tel = request.getParameter("company_tel");
	   String company_address  = request.getParameter("company_address");
	   String memo = request.getParameter("memo");
	   
	   AddBookVO avo = new AddBookVO(); 
	   
	   avo.setPk_addbook_no(pk_addbook_no);
	   avo.setAddb_name(addb_name);
	   avo.setFk_dept_no(fk_dept_no);
	   avo.setFk_rank_no(fk_rank_no);
	   avo.setEmail(email);
	   avo.setPhone(phone);
	   avo.setCompanyname(companyname);
	   avo.setCom_tel(com_tel);
	   avo.setCompany_address(company_address);
	   avo.setMemo(memo);
	   
	   int n = service.addBook_main_telUpdate_update(avo);
	 //성공했는지 확인했는지
	   String message = "";
	   String loc = "";
	   
	   if(n == 1) {
		   //성공
		    message = "연락처 수정이 완료 되었습니다";
			loc =  request.getContextPath()+"/addBook/addBook_main.bts"; 
	   }else {
		   //실패
		   message = "연락처 수정이 추가가 실패했습니다";
		   loc =  request.getContextPath()+"/addBook/addBook_main.bts"; 
	   }
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
      
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
	
	
	// 유리한테 줄 모달 페이지에서 사원상세정보 ajax로 select 해오기
	@RequestMapping(value="/addBook/addBook_telAdd_select_ajax.bts", produces = "application/json; charset=utf-8")
	public Map<String,Object> addBook_telAdd_select_ajax(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String,Object> depInfoMap = new HashMap<>();
		
		String hiddenEmpno = request.getParameter("hiddenEmpno");
	   
		List<String> list = Arrays.asList(hiddenEmpno.split(","));
		
		System.out.println(list.get(0));
		System.out.println(list.get(1));
		System.out.println(list.get(2));
/*		
		EmployeeVO evo = service.addBook_depInfo_select_ajax(pk_emp_no);
		
		depInfoMap.put("name",evo.getEmp_name());
		depInfoMap.put("department", evo.getKo_depname());
		depInfoMap.put("rank", evo.getKo_rankname());
		depInfoMap.put("email", evo.getUq_email());
		depInfoMap.put("phone", evo.getUq_phone());
		depInfoMap.put("address", evo.getAddress());
		depInfoMap.put("detailaddress", evo.getDetailaddress());
		depInfoMap.put("extraaddress", evo.getExtraaddress());	   
*/		
		return depInfoMap;
	}
   
   

   
   

	
	
	
	
	
	

   

}