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

	// 사용자가 존재하는지 확인
	boolean isUserExist(Map<String, String> paraMap);

	// 비밀번호 변경
	int pwdUpdate(Map<String, String> paraMap);

	// 원시인(생일구하기)
	Map<String, String> getBirthday(int pk_emp_no);

	// 프로필 사진 업데이트
	int updateEmpImg(EmployeeVO empVO);

	// 회원정보 수정
	int updateMember(EmployeeVO empvo);

}
