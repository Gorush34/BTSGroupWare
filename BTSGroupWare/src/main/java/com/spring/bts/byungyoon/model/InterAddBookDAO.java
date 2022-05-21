package com.spring.bts.byungyoon.model;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.spring.bts.hwanmo.model.EmployeeVO;

@Repository
public interface InterAddBookDAO {
	
	// 주소록 메인페이지에 select 해오기
	public List<AddBookVO> addBook_main_select(Map<String, String> paraMap);
	
	
	// 주소록 연락처에 insert 하기
	int addBook_telAdd_insert(AddBookVO avo);

	
	// 상세부서정보 페이지 사원목록 불러오기
	public List<EmployeeVO> addBook_depInfo_select();  

	
	// 상세부서정보 페이지에서 사원상세정보 ajax로 select 해오기
	public EmployeeVO addBook_depInfo_select_ajax(int pk_emp_no);


	// 주소록 메인에서 select 해와서 연락처 update 하기 (select)
	public AddBookVO addBook_main_telUpdate_select(int pk_addbook_no);


	// 주소록 메인에서 select 해와서 연락처 update 하기 (update)
	public int addBook_main_telUpdate_update(AddBookVO avo);


	// 주소록 메인에서 총 연락처 개수 가져오기
	public int addBook_main_totalPage(Map<String, String> paraMap);


	// 주소록 삭제하기
	public int addBook_delete(int pk_addbook_no);


	// 상세부서정보 페이지에서 관리자로 로그인시 사원상세정보 update 하기
	public int addBook_depInfo_update(EmployeeVO evo);

	
	// 이메일 중복체크
	public boolean emailDuplicateCheck(String email);

	
	// 사원 목록에서 사원 삭제하기
	public int addBook_depInfo_delete(int pk_emp_no);


	// 사이드인포 계급순 구성원 띄우기
	public List<EmployeeVO> sideinfo_addBook();


	// 부서리스트 가져오기
	public List<Map<String, String>> addBook_depList_select();


	// 관리자에서 부서 추가하기
	public int addBook_dep_insert(Map<String, String> paraMap);



	
}
