package com.spring.bts.moongil.service;

import java.util.List;
import java.util.Map;

import com.spring.bts.moongil.model.BoardVO;

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



}
