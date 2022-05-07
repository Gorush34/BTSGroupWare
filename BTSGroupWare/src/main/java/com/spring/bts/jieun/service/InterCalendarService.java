package com.spring.bts.jieun.service;

import java.util.List;
import java.util.Map;

import com.spring.bts.jieun.model.CalendarVO;

public interface InterCalendarService {

	// === 사내 캘린더에 사내 캘린더 소분류 추가하기 === //
	int addComCalendar(Map<String, String> paraMap);

	// === 사내 캘린더에서 사내캘린더 소분류 보여주기  === //
	List<CalendarVO> showCompanyCalendar();

	// === 내 캘린더에 내 캘린더 소분류 추가하기 === //
	int addMyCalendar(Map<String, String> paraMap);

	// === 내 캘린더에서 내캘린더 소분류 보여주기  === //
	List<CalendarVO> showMyCalendar(String fk_emp_no);

	// === 캘린더 소분류 수정하기 === //
	int editCalendar(Map<String, String> paraMap);

	// === 서브 캘린더 가져오기 === //
	List<CalendarVO> selectCalNo(Map<String, String> paraMap);
	
	// === 일정 등록 하기 === //
	int scheduleRegisterInsert(Map<String, String> paraMap);


	
}
