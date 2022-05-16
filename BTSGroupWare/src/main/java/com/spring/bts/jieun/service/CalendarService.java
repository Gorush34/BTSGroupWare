package com.spring.bts.jieun.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.jieun.model.CalendarVO;
import com.spring.bts.jieun.model.InterCalendarDAO;
import com.spring.bts.jieun.model.ScheduleVO;


//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class CalendarService implements InterCalendarService {
	
	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private InterCalendarDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO 의 bean 을  dao 에 주입시켜준다. 
    // 그러므로 dao 는 null 이 아니다.

	
	// === 사내 캘린더에 사내 캘린더 소분류 추가하기 === //
	@Override
	public int addComCalendar(Map<String, String> paraMap) {
		int n = 0;
		String addCom_calname = paraMap.get("addCom_calname");
		String fk_emp_no = paraMap.get("fk_emp_no");
		
		Map<String, String> map = new HashMap<>();
		map.put("addCom_calname", addCom_calname);
		map.put("fk_emp_no", fk_emp_no);
		
		// 사내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
		int m = dao.existComCalendar(map);
		
		if(m==0) {
			n = dao.addComCalendar(paraMap);
		}
		return n;
	}

	// === 사내 캘린더에 사내 캘린더 소분류 보여주기 === //
	@Override
	public List<CalendarVO> showCompanyCalendar() {
		List<CalendarVO> companyCalList = dao.showCompanyCalendar();
		return companyCalList;
	}

	// === 내 캘린더에 내 캘린더 소분류 추가하기 === //
	@Override
	public int addMyCalendar(Map<String, String> paraMap) {
		int n = 0;
		String addMy_calname = paraMap.get("addMy_calname");
		String fk_emp_no = paraMap.get("fk_emp_no");
		
		Map<String, String> map = new HashMap<>();
		map.put("addMy_calname", addMy_calname);
		map.put("fk_emp_no", fk_emp_no);
		
		// 내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
		int m = dao.existMyCalendar(map);
		
		if(m==0) {
			n = dao.addMyCalendar(paraMap);
		}		
		return n;
	}

	// === 내 캘린더에 내 캘린더 소분류 보여주기 === //
	@Override
	public List<CalendarVO> showMyCalendar(String fk_emp_no) {
		List<CalendarVO> myCalList = dao.showMyCalendar(fk_emp_no);
		return myCalList;
	}

	// === 캘린더 소분류 수정하기 === //
	@Override
	public int editCalendar(Map<String, String> paraMap) {
		int n = 0;
		
		// 캘린더에 이름이 있는지 확인
		int m = dao.existsCalendar(paraMap); 
		
		if(m==0) {
			n = dao.editCalendar(paraMap);
		}
		return n;
	}

	// === 캘린더 소분류 삭제하기 === //
	@Override
	public int deleteCalendar(String pk_calno) {
		int n = dao.deleteCalendar(pk_calno);
		return n;
	}

	// === 서브 캘린더 가져오기 === //
	@Override
	public List<CalendarVO> selectCalNo(Map<String, String> paraMap) {
		List<CalendarVO> calendarvoList = dao.selectCalNo(paraMap);
		return calendarvoList;
	}
	
	// === 참석자 추가하기 : 사원 명단 불러오기 === //
	@Override
	public List<EmployeeVO> searchJoinUser(String joinUserName) {
		List<EmployeeVO> joinUserList = dao.searchJoinUser(joinUserName);
		return joinUserList;
	}
	
	// === 일정 등록 하기 === //
	@Override
	public int scheduleRegisterInsert(Map<String, String> paraMap) {
		int n = dao.scheduleRegisterInsert(paraMap);
		return n;
	}

	// === 일정 보여주기 === //
	@Override
	public List<ScheduleVO> selectSchedule(Map<String, String> paraMap) {
		List<ScheduleVO> scheduleList = dao.selectSchedule(paraMap);
		return scheduleList;
	}

	// === 일정 상세 페이지 === //
	@Override
	public Map<String, String> detailSchedule(String pk_schno) {
		 Map<String, String> map = dao.detailSchedule(pk_schno);
		return map;
	}

	// === 일정 삭제 하기 === //
	@Override
	public int deleteSchedule(String pk_schno) {
		int n = dao.deleteSchedule(pk_schno);
		return n;
	}

	// == 일정 수정하기 == //
	@Override
	public int editSchedule_end(ScheduleVO svo) {
		int n = dao.editSchedule_end(svo);
		return n;
	}

	// 총 일정 검색 건수(totalCount)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}

	// 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
	@Override
	public List<Map<String, String>> scheduleListSearchWithPaging(Map<String, String> paraMap) {
		List<Map<String, String>> calendarSearchList  = dao.scheduleListSearchWithPaging(paraMap);
		return calendarSearchList;
	}

	// 오늘의 일정 수
	@Override
	public int scheduleCount(int pk_emp_no) {
		int n = dao.scheduleCount(pk_emp_no);
		return n;
	}

	
	

	

	

	
	


	


	
	
	
}
