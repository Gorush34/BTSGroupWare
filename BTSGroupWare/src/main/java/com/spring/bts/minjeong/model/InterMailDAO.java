package com.spring.bts.minjeong.model;

import java.util.List;
import java.util.Map;

public interface InterMailDAO {

	// 받은메일함 목록 보여주기
	List<MailVO> getReceiveMailList();

	// 총 받은메일 개수 구해오기
	int getTotalCount(Map<String, String> paraMap);

	// 페이징처리 한 받은 메일목록 (검색 있든, 없든 모두 다 포함)
	List<MailVO> recMailListSearchWithPaging(Map<String, String> paraMap);

}
