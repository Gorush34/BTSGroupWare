package com.spring.bts.moongil.model;

import java.util.List;
import java.util.Map;



public interface InterBoardDAO {


	// 총 게시물 건수(totalCount) 구하기  - 검색이 있을때와 검색이 업을때로 나뉜다
	int getTotalCount(Map<String, String> paraMap);
	
	// 자유게시판 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap);

	// 자유게시판 글1개를 조회를 해주는 것 
	BoardVO getView(Map<String, String> paraMap);

	// 자유게시판 글1개의 조회수를 증가
	void setAddReadCount(String pk_seq);

	// tbl_board 테이블에서  groupno 컬럼의 최대값 알아오기
	int getGroupnoMax();

	// 파일첨부가 있는 경우 자유게시판 글쓰기
	int add_withFile(BoardVO boardvo);

	// 파일첨부가 없는 경우 자유게시판 글쓰기
	int add(BoardVO boardvo);

	// ===  1개글 삭제하기 ===
	int del(Map<String, String> paraMap);

	// === 글수정 페이지 완료하기 === //
	int edit(BoardVO boardvo);

	// 임시저장 파일 있을 경우
	int save_withFile(BoardVO boardvo);

	// 임시저장
	int save(BoardVO boardvo);

	// 임시저장 글목록 가져오기
	List<BoardVO> temp_list(Map<String, String> paraMap);
	
	// ===  댓글쓰기(Ajax 로 처리) === //
	int addComment(CommentVO commentvo);

	// tbl_board 테이블에 commentCount 컬럼이 1증가(update)
	int updateCommentCount(String fk_seq);

	// === 임시저장글 완료하기 === //
	int tmp_write(BoardVO boardvo);

	// 임시저장글 조회수 안올라가게
	BoardVO getView2(Map<String, String> paraMap);

	// 원글 글번호(parentSeq)에 해당하는 댓글의 totalPage 수 알아오기 
	int getCommentTotalPage(Map<String, String> paraMap);

	// === 원게시물에 딸린 댓글들을 페이징 처리해서 조회해오기(Ajax 로 처리) === //
	List<CommentVO> getCommentListPaging(Map<String, String> paraMap);

	// 댓글 삭제하기
	int delComment(String pk_seq);

	// 댓글이 삭제되면 해당 글의 댓글수 감소시켜주기
	int minusCommentCount(String fk_seq);

	// 공지사항 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	List<NoticeVO> noticeListSearchWithPaging(Map<String, String> paraMap);

	// 공지사항 총 게시물 건수(totalCount)
	int getTotalCount_notice(Map<String, String> paraMap);

	// 파일첨부가 없는 경우 공지사항 글쓰기
	int add_notice(NoticeVO noticevo);

	// 파일첨부가 있는 경우 공지사항 글쓰기
	int add_withFile_notice(NoticeVO noticevo);

	// 공지사항 글1개를 조회를 해주는 것 
	NoticeVO getView_notice(Map<String, String> paraMap);

	 // 공지사항 글 조회수 1증가
	void setAddReadCount_notice(String pk_seq);

	// 좋아요를 눌렀는지 확인
	int likeCheck(int fk_seq, int fk_emp_no);

	//like테이블 삽입
	void insertLike(int fk_seq, int fk_emp_no);

	//게시판테이블 +1
	void updateLike(int fk_seq);

	//게시판테이블 - 1
	void updateLikeCancel(int fk_seq);

	//like테이블 삭제
	void deleteLike(int fk_seq, int fk_emp_no);

	// 좋아요 불러오기
	List<LikeVO> get_heart(Map<String, String> paraMap);

	// 전체글의 게시물 건수(totalCount)
	int getTotalCount_total(Map<String, String> paraMap);

	// 전체글 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	List<BoardVO> boardListSearchWithPaging_total(Map<String, String> paraMap);

	// 오늘의 인기글
	List<Map<String, String>> getBestboard();

	// 공지사항 글 수정
	int edit_notice(NoticeVO noticevo);

	// 공지사항 글 삭제
	int del_notice(Map<String, String> paraMap);

	// 자료실 총 게시물 건수(totalCount)
	int getTotalCount_fileboard(Map<String, String> paraMap);

	// 자료실 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	List<FileboardVO> ListSearchWithPaging_fileboard(Map<String, String> paraMap);

	// 자료실 파일 있는 글쓰기
	int add_withFile_fileboard(FileboardVO fileboardvo);

	// 자료실 파일 없는 글쓰기
	int add_fileboard(FileboardVO fileboardvo);

	// 자료실 글1개를 조회를 해주는 것 
	FileboardVO getView_fileboard(Map<String, String> paraMap);

	// 자료실 글조회수 1증가 하기 
	void setAddReadCount_fileboard(String pk_seq);

	// 자료실 글수정
	int edit_fileboard(FileboardVO fileboardvo);

	// 자료실 글 삭제
	int del_fileboard(Map<String, String> paraMap);
	
	// 메인페이지에서 공지사항 글 ajax 로 불러오기
	List<Map<String, String>> getNoticeboard();

	// 메인페이지에서 자유게시판 글 ajax로 불러오기
	List<Map<String, String>> getBoard();

	// 메인페이지에서 자료실 글 ajax로 불러오기
	List<Map<String, String>> getFileboard();

	// 메인페이지 전체게시판 글 ajax 로 불러오기
	List<Map<String, String>> getAll();

	// 로그인한 유저가 좋아요를 눌렀는지 안눌렀는지 조회
	LikeVO getlikeuser(Map<String, String> paraMap);

	// 내가 쓴 글 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	List<BoardVO> boardListSearchWithPaging_my(Map<String, String> paraMap);

	// 내가 쓴 총 게시물 건수(totalCount)
	int getTotalCount_my(Map<String, String> paraMap);

	int my_cnt(int pk_emp_no);

	// 내 댓글이 있는 총 게시물 건수
	int getTotalCount_comment(Map<String, String> paraMap);

	// 댓글 쓴 글 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	List<BoardVO> boardListSearchWithPaging_comment(Map<String, String> paraMap);

	// 댓글 보기
	List<CommentVO> view_comment(Map<String, String> paraMap);

	// 글삭제를 하면 댓글들도 삭제
	int update_comment_status(Map<String, String> paraMap);


	
	
}
