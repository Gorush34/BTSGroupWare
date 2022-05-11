package com.spring.bts.hwanmo.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.common.AES256;
import com.spring.bts.common.FileManager;
import com.spring.bts.common.MyUtil;
import com.spring.bts.hwanmo.model.AttendanceSortVO;
import com.spring.bts.hwanmo.model.AttendanceVO;
import com.spring.bts.hwanmo.model.CommuteVO;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.hwanmo.model.LeaveVO;
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
	private AES256 aes;
	
	@Autowired
	private InterAttendanceService attService;
	
	// === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : DependencyInjection) ===	  
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다. 
	private FileManager fileManager; // type (FileManager) 만 맞으면 다 주입해준다.
	
	// === 근태관리 시작 페이지 ===
	@RequestMapping(value="/att/attMain.bts")
	public ModelAndView attMain(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		mav.setViewName("attMain.att");

		return mav;
	}
	
	// === 연차내역 페이지 ===
	@RequestMapping(value="/att/myAtt.bts")
	public ModelAndView showSchedule(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		String fk_emp_no = String.valueOf(loginuser.getPk_emp_no());
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_emp_no", fk_emp_no);
		
		// 로그인한 사용자의 연차테이블 불러오기
		LeaveVO leaveVO = attService.getOneLeave(fk_emp_no);
		
		// ================== 페이징처리 시작 =====================
		
		// 먼저 총 받은 메일 수(totalCount)를 구해와야 한다.
		// 총 게시물 건수는 검색조건이 있을 때와 없을 때로 나뉜다.
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");	// 현재 페이지 번호
		int totalCount = 0;
		int sizePerPage = 3;
		int currentShowPageNo = 0;
		int totalPage = 0;
		
		int startRno = 0;
		int endRno = 0;
		
		// 총 올린  연차신청 수 가져오기
		totalCount = attService.getTotalVacReportCount(fk_emp_no); 
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);	// 총 페이지 수 (전체게시물 / 페이지당 보여줄 갯수)

		if(str_currentShowPageNo == null) {
			// 페이지바를 거치지 않은 맨 처음 화면
			currentShowPageNo = 1;
		}
		else {	
			try {	// 사용자가 페이지 넘버에 정수만 입력할 수 있도록 설정		
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					// 1 미만의 페이지 또는 총 페이지 수를 넘어서는 페이지수 입력 시 기본페이지로
					currentShowPageNo = 1;
				}				
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		startRno = ( (currentShowPageNo - 1) * sizePerPage ) + 1;
		endRno = startRno + sizePerPage - 1;
		
		// 페이지에 보여줄 인덱스 맵 생성
		Map<String, Object> idx = new HashMap<>();
		idx.put("startIdx", (startRno-1));
		idx.put("endIdx", (endRno-1));
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		// 페이징처리 한 받은 공가/경조신청목록 
		List<Map<String, Object>> myAttList = attService.getMyAttListWithPaging(paraMap);
		
		
		// ================= 페이징처리 끝 ====================
		
		// === 페이지바 만들기 === //
		int blockSize = 10;
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "myAtt.bts";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
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
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		String gobackURL = MyUtil.getCurrentURL(request);

		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
		
		mav.addObject("idx", idx);
		mav.addObject("myAttList", myAttList);
		mav.addObject("leaveVO", leaveVO);
		mav.setViewName("myAtt.att");

		return mav;
	}
	
	// 연차신청 페이지
	@RequestMapping(value="/att/reportVacation.bts")
	public ModelAndView requiredLogin_reportVacation(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		String pk_emp_no = String.valueOf(loginuser.getPk_emp_no());
		
		// 휴대폰 복호화(잠시쉬어라)
		/*
		try {
			loginuser.setUq_phone(aes.decrypt(loginuser.getUq_phone()));
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		*/
		// System.out.println(" 잘됐냐? : " + loginuser.getUq_phone());
		
		// 사원번호로 직급명 알아오기
		String ko_rankname = attService.getKo_rankname(pk_emp_no);
		loginuser.setKo_rankname(ko_rankname);
		// System.out.println("받아왔니? ko_rankname : " + ko_rankname);
		
		// 사원번호로 부서명, 부서장, 부서장 사번 알아오기
		Map<String, String> deptMap = new HashMap<>();
		deptMap = attService.getDeptInfo(pk_emp_no);
		
		// System.out.println("받아왔니? ko_depname : " + deptMap.get("ko_depname"));
		// System.out.println("받아왔니? manager : " + deptMap.get("manager"));
		// System.out.println("받아왔니? manager_name : " + deptMap.get("manager_name"));

		// 사원번호로 연차테이블 불러오기
		Map<String, String> leaveMap = new HashMap<>();
		leaveMap = attService.getLeaveInfo(pk_emp_no);
		/*
		System.out.println("받아왔니? total_vac_days : " + leaveMap.get("total_vac_days"));
		System.out.println("받아왔니? use_vac_days : " + leaveMap.get("use_vac_days"));
		System.out.println("받아왔니? rest_vac_days : " + leaveMap.get("rest_vac_days"));
		System.out.println("받아왔니? instead_vac_days : " + leaveMap.get("instead_vac_days"));
		*/
		
		// 연차구분테이블 불러오기
		List<Map<String, Object>> attSortList = attService.getAttSortInfo();
		/*
		for(int i=0; i<attSortList.size(); i++) {
			System.out.println("잘 들어왔나~ : " + attSortList.get(i).get("pk_att_sort_no"));
		}
		*/
		
		mav.addObject("deptMap", deptMap);
		mav.addObject("leaveMap", leaveMap);
		mav.addObject("attSortList", attSortList);
		mav.addObject("loginuser", loginuser);
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
		// System.out.println("isTomorrow : " + isTomorrow);
		
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
	} // end of public ModelAndView myCommute(HttpServletRequest request, CommuteVO cmtvo, ModelAndView mav)---------------
	
	
	// 연차신청서 제출
	@RequestMapping(value="/att/reportVacationSubmit.bts", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public ModelAndView reportVacationSubmit(MultipartHttpServletRequest mrequest,  ModelAndView mav, AttendanceVO attVO, LeaveVO leaveVO, AttendanceSortVO attSortVO) { 
	
		/////////////////// 첨부파일 있는 경우 시작 (스마트에디터 X) ///////////////////////
		MultipartFile attach = attVO.getAttach();		// 실제 첨부된 파일

		if( !attach.isEmpty() ) {	// 첨부파일 존재시 true, 존재X시 false
			// 첨부파일이 존재한다면 (true) 업로드 해야한다.
			// 1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해준다.
			// WAS 의 절대경로를 알아와야 한다.
			
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			
			String path = root+"resources"+File.separator+"files";
			// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다. --> path 에 파일을 업로드 한다.
			
			// 2. 파일첨부를 위한 변수 설정 및 값을 초기화 한 후 파일 업로드 하기
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명

			// 내용물을 읽어온다.
			byte[] bytes = null;	// bytes 가 null 이라면 내용물이 없다는 것이다.
			// 첨부파일의 내용물을 담는 것, return 타입은 byte 의 배열

			long fileSize = 0;		// 첨부파일의 크기
		
			try {
				bytes = attach.getBytes();	// 파일에서 내용물을 꺼내오자. 파일을 올렸을 때 깨진파일이 있다면 (입출력이 안된다!!) 그때 Exception 을 thorws 한다.
				// 첨부파일의 내용물을 읽어오는 것. 그 다음, 첨부한 파일의 파일명을 알아와야 DB 에 넣을 수가 있다. 그러므로 파일명을 알아오도록 하자.
				// 즉 파일을 올리고 성공해야 - 내용물을 읽어올 수 있고 - 파일명을 알아와서 DB 에 넣을 수가 있다.
				
				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일의 파일명(예: 강아지.png) 이다.
	
				// 의존객체인 FileManager 를 불러온다. (String 타입으로 return 함.)
				// 리턴값 : 서버에 저장된 새로운 파일명(예: 2022042912181535243254235235234.png)
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부된 파일을 업로드 한다.
				
				// 파일을 받아와야만 service 에 보낼 수 있다. (DB 에 보내도록 한다.)
				attVO.setFilename(newFileName);			// 톰캣(WAS)에 저장될 파일명
				attVO.setOrgfilename(originalFilename); 	// 사용자가 파일 다운로드시 사용되는 파일명
				
				fileSize = attach.getSize();					// 첨부파일의 크기
				attVO.setFilesize(String.valueOf(fileSize));	// long 타입인 fileSize 를 String 타입으로 바꾼 후 vo 에 set 한다.
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
		/////////////////// 첨부파일 있는 경우 끝 (스마트에디터 X) ///////////////////////
		
		// 메일 data 를 DB 로 보낸다. (첨부파일 있을 때 / 첨부파일 없을 때)
		int n = 0;
		
		if(attach.isEmpty()) {
			// 첨부파일이 없을 때
			n = attService.reportVacation(attVO);
		}
		else {
			// 첨부파일 있을 때
			n = attService.reportVacation_withFile(attVO);
		}
		
		// 성공 시 나의 연차페이지로 이동
		// insert 가 성공적으로 됐을 때 / 실패했을 때
		if(n==1) {
			// 연차테이블 최신화 위해 사원번호와 연차차감개수 가져옴
			/*
			String fk_emp_no = mrequest.getParameter("fk_emp_no");
			String minus_cnt = mrequest.getParameter("minus_cnt");
			String instead_vac_days = mrequest.getParameter("instead_vac_days");
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_emp_no", fk_emp_no);
			paraMap.put("minus_cnt", minus_cnt);
			paraMap.put("instead_vac_days", instead_vac_days);
				사원의 연차테이블 최신화(결재받고 깎아야지 이녀석아~~~~~~~)
			int up = attService.updateLeave(paraMap);
			*/
			mav.setViewName("redirect:/att/myAtt.bts");
			System.out.println("완전성공!!");
		}
		else { // 실패 시 연차신청 페이지로 이동	
			System.out.println("실패했어..");
			mav.setViewName("redirect:/att/reportVacation.bts");
		}
		
		return mav;
	}
	
}
