package com.spring.bts.minjeong.service;

import java.util.List;
import java.util.Map;

import com.spring.bts.hwanmo.model.EmployeeVO;
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
	List<Map<String, String>> mailReceive_main(String fk_receiveuser_num);

	// 받은 메일 1개 클릭 시 rec_status 업데이트 (받은메일함에서 읽음 표시하기 위함)
	int updateRec_status(Map<String, String> paraMap);

	// 보낸 메일 1개 클릭 시 send_status 업데이트 (보낸메일함에서 읽음 표시하기 위함)
	int updateSend_status(Map<String, String> paraMap);

	// 받은 메일 1개 클릭 시 imp_status 업데이트 (중요메일함에서 읽음 표시하기 위함)
	int updateImp_status(Map<String, String> paraMap);

	// 글씀과 동시에 tbl_mailRead 테이블에 해당 글번호의 값을 insert 시켜준다.
	int addToMailRead(String fk_mail_num);
 
	// 메일 글쓰기 pk_mail_num 가져오기 (글쓰기 다음 번호, 읽음처리 테이블 fk_mail_num 에 넣기 위함) -->
	String getPkMailNum(MailVO mailvo);

	// 페이징처리 한 보낸메일 수신확인 메일목록 (검색 있든, 없든 모두 다 포함) 
	List<MailVO> sendMailListSearchWithPaging_recCheck(Map<String, String> paraMap);

	// 총 보낸 메일 수신확인 건수 구해오기 (service 단으로 보내기) 
	int getTotalCount_recCheck(Map<String, String> paraMap);

	// 상세부서정보 페이지 사원목록 불러오기 
	List<EmployeeVO> addBook_depInfo_select();

	// 로그인한 사용자의 안읽은 메일갯수 가져오기 (rec_status=0)	
	int recMailCount_main(String fk_receiveuser_num);

	// 임시보관함 내용 읽기 페이지 요청 (메일쓰기 양식) (이전에 썼던 내용들을 갖고온다.)
	MailVO getTemporaryMailView(Map<String, String> paraMap);

	// === 검색어 입력 시 자동글 완성하기 3 ===
	List<String> wordSearchShow(Map<String, String> paraMap);

	
}
