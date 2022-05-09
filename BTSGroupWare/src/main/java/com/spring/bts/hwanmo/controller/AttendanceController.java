package com.spring.bts.hwanmo.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.common.MyUtil;
import com.spring.bts.hwanmo.model.CommuteVO;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.hwanmo.service.InterAttendanceService;
import com.spring.bts.jieun.model.CalendarVO;

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
	
	
	// 기록된 출퇴근시간 사이드바에 띄우기
	@ResponseBody
	@RequestMapping(value="/att/getWorkInOutTime.bts", produces="text/plain;charset=UTF-8")
	public String getWorkInOutTime(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		String yymmdd = request.getParameter("yymmdd");
		yymmdd = yymmdd.replaceAll("-", "");
		yymmdd = yymmdd.substring(0, 8);
		// System.out.println("yymmdd : " + yymmdd);
		
		String fk_emp_no = request.getParameter("fk_emp_no");
		// System.out.println("fk_emp_no : " + fk_emp_no);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("regdate", yymmdd);
		paraMap.put("fk_emp_no", fk_emp_no);
		
		Map<String, String> workInOut = new HashMap<>();
		String in_time = "미등록";
		String out_time = "미등록";		
		// 출퇴근기록이 있는지 알아오자.
		int isExist = attService.getTodayCommute(paraMap);
		// System.out.println("isExist : " + isExist);
		if(isExist != 0) {
			// 출퇴근시간을 알아오자.
			workInOut = attService.getTodayworkInOutTime(paraMap);
			
			// System.out.println("확인용 출근시간 : " + workInOut.get("in_time"));
			// System.out.println("확인용 퇴근시간 : " + workInOut.get("out_time"));
			
			in_time = workInOut.get("in_time");
			out_time = workInOut.get("out_time");
		}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("in_time", in_time);
		jsonObj.put("out_time", out_time);
		
		return jsonObj.toString();
	} // end of public String getWorkInOutTime(HttpServletRequest request, HttpServletResponse response, ModelAndView mav)-----
	
	
	// 날이 바뀌면 출퇴근 초기화하기
	@ResponseBody
	@RequestMapping(value="/att/refreshInOutTime.bts", produces="text/plain;charset=UTF-8")
	public String refreshInOutTime(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		String yymmdd = request.getParameter("yymmdd");
		yymmdd = yymmdd.replaceAll("-", "");
		yymmdd = yymmdd.substring(0, 8);
		// System.out.println("yymmdd : " + yymmdd);
		
		String fk_emp_no = request.getParameter("fk_emp_no");
		// System.out.println("fk_emp_no : " + fk_emp_no);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("regdate", yymmdd);
		paraMap.put("fk_emp_no", fk_emp_no);
		
		Map<String, String> workInOut = new HashMap<>();
		String in_time = "미등록";
		String out_time = "미등록";		
		// 날이 달라졌는지 알아보자.
		int isTomorrow = attService.checkTomorrow(paraMap);
		System.out.println("isTomorrow : " + isTomorrow);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isTomorrow", isTomorrow);
		jsonObj.put("in_time", in_time);
		jsonObj.put("out_time", out_time);
		
		return jsonObj.toString();
	} // end of public String getWorkInOutTime(HttpServletRequest request, HttpServletResponse response, ModelAndView mav)-----
		
	
	
	// 출근버튼 클릭시
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
		yymmdd = yymmdd.substring(0, 8);
		// System.out.println("바꾼 yymmdd : " + yymmdd );
		
		// clock = clock.replaceAll(":", "");
		
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("regdate", yymmdd);
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
				// System.out.println("컨트롤러에서 insert 성공!");
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
	
	// 퇴근버튼 클릭시
	@ResponseBody
	@RequestMapping(value="/att/workOut.bts")
	public String workOut(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		// 오늘 출근기록이 없다면 테이블 생성, 있으면 비활성화
		String yymmdd = request.getParameter("yymmdd");
		String out_time = request.getParameter("out_time");
		String total_workTime = request.getParameter("total_workTime");
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		// System.out.println(" 퇴근처리 확인용 yymmdd : " + yymmdd);
		// System.out.println(" 퇴근처리 확인용 out_time : " + out_time);
		// System.out.println(" 퇴근처리 확인용 fk_emp_no : " + fk_emp_no);
		//  System.out.println(" 퇴근처리 확인용 total_workTime : " + total_workTime);
			
		yymmdd = yymmdd.replaceAll("-", "");
		yymmdd = yymmdd.substring(0, 8);
		// System.out.println("바꾼 yymmdd : " + yymmdd );
		
		// clock = clock.replaceAll(":", "");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("regdate", yymmdd);
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("out_time", out_time);
		paraMap.put("total_workTime", total_workTime);
		
		int n = 0;
		JSONObject jsonObj = new JSONObject();
		
		// 퇴근시간 및 하루 근무시간 update하기
		n = attService.updateTodayOutTime(paraMap);
		// System.out.println(" update 잘 들어갔니? n : " + n);
		if(n==1) {
			// System.out.println("컨트롤러에서 퇴근 update 성공!");
			jsonObj.put("n", n);
		}
		else {
			System.out.println("뭔가 이상한 실패..");
			jsonObj.put("n", n);
		}
		
		return jsonObj.toString();
		
	} // end of public String workOut(HttpServletRequest request, HttpServletResponse response, ModelAndView mav)-------
	
	
	// === 내 출퇴근기록 페이지 요청
	@RequestMapping(value="/att/myCommute.bts")
	public ModelAndView myCommute(HttpServletRequest request, CommuteVO cmtvo, ModelAndView mav) { 
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		String fk_emp_no = String.valueOf(loginuser.getPk_emp_no());
		// System.out.println(" 들어갔니? pk_emp_no : " + pk_emp_no);
		
		// *** 페이징처리 및 검색 시작 *** //
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(year == null || (!"2021".equals(year) && !"2022".equals(year)) ) {
			year = "";
		}
		
		if(month == null || !("01".equals(month) || "02".equals(month) || "03".equals(month) || "04".equals(month)
							   || "05".equals(month) || "06".equals(month) || "07".equals(month) || "08".equals(month)
							   || "09".equals(month) || "10".equals(month) || "11".equals(month) || "12".equals(month) )	
		){
			month = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("year", year);
		paraMap.put("month", month);
		paraMap.put("fk_emp_no", fk_emp_no);
		// System.out.println(" fk_emp_no : " + fk_emp_no);
		// System.out.println(" year : " + year);
		// System.out.println(" month : " + month);
		
		
		int totalCount = 0;        // 총 게시물 건수
		int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0; // 시작 행번호
		int endRno = 0;   // 끝 행번호
		
		// 총 출퇴근 건수 알아오기
		totalCount = attService.getTotalCommuteCount(paraMap);
		// System.out.println(" 가져온 totalCount : " + totalCount);
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		
		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo); 
				if( currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;

		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		// 페이징처리가 있는 한 사원에 대한 출퇴근기록 가져오기
		List<CommuteVO> cmtList = attService.getMyCommute(paraMap);
		
		if( !"".equals(year) && !"".equals(month) ) {
			mav.addObject("paraMap", paraMap);
		}
		
		// *** 페이징처리 및 검색 끝 *** //
		
		// === 페이지바 만들기 === //
		int blockSize = 10;
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "myCommute.bts";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?year="+year+"&month="+month+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?year="+year+"&month="+month+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?year="+year+"&month="+month+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?year="+year+"&month="+month+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?year="+year+"&month="+month+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		String gobackURL = MyUtil.getCurrentURL(request);

		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
				
		
		
		
		
		
		mav.addObject("cmtList", cmtList);
		mav.setViewName("myCommute.att");

		return mav;
	}
	
	
	
	
}
