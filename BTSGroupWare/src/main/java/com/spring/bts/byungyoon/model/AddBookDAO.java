package com.spring.bts.byungyoon.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bts.hwanmo.model.EmployeeVO;

@Repository
public class AddBookDAO implements InterAddBookDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	// 주소록 메인페이지에서 주소록검색 ajax 쓰기
	@Override
	public String getNameMember(int no) {
		
		String loginuser = sqlsession.selectOne("byungyoon.mby_test", no);
		return loginuser;
	}

	
	// 주소록 메인페이지에 select 해오기
	@Override
	public List<AddBookVO> addBook_main_select() {
		
		List<AddBookVO> adbList = sqlsession.selectList("byungyoon.addBook_main_select");
		
		return adbList;
	}

	
	// 주소록 연락처에 insert 하기
	@Override
	public int addBook_telAdd_insert(AddBookVO avo) {
		
		
		int n = sqlsession.insert("byungyoon.addBook_telAdd_insert", avo);
		
		return n;
	}

	
	// 상세부서정보 페이지 사원목록 불러오기
	@Override
	public List<EmployeeVO> addBook_depInfo_select() {
		List<EmployeeVO> empList = sqlsession.selectList("byungyoon.addBook_depInfo_select");
		return empList;
	}


	// 상세부서정보 페이지에서 사원상세정보 ajax로 select 해오기
	@Override
	public EmployeeVO addBook_depInfo_select_ajax(int pk_emp_no) {
		
		EmployeeVO evo = sqlsession.selectOne("byungyoon.addBook_depInfo_select_ajax", pk_emp_no);
		
		return evo;
	}


	// 주소록 메인에서 select 해와서 연락처 update 하기
	@Override
	public AddBookVO addBook_main_telUpdate(int pk_addbook_no) {

		AddBookVO avo = sqlsession.selectOne("byungyoon.addBook_main_telUpdate", pk_addbook_no);
		
		return avo;
	}

	
	
	
	
	
	
	
	
}
