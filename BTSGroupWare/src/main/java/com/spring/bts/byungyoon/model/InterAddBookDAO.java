package com.spring.bts.byungyoon.model;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.bts.hwanmo.model.EmployeeVO;

@Repository
public interface InterAddBookDAO {

	// 주소록 메인페이지에서 주소록검색 ajax 쓰기
	public String getNameMember(int no);
	
	
	// 주소록 메인페이지에 select 해오기
	public List<AddBookVO> addBook_main_select();
	
	
	// 주소록 연락처에 insert 하기
	int addBook_telAdd_insert(AddBookVO avo);

	
	// 상세부서정보 페이지 사원목록 불러오기
	public List<EmployeeVO> addBook_depInfo_select(); // 영업팀


	
}
