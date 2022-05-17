package com.spring.bts.minjeong.service;

import java.util.List;
import java.util.Map;

import com.spring.bts.minjeong.model.MailVO;

public interface InterMailService {

	// 받은메일함 목록 보여주기
	List<MailVO> getReceiveMailList();

	// 총 게시물 건수 구해오기 - 받은메일함 (service 단으로 보내기)
	int getTotalCount(Map<String, String> paraMap);

	// 페이징처리 한 받은 메일목록 (검색 있든, 없든 모두 다 포함)
	List<MailVO> recMailListSearchWithPaging(Map<String, String> paraMap);

	// 총 게시물 건수 구해오기 - 보낸메일함 (service 단으로 보내기)
	int getTotalCount_send(Map<String, String> paraMap);

	// 페이징처리 한 보낸 메일목록 (검색 있든, 없든 모두 다 포함)
	List<MailVO> sendMailListSearchWithPaging(Map<String, String> paraMap);

	// 메일주소로 사원이름, 사원번호 알아오기
	Map<String, String> getEmpnameAndNum(String uq_email);
	
	// 메일쓰기 (파일첨부가 없는 메일쓰기)
	int add(MailVO mailvo);

	// 메일쓰기 (파일첨부가 있는 메일쓰기)
	int add_withFile(MailVO mailvo);

	// 받은 메일 1개 상세내용을 읽어오기 
	MailVO getRecMailView(Map<String, String> paraMap);

	// 보낸 메일 1개 상세내용을 읽어오기
	MailVO getSendMailView(Map<String, String> paraMap);

	// 받은메일함에서 선택한 글번호에 해당하는 메일을 삭제 시, 메일 테이블에서 해당 메일번호의 삭제 상태를 1로 변경해주기
	int updateFromTblMailDelStatus(Map<String, String> paraMap);

	// 총 게시물 건수 구해오기 - 휴지통 (service 단으로 보내기)
	int getTotalCount_recyclebin(Map<String, String> paraMap);
	
	// 페이징처리 한 휴지통 목록 (검색 있든, 없든 모두 다 포함 // del_status = 1 인 글만 보여주기)
	List<MailVO> RecyclebinMailListSearchWithPaging(Map<String, String> paraMap);

	// 휴지통 메일함 1개 상세내용을 읽어오기
	MailVO getRecyclebinMailView(Map<String, String> paraMap);

	// 휴지통에서 선택한 글들을 mail 테이블에서 삭제하기
	int deleteFromTblMail(Map<String, String> paraMap);

	
	// ==== 예약메일함 (스프링 스케줄러) 시작 ==== //

	// 총 게시물 건수 구해오기 - 예약메일함 (service 단으로 보내기)
	int getTotalCount_reservation(Map<String, String> paraMap);
	
	// 페이징처리 한 예약메일함 목록 1 (검색 있든, 없든 모두 다 포함 // reservation_status = 1 인 글만 보여주기)
	List<MailVO> getReservationListWithPaging(Map<String, String> paraMap);

	// 예약 메일 1개 상세내용을 읽어오기
	MailVO getReservationMailView(Map<String, String> paraMap);	

	// 스프링 스케줄러를 이용해서 발송예약 실행하기
	void reservationMailSendSchedular() throws Exception ;
	
	// ==== 예약메일함 (스프링 스케줄러) 끝 ==== //


	// ==== 임시보관함 시작 ==== //
	
	// 총 임시보관함 메일 건수 구해오기 (service 단으로 보내기) 
	int getTotalCount_temporary(Map<String, String> paraMap);
	
	// 페이징처리 한 임시보관함 메일목록 (검색 있든, 없든 모두 다 포함) 
	List<MailVO> getTemporaryMailListWithPaging(Map<String, String> paraMap);

	// 임시보관함에서 제목 클릭했을 때 넘어왔을 경우 받아온 글번호인 pk_mail_num 의 temp_status 를 update (수정함)
//	int updateFromTbltemp(Map<String, String> paraMap);

	// 임시보관함에서 제목 클릭했을 때 넘어왔을 경우 받아온 글번호인 pk_mail_num 를 delete
	int deleteFromTbltemp(Map<String, String> paraMap);
	
	// ==== 임시보관함 끝 ==== //

	// 총 중요 메일 건수 구해오기
	int getTotalCount_important(Map<String, String> paraMap);

	// 페이징처리 한 중요메일함 목록 (검색 있든, 없든 모두 다 포함) 
	List<MailVO> ImportantMailListSearchWithPaging(Map<String, String> paraMap);

	// 중요 메일 1개 상세내용을 읽어오기
	MailVO getImportantMailView(Map<String, String> paraMap);

	// pk_mail_num 를 통해서 temp_status 조회해오기
	Map<String, String> getTempStatus(String pk_mail_num);

	// updateImportance_star_rec Update 를 통해 값을 0,1로 변경해주기
	int updateImportance_star_rec(Map<String, String> paraMap);

	// updateImportance_star_send Update 를 통해 값을 0,1로 변경해주기
	int updateImportance_star_send(Map<String, String> paraMap);

	// 메일 1개 상세내용을 읽어오기 (메일 전달 및 답장을 위함 - 검색타입과 검색명 없음)
	MailVO getRecMailView_noSearch(Map<String, String> paraMap);

	// 각 메일함 상세보기에서 삭제버튼 클릭 (글 1개)시 해당 글번호 글 휴지통으로 이동하기 (del_status = 1)
	int updateTblMailDelStatus_one(Map<String, String> paraMap);

	// 총 내게 쓴 메일 건수 구해오기
	int getTotalCount_sendToMe(Map<String, String> paraMap);

	// 페이징처리 한 내게쓴 메일목록 (검색 있든, 없든 모두 다 포함) 
	List<MailVO> sendToMeListSearchWithPaging(Map<String, String> paraMap);

	// 내게쓴 메일 1개 상세내용을 읽어오기 (service 로 보낸다.)
	MailVO getSendToMeMailView(Map<String, String> paraMap);

	// 메인페이지에서 로그인한 사용자의 받은메일함 목록 보여주기
//	List<Map<String, String>> mailReceive_main();

	
}
