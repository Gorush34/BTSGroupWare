package com.spring.bts.byungyoon.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AddBookDAO implements InterAddBookDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public String getNameMember(int no) {
		
		String loginuser = sqlsession.selectOne("byungyoon.mby_test", no);
		return loginuser;
	}

	// 주소록 메인페이지에 select 해오기
	@Override
	public List<AddBookVO> addBook_select() {
		
		List<AddBookVO> adbList = sqlsession.selectList("byungyoon.addBook_select");
		
	//	System.out.println("여기는 dao");
		
		return adbList;
	}

	// 주소록 연락처에 insert 하기
	@Override
	public int addBook_insert(AddBookVO avo) {
		
		int n = sqlsession.insert("byungyoon.addBook_insert", avo);
		
		return n;
	}
}
