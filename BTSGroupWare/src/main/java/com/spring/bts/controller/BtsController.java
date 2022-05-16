package com.spring.bts.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.common.AES256;
import com.spring.bts.common.MyUtil;
import com.spring.bts.common.Sha256;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.hwanmo.service.InterEmployeeService;
import com.spring.bts.service.*;

/*
사용자 웹브라우저 요청(View)  ==> DispatcherServlet ==> @Controller 클래스 <==>> Service단(핵심업무로직단, business logic단) <==>> Model단[Repository](DAO, DTO) <==>> myBatis <==>> DB(오라클)           
(http://...  *.bts)                                  |                                                                                                                              
 ↑                                                View Resolver
 |                                                      ↓
 |                                                View단(.jsp 또는 Bean명)
 -------------------------------------------------------| 

사용자(클라이언트)가 웹브라우저에서 http://localhost:9090/board/test_insert.bts 을 실행하면
배치서술자인 web.xml 에 기술된 대로  org.springframework.web.servlet.DispatcherServlet 이 작동된다.
DispatcherServlet 은 bean 으로 등록된 객체중 controller 빈을 찾아서  URL값이 "/test_insert.bts" 으로
매핑된 메소드를 실행시키게 된다.                                               
Service(서비스)단 객체를 업무 로직단(비지니스 로직단)이라고 부른다.
Service(서비스)단 객체가 하는 일은 Model단에서 작성된 데이터베이스 관련 여러 메소드들 중 관련있는것들만을 모아 모아서
하나의 트랜잭션 처리 작업이 이루어지도록 만들어주는 객체이다.
여기서 업무라는 것은 데이터베이스와 관련된 처리 업무를 말하는 것으로 Model 단에서 작성된 메소드를 말하는 것이다.
이 서비스 객체는 @Controller 단에서 넘겨받은 어떤 값을 가지고 Model 단에서 작성된 여러 메소드를 호출하여 실행되어지도록 해주는 것이다.
실행되어진 결과값을 @Controller 단으로 넘겨준다.
*/

// === #30. 컨트롤러 선언 === // 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
즉, 여기서 bean의 이름은  btsController 이 된다. 
여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BtsController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller
public class BtsController {
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
	
	@Autowired
	private AES256 aes;
	
	@Autowired
	private InterEmployeeService empService;
	
	@Autowired	// Type에 따라 알아서 Bean을 주입해준다.
	private InterBtsService service;
	
	// 메인 페이지 요청
	@RequestMapping(value="/index.bts")
	public ModelAndView requiredLogin_index(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// getCurrentURL(request); // 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출 
		
		// List<String> imgfilenameList = service.getImgfilenameList();
		
		// mav.addObject("imgfilenameList", imgfilenameList);
		
		// /WEB-INF/views/tiles1/main/index.jsp 페이지를 만들어야 한다.
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		int pk_emp_no = loginuser.getPk_emp_no();
		
		// 회원정보 받아오기
		List<Map<String, Object>> empList = empService.getEmpInfo(pk_emp_no);
		
		mav.addObject("empList", empList);
		mav.setViewName("main/index.tiles1");
		return mav;
	}
	
	// 로그인 페이지 요청
	@RequestMapping(value="/login.bts")
	public ModelAndView login(ModelAndView mav, HttpServletRequest request) {
		
		// getCurrentURL(request); // 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출 
		
		// List<String> imgfilenameList = service.getImgfilenameList();
		
		// mav.addObject("imgfilenameList", imgfilenameList);
		mav.setViewName("/tiles1/main/login");
		// /WEB-INF/views/tiles1/main/login.jsp 페이지를 만들어야 한다.
		
		return mav;
	} // public ModelAndView login(ModelAndView mav, HttpServletRequest request) ----
	
	
	// === #41. 로그인 처리하기 === // 
	@RequestMapping(value="/loginEnd.bts", method= {RequestMethod.POST})
	public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {
		
		String userid = request.getParameter("pk_emp_no");
		String pwd = request.getParameter("emp_pwd");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_emp_no", userid);
		paraMap.put("emp_pwd", Sha256.encrypt(pwd));
		
		EmployeeVO loginuser = service.getLoginMember(paraMap);
		
		if(loginuser == null) { // 로그인 실패시
			String message = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
		
			mav.setViewName("msg");
			// /WEB-INF/views/msg.jsp
		}
		else { // 아이디와 암호가 존재하는 경우
			
			
			HttpSession session = request.getSession();
			// 메모리에 생성되어져 있는 session 을 불러오는 것이다.
			
			session.setAttribute("loginuser", loginuser);
			// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
			
			
			if(loginuser.isRequirePwdChange() == true) { // 암호를 마지막으로 변경한 것이 3개월이 경과한 경우
				String message = "비밀번호를 변경하신지 3개월이 지났습니다.\\n암호를 변경하시기 바랍니다.";
				String loc = request.getContextPath()+"/index.bts";
				// 원래는 위와 같이 index.action 이 아니라 휴면인 계정을 풀어주는 페이지로 잡아주어야 한다.
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
			
				mav.setViewName("msg");
			}
			else { // 암호를 마지막으로 변경한 것이 3개월 이내인 경우
				
				// 로그인을 해야만 접근할 수 있는 페이지에 로그인을 하지 않은 상태에서 접근을 시도한 경우 
                // "먼저 로그인을 하세요!!" 라는 메시지를 받고서 사용자가 로그인을 성공했다라면
                // 화면에 보여주는 페이지는 시작페이지로 가는 것이 아니라
                // 조금전 사용자가 시도하였던 로그인을 해야만 접근할 수 있는 페이지로 가기 위한 것이다.
				String goBackURL = (String) session.getAttribute("goBackURL");
				
				if(goBackURL != null) {
					mav.setViewName("redirect:"+goBackURL);
					session.removeAttribute("goBackURL"); // 세션에서 반드시 제거해주어야 한다.
				}
				else {
					mav.setViewName("redirect:/index.bts"); // 시작페이지로 이동
				}
			} // end of if(loginuser.isRequirePwdChange() == true)-------
				
			
		}
		
		return mav;
	} // end of public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request)------
	
	// === #50. 로그아웃 처리하기 === //
	@RequestMapping(value="/logout.bts")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		
		/*
		// 로그아웃시 로그인페이지로 돌아가는 것임
		HttpSession session = request.getSession();
		session.invalidate();
		
		String message = "로그아웃 되었습니다.";
		String loc = request.getContextPath()+"/login.bts";
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		mav.setViewName("msg");
		// 
		
		return mav;
		*/
		
		// 로그아웃시 현재 보았던 페이지로 돌아가는 것임
		HttpSession session = request.getSession();
		
		String goBackURL = (String) session.getAttribute("goBackURL");
		
		session.invalidate();
		
		String message = "로그아웃 되었습니다.";
		
		String loc = "";
		if(goBackURL != null) {
			loc = request.getContextPath()+goBackURL;
		}
		else {
			loc = request.getContextPath()+"/login.bts";
		}
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		mav.setViewName("msg");
		// 
		
		return mav;
		
	}
	
	
	// === #200. 기상청 공공데이터(오픈데이터)를 가져와서 날씨정보 보여주기 === //
	@RequestMapping(value = "/opendata/weatherXML.bts", method = {RequestMethod.GET})	// default 가 GET.
	public String weatherXML() {
		
		return "opendata/weatherXML";		// 접두어/접미어 기억하기
		// /Board/src/main/webapp/WEB-INF/views/opendata/weatherXML.jsp 파일을 생성한다.
	}
		
	//////////////////////////////////////////////////////
	@ResponseBody
	@RequestMapping(value="/opendata/weatherXMLtoJSON.bts", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8") 
	public String weatherXMLtoJSON(HttpServletRequest request) { 
	
		String str_jsonObjArr = request.getParameter("str_jsonObjArr");
		/*  확인용
		//   System.out.println(str_jsonObjArr);
		//  [{"locationName":"속초","ta":"2.4"},{"locationName":"북춘천","ta":"-2.3"},{"locationName":"철원","ta":"-2.0"},{"locationName":"동두천","ta":"-0.7"},{"locationName":"파주","ta":"-1.2"},{"locationName":"대관령","ta":"-3.0"},{"locationName":"춘천","ta":"-1.6"},{"locationName":"백령도","ta":"1.1"},{"locationName":"북강릉","ta":"3.4"},{"locationName":"강릉","ta":"4.3"},{"locationName":"동해","ta":"4.1"},{"locationName":"서울","ta":"-0.3"},{"locationName":"인천","ta":"-0.2"},{"locationName":"원주","ta":"-2.2"},{"locationName":"울릉도","ta":"4.2"},{"locationName":"수원","ta":"1.4"},{"locationName":"영월","ta":"-4.5"},{"locationName":"충주","ta":"-3.0"},{"locationName":"서산","ta":"2.5"},{"locationName":"울진","ta":"3.9"},{"locationName":"청주","ta":"-0.7"},{"locationName":"대전","ta":"2.9"},{"locationName":"추풍령","ta":"3.2"},{"locationName":"안동","ta":"-2.3"},{"locationName":"상주","ta":"1.5"},{"locationName":"포항","ta":"4.7"},{"locationName":"군산","ta":"2.6"},{"locationName":"대구","ta":"1.6"},{"locationName":"전주","ta":"5.7"},{"locationName":"울산","ta":"4.0"},{"locationName":"창원","ta":"4.4"},{"locationName":"광주","ta":"2.8"},{"locationName":"부산","ta":"4.3"},{"locationName":"통영","ta":"5.7"},{"locationName":"목포","ta":"4.5"},{"locationName":"여수","ta":"5.6"},{"locationName":"흑산도","ta":"7.8"},{"locationName":"완도","ta":"7.3"},{"locationName":"고창","ta":"3.5"},{"locationName":"순천","ta":"5.3"},{"locationName":"홍성","ta":"1.7"},{"locationName":"제주","ta":"8.5"},{"locationName":"고산","ta":"9.1"},{"locationName":"성산","ta":"7.5"},{"locationName":"서귀포","ta":"8.8"},{"locationName":"진주","ta":"3.5"},{"locationName":"강화","ta":"-0.9"},{"locationName":"양평","ta":"-1.3"},{"locationName":"이천","ta":"-2.0"},{"locationName":"인제","ta":"-0.5"},{"locationName":"홍천","ta":"-2.6"},{"locationName":"태백","ta":"-1.5"},{"locationName":"정선군","ta":"-1.9"},{"locationName":"제천","ta":"-4.4"},{"locationName":"보은","ta":"-1.2"},{"locationName":"천안","ta":"-1.0"},{"locationName":"보령","ta":"3.6"},{"locationName":"부여","ta":"0.6"},{"locationName":"금산","ta":"3.7"},{"locationName":"세종","ta":"-0.8"},{"locationName":"부안","ta":"5.8"},{"locationName":"임실","ta":"1.6"},{"locationName":"정읍","ta":"5.8"},{"locationName":"남원","ta":"0.1"},{"locationName":"장수","ta":"1.4"},{"locationName":"고창군","ta":"4.3"},{"locationName":"영광군","ta":"4.2"},{"locationName":"김해시","ta":"4.1"},{"locationName":"순창군","ta":"1.0"},{"locationName":"북창원","ta":"5.9"},{"locationName":"양산시","ta":"3.9"},{"locationName":"보성군","ta":"5.1"},{"locationName":"강진군","ta":"4.4"},{"locationName":"장흥","ta":"4.9"},{"locationName":"해남","ta":"6.2"},{"locationName":"고흥","ta":"5.4"},{"locationName":"의령군","ta":"5.7"},{"locationName":"함양군","ta":"4.9"},{"locationName":"광양시","ta":"5.4"},{"locationName":"진도군","ta":"7.0"},{"locationName":"봉화","ta":"-3.3"},{"locationName":"영주","ta":"-4.3"},{"locationName":"문경","ta":"-3.1"},{"locationName":"청송군","ta":"0.5"},{"locationName":"영덕","ta":"4.7"},{"locationName":"의성","ta":"-0.6"},{"locationName":"구미","ta":"2.3"},{"locationName":"영천","ta":"3.4"},{"locationName":"경주시","ta":"4.5"},{"locationName":"거창","ta":"0.8"},{"locationName":"합천","ta":"0.7"},{"locationName":"밀양","ta":"1.1"},{"locationName":"산청","ta":"4.2"},{"locationName":"거제","ta":"5.8"},{"locationName":"남해","ta":"6.2"}]  
		*/
		//   return str_jsonObjArr;  -- 지역 96개 모두 차트에 그리기에는 너무 많으므로 아래처럼 작업을 하여 지역을  21개(String[] locationArr 임)로 줄여서 나타내기로 하겠다.
		
		str_jsonObjArr = str_jsonObjArr.substring(1, str_jsonObjArr.length()-1);
		
		String[] arr_str_jsonObjArr = str_jsonObjArr.split("\\},");
		
		for(int i=0; i<arr_str_jsonObjArr.length; i++) {
			arr_str_jsonObjArr[i] += "}";	//,"ta":"15.7"} 부분에서 '}' 부분 += 함.
		}
		
		/*  확인용
		for(String jsonObj : arr_str_jsonObjArr) {
			System.out.println(jsonObj);
		}
		
		*/ // jsonObj 객체 하나하나가 나온다.
		// {"locationName":"속초","ta":"15.7"}
		// {"locationName":"북춘천","ta":"24.9"}
		// {"locationName":"철원","ta":"23.8"}
		// {"locationName":"동두천","ta":"26.3"}
		// {"locationName":"파주","ta":"25.5"}
		// {"locationName":"대관령","ta":"10.8"}
		// {"locationName":"춘천","ta":"26.7"}
		// {"locationName":"백령도","ta":"13.8"}
		// ........ 등등  
		// {"locationName":"밀양","ta":"24.7"}
		// {"locationName":"산청","ta":"24.2"}
		// {"locationName":"거제","ta":"21.0"}
		// {"locationName":"남해","ta":"22.7"}
		
		
		String[] locationArr = {"서울","인천","수원","춘천","강릉","청주","홍성","대전","안동","포항","대구","전주","울산","부산","창원","여수","광주","목포","제주","울릉도","백령도"};
		String result = "[";
		
		for(String jsonObj : arr_str_jsonObjArr) {
		
		for(int i=0; i<locationArr.length; i++) {
			//  if( jsonObj.indexOf(locationArr[i]) >= 0 ) { // 북춘천,춘천,북강릉,강릉,북창원,창원이 있으므로  if(jsonObj.indexOf(locationArr[i]) >= 0) { 을 사용하지 않음 
				if( jsonObj.substring(jsonObj.indexOf(":")+2, jsonObj.indexOf(",")-1).equals(locationArr[i]) ) { 
					result += jsonObj+",";  // [{"locationName":"춘천","ta":"26.7"},{"locationName":"백령도","ta":"13.8"}, ..... {"locationName":"제주","ta":"18.9"}, 
					break;
				}
			}
		}// end of for------------------------------
		
			result = result.substring(0, result.length()-1);  // [{"locationName":"춘천","ta":"26.7"},{"locationName":"백령도","ta":"13.8"}, ..... {"locationName":"제주","ta":"18.9"}
			result = result + "]";                            // [{"locationName":"춘천","ta":"26.7"},{"locationName":"백령도","ta":"13.8"}, ..... {"locationName":"제주","ta":"18.9"}]
			
			/*  확인용
			System.out.println(result);
			// [{"locationName":"춘천","ta":"26.7"},{"locationName":"백령도","ta":"13.8"},{"locationName":"강릉","ta":"18.4"},{"locationName":"서울","ta":"27.7"},{"locationName":"인천","ta":"23.8"},{"locationName":"울릉도","ta":"19.2"},{"locationName":"수원","ta":"26.5"},{"locationName":"청주","ta":"26.8"},{"locationName":"대전","ta":"26.4"},{"locationName":"안동","ta":"24.3"},{"locationName":"포항","ta":"19.4"},{"locationName":"대구","ta":"22.7"},{"locationName":"전주","ta":"26.3"},{"locationName":"울산","ta":"20.7"},{"locationName":"창원","ta":"21.9"},{"locationName":"광주","ta":"25.6"},{"locationName":"부산","ta":"22.0"},{"locationName":"목포","ta":"23.2"},{"locationName":"여수","ta":"23.0"},{"locationName":"홍성","ta":"25.0"},{"locationName":"제주","ta":"18.9"}]
			
			*/
		return result;
	}
	
	
	
	

	 /*
	    @ExceptionHandler 에 대해서..... (GET방식일때 유저가 URL 에 장난치는 것 방지하기)
	    ==> 어떤 컨트롤러내에서 발생하는 익셉션이 있을시 익셉션 처리를 해주려고 한다면
	        @ExceptionHandler 어노테이션을 적용한 메소드를 구현해주면 된다
	         
	       컨트롤러내에서 @ExceptionHandler 어노테이션을 적용한 메소드가 존재하면, 
	       스프링은 익셉션 발생시 @ExceptionHandler 어노테이션을 적용한 메소드가 처리해준다.
	       따라서, 컨트롤러에 발생한 익셉션을 직접 처리하고 싶다면 @ExceptionHandler 어노테이션을 적용한 메소드를 구현해주면 된다.
	 */
	/*
	 @ExceptionHandler(java.lang.Throwable.class)	// exception 이나 error 가 발생되면 작동함. 에러 처리시 꼭 @ExceptionHandler 를 넣도록 하자!!
	 public void handleThrowable(Throwable e, HttpServletRequest request, HttpServletResponse response) {
	    
	    e.printStackTrace(); // 콘솔에 에러메시지 나타내기
	    
	    try {
	       // *** 웹브라우저에 출력하기 시작 *** //
	       
	       // HttpServletResponse response 객체는 넘어온 데이터를 조작해서 결과물을 나타내고자 할때 쓰인다. 
	       response.setContentType("text/html; charset=UTF-8");
	       
	       PrintWriter out = response.getWriter();   // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
	       
	       out.println("<html>");
	       out.println("<head><title>오류메시지 출력하기</title></head>");
	       out.println("<body>");
	       out.println("<h1>오류발생</h1>");
	       
	  //   out.printf("<div><span style='font-weight: bold;'>오류메시지</span><br><span style='color: red;'>%s</span></div>", e.getMessage());
	       
	       String ctxPath = request.getContextPath();
	       
	       out.println("<div><img src='"+ctxPath+"/resources/images/error.gif'/></div>");
	       out.printf("<div style='margin: 20px; color: blue; font-weight: bold; font-size: 26pt;'>%s</div>", "장난금지");
	       out.println("<a href='"+ctxPath+"/index.bts'>홈페이지로 가기</a>");
	       out.println("</body>");
	       out.println("</html>");
	       
	       // *** 웹브라우저에 출력하기 끝 *** //
	    } catch (IOException e1) {
	       e1.printStackTrace();
	    }
	    
	 } // 다하면 넣을 것
	 */
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
		
	// === 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성 === //
	public void getCurrentURL(HttpServletRequest request) {
	HttpSession session = request.getSession();
	session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	
}
