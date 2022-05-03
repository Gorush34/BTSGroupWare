package com.spring.bts.hwanmo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.hwanmo.model.InterEmployeeDAO;

//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class EmployeeService implements InterEmployeeService {

	@Autowired
	private InterEmployeeDAO empDAO; 
	
	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
	@Override
	public boolean idDuplicateCheck(String pk_emp_no) {
		boolean isExist = empDAO.idDuplicateCheck(pk_emp_no);
		return isExist;
	}

}
