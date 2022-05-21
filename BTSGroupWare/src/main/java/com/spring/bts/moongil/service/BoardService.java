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
import com.spring.bts.moongil.model.FileboardVO;
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

	// 자유게시판 게시물 건수(totalCount)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}

	// 자유게시판 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<BoardVO> boardList = dao.boardListSearchWithPaging(paraMap);
		return boardList;
	}

	// 자유게시판 글조회수 증가와 함께 글1개를 조회를 해주는 것 
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

	// 자유게시판 글조회수 증가없이 글1개를 조회를 해주는 것 
	@Override
	public BoardVO getViewWithNoAddCount(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView(paraMap); // 글1개 조회하기
		return boardvo;
	}


	// 파일첨부가 없는 경우 자유게시판 글쓰기
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

	// 파일첨부가 있는 경우 자유게시판 글쓰기
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



	// ===  자유게시판 1개글 삭제하기 === // 
	@Override
	public int del(Map<String, String> paraMap) {
	
		int n = dao.del(paraMap);
		
		// ===  파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. === //
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
		
		dao.update_comment_status(paraMap);		
		// 자유게시판 글삭제를 하면 댓글들도 삭제

		return n;
	}

	// === 자유게시판 글수정 페이지 완료하기 === //
	@Override
	public int edit(BoardVO boardvo) {
		int n = dao.edit(boardvo);
		return n;
	}

	// 자유게시판 첨부파일이 있는 임시저장
	@Override
	public int save_withFile(BoardVO boardvo) {
		if("".contentEquals(boardvo.getFk_seq())) {

			int groupno = dao.getGroupnoMax() + 1;
			boardvo.setGroupno(String.valueOf(groupno));
		}
		
		int n = dao.save_withFile(boardvo); // 첨부파일이 있는 경우
		
		return n;
	}

	// 자유게시판 임시저장
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
	
	// ===  댓글쓰기(Ajax 로 처리) === //
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

	// 임시저장 글목록 가져오기
	@Override
	public List<BoardVO> temp_list(Map<String, String> paraMap) {
		List<BoardVO> temp_list = dao.temp_list(paraMap);
		return temp_list;
	}

	// === 임시저장글 완료하기 === //
	@Override
	public int tmp_write(BoardVO boardvo) {
		int n = dao.tmp_write(boardvo);
		return n;
	}

	// 임시저장글 조회수 안올라가게
	@Override
	public BoardVO getViewWithNoAddCount2(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView2(paraMap); // 글1개 조회하기
		return boardvo;
	}

	// 원글 글번호(parentSeq)에 해당하는 댓글의 totalPage 수 알아오기 
	@Override
	public int getCommentTotalPage(Map<String, String> paraMap) {
		int totalPage = dao.getCommentTotalPage(paraMap);
		return totalPage;
	}

	// === 원게시물에 딸린 댓글들을 페이징 처리해서 조회해오기(Ajax 로 처리) === //
	@Override
	public List<CommentVO> getCommentListPaging(Map<String, String> paraMap) {
		List<CommentVO> commentList = dao.getCommentListPaging(paraMap);
		return commentList;
	}

	// 댓글 삭제하기
	@Override
	public int delComment(String pk_seq) {
		int n = dao.delComment(pk_seq);
		return n;
	}

	// 댓글이 삭제되면 해당 글의 댓글수 감소시켜주기
	@Override
	public int minusCommentCount(String fk_seq) {
		int m = dao.minusCommentCount(fk_seq);
		return m;
	}

	// 공지사항 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<NoticeVO> noticeListSearchWithPaging(Map<String, String> paraMap) {
		List<NoticeVO> noticeList = dao.noticeListSearchWithPaging(paraMap);
		return noticeList;
	}
	
	// 공지사항 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount_notice(Map<String, String> paraMap) {
		int n = dao.getTotalCount_notice(paraMap);
		return n;
	}

	// 파일첨부가 없는 경우 공지사항 글쓰기
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

	// 파일첨부가 있는 경우 공지사항 글쓰기
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

	// 공지사항 글조회수 증가와 함께 글1개를 조회를 해주는 것 
	@Override
	public NoticeVO getView_notice(Map<String, String> paraMap) {
		NoticeVO noticevo = dao.getView_notice(paraMap); // 글1개 조회하기
		
		String login_userid = paraMap.get("login_userid");  
		
		int login_userid1 = Integer.parseInt(login_userid);

		
		if(login_userid1 != 0 &&
				noticevo != null &&
		  !login_userid.equals(noticevo.getFk_emp_no())) {
			
			dao.setAddReadCount_notice(noticevo.getPk_seq());   // 공지사항 글 조회수 1증가
			noticevo = dao.getView_notice(paraMap); 
		}
		
		return noticevo;
	}

	// 공지사항 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것 
	@Override
	public NoticeVO getViewWithNoAddCount_notice(Map<String, String> paraMap) {
		NoticeVO noticevo = dao.getView_notice(paraMap); // 글1개 조회하기
		return noticevo;
	}


	//like테이블 삽입
	@Override
	public void insertLike(int fk_seq, int fk_emp_no) throws Exception {
		dao.insertLike(fk_seq, fk_emp_no);
		
	}

	//게시판테이블 +1
	@Override
	public void updateLike(int fk_seq) throws Exception {
		dao.updateLike(fk_seq);
		
	}

	//게시판테이블 - 1
	@Override
	public void updateLikeCancel(int fk_seq) throws Exception {
		dao.updateLikeCancel(fk_seq);
		
	}

	//like테이블 삭제
	@Override
	public void deleteLike(int fk_seq, int fk_emp_no) throws Exception {
		dao.deleteLike(fk_seq, fk_emp_no);
		
	}

	// 좋아요를 눌렀는지 확인
	@Override
	public int likeCheck(int fk_seq, int fk_emp_no) throws Exception {
		return dao.likeCheck(fk_seq, fk_emp_no);
	}

	// 좋아요 불러오기
	@Override
	public List<LikeVO> get_heart(Map<String, String> paraMap) {
		List<LikeVO> likeList = dao.get_heart(paraMap); 
		return likeList;
	}

	// 전체글의 게시물 건수(totalCount)
	@Override
	public int getTotalCount_total(Map<String, String> paraMap) {
		int n = dao.getTotalCount_total(paraMap);
		return n;
	}

	// 전체글 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<BoardVO> boardListSearchWithPaging_total(Map<String, String> paraMap) {
		List<BoardVO> boardList = dao.boardListSearchWithPaging_total(paraMap);
		return boardList;
	}

	// 오늘의 인기글
	@Override
	public List<Map<String, String>> getBestboard() {
		List<Map<String, String>> boardMap = dao.getBestboard();
		return boardMap;
	}

	// 공지사항 글 수정
	@Override
	public int edit_notice(NoticeVO noticevo) {
		int n = dao.edit_notice(noticevo);
		return n;
	}

	// 공지사항 글 삭제
	@Override
	public int del_notice(Map<String, String> paraMap) {
		int n = dao.del_notice(paraMap);

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
		
		return n;
	}

	// 자료실 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount_fileboard(Map<String, String> paraMap) {
		int n = dao.getTotalCount_fileboard(paraMap);
		return n;
	}

	// 자료실 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<FileboardVO> ListSearchWithPaging_fileboard(Map<String, String> paraMap) {
		List<FileboardVO> fileboardlist = dao.ListSearchWithPaging_fileboard(paraMap);
		return fileboardlist;
	}

	@Override
	public int add_fileboard(FileboardVO fileboardvo) {
			if("".contentEquals(fileboardvo.getFk_seq())) {
				int groupno = dao.getGroupnoMax() + 1;
				fileboardvo.setGroupno(String.valueOf(groupno));
			}
			
			int n = dao.add_fileboard(fileboardvo); // 자료실 파일 없는 글쓰기
			return n;
	}

	@Override
	public int add_withFile_fileboard(FileboardVO fileboardvo) {
		if("".contentEquals(fileboardvo.getFk_seq())) {
			// 원글쓰기인 경우
			// groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해야한다.
			int groupno = dao.getGroupnoMax() + 1;
			fileboardvo.setGroupno(String.valueOf(groupno));
		}
 	    // == 원글쓰기인지, 답변글쓰기 인지 구분하기 끝 == //
		
		int n = dao.add_withFile_fileboard(fileboardvo); // 자료실 파일 있는 글쓰기
		
		return n;
	}

	@Override
	public FileboardVO getView_fileboard(Map<String, String> paraMap) {
		FileboardVO fileboardvo = dao.getView_fileboard(paraMap); // 글1개 조회하기
		
		String login_userid = paraMap.get("login_userid");  
		// paraMap.get("login_userid") 은 로그인을 한 상태이라면 로그인한 사용자의 userid 이고,
		// 로그인을 하지 않은 상태이라면  paraMap.get("login_userid") 은 null 이다.
		
		int login_userid1 = Integer.parseInt(login_userid);

		
		if(login_userid1 != 0 &&
			fileboardvo != null &&
		  !login_userid.equals(fileboardvo.getFk_emp_no())) {
			// 글조회수 증가는 로그인을 한 상태에서 다른 사람의 글을 읽을때만 증가하도록 한다. 
			
			dao.setAddReadCount_fileboard(fileboardvo.getPk_seq());  // 자료실 글조회수 1증가 하기 
			fileboardvo = dao.getView_fileboard(paraMap); // 자료실 글1개를 조회를 해주는 것 
		}
		
		return fileboardvo;
	}

	// 자료실 글조회수 증가 없이 글1개를 조회를 해주는 것 
	@Override
	public FileboardVO getViewWithNoAddCount_fileboard(Map<String, String> paraMap) {
		FileboardVO fileboardvo = dao.getView_fileboard(paraMap); // 글1개 조회하기
		return fileboardvo;
	}

	// 자료실 글수정
	@Override
	public int edit_fileboard(FileboardVO fileboardvo) {
		int n = dao.edit_fileboard(fileboardvo);
		return n;
	}

	// 자료실 글 삭제
	@Override
	public int del_fileboard(Map<String, String> paraMap) {
		int n = dao.del_fileboard(paraMap);

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
		
		return n;
	}

	// 메인페이지에서 공지사항 글 ajax 로 불러오기
	@Override
	public List<Map<String, String>> getNoticeboard() {
		List<Map<String, String>> boardMap = dao.getNoticeboard();
		return boardMap;
	}

	// 메인페이지에서 자유게시판 글 ajax로 불러오기
	@Override
	public List<Map<String, String>> getBoard() {
		List<Map<String, String>> boardMap = dao.getBoard();
		return boardMap;
	}

	// 메인페이지에서 자료실 글 ajax로 불러오기
	@Override
	public List<Map<String, String>> getFileboard() {
		List<Map<String, String>> boardMap = dao.getFileboard();
		return boardMap;
	}
	
	// 메인페이지 전체게시판 글 ajax 로 불러오기
	@Override
	public List<Map<String, String>> getAll() {
		List<Map<String, String>> boardMap = dao.getAll();
		return boardMap;
	}

	// 로그인한 유저가 좋아요를 눌렀는지 안눌렀는지 조회
	@Override
	public LikeVO getlikeuser(Map<String, String> paraMap) {
		LikeVO likevo = dao.getlikeuser(paraMap); 
		return likevo;
	}

	// 내가 쓴 글 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<BoardVO> boardListSearchWithPaging_my(Map<String, String> paraMap) {
		List<BoardVO> boardList = dao.boardListSearchWithPaging_my(paraMap);
		return boardList;
	}

	// 내가 쓴 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount_my(Map<String, String> paraMap) {
		int n = dao.getTotalCount_my(paraMap);
		return n;
	}

	// 내가 작성한 글 수 알아오기
	@Override
	public int my_cnt(int pk_emp_no) {
		int n = dao.my_cnt(pk_emp_no);
		return n;
	}

	// 내 댓글이 있는 총 게시물 건수
	@Override
	public int getTotalCount_comment(Map<String, String> paraMap) {
		int n = dao.getTotalCount_comment(paraMap);
		return n;
	}

	// 댓글 쓴 글 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<BoardVO> boardListSearchWithPaging_comment(Map<String, String> paraMap) {
		List<BoardVO> boardList = dao.boardListSearchWithPaging_comment(paraMap);
		return boardList;
	}

	// 댓글 보기
	@Override
	public List<CommentVO> view_comment(Map<String, String> paraMap) {
		List<CommentVO> commentList = dao.view_comment(paraMap);
		return commentList;
	}

	@Override
	public int selectDel(Map<String, String> paraMap) {
		int n = dao.selectDel(paraMap);
		return n;
	}












}
