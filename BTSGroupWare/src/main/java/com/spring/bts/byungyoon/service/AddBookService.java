package com.spring.bts.byungyoon.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
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

	// 이메일 중복체크
	@Override
	public boolean emailDuplicateCheck(String email) {
		try {
			email = aes.encrypt(email); // 이메일을 암호화
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		boolean isExist = dao.emailDuplicateCheck(email);
		return isExist;
	}


	// 사원목록에서 사원 삭제하기
	@Override
	public int addBook_depInfo_delete(int pk_emp_no) {
		
		int n = dao.addBook_depInfo_delete(pk_emp_no);
		
		return n;
	}


	// 사이드인포 계급순 구성원 띄우기
	@Override
	public List<EmployeeVO> sideinfo_addBook() {
		List<EmployeeVO> empList = dao.sideinfo_addBook();
		return empList;
	}


	// 부서리스트 가져오기
	@Override
	public List<Map<String, String>> addBook_depList_select() {
		List<Map<String, String>> depList = dao.addBook_depList_select();
		return depList;
	}


	// 관리자에서 부서 추가하기
	@Override
	public int addBook_dep_insert(Map<String, String> paraMap) {
		
		int n = dao.addBook_dep_insert(paraMap);
		
		return n;
	}


	// 직급리스트 가져오기
	@Override
	public List<Map<String, String>> addBook_rankList_select() {
		List<Map<String, String>> rankList = dao.addBook_rankList_select();
		return rankList;
	}


	// 관리자에서 부서 삭제하기
	@Override
	public int addBook_dep_delete(int dep_delete) {
		
		int n = dao.addBook_dep_delete(dep_delete);
		
		return n;
	}
	
	
	// 부서리스트 가져오기(주소록 --)
	@Override
	public List<Map<String, String>> addBook_depList_select_ab() {
		List<Map<String, String>> ab_depList = dao.addBook_depList_select_ab();
		return ab_depList;
	}
	
	// 직급리스트 가져오기(주소록 --)
	@Override
	public List<Map<String, String>> addBook_rankList_select_ab() {
		List<Map<String, String>> ab_rankList = dao.addBook_rankList_select_ab();
		return ab_rankList;
	}


	
	
	


}
