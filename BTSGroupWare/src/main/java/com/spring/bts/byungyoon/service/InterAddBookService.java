package com.spring.bts.byungyoon.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.bts.byungyoon.model.AddBookVO;

@Service
public interface InterAddBookService {

	String getNameNumber(int no);

	// 주소록 메인페이지에 select 해오기
	List<AddBookVO> addBook_select(); 
	
	
	
	
}
