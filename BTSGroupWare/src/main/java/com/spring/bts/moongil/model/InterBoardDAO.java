package com.spring.bts.moongil.model;

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

	List<CommentVO> getCommentList(String fk_seq);

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

	List<String> wordSearchShow(Map<String, String> paraMap);

//	int add_like(LikeVO likevo);

	
	
}
