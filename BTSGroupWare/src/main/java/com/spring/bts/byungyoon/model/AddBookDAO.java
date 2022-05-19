package com.spring.bts.byungyoon.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.bts.hwanmo.model.EmployeeVO;

@Repository
public class AddBookDAO implements InterAddBookDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	// 주소록 메인페이지에 select 해오기
	@Override
	public List<AddBookVO> addBook_main_select(Map<String, String> paraMap) {
		
		List<AddBookVO> adbList = sqlsession.selectList("byungyoon.addBook_main_select", paraMap);
		
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


	// 주소록 메인에서 select 해와서 연락처 update 하기 (select)
	@Override
	public AddBookVO addBook_main_telUpdate_select(int pk_addbook_no) {

		AddBookVO avo = sqlsession.selectOne("byungyoon.addBook_main_telUpdate_select", pk_addbook_no);
		
		return avo;
	}


	// 주소록 메인에서 select 해와서 연락처 update 하기 (update)
	@Override
	public int addBook_main_telUpdate_update(AddBookVO avo) {

		int n = sqlsession.update("byungyoon.addBook_main_telUpdate_update" , avo);
		
		return n;
	}


	// 주소록 메인에서 총 연락처 개수 가져오기
	@Override
	public int addBook_main_totalPage(Map<String, String> paraMap) {
		
		int n = sqlsession.selectOne("byungyoon.addBook_main_totalPage" , paraMap);
		return n;
	}


	// 주소록 삭제하기
	@Override
	public int addBook_delete(int pk_addbook_no) {
		int n = sqlsession.delete("byungyoon.addBook_delete" , pk_addbook_no);
		return n;
	}


	// 상세부서정보 페이지에서 관리자로 로그인시 사원상세정보 update 하기
	@Override
	public int addBook_depInfo_update(EmployeeVO evo) {

		int n = sqlsession.update("byungyoon.addBook_depInfo_update" , evo);
		
		return n;
	}


	// 이메일 중복체크
	@Override
	public boolean emailDuplicateCheck(String email) {
		
		boolean isExist = sqlsession.selectOne("byungyoon.emailDuplicateCheck", email);
		
		return isExist;
	}


	// 사원 목록에서 사원 삭제하기
	@Override
	public int addBook_depInfo_delete(int pk_emp_no) {
		
		int n = sqlsession.delete("byungyoon.addBook_depInfo_delete" , pk_emp_no);
		
		return n;
	}


	// 사이드인포 계급순 구성원 띄우기
	@Override
	public List<EmployeeVO> sideinfo_addBook() {
		List<EmployeeVO> empList = sqlsession.selectList("byungyoon.sideinfo_addBook");
		return empList;
	}



	
	
	
	
	
	
	
	
}
