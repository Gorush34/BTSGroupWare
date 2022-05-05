package com.spring.bts.byungyoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.byungyoon.model.AddBookVO;
import com.spring.bts.byungyoon.model.InterAddBookDAO;
import com.spring.bts.hwanmo.model.EmployeeVO;

@Service
public class AddBookService implements InterAddBookService  {
	
 @Autowired
 private InterAddBookDAO dao;
	 
 
 	// 주소록 메인페이지에서 주소록검색 ajax 쓰기
	@Override
	public String getNameNumber(int no) {
	 	String ab = dao.getNameMember(no);
	 	return ab;
	}
	
	
	// 주소록 메인페이지에 select 해오기
	@Override
	public List<AddBookVO> addBook_main_select() {
		
		List<AddBookVO> adbList = dao.addBook_main_select();
		
		return adbList;
	}

	
	// 주소록 연락처에 insert 하기
	@Override
	public int addBook_telAdd_insert(AddBookVO avo) {
		
		int n = dao.addBook_telAdd_insert(avo);
		
		return n;
	}

	
	// 상세부서정보 페이지 사원목록 불러오기 (영업팀)
	@Override
	public List<EmployeeVO> addBook_depInfo_select() {
		List<EmployeeVO> empList = dao.addBook_depInfo_select();
		return empList;
	}

	
}
