package com.spring.bts.byungyoon.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.bts.byungyoon.model.AddBookVO;
import com.spring.bts.hwanmo.model.EmployeeVO;

@Service
public interface InterAddBookService {

	// 주소록 메인페이지에서 주소록검색 ajax 쓰기
	String getNameNumber(int no);

	// 주소록 메인페이지에 select 해오기
	List<AddBookVO> addBook_main_select(); 
	
	// 주소록 연락처에 insert 하기
	int addBook_telAdd_insert(AddBookVO avo);

	// 상세부서정보 페이지 사원목록 불러오기
	List<EmployeeVO> addBook_depInfo_select(); 
}
