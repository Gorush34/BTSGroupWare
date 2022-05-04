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

	@Override
	public BoardVO getView(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView(paraMap); // 글1개 조회하기
		
		String login_userid = paraMap.get("login_fk_emp_no");  
		// paraMap.get("login_userid") 은 로그인을 한 상태이라면 로그인한 사용자의 userid 이고,
		// 로그인을 하지 않은 상태이라면  paraMap.get("login_userid") 은 null 이다.
		
		if(login_userid != null &&
		   boardvo != null &&
		  !login_userid.equals(boardvo.getFk_emp_no())) {
			// 글조회수 증가는 로그인을 한 상태에서 다른 사람의 글을 읽을때만 증가하도록 한다. 
			
			dao.setAddReadCount(boardvo.getPk_seq());  // 글조회수 1증가 하기 
			boardvo = dao.getView(paraMap); 
		}
		
		return boardvo;
	}

	@Override
	public BoardVO getViewWithNoAddCount(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView(paraMap); // 글1개 조회하기
		return boardvo;
	}

	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = dao.wordSearchShow(paraMap);
		return wordList;
	}

	@Override
	public int add(BoardVO boardvo) {

		  // == 원글쓰기인지, 답변글쓰기 인지 구분하기 시작 == //
			if("".contentEquals(boardvo.getFk_seq())) {
				// 원글쓰기인 경우
				// groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해야한다.
				int groupno = dao.getGroupnoMax() + 1;
				boardvo.setGroupno(String.valueOf(groupno));
			}
		  // == 원글쓰기인지, 답변글쓰기 인지 구분하기 끝 == //	
			
			
			int n = dao.add(boardvo);
			return n;
	}

	@Override
	public int add_withFile(BoardVO boardvo) {
		if("".contentEquals(boardvo.getFk_seq())) {
			// 원글쓰기인 경우
			// groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해야한다.
			int groupno = dao.getGroupnoMax() + 1;
			boardvo.setGroupno(String.valueOf(groupno));
		}
 	    // == 원글쓰기인지, 답변글쓰기 인지 구분하기 끝 == //
		
		int n = dao.add_withFile(boardvo); // 첨부파일이 있는 경우
		
		return n;
	}

	@Override
	public int totalBoardCnt(Map<String, String> paraMap) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BoardVO> boardListSearchP(Map<String, String> paraMap) {
		// TODO Auto-generated method stub
		return null;
	}


	
	


}
