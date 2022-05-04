package com.spring.bts.minjeong.service;

import java.util.List;
import java.util.Map;

import com.spring.bts.minjeong.model.MailVO;

public interface InterMailService {

	// 받은메일함 목록 보여주기
	List<MailVO> getReceiveMailList();

	// 총 게시물 건수 구해오기 (service 단으로 보내기)
	int getTotalCount(Map<String, String> paraMap);

	// 페이징처리 한 받은 메일목록 (검색 있든, 없든 모두 다 포함)
	List<MailVO> recMailListSearchWithPaging(Map<String, String> paraMap);

	
}
