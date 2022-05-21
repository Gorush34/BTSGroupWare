package com.spring.bts.jieun.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.common.AES256;
import com.spring.bts.common.MyUtil;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.jieun.model.CalendarVO;
import com.spring.bts.jieun.model.ScheduleVO;
import com.spring.bts.jieun.service.InterCalendarService;

/*
사용자 웹브라우저 요청(View)  ==> DispatcherServlet ==> @Controller 클래스 <==>> Service단(핵심업무로직단, business logic단) <==>> Model단[Repository](DAO, DTO) <==>> myBatis <==>> DB(오라클)           
(http://...  *.action)                                  |                                                                                                                              
 ↑                                                View Resolver
 |                                                      ↓
 |                                                View단(.jsp 또는 Bean명)
 -------------------------------------------------------| 

사용자(클라이언트)가 웹브라우저에서 http://localhost:9090/board/test/test_insert.action 을 실행하면
배치서술자인 web.xml 에 기술된 대로  org.springframework.web.servlet.DispatcherServlet 이 작동된다.
DispatcherServlet 은 bean 으로 등록된 객체중 controller 빈을 찾아서  URL값이 "/test_insert.action" 으로
매핑된 메소드를 실행시키게 된다.                                               
Service(서비스)단 객체를 업무 로직단(비지니스 로직단)이라고 부른다.
Service(서비스)단 객체가 하는 일은 Model단에서 작성된 데이터베이스 관련 여러 메소드들 중 관련있는것들만을 모아 모아서
하나의 트랜잭션 처리 작업이 이루어지도록 만들어주는 객체이다.
여기서 업무라는 것은 데이터베이스와 관련된 처리 업무를 말하는 것으로 Model 단에서 작성된 메소드를 말하는 것이다.
이 서비스 객체는 @Controller 단에서 넘겨받은 어떤 값을 가지고 Model 단에서 작성된 여러 메소드를 호출하여 실행되어지도록 해주는 것이다.
실행되어진 결과값을 @Controller 단으로 넘겨준다.
*/

//=== #30. 컨트롤러 선언 ===
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
 그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
 즉, 여기서 bean의 이름은 boardController 이 된다. 
 여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/

@Controller
public class CalendarController {
	
	
	// === #35. 의존객체 주입하기(DI: Dependency Injection) ===
	// ※ 의존객체주입(DI : Dependency Injection) 
	//  ==> 스프링 프레임워크는 객체를 관리해주는 컨테이너를 제공해주고 있다.
	//      스프링 컨테이너는 bean으로 등록되어진 BoardController 클래스 객체가 사용되어질때, 
	//      BoardController 클래스의 인스턴스 객체변수(의존객체)인 BoardService service 에 
	//      자동적으로 bean 으로 등록되어 생성되어진 BoardService service 객체를  
	//      BoardController 클래스의 인스턴스 변수 객체로 사용되어지게끔 넣어주는 것을 의존객체주입(DI : Dependency Injection)이라고 부른다. 
	//      이것이 바로 IoC(Inversion of Control == 제어의 역전) 인 것이다.
	//      즉, 개발자가 인스턴스 변수 객체를 필요에 의해 생성해주던 것에서 탈피하여 스프링은 컨테이너에 객체를 담아 두고, 
	//      필요할 때에 컨테이너로부터 객체를 가져와 사용할 수 있도록 하고 있다. 
	//      스프링은 객체의 생성 및 생명주기를 관리할 수 있는 기능을 제공하고 있으므로, 더이상 개발자에 의해 객체를 생성 및 소멸하도록 하지 않고
	//      객체 생성 및 관리를 스프링 프레임워크가 가지고 있는 객체 관리기능을 사용하므로 Inversion of Control == 제어의 역전 이라고 부른다.  
	//      그래서 스프링 컨테이너를 IoC 컨테이너라고도 부른다.
	
	//  IOC(Inversion of Control) 란 ?
	//  ==> 스프링 프레임워크는 사용하고자 하는 객체를 빈형태로 이미 만들어 두고서 컨테이너(Container)에 넣어둔후
	//      필요한 객체사용시 컨테이너(Container)에서 꺼내어 사용하도록 되어있다.
	//      이와 같이 객체 생성 및 소멸에 대한 제어권을 개발자가 하는것이 아니라 스프링 Container 가 하게됨으로써 
	//      객체에 대한 제어역할이 개발자에게서 스프링 Container로 넘어가게 됨을 뜻하는 의미가 제어의 역전 
	//      즉, IOC(Inversion of Control) 이라고 부른다.
	
	
	//  === 느슨한 결합 ===
	//      스프링 컨테이너가 BoardController 클래스 객체에서 BoardService 클래스 객체를 사용할 수 있도록 
	//      만들어주는 것을 "느슨한 결합" 이라고 부른다.
	//      느스한 결합은 BoardController 객체가 메모리에서 삭제되더라도 BoardService service 객체는 메모리에서 동시에 삭제되는 것이 아니라 남아 있다.
	
	// ===> 단단한 결합(개발자가 인스턴스 변수 객체를 필요에 의해서 생성해주던 것)
	// private InterBoardService service = new BoardService(); 
	// ===> BoardController 객체가 메모리에서 삭제 되어지면  BoardService service 객체는 멤버변수(필드)이므로 메모리에서 자동적으로 삭제되어진다.	
	

	@Autowired    // Type에 따라 알아서 Bean 을 주입해준다.
    private InterCalendarService service;
	
/*	@Autowired
	private AES256 aes;*/
	
	// === 캘린더 일정 페이지 === //	
	@RequestMapping(value="/calendar/calenderMain.bts")
	public ModelAndView calenderMain(ModelAndView mav) {
		
		mav.setViewName("calendarMain.calendar");
		
		return mav;
	//  /WEB-INF/views/tiles3/fcalenderMain.jsp	페이지를 만들어야 한다.		
	}
	
	// === 일정등록 페이지  === //
	@RequestMapping(value="/calendar/scheduleRegister.bts", method= {RequestMethod.POST})
	public ModelAndView scheduleRegister(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// form 에서 받아온 날짜. (+ 일정 등록창으로 넘어가는 기능)
		String chooseDate = request.getParameter("chooseDate");
		
		mav.addObject("chooseDate", chooseDate);
		mav.setViewName("scheduleRegister.calendar");
		
		return mav;
	}
	
	// === 사내 캘린더에 사내 캘린더 소분류 추가하기 === //
	@ResponseBody
	@RequestMapping(value="/calendar/addComCalendar.bts", method= {RequestMethod.POST})
	public String addComCalendar(HttpServletRequest request) throws Throwable {
		
		String addCom_calname  = request.getParameter("addCom_calname");
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("addCom_calname", addCom_calname);
		paraMap.put("fk_emp_no", fk_emp_no);
		
		int n = service.addComCalendar(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// === 사내 캘린더에서 사내캘린더 소분류 보여주기  === //
	@ResponseBody
	@RequestMapping(value="/calendar/showCompanyCalendar.bts", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String showCompanyCalendar() {
		
		List<CalendarVO> companyCalList = service.showCompanyCalendar();
		
		JSONArray jsonArr = new JSONArray();
		
		if(companyCalList != null) {
			for(CalendarVO cavo : companyCalList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("pk_calno", cavo.getPk_calno());
				jsonObj.put("calname", cavo.getCalname());
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
	
		
	// === 내 캘린더에 내 캘린더 소분류 추가하기 === //
	@ResponseBody
	@RequestMapping(value="/calendar/addMyCalendar.bts", method= {RequestMethod.POST})
	public String addMyCalendar(HttpServletRequest request) throws Throwable {
		
		String addMy_calname  = request.getParameter("addMy_calname");
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("addMy_calname", addMy_calname);
		paraMap.put("fk_emp_no", fk_emp_no);
		
		int n = service.addMyCalendar(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// === 내 캘린더에서 내캘린더 소분류 보여주기  === //
	@ResponseBody
	@RequestMapping(value="/calendar/showMyCalendar.bts", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String showMyCalendar(HttpServletRequest request) {
		
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		List<CalendarVO> myCalList = service.showMyCalendar(fk_emp_no);
		
		JSONArray jsonArr = new JSONArray();
		
		if(myCalList != null) {
			for(CalendarVO cavo : myCalList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("pk_calno", cavo.getPk_calno());
				jsonObj.put("calname", cavo.getCalname());
				//System.out.println(jsonObj);
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	// === 캘린더 소분류 수정하기 === //
	@ResponseBody
	@RequestMapping(value="/calendar/editCalendar.bts", method= {RequestMethod.POST})
	public String editCalendar(HttpServletRequest request) throws Throwable {
		
		String pk_calno = request.getParameter("pk_calno");
		String calname = request.getParameter("calname");
		String fk_emp_no = request.getParameter("fk_emp_no");
		String caltype = request.getParameter("caltype");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_calno", pk_calno);
		paraMap.put("calname", calname);
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("caltype", caltype);
		
		int n = service.editCalendar(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// === 캘린더 소분류 삭제하기 === //
	@ResponseBody
	@RequestMapping(value="/calendar/deleteCalendar.bts", method= {RequestMethod.POST})
	public String deleteCalendar(HttpServletRequest request) throws Throwable  {
		
		String pk_calno = request.getParameter("pk_calno");
		//System.out.println("확인용"+ pk_calno);
		
		int n = service.deleteCalendar(pk_calno);
		//System.out.println("확인용" + n);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// === 서브 캘린더 가져오기 === //
	@ResponseBody
	@RequestMapping(value="/calendar/selectCalNo.bts",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String selectCalNo(HttpServletRequest request) {
		
		String fk_lgcatgono = request.getParameter("fk_lgcatgono");
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		paraMap.put("fk_emp_no", fk_emp_no);
		
		List<CalendarVO> calendarvoList = service.selectCalNo(paraMap);
		
		JSONArray jsArr = new JSONArray();
		if(calendarvoList != null) {
			for(CalendarVO cavo :calendarvoList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("pk_calno", cavo.getPk_calno());
				jsonObj.put("calname", cavo.getCalname());
				
				jsArr.put(jsonObj);
			}
		}
		
		return jsArr.toString();
	}
	
	

	// === 참석자 추가하기 === //
	@ResponseBody
	@RequestMapping(value="/calendar/scheduleRegister/searchJoinUser.bts", produces="text/plain;charset=UTF-8")
	public String searchJoinUser(HttpServletRequest request) throws JSONException, NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {
		
		String joinUserName = request.getParameter("joinUserName");
		
		// 사원 명단 불러오기
		List<EmployeeVO> joinUserList = service.searchJoinUser(joinUserName);
		
		JSONArray jsonArr = new JSONArray();
		if(joinUserList != null && joinUserList.size() > 0) {
			for(EmployeeVO mvo : joinUserList) {
				JSONObject jsObj = new JSONObject();
				//jsObj.put("email", aes.decrypt(mvo.getUq_email()) );
				jsObj.put("name", mvo.getEmp_name());
				
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
	}

//	
	// === 일정 등록 하기 === //
	@RequestMapping(value="/calendar/scheduleRegisterInsert.bts",method = {RequestMethod.POST})
	public ModelAndView scheduleRegisterInsert(ModelAndView mav, HttpServletRequest request) throws Throwable {
		
		String method = request.getMethod();
		mav.addObject("method", method);
	//	System.out.println("확인용 : "+method);
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String subject = request.getParameter("subject");
		String fk_lgcatgono= request.getParameter("fk_lgcatgono");
		String fk_calno = request.getParameter("fk_calno");
		String joinuser = request.getParameter("joinuser");
		String color = request.getParameter("color");
		String place = request.getParameter("place");
		String content = request.getParameter("content");
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("subject", subject);
		paraMap.put("fk_lgcatgono",fk_lgcatgono);
		paraMap.put("fk_calno", fk_calno);
		paraMap.put("joinuser", joinuser);
		paraMap.put("color", color);
		paraMap.put("place", place);
		paraMap.put("content", content);
		paraMap.put("fk_emp_no", fk_emp_no);
		
		int n = service.scheduleRegisterInsert(paraMap);
		
		if(n ==0) {
			mav.addObject("message", "일정 등록에 실패하였습니다.");
		}
		else {
			mav.addObject("message", "일정 등록에 성공하였습니다.");
		}
		
		mav.addObject("loc", request.getContextPath()+"/calendar/calenderMain.bts");
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	// === 일정 보여주기 === //
	@ResponseBody
	@RequestMapping(value="/calendar/selectSchedule.bts", produces="text/plain;charset=UTF-8")
	public String selectSchedule(HttpServletRequest request) {
		
		String fk_emp_no = request.getParameter("fk_emp_no");
		String emp_name = request.getParameter("emp_name");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("emp_name", emp_name);
		
		List<ScheduleVO> scheduleList = service.selectSchedule(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(scheduleList != null && scheduleList.size() > 0) {
			for(ScheduleVO svo:scheduleList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("subject", svo.getSubject());
				jsonObj.put("startdate", svo.getStartdate());
				jsonObj.put("enddate", svo.getEnddate());
				jsonObj.put("color", svo.getColor());
				jsonObj.put("pk_schno", svo.getPk_schno());
				jsonObj.put("fk_lgcatgono", svo.getFk_lgcatgono());
				jsonObj.put("fk_calno", svo.getFk_calno());
				jsonObj.put("fk_emp_no", svo.getFk_emp_no());
				jsonObj.put("joinuser", svo.getJoinuser());
				
				jsonArr.put(jsonObj);
			}// end of for----------------------------------------------
		
		}	
		
		return jsonArr.toString();
	}
	
	
	// === 일정 상세 페이지 === //
	@RequestMapping(value="/calendar/detailSchedule.bts")
	public ModelAndView detailSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String pk_schno = request.getParameter("pk_schno");
		//System.out.println("확인:"+pk_schno);
		// 검색  취소 버튼 클릭시
		// String gobackURL_calendar = request.getParameter("gobackURL_calendar");
		
		// 일정 상세 보기에서 일정수정하기로 넘어갔을 때 
		String gobackURL_ds = MyUtil.getCurrentURL(request);
		mav.addObject("gobackURL_ds", gobackURL_ds);
		
		try {
			Integer.parseInt(pk_schno);
			Map<String,String> map = service.detailSchedule(pk_schno);
			mav.addObject("map", map);
			mav.setViewName("detailSchedule.calendar");
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/calendar/calenderMain.bts");
		}
		
		return mav;
	}
	
	// == 상세페이지에서 댓글 적기 == //
	@ResponseBody
	@RequestMapping(value="/calendar/commentInput.bts", method= {RequestMethod.POST})
	public String commentInput(HttpServletRequest request) {
		
		String fk_emp_no = request.getParameter("fk_emp_no");
		String emp_name = request.getParameter("emp_name");
		String content = request.getParameter("content");
		String pk_schno = request.getParameter("pk_schno");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("emp_name", emp_name);
		paraMap.put("content", content);
		paraMap.put("pk_schno", pk_schno);
		
		int n = service.commentInput(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// == 상세페이지에서 댓글 보여주기 == //
	@ResponseBody
	@RequestMapping(value="calendar/getScheduleComment.bts", produces="text/plain;charset=UTF-8")
	public String getScheduleComment(HttpServletRequest request) {
		
		String pk_schno = request.getParameter("pk_schno");
		List<Map<String,String>> commentList = service.getScheduleComment(pk_schno);

		JSONArray jsArr = new JSONArray();
		for(Map<String,String> map :commentList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("CONTENT", map.get("CONTENT"));
			jsonObj.put("REGDATE", map.get("REGDATE"));
			jsonObj.put("PK_SCHECONO", map.get("PK_SCHECONO"));
			jsonObj.put("FK_EMP_NO", map.get("FK_EMP_NO"));
			jsonObj.put("NAME", map.get("NAME"));
			jsonObj.put("PARENTSCHNO", map.get("PARENTSCHNO"));
			jsonObj.put("STATUS", map.get("STATUS"));
			
			jsArr.put(jsonObj);
		}
		
		
		return jsArr.toString();
	}
	
	
	// == 상세페이지에서 댓글 삭제 == //
	@ResponseBody
	@RequestMapping(value="/calendar/delComment.bts", method= {RequestMethod.POST})
	public String delComment(HttpServletRequest request) {
		
		String pk_schecono = request.getParameter("pk_schecono");
		
		int n = service.delComment(pk_schecono);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// === 일정 삭제 하기 === //
	@ResponseBody
	@RequestMapping(value="/calendar/deleteSchedule.bts", method= {RequestMethod.POST})
	public String deleteSchedule(HttpServletRequest request) {
		
		String pk_schno = request.getParameter("pk_schno");
		
		int n = service.deleteSchedule(pk_schno);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// == 일정 수정 페이지로 이동 == //
	@RequestMapping(value="/calendar/editSchedule.bts", method= {RequestMethod.POST})
	public ModelAndView editSchedule(HttpServletRequest request, ModelAndView mav) {
		
		String pk_schno = request.getParameter("pk_schno");
		
		try {
			Integer.parseInt(pk_schno);
			
			String gobackURL_ds = MyUtil.getCurrentURL(request);
			
			HttpSession session = request.getSession();
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			Map<String,String> map = service.detailSchedule(pk_schno);
			
			if(loginuser.getPk_emp_no() != Integer.parseInt(map.get("FK_EMP_NO"))) {
				String message = "다른 사용자가 작성한 일정은 수정이 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			else {
				mav.addObject("map", map);
				mav.addObject("gobackURL_ds", gobackURL_ds);
				
				mav.setViewName("editSchedule.calendar");
			}
			
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/calendar/calenderMain.bts");
		}
		return mav;
	}
	
	
	// == 일정 수정하기 == //
	@ResponseBody
	@RequestMapping(value="/calendar/editSchedule_end.bts", method= {RequestMethod.POST})
	public ModelAndView editSchedule_end(ScheduleVO svo, HttpServletRequest request, ModelAndView mav) {
		
		try {
			
			int n = service.editSchedule_end(svo);
			
			if(n==1) {
				mav.addObject("message", "일정을 수정하였습니다.");
				mav.addObject("loc", request.getContextPath()+"/calendar/calenderMain.bts");
			}
			else {
				mav.addObject("message", "일정 수정에 실패하였습니다.");
				mav.addObject("loc", "javascript:history.back()");
			}
			
			mav.setViewName("msg");
		} catch (Throwable e) {	
			e.printStackTrace();
			mav.setViewName("redirect:/calendar/calenderMain.bts");
		}
		
		return mav;
	}
	
		
	// == 일정 검색하기 == //
	@RequestMapping(value="/calendar/calendarSearch.bts", method = {RequestMethod.GET})
	public ModelAndView calendarSearch(ModelAndView mav, HttpServletRequest request) {
		
		List<Map<String, String>> calendarSearchList = null;
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String searchSubject = request.getParameter("searchSubject");
		String searchJoinuser = request.getParameter("searchJoinuser");
		String fk_emp_no = request.getParameter("fk_emp_no");  // 로그인한 사용자고유번호
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String str_sizePerPage = request.getParameter("sizePerPage");
			
		if(searchType==null || !"calendar".equals(searchType) ) {  
			searchType="";
		}
		
		if(searchWord==null || "".equals(searchWord) || searchWord.trim().isEmpty()) {  
			searchWord="";
		}
		
		if(searchSubject==null || "".equals(searchSubject) || searchSubject.trim().isEmpty()) {
			searchSubject="";
		}
		
		if(searchJoinuser==null || "".equals(searchJoinuser) || searchJoinuser.trim().isEmpty()) {
			searchJoinuser="";
		}
		
		if(startdate==null || "".equals(startdate)) {
			startdate="";
		}
		
		if(enddate==null || "".equals(enddate)) {
			enddate="";
		}
			
		if(str_sizePerPage == null || "".equals(str_sizePerPage) || 
		   !("10".equals(str_sizePerPage) || "15".equals(str_sizePerPage) || "20".equals(str_sizePerPage))) {
				str_sizePerPage ="10";
		}
		
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("searchSubject", searchSubject);
		paraMap.put("searchJoinuser", searchJoinuser);
		paraMap.put("str_sizePerPage", str_sizePerPage);

		
		int totalCount=0;          // 총 게시물 건수		
		int currentShowPageNo=0;   // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage=0;           // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
		int sizePerPage = 5;  // 한 페이지당 보여줄 행의 개수
		int startRno=0;            // 시작 행번호
	    int endRno=0;              // 끝 행번호 
	    
	    // 총 일정 검색 건수(totalCount)
	    totalCount = service.getTotalCount(paraMap);
	//  System.out.println("~~~ 확인용 총 일정 검색 건수 totalCount : " + totalCount);
      
	    totalPage = (int)Math.ceil((double)totalCount/sizePerPage); 

		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo=1;
			}
		}
		
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
	    endRno = startRno + sizePerPage - 1;
	      
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    	   
	    calendarSearchList = service.scheduleListSearchWithPaging(paraMap);
	    // 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
		
		mav.addObject("paraMap", paraMap);
		// 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		
		// === 페이지바 만들기 === //
			int blockSize= 5;
			
			int loop = 1;
			
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		   
			String pageBar = "<ul style='list-style:none;'>";
			
			String url = "calendarSearch.bts";
			
			// === [맨처음][이전] 만들기 ===
			if(pageNo!=1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_emp_no="+fk_emp_no+"&searchJoinuser="+searchJoinuser+"&searchSubject="+searchSubject+"&currentShowPageNo=1'>[맨처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_emp_no="+fk_emp_no+"&searchJoinuser="+searchJoinuser+"&searchSubject="+searchSubject+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			while(!(loop>blockSize || pageNo>totalPage)) {
				
				if(pageNo==currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
				}
				else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_emp_no="+fk_emp_no+"&searchJoinuser="+searchJoinuser+"&searchSubject="+searchSubject+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}
				
				loop++;
				pageNo++;
			}// end of while--------------------
			
			// === [다음][마지막] 만들기 === //
			if(pageNo <= totalPage) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_emp_no="+fk_emp_no+"&searchJoinuser="+searchJoinuser+"&searchSubject="+searchSubject+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_emp_no="+fk_emp_no+"&searchJoinuser="+searchJoinuser+"&searchSubject="+searchSubject+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
			}
			pageBar += "</ul>";
			
			mav.addObject("pageBar",pageBar);
			
			String listgobackURL_schedule = MyUtil.getCurrentURL(request);
		//	System.out.println("~~~ 확인용 검색 listgobackURL_schedule : " + listgobackURL_schedule);
			
			mav.addObject("listgobackURL_schedule",listgobackURL_schedule);
			mav.addObject("calendarSearchList", calendarSearchList);
			mav.setViewName("calendarSearch.calendar");
	
		
		return mav;
	}
	
	// == 메인 페이지 오늘의 일정 수 불러오기 == //
	@ResponseBody
	@RequestMapping(value="/calendar/scheduleCount.bts")
	public String scheduleCount(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		
		String pk_emp_no = String.valueOf(loginuser.getPk_emp_no());
		String emp_name = loginuser.getEmp_name();
		// System.out.println("pk_emp_no" +pk_emp_no);
		//System.out.println("emp_name" +emp_name);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_emp_no", pk_emp_no);
		paraMap.put("emp_name", emp_name);
		int n = service.scheduleCount(paraMap);
		// System.out.println(n);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		
		return jsonObj.toString();
	}
	
	// == 메인페이지 : 임직원 생일 가져오기 == //
	@ResponseBody
	@RequestMapping(value="/calendar/employeeBirthIndex.bts", produces="text/plain;charset=UTF-8")
	public String employeeBirthIndex() {
		
		List<Map<String,String>> birthIndexList = service.employeeBirthIndex();
	/*	
		int totalCount=0;          // 총 생일 건수		
		int currentShowPageNo=0;   // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage=0;           // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
		int sizePerPage = 4;  // 한 페이지당 보여줄 행의 개수
		int startRno=0;            // 시작 행번호
	    int endRno=0;              // 끝 행번호 
	    
	    // 총 생일 건수(totalCount)
	    totalCount = service.getTotaBirthCount();
	
      
	    totalPage = (int)Math.ceil((double)totalCount/sizePerPage); 
	*/	
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> map : birthIndexList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("EMP_NAME", map.get("EMP_NAME"));
			jsonObj.put("BIRTHDAY", map.get("BIRTHDAY"));
			jsonObj.put("MONTH", map.get("MONTH"));
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString();
	}
	
	// == 메인페이지 : 임직원 생일 가져오기 == //
	@ResponseBody
	@RequestMapping(value="/calendar/preMonthBirthIndex.bts", produces="text/plain;charset=UTF-8")
	public String preMonthBirthIndex(HttpServletRequest request) {
		
		String month = request.getParameter("month");
		
		List<Map<String,String>> birthIndexList1 = service.preMonthBirthIndex(month);
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> map : birthIndexList1) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("EMP_NAME", map.get("EMP_NAME"));
			jsonObj.put("BIRTHDAY", map.get("BIRTHDAY"));
			jsonObj.put("MONTH", map.get("MONTH"));
			
			jsonArr.put(jsonObj);
		}	
		return jsonArr.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/calendar/nextMonthBirthIndex.bts", produces="text/plain;charset=UTF-8")
	public String nextMonthBirthIndex(HttpServletRequest request) {
		
		String month = request.getParameter("month");
		
		List<Map<String,String>> birthIndexList2 = service.nextMonthBirthIndex(month);
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> map : birthIndexList2) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("EMP_NAME", map.get("EMP_NAME"));
			jsonObj.put("BIRTHDAY", map.get("BIRTHDAY"));
			jsonObj.put("MONTH", map.get("MONTH"));
			
			jsonArr.put(jsonObj);
		}	
		return jsonArr.toString();
	}
	
}
