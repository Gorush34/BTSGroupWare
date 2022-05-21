package com.spring.bts.byungyoon.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.byungyoon.model.AddBookVO;
import com.spring.bts.byungyoon.service.InterAddBookService;
import com.spring.bts.common.AES256;
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
 
	@Autowired
	private AES256 aes;
	
   // 주소록 메인페이지
   @RequestMapping(value="/addBook/addBook_main.bts")
   public ModelAndView requiredLogin_requaddBook_main(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	   
	   Map<String, String> paraMap = new HashMap<>();
	   
	   HttpSession session = request.getSession();
	   EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
	   
	   String str_currentShowPageNo = request.getParameter("currentShowPageNo");
	   String searchWord = request.getParameter("searchWord");
	   
	   if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
	   
	   int totalCount = 0;        // 총 게시물 건수
	   int sizePerPage = 5;       // 한 페이지당 보여줄 게시물 건수 
	   int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
	   int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
	   int startRno = 0; 		  // 시작 행번호
	   int endRno = 0;   		  // 끝 행번호
	   int registeruser = loginuser.getPk_emp_no();
	   
	   paraMap.put("registeruser", String.valueOf(registeruser));
	   paraMap.put("searchWord", searchWord);
	   
	   totalCount = service.addBook_main_totalPage(paraMap);
	   
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
	   
	   startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
	   endRno = startRno + sizePerPage - 1;
	   
	   String message = "";
	   String loc = "";
	   
	  int pk_emp_no = loginuser.getPk_emp_no();
	   
	   paraMap.put("startRno", String.valueOf(startRno));
	   paraMap.put("endRno",  String.valueOf(endRno));
	   paraMap.put("pk_emp_no",  String.valueOf(pk_emp_no));
	   
	   List<AddBookVO> adbList = service.addBook_main_select(paraMap);
	   
	   if( !"".equals(searchWord) ) {
			mav.addObject("paraMap", paraMap);
		}
	   
	   int blockSize = 10;
	   int loop = 1;
	   
	   int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	   
	   String pageBar = "<ul style='list-style: none;'>";
	   String url = "addBook_main.bts";
	   
	   if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchWord="+searchWord+"?&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchWord="+searchWord+"?&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
	   
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchWord="+searchWord+"?&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchWord="+searchWord+"?&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		
	   List<EmployeeVO> empList = service.sideinfo_addBook(); // sideInfo
	   mav.addObject("empList", empList); // sideInfo
	   
	   mav.addObject("message", message);
	   mav.addObject("loc", loc);
	   mav.addObject("pageBar", pageBar);	
	   mav.addObject("adbList", adbList);
	   mav.addObject("loginuser", loginuser);
	   
	   mav.setViewName("addBook_main.addBook");
	   
      return mav;
   }
   
   
   // 주소록 연락처 추가 페이지 
   @RequestMapping(value="/addBook/addBook_telAdd.bts")
   public ModelAndView requiredLogin_addBook_telAdd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	   
	   HttpSession session = request.getSession();
	   EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	 
	   List<EmployeeVO> empList = service.addBook_depInfo_select();
		
		 String message = "";
		 String loc = "";
	   
	   mav.addObject("loginuser", loginuser);
	   mav.addObject("message", message);
	   mav.addObject("loc", loc);
	   mav.addObject("empList", empList);
	   
	   mav.setViewName("addBook_telAdd.addBook");
	   
      return mav;
   }
   
   
   // 주소록 연락처 추가 페이지에서 데이터 넣기
   @ResponseBody
   @RequestMapping(value="/addBook/addBook_telAdd_insert.bts" , method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
   public ModelAndView addBook_telAdd_insert(HttpServletRequest request, ModelAndView mav) {
	   
	   HttpSession session = request.getSession();
	   EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	   
	   List<EmployeeVO> empList = service.addBook_depInfo_select();
	   
	   int registeruser = loginuser.getPk_emp_no();
	   String addb_name = request.getParameter("addb_name");
	   int fk_dept_no = Integer.parseInt(request.getParameter("department"));
	   int fk_rank_no = Integer.parseInt(request.getParameter("rank"));
	   String email = request.getParameter("email");
	   String hp1 = request.getParameter("hp1");
	   String hp2 = request.getParameter("hp2");
	   String hp3 = request.getParameter("hp3");
	   String phone = hp1+"-"+hp2+"-"+hp3; 
	   
	   String companyname = request.getParameter("company");
	   String num1 = request.getParameter("num1");												
	   String num2 = request.getParameter("num2");												
	   String num3 = request.getParameter("num3");
	   String com_tel = num1+"-"+num2+"-"+num3;
	   String company_address = request.getParameter("company_address");
	   String memo = request.getParameter("memo");
	   
	   AddBookVO avo = new AddBookVO();
	   
	   avo.setRegisteruser(registeruser);
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
		
	    mav.addObject("empList", empList);
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
	   
//	   int i= avo.getEmail().indexOf("@");
	/*	
	   String email1 = avo.getEmail().substring(0, i);
	   String email2 = avo.getEmail().substring(i+1);
	*/	
       String hp2 = avo.getPhone().substring(4, 8);
       String hp3 = avo.getPhone().substring(9, 13);
       
       String tel = avo.getCom_tel();
       String[] telarr = tel.split("-");
       
       String num1 = telarr[0];
       String num2 = telarr[1];
       String num3 = telarr[2];
       
       updateMap.put("hp2" , hp2);
       updateMap.put("hp3" , hp3);
 //    updateMap.put("email1" , email1);
 //    updateMap.put("email2" , email2);
       updateMap.put("num1" , num1);
       updateMap.put("num2" , num2);
       updateMap.put("num3" , num3);
       updateMap.put("company_tel", avo.getCom_tel());
	   updateMap.put("company_name", avo.getCompanyname());
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
//	   String email1 = request.getParameter("email1");
//	   String email2 = request.getParameter("email2");
	   String email = request.getParameter("email");
	   String hp1 = request.getParameter("hp1");												
	   String hp2 = request.getParameter("hp2");												
	   String hp3 = request.getParameter("hp3");
	   String companyname = request.getParameter("company_name");
	   String num1 = request.getParameter("num1");												
	   String num2 = request.getParameter("num2");												
	   String num3 = request.getParameter("num3");
	   String company_address  = request.getParameter("company_address");
	   String memo = request.getParameter("memo");
	   
//	   String email = email1+"@"+email2;
	   String phone = hp1+"-"+hp2+"-"+hp3;
	   String com_tel = "";
		if( num2 == "" && num3 == "") {
			com_tel = "";
		}else {
			com_tel = num1+"-"+num2+"-"+num3;
		}
	   
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
	   
	   HttpSession session = request.getSession();
	   EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	   
	   List<EmployeeVO> empList = service.addBook_depInfo_select(); // 사원리스트
	   
	   List<Map<String,String>> depList = service.addBook_depList_select(); // 부서리스트
	   
	   List<Map<String,String>> rankList = service.addBook_rankList_select(); // 직급리스트
	   
	   mav.addObject("empList", empList);
	   mav.addObject("depList", depList);
	   mav.addObject("rankList", rankList);
	   
	   mav.setViewName("addBook_depInfo.addBook");
	   
	   return mav;
   }
   
   
   // 상세부서정보 페이지에서 사원상세정보 ajax로 select 해오기
	@RequestMapping(value="/addBook/addBook_depInfo_select_ajax.bts", produces = "application/json; charset=utf-8")
	public Map<String,Object> addBook_depInfo_select_ajax(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		Map<String,Object> depInfoMap = new HashMap<>();
		
		int pk_emp_no = Integer.parseInt(request.getParameter("pk_emp_no"));
	   
		EmployeeVO evo = service.addBook_depInfo_select_ajax(pk_emp_no);
		
		
		depInfoMap.put("pk_emp_no",evo.getPk_emp_no());
		depInfoMap.put("name",evo.getEmp_name());
		depInfoMap.put("department", evo.getKo_depname());
		depInfoMap.put("department_id", evo.getFk_department_id());
		depInfoMap.put("rank", evo.getKo_rankname());
		depInfoMap.put("rank_id", evo.getFk_rank_id());
		depInfoMap.put("email", evo.getUq_email());
		depInfoMap.put("phone", evo.getUq_phone());
		
		
		/*
		   String email = "test@test.com";
	       String id;
	       String domain;
	       // 변수 email이 포함하고있는 @ 의 인덱스 값을 index 에 대입.
	       int i= email.indexOf("@"); 
	        
	       // 변수 email의 0번째 index부터 index까지 추출하여 id 에 대입.
	       id = email.substring(0.i);
	 
	       // 변수 email의 index+1번째 부터 추출하여 domain 에 대입.
	       domain = email.substring(i+1);
	        
	       // 아이디: test 도메인: test.com
	       System.out.println("id: "+id+"domain: "+domain);
		*/
//		int i= evo.getUq_email().indexOf("@");
		
//		String email1 = evo.getUq_email().substring(0, i);
//		String email2 = evo.getUq_email().substring(i+1);
		
        String hp2 = evo.getUq_phone().substring(4, 8);
        String hp3 = evo.getUq_phone().substring(9, 13);
        
        depInfoMap.put("hp2" , hp2);
        depInfoMap.put("hp3" , hp3);
//      depInfoMap.put("email1" , email1);
//      depInfoMap.put("email2" , email2);
		
		depInfoMap.put("address", evo.getAddress());
		depInfoMap.put("detailaddress", evo.getDetailaddress());
		depInfoMap.put("extraaddress", evo.getExtraaddress());	   
		
		return depInfoMap;
	}
	
	
		// 상세부서정보 페이지에서 관리자로 로그인시 사원상세정보 update 하기
		@RequestMapping(value="/addBook/addBook_depInfo_update.bts", produces = "application/json; charset=utf-8")
		public ModelAndView addBook_depInfo_update(HttpServletRequest request, HttpServletResponse response , ModelAndView mav) throws Exception {
			
			HttpSession session = request.getSession();
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			int pk_emp_no = Integer.parseInt(request.getParameter("select_user_no"));
			
			String emp_name = request.getParameter("name");
			int fk_department_id = Integer.parseInt(request.getParameter("department"));
			int fk_rank_id = Integer.parseInt(request.getParameter("rank"));
//			String email1 = request.getParameter("email1");
//			String email2 = request.getParameter("email2");
			String uq_email = request.getParameter("email");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String address = request.getParameter("address");
			String detailaddress = request.getParameter("detailaddress");
			
//			String uq_email = email1+"@"+email2;
		    String uq_phone = hp1+"-"+hp2+"-"+hp3;
			
		    try {
		    	uq_email = aes.encrypt(uq_email);	 /* 이메일 */
		    	uq_phone = aes.encrypt(uq_phone);							 /* 합친 휴대전화 암호화 */
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}	
		    
			String message = "";
			String loc = "";
			
			
			EmployeeVO evo = new EmployeeVO(); 
			   
			evo.setPk_emp_no(pk_emp_no);
			evo.setEmp_name(emp_name);
			evo.setFk_department_id(fk_department_id);
			evo.setFk_rank_id(fk_rank_id);
			evo.setUq_email(uq_email);
			evo.setUq_phone(uq_phone);
			evo.setAddress(detailaddress);
			evo.setDetailaddress(detailaddress);;
			   
			int n = service.addBook_depInfo_update(evo);
			
			
			if(n == 1) {
				   //성공
				    message = "사원정보 수정이 완료 되었습니다";
					loc =  request.getContextPath()+"/addBook/addBook_depInfo.bts"; 
			   }else {
				   //실패
				   message = "사원정보 수정이 추가가 실패했습니다";
				   loc =  request.getContextPath()+"/addBook/addBook_depInfo.bts"; 
			   }
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
		      
		      return mav;
		}
	
	
		// 주소록 삭제하기
		@RequestMapping(value = "/addBook/addBook_delete.bts", method = {RequestMethod.POST})
		public ModelAndView addBook_delete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
			
			int pk_addbook_no = Integer.parseInt(request.getParameter("pk_addbook_no"));
			
			
			int n = service.addBook_delete(pk_addbook_no);
		        
			if(n == 0) {
				mav.addObject("message", "삭제할 수 없습니다.");
			} else {
				mav.addObject("message", "삭제되었습니다.");
			}
		  
			mav.addObject("loc", request.getContextPath()+"/addBook/addBook_main.bts");
			mav.setViewName("msg");
		      
			return mav;
		}
	
	
		// 사원목록에서 사원 삭제하기
		@RequestMapping(value = "/addBook/addBook_depInfo_delete.bts", method = {RequestMethod.POST})
		public ModelAndView addBook_depInfo_delete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
			
			int pk_emp_no = Integer.parseInt(request.getParameter("user"));
			
			int n = service.addBook_depInfo_delete(pk_emp_no);
		        
			if(n == 0) {
				mav.addObject("message", "삭제할 수 없습니다.");
			} else {
				mav.addObject("message", "삭제되었습니다.");
			}
	 	  
			mav.addObject("loc", request.getContextPath()+"/addBook/addBook_depInfo.bts");
			mav.setViewName("msg");
		     
			return mav;
		}
		
	   // 관리자에서 부서 추가하기 
	   @RequestMapping(value="/addBook/addBook_dep_insert.bts")
	   public ModelAndView addBook_dep_insert(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		   
		   HttpSession session = request.getSession();
		   EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		   
		   int pk_dep_no = Integer.parseInt(request.getParameter("dep_no"));
		   String ko_depname = request.getParameter("ko_dep_name");
		   String en_depname = request.getParameter("en_dep_name");
		   String manager = request.getParameter("dep_manager_no");
		   
		   Map<String, String> paraMap = new HashMap<>();
		   
		   paraMap.put("pk_dep_no", String.valueOf(pk_dep_no));
		   paraMap.put("ko_depname", ko_depname);
		   paraMap.put("en_depname", en_depname);
		   paraMap.put("manager", manager);
		 
		   
		   int n = service.addBook_dep_insert(paraMap);
			
			 String message = "";
			 String loc = "";
		   
			
			 if(n == 1) {
				   //성공
				    message = "부서가 추가 되었습니다";
					loc =  request.getContextPath()+"/addBook/addBook_depInfo.bts"; 
			   }else {
				   //실패
				   message = "추가가 실패했습니다";
				   loc =  request.getContextPath()+"/addBook/addBook_depInfo.bts"; 
			   }
				
				
			 
		   mav.addObject("loginuser", loginuser);
		   mav.addObject("message", message);
		   mav.addObject("loc", loc);
		   mav.setViewName("msg");
		   
	      return mav;
	   }
		
		
		
		// 사이드인포 계급순 구성원 띄우기
	    @RequestMapping(value="/sideinfo/sideinfo_addBook.bts")
	    public ModelAndView sideinfo_addBook(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		   
		    HttpSession session = request.getSession();
		    EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		   
		    List<EmployeeVO> empList = service.sideinfo_addBook();
		   
		    mav.addObject("empList", empList);
		   
		    mav.setViewName("sideinfo_addBook.sideinfo");
		   
		    return mav;
	    }	
	
	
	    // 이메일 중복체크
		@ResponseBody
		@RequestMapping(value="/addBook/emailDuplicateCheck.bts", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public String emailDuplicateCheck(HttpServletRequest request) { 
		
			String email = request.getParameter("email");
			
			
			// System.out.println(">>> 확인용 uq_email =>"+ uq_email );	// 내가 입력한 아이디 값
			
			boolean isExist = service.emailDuplicateCheck(email);
			
			JSONObject jsonObj = new JSONObject(); 	// {}
			jsonObj.put("isExist", isExist);			// {"isExist":true} 또는 {"isExist":false} 으로 만들어준다. 
				
				String json = jsonObj.toString();	// 문자열 형태인 "{"isExist":true}" 또는 "{"isExist":false}" 으로 만들어준다.
				// System.out.println(">>> 확인용 json =>"+ json );	
			//	>>> 확인용 json =>{"isExist":false}
			//	또는	
			//	>>> 확인용 json =>{"isExist":true}
				
			request.setAttribute("json",json);
				
			return json;
			
		} // public String emailDuplicateCheck(HttpServletRequest request) 
	
	
		// 관리자에서 부서 삭제하기
		@RequestMapping(value = "/addBook/addBook_dep_delete.bts", method = {RequestMethod.POST})
		public ModelAndView addBook_dep_delete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
			
			int dep_delete = Integer.parseInt(request.getParameter("dep_delete"));
			
			
			int n = service.addBook_dep_delete(dep_delete);
			
			
			if(n == 0) {
				mav.addObject("message", "삭제할 수 없습니다.");
			} else {
				mav.addObject("message", "삭제되었습니다.");
			}
	 	  
			mav.addObject("loc", request.getContextPath()+"/addBook/addBook_depInfo.bts");
			mav.setViewName("msg");
		     
			return mav;
		}
		
	
	
/*	
	 // 실험용 페이지
	   @RequestMapping(value="/addBook/orgChart_sample.bts")
	   public ModelAndView orgChart_sample(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		   
		   HttpSession session = request.getSession();
		   EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		 
		   List<EmployeeVO> empList = service.addBook_depInfo_select();
			 
			  String test_1 = request.getParameter("test_1");
			  String test_2 = request.getParameter("test_2");
			  String test_3 = request.getParameter("test_3");
			  
			  System.out.println(test_1);
			  System.out.println(test_2);
			  System.out.println(test_3);
		   
		   mav.addObject("loginuser", loginuser);
		   mav.addObject("empList", empList);
		   
		   mav.setViewName("orgChart_sample.addBook");
		   
	      return mav;
	   }
*/	   
	   
	  

	
	
	
	
	
	

   

}