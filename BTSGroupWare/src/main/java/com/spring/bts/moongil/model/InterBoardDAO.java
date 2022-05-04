package com.spring.bts.moongil.model;

import java.util.List;
import java.util.Map;




public interface InterBoardDAO {


	// 총 게시물 건수(totalCount) 구하기  - 검색이 있을때와 검색이 업을때로 나뉜다
	int getTotalCount(Map<String, String> paraMap);

	List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap);

	BoardVO getView(Map<String, String> paraMap);

	void setAddReadCount(String seq);

	List<String> wordSearchShow(Map<String, String> paraMap);

	int getGroupnoMax();

	int add_withFile(BoardVO boardvo);

	int add(BoardVO boardvo);
	
}
