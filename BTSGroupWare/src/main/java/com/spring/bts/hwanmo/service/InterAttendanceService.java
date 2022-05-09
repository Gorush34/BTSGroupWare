package com.spring.bts.hwanmo.service;

import java.util.List;
import java.util.Map;

import com.spring.bts.hwanmo.model.CommuteVO;

public interface InterAttendanceService {

	// 가입과 동시에 연차테이블 등록하기
	int registerLeave(int pk_emp_no);

	// 오늘 출퇴근기록 조회
	int getTodayCommute(Map<String, String> paraMap);

	// 날짜, 출근시간 입력한 테이블 insert
	int insertTodayCommute(Map<String, String> paraMap);

	// 출퇴근시간 알아오기
	Map<String, String> getTodayworkInOutTime(Map<String, String> paraMap);

	// 퇴근시간 및 하루 근무시간 update하기
	int updateTodayOutTime(Map<String, String> paraMap);

	// 00시가 되면 출퇴근 초기화하기
	int checkTomorrow(Map<String, String> paraMap);

	// 한 사원에 대한 출퇴근기록 가져오기
	List<CommuteVO> getMyCommute(int pk_emp_no);

}
