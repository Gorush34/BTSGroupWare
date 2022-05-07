package com.spring.bts.yuri.service;

import java.util.Map;

import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.yuri.model.ApprVO;

public interface InterEdmsService {

	// 로그인된 사원 정보 가져오기
	EmployeeVO getLoginMember(Map<String, String> paraMap);
	
	// 파일첨부가 없는 전자결재 문서작성
	int edmsAdd(ApprVO apprvo);



}
