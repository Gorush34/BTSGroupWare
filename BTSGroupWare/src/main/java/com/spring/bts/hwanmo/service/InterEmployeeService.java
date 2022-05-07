package com.spring.bts.hwanmo.service;

import java.sql.SQLException;
import java.util.Map;

import com.spring.bts.hwanmo.model.EmployeeVO;

public interface InterEmployeeService {

	// 아이디 중복 체크
	boolean idDuplicateCheck(String pk_emp_no);

	// 이메일 중복 체크
	boolean emailDuplicateCheck(String uq_email);

	// 사원 가입하기
	int registerMember(EmployeeVO empvo) throws SQLException;

	// 아이디 찾기
	String findEmpNo(Map<String, String> paraMap);

}
