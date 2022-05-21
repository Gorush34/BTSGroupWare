package com.spring.bts.hwanmo.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterEmployeeDAO {

	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
	boolean idDuplicateCheck(String pk_emp_no);

	// email 중복검사 (tbl_member 테이블에서 email 이 존재하면 true를 리턴해주고, email 이 존재하지 않으면 false를 리턴한다) 
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

	// 회원정보 받아오기
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

	// 배열에 담긴 사번에 따른 탈퇴처리(상세보기)
	int updateHireOne(String emp_no);
}
