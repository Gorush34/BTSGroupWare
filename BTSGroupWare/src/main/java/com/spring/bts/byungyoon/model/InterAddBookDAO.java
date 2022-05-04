package com.spring.bts.byungyoon.model;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface InterAddBookDAO {

	public String getNameMember(int no);

	// 주소록 메인페이지에 select 해오기
	public List<AddBookVO> addBook_select();
	
}
