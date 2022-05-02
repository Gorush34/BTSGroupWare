package com.spring.bts.service;

import java.util.Map;

import com.spring.bts.hwanmo.model.EmployeeVO;

public interface InterBtsService {

	// 로그인 처리하기
	EmployeeVO getLoginMember(Map<String, String> paraMap);
}
