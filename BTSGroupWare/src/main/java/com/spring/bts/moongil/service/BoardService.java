package com.spring.bts.moongil.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.bts.common.FileManager;
import com.spring.bts.moongil.model.BoardVO;
import com.spring.bts.moongil.model.CommentVO;
import com.spring.bts.moongil.model.InterBoardDAO;
import com.spring.bts.moongil.model.LikeVO;
import com.spring.bts.moongil.model.NoticeVO;



//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class BoardService implements InterBoardService {

	@Autowired
	private InterBoardDAO dao;

	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다
	private FileManager fileManager;
	
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
		
		String login_userid = paraMap.get("login_userid");  
		// paraMap.get("login_userid") 은 로그인을 한 상태이라면 로그인한 사용자의 userid 이고,
		// 로그인을 하지 않은 상태이라면  paraMap.get("login_userid") 은 null 이다.

	//	System.out.println("login_userid =>" + login_userid);
		
		int login_userid1 = Integer.parseInt(login_userid);

		
		if(login_userid1 != 0 &&
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



	// === #78. 1개글 삭제하기 === // 
	@Override
	public int del(Map<String, String> paraMap) {
		int n = dao.del(paraMap);
		
		// === #165. 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. === //
		if(n==1) {
			String path = paraMap.get("path");
			String filename = paraMap.get("filename");
			
			if( filename != null && !"".equals(filename)) {
				try {
					fileManager.doFileDelete(filename, path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		}
		
		///////////////////////////////////////////////////////////////
		
		return n;
	}

	@Override
	public int edit(BoardVO boardvo) {
		int n = dao.edit(boardvo);
		return n;
	}

	@Override
	public int save_withFile(BoardVO boardvo) {
		if("".contentEquals(boardvo.getFk_seq())) {

			int groupno = dao.getGroupnoMax() + 1;
			boardvo.setGroupno(String.valueOf(groupno));
		}
		
		int n = dao.save_withFile(boardvo); // 첨부파일이 있는 경우
		
		return n;
	}

	@Override
	public int save(BoardVO boardvo) {
		if("".contentEquals(boardvo.getFk_seq())) {
			// 원글쓰기인 경우
			// groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해야한다.
			int groupno = dao.getGroupnoMax() + 1;
			boardvo.setGroupno(String.valueOf(groupno));
		}
	  // == 원글쓰기인지, 답변글쓰기 인지 구분하기 끝 == //	
		
		
		int n = dao.save(boardvo);
		return n;
	}

	@Override
	public int exist(BoardVO boardvo) {
		int n = dao.exist(boardvo);
		return n;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addComment(CommentVO commentvo) throws Throwable {
		
		int n=0, m=0;
		
		n = dao.addComment(commentvo); // 댓글쓰기(tbl_comment 테이블에 insert)
		
		if(n==1) {
		   m = dao.updateCommentCount(commentvo.getFk_seq()); // tbl_board 테이블에 commentCount 컬럼이 1증가(update)
		}
		
		if(m==1) {
		   Map<String, String> paraMap = new HashMap<>();	
		   paraMap.put("userid", commentvo.getFk_emp_no());
		}
		
		return m;
	}

	@Override
	public List<CommentVO> getCommentList(String fk_seq) {
		List<CommentVO> commentList = dao.getCommentList(fk_seq);
		return commentList;
	}

	@Override
	public List<BoardVO> temp_list(Map<String, String> paraMap) {
		List<BoardVO> temp_list = dao.temp_list(paraMap);
		return temp_list;
	}

	@Override
	public int tmp_write(BoardVO boardvo) {
		int n = dao.tmp_write(boardvo);
		return n;
	}

	@Override
	public BoardVO getViewWithNoAddCount2(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView2(paraMap); // 글1개 조회하기
		return boardvo;
	}

	@Override
	public int getCommentTotalPage(Map<String, String> paraMap) {
		int totalPage = dao.getCommentTotalPage(paraMap);
		return totalPage;
	}

	@Override
	public List<CommentVO> getCommentListPaging(Map<String, String> paraMap) {
		List<CommentVO> commentList = dao.getCommentListPaging(paraMap);
		return commentList;
	}

	@Override
	public int delComment(String pk_seq) {
		int n = dao.delComment(pk_seq);
		return n;
	}

	@Override
	public int minusCommentCount(String fk_seq) {
		int m = dao.minusCommentCount(fk_seq);
		return m;
	}

	@Override
	public List<NoticeVO> noticeListSearchWithPaging(Map<String, String> paraMap) {
		List<NoticeVO> noticeList = dao.noticeListSearchWithPaging(paraMap);
		return noticeList;
	}

	@Override
	public int getTotalCount_notice(Map<String, String> paraMap) {
		int n = dao.getTotalCount_notice(paraMap);
		return n;
	}

	@Override
	public List<NoticeVO> temp_list_notice(Map<String, String> paraMap) {
		List<NoticeVO> temp_list_notice = dao.temp_list_notice(paraMap);
		return temp_list_notice;
	}

	@Override
	public int add_notice(NoticeVO noticevo) {
		 // == 원글쓰기인지, 답변글쓰기 인지 구분하기 시작 == //
		if("".contentEquals(noticevo.getFk_seq())) {
			// 원글쓰기인 경우
			// groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해야한다.
			int groupno = dao.getGroupnoMax() + 1;
			noticevo.setGroupno(String.valueOf(groupno));
		}
	  // == 원글쓰기인지, 답변글쓰기 인지 구분하기 끝 == //	
		
		
		int n = dao.add_notice(noticevo);
		return n;
	}

	@Override
	public int add_withFile_notice(NoticeVO noticevo) {
		if("".contentEquals(noticevo.getFk_seq())) {
			// 원글쓰기인 경우
			// groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해야한다.
			int groupno = dao.getGroupnoMax() + 1;
			noticevo.setGroupno(String.valueOf(groupno));
		}
 	    // == 원글쓰기인지, 답변글쓰기 인지 구분하기 끝 == //
		
		int n = dao.add_withFile_notice(noticevo); // 첨부파일이 있는 경우
		
		return n;
	}

	@Override
	public NoticeVO getView_notice(Map<String, String> paraMap) {
		NoticeVO noticevo = dao.getView_notice(paraMap); // 글1개 조회하기
		
		String login_userid = paraMap.get("login_userid");  
		
		int login_userid1 = Integer.parseInt(login_userid);

		
		if(login_userid1 != 0 &&
				noticevo != null &&
		  !login_userid.equals(noticevo.getFk_emp_no())) {
			
			dao.setAddReadCount_notice(noticevo.getPk_seq());  
			noticevo = dao.getView_notice(paraMap); 
		}
		
		return noticevo;
	}

	@Override
	public NoticeVO getViewWithNoAddCount_notice(Map<String, String> paraMap) {
		NoticeVO noticevo = dao.getView_notice(paraMap); // 글1개 조회하기
		return noticevo;
	}



	@Override
	public void insertLike(int fk_seq, int fk_emp_no) throws Exception {
		dao.insertLike(fk_seq, fk_emp_no);
		
	}

	@Override
	public void updateLike(int fk_seq) throws Exception {
		dao.updateLike(fk_seq);
		
	}


	@Override
	public void updateLikeCancel(int fk_seq) throws Exception {
		dao.updateLikeCancel(fk_seq);
		
	}

	@Override
	public void deleteLike(int fk_seq, int fk_emp_no) throws Exception {
		dao.deleteLike(fk_seq, fk_emp_no);
		
	}

	@Override
	public int likeCheck(int fk_seq, int fk_emp_no) throws Exception {
		return dao.likeCheck(fk_seq, fk_emp_no);
	}

	@Override
	public List<LikeVO> get_heart(Map<String, String> paraMap) {
		List<LikeVO> likeList = dao.get_heart(paraMap); // 글1개 조회하기
		return likeList;
	}

	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = dao.wordSearchShow(paraMap);
		return wordList;
	}	


}
