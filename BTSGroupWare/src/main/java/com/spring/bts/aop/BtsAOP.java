package com.spring.bts.aop;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.common.MyUtil;
import com.spring.bts.service.InterBtsService;

// === #53. 공통관심사 클래스(Aspect 클래스) 생성하기 === //
// AOP(Aspect Oriented Programming)
@Aspect		// 공통관심사 클래스(Aspect 클래스)로 등록된다.
@Component	// bean 으로 등록된다.
public class BtsAOP {

	// ===== Before Advice(보조업무) 만들기 ====== // 
    /*
	        주업무(<예: 글쓰기, 글수정, 댓글쓰기 직원목록조회 등등>)를 실행하기 앞서서  
	        이러한 주업무들은 먼저 로그인을 해야만 사용가능한 작업이므로
	        주업무에 대한 보조업무<예: 로그인 유무검사> 객체로 로그인 여부를 체크하는
	        관심 클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를 생성하여
	        동작하도록 만들겠다.
    */   
	
	// === Pointcut(주업무)을 설정해야 한다. === //
	// 	   PointCut이란 공통관심사<예 : 로그인 유무검사>를 필요로 하는 메소드를 말한다.
	@Pointcut("execution(public * com.spring..*Controller.requiredLogin_*(..) )")
	public void requiredLogin() {}
	
	// ===== Before Advice(공통관심사, 보조업무)를 구현한다. ====== // 
	@Before("requiredLogin()")
	public void loginCheck(JoinPoint joinpoint) { // 로그인 유무 검사를 하는 메소드 작성하기
		// JoinPoint joinpoint 는 포인트컷 되어진 주업무의 메소드이다.
		
		// 로그인 유무를 확인하기 위해서는 request를 통해 session 을 얻어와야 한다.
		HttpServletRequest request = (HttpServletRequest) joinpoint.getArgs()[0]; // 주업무 메소드의 첫번쨰 파라미터를 얻어오는 것이다.
		HttpServletResponse response = (HttpServletResponse) joinpoint.getArgs()[1]; // 주업무 메소드의 두번쨰 파라미터를 얻어오는 것이다.
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginuser") == null ) {
			String message = "먼저 로그인 하세요~~~";
			String loc = request.getContextPath()+"/login.bts";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//  >>> 로그인 성공 후 로그인 하기전 페이지로 돌아가는 작업 만들기 <<< //
 			// === 현재 페이지의 주소(URL) 알아오기 === // 
			String url = MyUtil.getCurrentURL(request);
			session.setAttribute("goBackURL", url); // 세션에 rul 정보를 저장시켜둔다.
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			// dispatcher 를 하면 forward를 해줘야함(forward에는 request, response 필요) 
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			
		}
		
		
		
	} // end of public void loginCheck(JoinPoint joinpoint)------------
	
	
	// ===== #97. After Advice(보조업무) 만들기 ====== // 
    /*
	        주업무(<예: 글쓰기, 제품구매 등등>)를 실행한 다음에  
	        회원의 포인트를 특정점수(예: 100점, 200점, 300점) 증가해 주는 것이 공통의 관심사(보조업무)라고 보자.
	        관심 클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를 생성하여
	        동작하도록 만들겠다.
    */   
	
	// === Pointcut(주업무)을 설정해야 한다. === //
	// 	   PointCut이란 공통관심사를 필요로 하는 메소드를 말한다.
	@Pointcut("execution(public * com.spring..*Controller.pointPlus_*(..) )")
	public void pointPlus() {}
	
	@Autowired
	private InterBtsService service;
	
	// === After Advice(공통관심사, 보조업무)를 구한다. === //
	// 회원의 포인트를 특정점수(예: 100점, 200점, 300점) 만큼 증가해 주는 메소드 생성하기 // 주 업무가 끝난 이후
	@SuppressWarnings("unchecked") // 앞으로 노란줄 경고 하지말란 뜻
	@After("pointPlus()") 
	public void pointPlus(JoinPoint joinpoint) {
		// JoinPoint joinpoint 는 포인트컷 되어진 주업무의 메소드이다.
		
		Map<String, String> paraMap = (Map<String, String>) joinpoint.getArgs()[0]; // 주업무 메소드의 첫번쨰 파라미터를 얻어오는 것이다.
		
		// 수정예정 service.pointPlus(paraMap);
	} // end of public void pointPlus(JoinPoint joinpoint)--------------
	
	
	// ===== Around Advice(보조업무) 만들기 ====== //
    /*
         Before ----> 보조업무1
               주업무 
         After  ----> 보조업무2
         
              보조업무1 + 보조업무2 을 실행하도록 해주는 것이 Around Advice 이다. 
     */
     // == Pointcut(주업무) 을 생성한다. ==
     //    Pointcut 이란 공통관심사를 필요로 하는 메소드를 말한다.
     // Pointcut 생성시 public 은 생략가능하다. 접근제한자를 생략하면 public 이 있는것으로 본다.
     // 왜냐하면 외부에서 특정메소드에 접근을 해야 하므로 접근제한자는 무조건  public 이어야 하기 때문이다.
	
	
	
	
	
}
