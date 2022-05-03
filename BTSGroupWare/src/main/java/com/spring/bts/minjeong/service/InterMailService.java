package com.spring.bts.minjeong.service;

import java.util.List;

import com.spring.bts.minjeong.model.MailVO;

public interface InterMailService {

	// 받은메일함 목록 보여주기
	List<MailVO> getReceiveMailList();
	
}
