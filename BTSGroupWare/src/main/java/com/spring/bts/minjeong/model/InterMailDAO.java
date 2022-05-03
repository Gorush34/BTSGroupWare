package com.spring.bts.minjeong.model;

import java.util.List;

public interface InterMailDAO {

	// 받은메일함 목록 보여주기
	List<MailVO> getReceiveMailList();

}
