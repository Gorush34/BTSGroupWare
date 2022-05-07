package com.spring.bts.yuri.model;

import java.util.Map;

import com.spring.bts.hwanmo.model.EmployeeVO;

public interface InterEdmsDAO {

	// 로그인된 사원 정보 가져오기
	EmployeeVO getLoginMember(Map<String, String> paraMap);

	// 파일첨부가 없는 전자결재 문서작성
	int add(ApprVO apprvo);

	// 파일첨부가 있는 전자결재 문서작성
	
	// 전자결재 글 수정하기
	
	// 전자결재 글 삭제하기
	
}
