package com.spring.bts.hwanmo.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.hwanmo.model.InterHwanmoDAO;

//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class HwanmoService implements InterHwanmoService {

	@Autowired
	private InterHwanmoDAO dao;
	
	@Override
	public int test_insert_2(Map<String, String> paraMap) {
		
		int n = dao.test_insert_2(paraMap);
		return n;
	}

}
