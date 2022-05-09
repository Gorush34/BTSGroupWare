package com.spring.bts.jieun.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.jieun.model.InterResourceDAO;

//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class ResourceService implements InterResourceService {
	@Autowired
	private InterResourceDAO dao;
	
}
