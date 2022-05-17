package com.spring.bts.moongil.service;

import java.util.List;
import java.util.Map;

import com.spring.bts.moongil.model.BoardVO;
import com.spring.bts.moongil.model.CommentVO;
import com.spring.bts.moongil.model.FileboardVO;
import com.spring.bts.moongil.model.LikeVO;
import com.spring.bts.moongil.model.NoticeVO;

public interface InterBoardService {

	int getTotalCount(Map<String, String> paraMap);

	List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap);

	BoardVO getView(Map<String, String> paraMap);

	BoardVO getViewWithNoAddCount(Map<String, String> paraMap);

	int add(BoardVO boardvo);

	int add_withFile(BoardVO boardvo);

	int del(Map<String, String> paraMap);

	int edit(BoardVO boardvo);

	int save_withFile(BoardVO boardvo);

	int save(BoardVO boardvo);

	int exist(BoardVO boardvo);

	int addComment(CommentVO commentvo) throws Throwable;

	List<CommentVO> getCommentList(String fk_seq);

	List<BoardVO> temp_list(Map<String, String> paraMap);

	int tmp_write(BoardVO boardvo);

	BoardVO getViewWithNoAddCount2(Map<String, String> paraMap);

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

	NoticeVO getViewWithNoAddCount_notice(Map<String, String> paraMap);
	
	int likeCheck(int fk_seq, int fk_emp_no) throws Exception;

	void insertLike(int fk_seq, int fk_emp_no) throws Exception;

	void updateLike(int fk_seq) throws Exception;

	void updateLikeCancel(int fk_seq) throws Exception;

	void deleteLike(int fk_seq, int fk_emp_no) throws Exception;

	List<LikeVO> get_heart(Map<String, String> paraMap);

	List<BoardVO> getIntegratedBoard();

	int getTotalCount_total(Map<String, String> paraMap);

	List<BoardVO> boardListSearchWithPaging_total(Map<String, String> paraMap);

	List<Map<String, String>> getBestboard();

	int edit_notice(NoticeVO noticevo);

	int del_notice(Map<String, String> paraMap);

	int getTotalCount_fileboard(Map<String, String> paraMap);

	List<FileboardVO> ListSearchWithPaging_fileboard(Map<String, String> paraMap);

	int add_fileboard(FileboardVO fileboardvo);

	int add_withFile_fileboard(FileboardVO fileboardvo);

	FileboardVO getView_fileboard(Map<String, String> paraMap);

	FileboardVO getViewWithNoAddCount_fileboard(Map<String, String> paraMap);

	int edit_fileboard(FileboardVO fileboardvo);

	int del_fileboard(Map<String, String> paraMap);

	List<Map<String, String>> getNoticeboard();

	List<Map<String, String>> getBoard();

	List<Map<String, String>> getFileboard();

	List<Map<String, String>> getAll();

	LikeVO getlikeuser(Map<String, String> paraMap);






}
