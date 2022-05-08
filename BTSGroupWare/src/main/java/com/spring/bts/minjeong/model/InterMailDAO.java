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
	
	// 총 보낸메일 개수 구해오기
	int getTotalCount_send(Map<String, String> paraMap);

	// 페이징처리 한 보낸 메일목록 (검색 있든, 없든 모두 다 포함)
	List<MailVO> sendMailListSearchWithPaging(Map<String, String> paraMap);
		
	// 메일쓰기 (파일첨부가 없는 메일쓰기)
	int add(MailVO mailvo);

	// 메일쓰기 (파일첨부가 있는 메일쓰기)
	int add_withFile(MailVO mailvo);

	// 메일 1개 상세내용을 읽어오기
	MailVO getRecMailView(Map<String, String> paraMap);

	// *** 아래 3개의 메소드는 1 set 이다. (첨부파일 유/무 --> 메일 삭제상태 1로 변경)
	// 메일함목록에서 선택 후 삭제버튼 클릭 시 휴지통테이블로 insert 하기 (첨부파일 있을 때)
	int moveToRecyclebin(Map<String, String> paraMap);

	// 메일함목록에서 선택 후 삭제버튼 클릭 시 휴지통테이블로 insert 하기 (첨부파일 없을 때)
	int moveToRecyclebinNoFile(Map<String, String> paraMap);

	// 휴지통 테이블로 insert 후 메일 테이블에서 해당 메일의 삭제 상태를 1로 변경해주기
	int updateFromTblMailRecDelStatus(Map<String, String> paraMap);

	// 메일주소로 사원이름, 사원번호 알아오기
	Map<String, String> getEmpnameAndNum(String uq_email);

}
