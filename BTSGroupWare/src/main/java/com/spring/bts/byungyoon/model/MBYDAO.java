package com.spring.bts.byungyoon.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MBYDAO implements InterMBYDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public String getNameMember(int no) {
		
		String loginuser = sqlsession.selectOne("byungyoon.mby_test", no);
		return loginuser;
	}
}
