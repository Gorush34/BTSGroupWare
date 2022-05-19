package com.spring.bts.jieun.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class TodolistDAO implements InterTodolistDAO {
	@Resource
	private SqlSessionTemplate sqlsession;

	// 투두 소분류 추가 
	@Override
	public int todoPlus(String todoSubject) {
		int n = sqlsession.insert("jieun.todoPlus", todoSubject);
		return n;
	} 
}
