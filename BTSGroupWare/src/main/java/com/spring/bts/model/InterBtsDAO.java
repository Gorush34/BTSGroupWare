package com.spring.bts.model;

import java.util.Map;

import com.spring.bts.hwanmo.model.EmployeeVO;

public interface InterBtsDAO {

	// 로그인 처리하기
	EmployeeVO getLoginMember(Map<String, String> paraMap);
}
