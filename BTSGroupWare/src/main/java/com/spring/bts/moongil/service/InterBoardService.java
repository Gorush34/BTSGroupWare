package com.spring.bts.moongil.service;

import java.util.List;
import java.util.Map;

import com.spring.bts.moongil.model.BoardVO;

public interface InterBoardService {

	int getTotalCount(Map<String, String> paraMap);

	List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap);



}
