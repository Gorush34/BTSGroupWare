package com.spring.bts.hwanmo.model;

import java.util.Map;

public interface InterAttendanceDAO {

	// 가입과 동시에 연차테이블 등록하기
	int registerLeave(int pk_emp_no);

	// 오늘 출퇴근기록 조회
	int getTodayCommute(Map<String, String> paraMap);

	// 날짜, 출근시간 입력한 테이블 insert
	int insertTodayCommute(Map<String, String> paraMap);

}
