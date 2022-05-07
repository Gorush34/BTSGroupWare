package com.spring.bts.hwanmo.service;

public interface InterAttendanceService {

	// 가입과 동시에 연차테이블 등록하기
	int registerLeave(int pk_emp_no);

}
