package com.spring.bts.jieun.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.jieun.model.InterTodolistDAO;

@Service
public class TodolistService implements InterTodolistService {
	@Autowired
	private InterTodolistDAO dao;

	// 투두 소분류 추가 
	@Override
	public int todoPlus(String todoSubject) {
		int n = dao.todoPlus(todoSubject);
		return n;
	}
}
