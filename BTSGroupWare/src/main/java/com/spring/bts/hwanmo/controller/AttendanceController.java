package com.spring.bts.hwanmo.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.hwanmo.service.InterAttendanceService;

//=== #30. 컨트롤러 선언 === // 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
즉, 여기서 bean의 이름은  btsController 이 된다. 
여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BtsController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller
public class AttendanceController {

	@Autowired
	private InterAttendanceService attService;
	
	// === 근태관리 시작 페이지 ===
	@RequestMapping(value="/att/attMain.bts")
	public ModelAndView attMain(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		mav.setViewName("attMain.att");

		return mav;
	}
	
	// === 연차내역 페이지 ===
	@RequestMapping(value="/att/myAtt.bts")
	public ModelAndView showSchedule(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		mav.setViewName("myAtt.att");

		return mav;
	}
	
	// === 일정관리 시작 페이지 ===
	@RequestMapping(value="/att/reportVacation.bts")
	public ModelAndView reportVacation(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		mav.setViewName("reportVacation.att");

		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/att/workIn.bts")
	public String workIn(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
	
		// 오늘 출근기록이 없다면 테이블 생성, 있으면 비활성화
		String yymmdd = request.getParameter("yymmdd");
		String clock = request.getParameter("clock");
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		// System.out.println(" 확인용 yymmdd : " + yymmdd);
		// System.out.println(" 확인용 clock : " + clock);
		// System.out.println(" 확인용 fk_emp_no : " + fk_emp_no);
		
		yymmdd = yymmdd.replaceAll("-", "");
		yymmdd = yymmdd.substring(2, 8);
		// System.out.println("바꾼 yymmdd : " + yymmdd );
		
		clock = clock.replaceAll(":", "");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("regdate", yymmdd);
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("in_time", clock);
		
		int isExist = attService.getTodayCommute(paraMap);
		// System.out.println("나와라 isExist : " + isExist);
		int n = 0;
		
		JSONObject jsonObj = new JSONObject();
		
		
		if(isExist == 0) { // 없다면
			// 날짜, 출근시간 입력한 테이블 insert
			n = attService.insertTodayCommute(paraMap);
			// System.out.println("잘 들어갔니? n : " + n);
			if(n==1) {
				System.out.println("컨트롤러에서 insert 성공!");
				jsonObj.put("n", n);
			}
			else {
				System.out.println("뭔가 이상한 실패..");
			}
		}
		else if(isExist == 1) {
			System.out.println("이미 출근했어 이양반아");
			jsonObj.put("n", n);
		}
		
		return jsonObj.toString();
	} // public String workIn(HttpServletRequest request, HttpServletResponse response, ModelAndView mav)
	
}
