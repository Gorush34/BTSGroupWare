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

	// 메일쓰기 (파일첨부가 없는 메일쓰기)
	int add(MailVO mailvo);

	// 메일쓰기 (파일첨부가 있는 메일쓰기)
	int add_withFile(MailVO mailvo);

	// 받은 메일 1개 상세내용을 읽어오기 (service 로 보낸다.)
	MailVO getRecMailView(Map<String, String> paraMap);

	
	
}
