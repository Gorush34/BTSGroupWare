package com.spring.bts.moongil.service;

import java.util.List;
import java.util.Map;

import com.spring.bts.moongil.model.BoardVO;
import com.spring.bts.moongil.model.CommentVO;

public interface InterBoardService {

	int getTotalCount(Map<String, String> paraMap);

	List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap);

	BoardVO getView(Map<String, String> paraMap);

	BoardVO getViewWithNoAddCount(Map<String, String> paraMap);

	List<String> wordSearchShow(Map<String, String> paraMap);

	int add(BoardVO boardvo);

	int add_withFile(BoardVO boardvo);

	int totalBoardCnt(Map<String, String> paraMap);

	List<BoardVO> boardListSearchP(Map<String, String> paraMap);

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



}
