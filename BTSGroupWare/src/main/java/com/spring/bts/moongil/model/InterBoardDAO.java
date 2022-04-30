package com.spring.bts.moongil.model;

import java.util.List;
import java.util.Map;

public interface InterBoardDAO {


	public int getTotalCount(Map<String, String> paraMap);

	public List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap);
	
}
