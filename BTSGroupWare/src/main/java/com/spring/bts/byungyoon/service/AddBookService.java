package com.spring.bts.byungyoon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.byungyoon.model.AddBookVO;
import com.spring.bts.byungyoon.model.InterAddBookDAO;
import com.spring.bts.common.*;
import com.spring.bts.hwanmo.model.EmployeeVO;

@Service
public class AddBookService implements InterAddBookService  {
	
	@Autowired
	private InterAddBookDAO dao;
	 
 	@Autowired
 	private AES256 aes;
	
	// 주소록 메인페이지에 select 해오기
	@Override
	public List<AddBookVO> addBook_main_select(Map<String, String> paraMap) {
		
		List<AddBookVO> adbList = dao.addBook_main_select(paraMap);
		
		return adbList;
	}

	
	// 주소록 연락처에 insert 하기
	@Override
	public int addBook_telAdd_insert(AddBookVO avo) {
		
		int n = dao.addBook_telAdd_insert(avo);
		
		return n;
	}

	
	// 상세부서정보 페이지 사원목록 불러오기 
	@Override
	public List<EmployeeVO> addBook_depInfo_select() {
		List<EmployeeVO> empList = dao.addBook_depInfo_select();
		return empList;
	}


	// 상세부서정보 페이지에서 사원상세정보 ajax로 select 해오기
	@Override
	public EmployeeVO addBook_depInfo_select_ajax(int pk_emp_no) throws Exception{
		
		EmployeeVO evo = dao.addBook_depInfo_select_ajax(pk_emp_no);
		
		String email = aes.decrypt(evo.getUq_email());
		String phone = aes.decrypt(evo.getUq_phone());
		
		evo.setUq_email(email);
		evo.setUq_phone(phone);
		
		return evo;
	}


	// 주소록 메인에서 select 해와서 연락처 update 하기 (select)
	@Override
	public AddBookVO addBook_main_telUpdate_select(int pk_addbook_no) {
		
		AddBookVO avo = dao.addBook_main_telUpdate_select(pk_addbook_no);
		
		return avo;
	}


	// 주소록 메인에서 select 해와서 연락처 update 하기 (update)
	@Override
	public int addBook_main_telUpdate_update(AddBookVO avo) {
		
		int n = dao.addBook_main_telUpdate_update(avo);
		
		return n;
	}


	// 주소록 메인에서 총 연락처 개수 가져오기
	@Override
	public int addBook_main_totalPage(Map<String, String> paraMap) {
		
		int n = dao.addBook_main_totalPage(paraMap);
		
		return n;
	}


	// 주소록 삭제하기
	@Override
	public int addBook_delete(int pk_addbook_no) {

		int n = dao.addBook_delete(pk_addbook_no);
		
		return n;
	}


	// 상세부서정보 페이지에서 관리자로 로그인시 사원상세정보 update 하기
	@Override
	public int addBook_depInfo_update(EmployeeVO evo) {

		int n = dao.addBook_depInfo_update(evo);
				
		return n;
	}


}
