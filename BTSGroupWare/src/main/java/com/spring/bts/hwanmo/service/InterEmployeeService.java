package com.spring.bts.hwanmo.service;

import java.sql.SQLException;
import java.util.List;
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

	// 회원정보 가져오기
	List<Map<String, Object>> getEmpInfo(int pk_emp_no);

	// 로그인 처리하기
	EmployeeVO getLoginMember(Map<String, String> paraMap);

	// 관리자페이지 - 총 사원 수 가져오기
	int getTotalCountEmp(Map<String, String> paraMap);

	// 관리자페이지 - 총 사원 목록 가져오기
	List<Map<String, Object>> getEmpAllWithPaging(Map<String, String> paraMap);

	// 사원번호를 통해 정보를 받아옴
	Map<String, Object> getMemberOne(int pk_emp_no);

	// 배열에 담긴 사번에 따른 탈퇴처리
	int updateHire(Map<String, String> paraMap);

	// 배열에 담긴 사번에 따른 탈퇴처리(상세페이지)
	int updateHireOne(String emp_no);

	
	
	
	
}
