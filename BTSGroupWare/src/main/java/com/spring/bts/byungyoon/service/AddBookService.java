package com.spring.bts.byungyoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.byungyoon.model.AddBookVO;
import com.spring.bts.byungyoon.model.InterAddBookDAO;

@Service
public class AddBookService implements InterAddBookService  {
	
 @Autowired
 private InterAddBookDAO dao;
	 
	@Override
	public String getNameNumber(int no) {
	 	String ab = dao.getNameMember(no);
	 	return ab;
	}
	
	// 주소록 메인페이지에 select 해오기
	@Override
	public List<AddBookVO> addBook_select() {
		List<AddBookVO> adbList = dao.addBook_select();
		
	//	System.out.println("여기는 서비스");
		
		return adbList;
}
	
}
