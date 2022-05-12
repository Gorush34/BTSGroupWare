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

	// 받은 메일 1개 상세내용을 읽어오기
	MailVO getRecMailView(Map<String, String> paraMap);

	// 보낸 메일 1개 상세내용을 읽어오기
	MailVO getSendMailView(Map<String, String> paraMap);

	// 받은메일함에서 선택한 글번호에 해당하는 메일을 삭제 시, 메일 테이블에서 해당 메일번호의 삭제 상태를 1로 변경해주기
	int updateFromTblMailDelStatus(Map<String, String> paraMap);

	// 메일주소로 사원이름, 사원번호 알아오기
	Map<String, String> getEmpnameAndNum(String uq_email);

	// 총 게시물 건수 구해오기 - 휴지통 (service 단으로 보내기)
	int getTotalCount_recyclebin(Map<String, String> paraMap);
	
	// 페이징처리 한 휴지통 목록 (검색 있든, 없든 모두 다 포함) 
	List<MailVO> RecyclebinMailListSearchWithPaging(Map<String, String> paraMap);

	// 휴지통 메일함 1개 상세내용을 읽어오기
	MailVO getRecyclebinMailView(Map<String, String> paraMap);

	// 휴지통에서 선택한 글들을 mail 테이블에서 삭제하기
	int deleteFromTblMail(Map<String, String> paraMap);

	// ==== 예약메일함 시작 ==== //
	
	// 총 게시물 건수 구해오기 - 예약메일함 (service 단으로 보내기)
	int getTotalCount_reservation(Map<String, String> paraMap);

	// 페이징처리 한 예약메일함 목록 (검색 있든, 없든 모두 다 포함 // reservation_status = 1 인 글만 보여주기)
	List<MailVO> getReservationListWithPaging(Map<String, String> paraMap);

	// 페이징처리 한 예약메일함 목록 (검색 있든, 없든 모두 다 포함 // reservation_status = 1 인 글만 보여주기, 파라미터 없음)
	// 파라미터 없음 (스프링스케줄러)
	// (insert 된 예약메일함 글목록을 DB 에서 조회해온다. RESERVATION_STATUS 가 1인 것들만 조회) 
	// 예약 메일(email)을 발송할 회원이 누구인지 알아와야 한다. // (DB 에서 조회해온다. reservation_status 가 1인 것들만 조회) - paraMap 파라미터 없음 
	// 사용자가 발송예약 버튼을 누른 후 - 현재 예약메일함에 들어가 있는 것들(reservation_status = 1 && reservation_date 존재)
	List<MailVO> getReservationListWithPaging();

	// 예약 메일 1개 상세내용을 읽어오기
	MailVO getReservationMailView(Map<String, String> paraMap);

	// 첨부파일이 존재하는 경우 (filename 이 null 이 아님 ==> 존재한다는 것)
	// mail 테이블에서 reservation_status 를 1에서 다시 0으로 바꿔준다? --> 그럼 보낸메일함에서 보여질 테니까?
	// Insert 가 아닌 update 를 해주자.
	int add_withFile_updateResStatus(MailVO mailvo);

	// 첨부파일이 존재하지 않는 경우 (filename == null)
	// mail 테이블에서 reservation_status 를 1에서 다시 0으로 바꿔준다? --> 그럼 보낸메일함에서 보여질 테니까?
	// Insert 가 아닌 update 를 해주자.
	int add_updateResStatus(MailVO mailvo);

	// ==== 예약메일함 끝 ==== //



}
