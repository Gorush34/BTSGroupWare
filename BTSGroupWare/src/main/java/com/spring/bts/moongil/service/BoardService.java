package com.spring.bts.moongil.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.moongil.model.BoardVO;
import com.spring.bts.moongil.model.InterBoardDAO;



//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class BoardService implements InterBoardService {

	@Autowired
	private InterBoardDAO dao;

	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}

	@Override
	public List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<BoardVO> boardList = dao.boardListSearchWithPaging(paraMap);
		return boardList;
	}


	
	


}
