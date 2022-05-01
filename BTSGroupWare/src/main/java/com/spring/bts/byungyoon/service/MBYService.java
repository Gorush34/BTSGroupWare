package com.spring.bts.byungyoon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.byungyoon.model.InterMBYDAO;

@Service
public class MBYService implements InterMBYService  {
	
 @Autowired
 private InterMBYDAO mbydao;
 
 @Override
	public String getNameNumber(int no) {
		
	 	String ab = mbydao.getNameMember(no);
	 
	 	return ab;
	}
	
}
