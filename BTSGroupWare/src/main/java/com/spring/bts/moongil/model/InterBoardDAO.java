package com.spring.bts.moongil.model;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;




public interface InterBoardDAO {


	// 총 게시물 건수(totalCount) 구하기  - 검색이 있을때와 검색이 업을때로 나뉜다
	int getTotalCount(Map<String, String> paraMap);

	List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap);

	BoardVO getView(Map<String, String> paraMap);

	void setAddReadCount(String pk_seq);

	int getGroupnoMax();

	int add_withFile(BoardVO boardvo);

	int add(BoardVO boardvo);

	int del(Map<String, String> paraMap);

	int edit(BoardVO boardvo);

	// 임시저장 파일 있을 경우
	int save_withFile(BoardVO boardvo);

	// 임시저장
	int save(BoardVO boardvo);

	int exist(BoardVO boardvo);

	List<BoardVO> temp_list(Map<String, String> paraMap);
	
	int addComment(CommentVO commentvo);

	int updateCommentCount(String fk_seq);

	int tmp_write(BoardVO boardvo);

	BoardVO getView2(Map<String, String> paraMap);

	int getCommentTotalPage(Map<String, String> paraMap);

	List<CommentVO> getCommentListPaging(Map<String, String> paraMap);

	int delComment(String pk_seq);

	int minusCommentCount(String fk_seq);

	List<NoticeVO> noticeListSearchWithPaging(Map<String, String> paraMap);

	int getTotalCount_notice(Map<String, String> paraMap);

	List<NoticeVO> temp_list_notice(Map<String, String> paraMap);

	int add_notice(NoticeVO noticevo);

	int add_withFile_notice(NoticeVO noticevo);

	NoticeVO getView_notice(Map<String, String> paraMap);

	void setAddReadCount_notice(String pk_seq);

	int likeCheck(int fk_seq, int fk_emp_no);

	void insertLike(int fk_seq, int fk_emp_no);

	void updateLike(int fk_seq);

	void updateLikeCancel(int fk_seq);

	void deleteLike(int fk_seq, int fk_emp_no);

	List<LikeVO> get_heart(Map<String, String> paraMap);

	List<BoardVO> getIntegratedBoard();

	int getTotalCount_total(Map<String, String> paraMap);

	List<BoardVO> boardListSearchWithPaging_total(Map<String, String> paraMap);

	List<Map<String, String>> getBestboard();

	int edit_notice(NoticeVO noticevo);

	int del_notice(Map<String, String> paraMap);

	int getTotalCount_fileboard(Map<String, String> paraMap);

	List<FileboardVO> ListSearchWithPaging_fileboard(Map<String, String> paraMap);

	int add_withFile_fileboard(FileboardVO fileboardvo);

	int add_fileboard(FileboardVO fileboardvo);

	FileboardVO getView_fileboard(Map<String, String> paraMap);

	void setAddReadCount_fileboard(String pk_seq);

	int edit_fileboard(FileboardVO fileboardvo);

	int del_fileboard(Map<String, String> paraMap);

	List<Map<String, String>> getNoticeboard();

	List<Map<String, String>> getBoard();

	List<Map<String, String>> getFileboard();

	List<Map<String, String>> getAll();

	LikeVO getlikeuser(Map<String, String> paraMap);

	List<BoardVO> boardListSearchWithPaging_my(Map<String, String> paraMap);

	int getTotalCount_my(Map<String, String> paraMap);

	int my_cnt(int pk_emp_no);




	
	
}
