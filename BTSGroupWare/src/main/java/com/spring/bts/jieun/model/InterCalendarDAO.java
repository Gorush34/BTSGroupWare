package com.spring.bts.jieun.model;

import java.util.List;
import java.util.Map;

import com.spring.bts.hwanmo.model.EmployeeVO;

public interface InterCalendarDAO {

	// *********** 캘린더 사이드 바 *********** //
	
	// === 사내 캘린더에 사내 캘린더 소분류 추가하기 === //
	int addComCalendar(Map<String, String> paraMap);
			// 사내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
			int existComCalendar(Map<String, String> map);

	// === 사내 캘린더에 사내 캘린더 소분류 보여주기 === //
	List<CalendarVO> showCompanyCalendar();
			// 내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
			int existMyCalendar(Map<String, String> map);
	
	// === 내 캘린더에 내 캘린더 소분류 추가하기 === //
	int addMyCalendar(Map<String, String> paraMap);

	// === 내 캘린더에 내 캘린더 소분류 보여주기 === //
	List<CalendarVO> showMyCalendar(String fk_emp_no);

	
	// === 캘린더 소분류 수정하기 === //
	int editCalendar(Map<String, String> paraMap);
			// 캘린더에 이름이 있는지 확인
			int existsCalendar(Map<String, String> paraMap);

	// === 캘린더 소분류 삭제하기 === //
	int deleteCalendar(String pk_calno);
	
	
	
	// *********** 일정 등록 페이지 *********** //
	
	// === 서브 캘린더 가져오기 === //
	List<CalendarVO> selectCalNo(Map<String, String> paraMap);
		
	// === 참석자 추가하기 : 사원 명단 불러오기 === //
	List<EmployeeVO> searchJoinUser(String joinUserName);
	
	// === 일정 등록 하기 === //
	int scheduleRegisterInsert(Map<String, String> paraMap);
	
	
	// === 일정 보여주기 === //
	List<ScheduleVO> selectSchedule(Map<String, String> paraMap);
	
	// === 일정 상세 페이지 === //
	Map<String, String> detailSchedule(String pk_schno);
	
	// == 상세페이지에서 댓글 보여주기 == //
	List<Map<String, String>> getScheduleComment(String pk_schno);	
	
	// == 상세페이지에서 댓글 삭제 == //
	int delComment(String pk_schecono);
	
	// === 일정 삭제 하기 === //
	int deleteSchedule(String pk_schno);
	
	// == 일정 수정하기 == //
	int editSchedule_end(ScheduleVO svo);
	
	
	
	// == 총 일정 검색 건수(totalCount) == //
	int getTotalCount(Map<String, String> paraMap);
	
	// == 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임) == //
	List<Map<String, String>> scheduleListSearchWithPaging(Map<String, String> paraMap);
	
	// 오늘의 일정 수
	int scheduleCount(Map<String, String> paraMap);
	
	// == 메인페이지 : 임직원 생일 가져오기 == //
	List<Map<String, String>> employeeBirthIndex();
	
	// 총 생일 건수(totalCount)
	//int getTotaBirthCount();
	
	// == 메인페이지 : 임직원 생일 가져오기 :전월 == //
	List<Map<String, String>> preMonthBirthIndex(String month);

	// == 메인페이지 : 임직원 생일 가져오기 :이월 == //
	List<Map<String, String>> nextMonthBirthIndex(String month);
	
	// == 상세페이지에서 댓글 적기 == //
	int commentInput(Map<String, String> paraMap);
	


	
	
}
