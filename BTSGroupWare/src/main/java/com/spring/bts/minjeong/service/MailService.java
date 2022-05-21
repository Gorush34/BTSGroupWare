package com.spring.bts.minjeong.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.minjeong.model.InterMailDAO;
import com.spring.bts.minjeong.model.MailVO;

@Service
public class MailService implements InterMailService {
	// === 의존객체 주입하기(DI: Dependency Injection) ===
	// DAO 필드를 하나 만들도록 한다.
	@Autowired	// Spring Container BoardDAO 가 bean 으로 올라가도록 해준다. Type에 따라 알아서 Bean 을 주입해준다.
	private InterMailDAO dao;	// null 이 아니도록 바꿔준다. 
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO 의 bean 을  dao 에 주입시켜준다. 
    // 그러므로 dao 는 null 이 아니다.
	
	// 받은메일함 목록 보여주기
	@Override
	public List<MailVO> getReceiveMailList() {
		List<MailVO> receiveMailList = dao.getReceiveMailList();		
		return receiveMailList;
	}

	// 총 게시물 건수 구해오기 - 받은메일함 (service 단으로 보내기)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}
	
	// 페이징처리 한 받은 메일목록 (검색 있든, 없든 모두 다 포함)	
	@Override
	public List<MailVO> recMailListSearchWithPaging(Map<String, String> paraMap) {
		List<MailVO> receiveMailList = dao.recMailListSearchWithPaging(paraMap);
	//	System.out.println("확인용 서비스");
		return receiveMailList;		
	}

	// 총 게시물 건수 구해오기 - 보낸메일함 (service 단으로 보내기)
	@Override
	public int getTotalCount_send(Map<String, String> paraMap) {
		int n = dao.getTotalCount_send(paraMap);
		return n;
	}

	// 페이징처리 한 보낸 메일목록 (검색 있든, 없든 모두 다 포함)	
	@Override
	public List<MailVO> sendMailListSearchWithPaging(Map<String, String> paraMap) {
		List<MailVO> sendMailList = dao.sendMailListSearchWithPaging(paraMap);
		return sendMailList;
	}

	// 메일주소로 사원이름, 사원번호 알아오기
	@Override
	public Map<String, String> getEmpnameAndNum(String uq_email) {
		Map<String, String> empnameAndNum = dao.getEmpnameAndNum(uq_email);
		return empnameAndNum;
	}
	
	// 메일쓰기 (파일첨부가 없는 메일쓰기)
	@Override
	public int add(MailVO mailvo) {
		int n = dao.add(mailvo);
		return n;
		
	}

	// 메일쓰기 (파일첨부가 있는 메일쓰기)
	@Override
	public int add_withFile(MailVO mailvo) {
		int n = dao.add_withFile(mailvo);
		return n;
	}

	// 받은메일 1개 상세내용을 읽어오기
	@Override
	public MailVO getRecMailView(Map<String, String> paraMap) {
		MailVO mailvo = dao.getRecMailView(paraMap);		
		return mailvo;
	}

	// 보낸메일 1개 상세내용을 읽어오기
	@Override
	public MailVO getSendMailView(Map<String, String> paraMap) {
		MailVO mailvo = dao.getSendMailView(paraMap);		
		return mailvo;
	}

	// 받은 메일 테이블에서 해당 메일의 삭제 상태를 1로 변경해주기 (ajax)
	// 받은메일함에서 선택한 글번호에 해당하는 메일을 삭제 시, 메일 테이블에서 해당 메일번호의 삭제 상태를 1로 변경해주기
	@Override
	public int updateFromTblMailDelStatus(Map<String, String> paraMap) {
		int n = dao.updateFromTblMailDelStatus(paraMap);
		return n;
	}

	// 총 게시물 건수 구해오기 - 휴지통 (service 단으로 보내기)
	@Override
	public int getTotalCount_recyclebin(Map<String, String> paraMap) {
		int n = dao.getTotalCount_recyclebin(paraMap);
		return n;
	}

	 // 페이징처리 한 휴지통 목록 (검색 있든, 없든 모두 다 포함) 
	@Override
	public List<MailVO> RecyclebinMailListSearchWithPaging(Map<String, String> paraMap) {
		List<MailVO> recyclebinMailList = dao.RecyclebinMailListSearchWithPaging(paraMap);
		return recyclebinMailList;
	}

	// 휴지통 메일함 1개 상세내용을 읽어오기
	@Override
	public MailVO getRecyclebinMailView(Map<String, String> paraMap) {
		MailVO mailvo = dao.getRecyclebinMailView(paraMap);
		return mailvo;
	}

	// 휴지통에서 선택한 글들을 mail 테이블에서 삭제하기
	@Override
	public int deleteFromTblMail(Map<String, String> paraMap) {
		int n = dao.deleteFromTblMail(paraMap);
		return n;
	}

	// === 예약메일함 시작 === //

	// 총 게시물 건수 구해오기 - 예약메일함 (service 단으로 보내기)
	@Override
	public int getTotalCount_reservation(Map<String, String> paraMap) {
			int n = dao.getTotalCount_reservation(paraMap);
		return n;
	}

	// 페이징처리 한 예약메일함 목록 1 (검색 있든, 없든 모두 다 포함 // reservation_status = 1 인 글만 보여주기)
	@Override
	public List<MailVO> getReservationListWithPaging(Map<String, String> paraMap) {
		List<MailVO> reservationList = dao.getReservationListWithPaging(paraMap);
		return reservationList;
	}

	// 예약 메일 1개 상세내용을 읽어오기
	@Override
	public MailVO getReservationMailView(Map<String, String> paraMap) {
		MailVO mailvo = dao.getReservationMailView(paraMap);
		return mailvo;
	}

	
	// 스프링 스케줄러를 이용해서 발송예약 실행하기	  
	@Override	  
//	@Scheduled(cron = "0 * * * * *") 
	public void reservationMailSendSchedular() throws Exception { 
	  // ***주의*** 스케줄러로 사용되어지는 메소드는 반드시 파라미터는 없어야 한다.
	  
	  // === 현재 시각을 나타내기 ==== // 
	  Calendar currentDate = Calendar.getInstance(); //	  현재 날짜와 시간을 얻어온다. 
	  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 발송날짜에서 2022-05-26 21:40 형식으로 불러옴
	  String currentTime = dateFormat.format(currentDate.getTime());
	  
	//System.out.println("Mail 현재시각 : " + currentTime);

	  // 메일테이블에서 reservation_status = 1인 값들을 select 한 결과의 발송날짜(reservation_date)와 
	  // java에서 구한  currentTime 이 같다면 메일테이블에 insert 한다. (년-월-일 시:분)
	  
	  // 페이징처리 한 예약메일함 목록 2 (검색 있든, 없든 모두 다 포함 // reservation_status = 1 인 글만 보여주기)
	  // 예약 메일(email)을 발송할 회원이 누구인지 알아와야 한다. // (DB 에서 조회해온다. reservation_status 가 1인 것들만 조회) - paraMap 파라미터 없음 
	  // 사용자가 발송예약 버튼을 누른 후 - 현재 예약메일함에 들어가 있는 것들(reservation_status = 1 && reservation_date 존재)
	  // view 단에 보여주는 것 X, 스프링 스케줄러에서 읽어올 용도로 가져옴
	  // 이미 들어가있는 data 읽어오는 것이므로 파라미터 X
	  List<MailVO> reservationList = dao.getReservationListWithPaging();
	  
	  // 메일테이블에 발송예약할 메일 insert 성공 후 RESERVATION_STATUS 가 1인 것들만 조회 
	/*  
	  for(MailVO mailvo : reservationList) { 
		  
		    System.out.println("메일 번호 : " + mailvo.getPk_mail_num()); 
	  		System.out.println("보낸 사원 번호 : " +	mailvo.getFk_senduser_num()); 
	  		System.out.println("받는 사원 번호 : " +	mailvo.getFk_receiveuser_num()); 
	  		System.out.println("보낸 사원명 : " + mailvo.getSendempname()); 
	  		System.out.println("받는 사원명 : " + mailvo.getRecempname()); 
	  		System.out.println("사용자가 선택한 발송예약 날짜 : " + mailvo.getReservation_date()); 
	  		System.out.println("제목 : " + mailvo.getSubject()); 
	  		System.out.println("날짜 : " + mailvo.getReg_date()); 
	  }
	 */ 
	  
	  /* 아래와 같이 for 반복문으로 select 결과값들이 출력된다. [ 한 행 ]
	   * 해당 글번호를 발송예약 날짜에 따라 발송되도록 한다.
			Mail 현재시각 : 2022-05-12 21:37 ( currentTime )
			메일 번호 : 73
			보낸 사원 번호 : 80000010
			받는 사원 번호 : 80000011
			보낸 사원명 : 김민정
			받는 사원명 : 김사장
			사용자가 선택한 발송예약 날짜 : 2022-05-12 21:40 ( reservation_date )
			제목 : 예약메일함 테스트 1 console 창 출력
			날짜 : 2022-05-12 21:37:41	
	   */
	  
	  
	  int n = 0;
	  // ** 사내 이메일 발송하기 ** // 메일 발송을 위해서는 예약한 회원들의 목록이 존재해야 하고, null 이 아니어야 한다.
	  if(reservationList != null && reservationList.size() > 0) { 
		  // reservationList 의 값 (예약발송함에 담긴 목록들) 의 값이 null 아니면서 && 0 보다 커야한다.
		  
		  for(int i=0; i<reservationList.size(); i++) {
			  
			  	/*
			  	 	Mail 현재시각 : 2022-05-12 22:20
					if문 실행 실패 ㅠㅠㅠㅠ
					if 문 확인 테스트
					if 문 발송예약시간 test2022-05-12 22:20
					if 문 컴퓨터 현재시간2022-05-12 22:20
			  	 */
			  
			  if( reservationList.get(i).getReservation_date().equals(dateFormat.format(currentDate.getTime())) ) {
				  // 발송예약함의 한 행 한행의 발송예약날짜가 dateFormat 인 "yyyy-MM-dd HH:mm"과 형식이 같고 == 현재 컴퓨터의 날짜와 시간이 같다면
				  // DB 에 있는 사용자가 선택한 예약날짜와 현재 컴퓨터에 찍히는 currentTime이 같다면!!
			//	  System.out.println("if 문 확인 테스트");
			//	  System.out.println("if 문 발송예약시간 test" + reservationList.get(i).getReservation_date());
			//	  System.out.println("if 문 컴퓨터 현재시간" + dateFormat.format(currentDate.getTime()));
				  
				  // 해당 정보들을 mailvo 에 set 해주도록 하자.
				  MailVO mailvo = new MailVO();
				  
				  // for문을 통해 나온 한 행 한행의 결과값들이 담겨있는 reservationList 에서 가져온 데이터들을 mailvo 에 set 한다.
				  // 한 행 한 행 (get(i)) 의 컬럼값들을 vo 에 set 해준다.
				  mailvo.setPk_mail_num( reservationList.get(i).getPk_mail_num() );
				  mailvo.setFk_senduser_num(reservationList.get(i).getFk_senduser_num());
				  mailvo.setFk_receiveuser_num(reservationList.get(i).getFk_receiveuser_num());
				  mailvo.setRecemail(reservationList.get(i).getRecemail());
				  mailvo.setSendemail(reservationList.get(i).getSendemail());
				  mailvo.setRecemail(reservationList.get(i).getRecemail());
				  mailvo.setSendempname(reservationList.get(i).getSendempname());
				  mailvo.setSubject(reservationList.get(i).getSubject());
				  mailvo.setContent(reservationList.get(i).getContent());
				  mailvo.setFilename(reservationList.get(i).getFilename());
				  mailvo.setOrgfilename(reservationList.get(i).getOrgfilename());
				  mailvo.setFilesize(reservationList.get(i).getFilesize());
				  mailvo.setReg_date(reservationList.get(i).getReg_date());
				  mailvo.setImportance(reservationList.get(i).getImportance_star_send());
				  mailvo.setImportance(reservationList.get(i).getImportance_star_rec());
				  mailvo.setRead_status(reservationList.get(i).getRead_status());
				  mailvo.setReservation_date(reservationList.get(i).getReservation_date());
				  mailvo.setReservation_status(reservationList.get(i).getReservation_status());
				  mailvo.setDel_status(reservationList.get(i).getDel_status());
				  
				  // 작성일자는 사용자가 설정한 발송예약일자로 설정하도록 한다. (발송예약시간)
				  //mailvo 에 set 해둔 내용을 발송예약시간에 따라 메일을 발송하고 status 를 update 할 수 있도록 한다.
				  // 첨부파일이 있는경우와 없는 경우로 나눈다.
				  
				  // 첨부파일이 존재하는 경우 (filename 이 null 이 아님 ==> 존재한다는 것)
				  // mail 테이블에서 reservation_status 를 1에서 다시 0으로 바꿔준다.
				  // Insert 가 아닌 update 를 해주자.
				  if(reservationList.get(i).getFilename() != null) {
					 n = dao.add_updateResStatus(mailvo);
				  }
				  else {
					// 첨부파일이 존재하지 않는 경우 (filename == null)
					// mail 테이블에서 reservation_status 를 1에서 다시 0으로 바꿔준다.
					// Insert 가 아닌 update 를 해주자.
					 n = dao.add_updateResStatus(mailvo);
				}
			  }// end of if()--------------------------------
			  else {
			//	System.out.println("if문 실행 실패 !!!!!");
			  }
			  
		  }// end of for()---------------------------------------------
		  		  
		  	if(n==1) {
		  		// 예약 발송 성공
		  		System.out.println("****** 발송예약에 성공했습니다. ******");
		  	}
		  	else {
				// 예약 발송 실패
		  	//	System.out.println("****** 발송예약에 실패했습니다. ******");
			}		  
		  
	  }// end of if(reservationList != null && reservationList.size() > 0)---------------------------------------------------
	  
	}// end of public void reservationMailSendSchedular() throws Exception-----------------

	// === 예약메일함 끝 === //

	// === 임시보관함 시작 === //
	// 총 임시보관함 메일 건수 구해오기 (service 단으로 보내기) 
	@Override
	public int getTotalCount_temporary(Map<String, String> paraMap) {
		int n = dao.getTotalCount_temporary(paraMap);		
		return n;
	}
	
	// 페이징처리 한 임시보관함 메일목록 (검색 있든, 없든 모두 다 포함) 
	@Override
	public List<MailVO> getTemporaryMailListWithPaging(Map<String, String> paraMap) {
		List<MailVO> TemporaryMailList = dao.getTemporaryMailListWithPaging(paraMap);
		return TemporaryMailList;
	}


	// 임시보관함 내용 읽기 페이지 요청 (메일쓰기 양식)
	@Override
	public MailVO getTemporaryMailView(Map<String, String> paraMap) {
		MailVO getTemporaryMailView = dao.getTemporaryMailView(paraMap);
		return getTemporaryMailView;
	}


	// 임시보관함에서 제목 클릭했을 때 넘어왔을 경우 받아온 글번호인 pk_mail_num 를 delete
	@Override
	public int deleteFromTbltemp(Map<String, String> paraMap) {
		int n = dao.deleteFromTbltemp(paraMap);
		return n;
	}

	
	// === 임시보관함 끝 === //

	
	// 총 중요 메일 건수 구해오기
	@Override
	public int getTotalCount_important(Map<String, String> paraMap) {
		int n = dao.getTotalCount_important(paraMap);
		return n;
	}

	// 페이징처리 한 중요메일함 목록 (검색 있든, 없든 모두 다 포함) 
	@Override
	public List<MailVO> ImportantMailListSearchWithPaging(Map<String, String> paraMap) {
		List<MailVO> ImportantMailList = dao.ImportantMailListSearchWithPaging(paraMap);
		return ImportantMailList;
	}

	// 중요 메일 1개 상세내용을 읽어오기
	@Override
	public MailVO getImportantMailView(Map<String, String> paraMap) {
		MailVO ImportantMailView = dao.getImportantMailView(paraMap);
		return ImportantMailView;
	}

	// pk_mail_num 를 통해서 temp_status 조회해오기
	@Override
	public Map<String, String> getTempStatus(String pk_mail_num) {
		Map<String, String> getTempStatus = dao.getTempStatus(pk_mail_num);
		return getTempStatus;
	}


	// updateImportance_star_rec Update 를 통해 값을 0,1로 변경해주기
	@Override
	public int updateImportance_star_rec(Map<String, String> paraMap) {
		int n = dao.updateImportance_star_rec(paraMap);
		return n;
	}

	// updateImportance_star_send Update 를 통해 값을 0,1로 변경해주기
	@Override
	public int updateImportance_star_send(Map<String, String> paraMap) {
		int n = dao.updateImportance_star_send(paraMap);
		return n;
	}

   // 메일 1개 상세내용을 읽어오기 (메일 전달 및 답장을 위함 - 검색타입과 검색명 없음)
   @Override
   public MailVO getRecMailView_noSearch(Map<String, String> paraMap) {
      MailVO recMailView_noSearch = dao.getRecMailView_noSearch(paraMap);
      return recMailView_noSearch;
   }

   // 각 메일함 상세보기에서 삭제버튼 클릭 (글 1개)시 해당 글번호 글 휴지통으로 이동하기 (del_status = 1)
   @Override
   public int updateTblMailDelStatus_one(Map<String, String> paraMap) {
      int n = dao.updateTblMailDelStatus_one(paraMap);
      return n;
   }

   // 총 내게 쓴 메일 건수 구해오기
   @Override
   public int getTotalCount_sendToMe(Map<String, String> paraMap) {
      int n = dao.getTotalCount_sendToMe(paraMap);
      return n;
   }

   // 페이징처리 한 내게쓴 메일목록 (검색 있든, 없든 모두 다 포함) 
   @Override
   public List<MailVO> sendToMeListSearchWithPaging(Map<String, String> paraMap) {
      List<MailVO> sendToMeList = dao.sendToMeListSearchWithPaging(paraMap);
      return sendToMeList;
   }

   // 내게쓴 메일 1개 상세내용을 읽어오기 (service 로 보낸다.)
   @Override
   public MailVO getSendToMeMailView(Map<String, String> paraMap) {
      MailVO mailvo = dao.getSendToMeMailView(paraMap);      
      return mailvo;
   }

   
	// 메인페이지에서 로그인한 사용자의 받은메일함 목록 보여주기
	@Override
	public List<Map<String, String>> mailReceive_main(String fk_receiveuser_num) {
		List<Map<String, String>> mailReceive_main = dao.mailReceive_main(fk_receiveuser_num);
		return mailReceive_main;
	}

	// 받은 메일 1개 클릭 시 rec_status 업데이트 (받은메일함에서 읽음 표시하기 위함)
	@Override
	public int updateRec_status(Map<String, String> paraMap) {
		int updateRec_status = dao.updateRec_status(paraMap);
		return updateRec_status;
	}

	// 보낸 메일 1개 클릭 시 send_status 업데이트 (보낸메일함에서 읽음 표시하기 위함)
	@Override
	public int updateSend_status(Map<String, String> paraMap) {
		int updateSend_status = dao.updateSend_status(paraMap);
		return updateSend_status;
	}

	// 받은 메일 1개 클릭 시 imp_status 업데이트 (중요메일함에서 읽음 표시하기 위함)
	@Override
	public int updateImp_status(Map<String, String> paraMap) {
		int updateImp_status = dao.updateImp_status(paraMap);
		return updateImp_status;
	}

	// 글씀과 동시에 tbl_mailRead 테이블에 해당 글번호의 값을 insert 시켜준다.
	@Override
	public int addToMailRead(String fk_mail_num) {
		int n = dao.addToMailRead(fk_mail_num);
		return n;
	}

	// 메일 글쓰기 pk_mail_num 가져오기 (글쓰기 다음 번호, 읽음처리 테이블 fk_mail_num 에 넣기 위함) -->
	@Override
	public String getPkMailNum(MailVO mailvo) {
		String getPkMailNum = dao.getPkMailNum(mailvo);
		return getPkMailNum;
	}

	 // 페이징처리 한 보낸메일 수신확인 메일목록 (검색 있든, 없든 모두 다 포함) 
	@Override
	public List<MailVO> sendMailListSearchWithPaging_recCheck(Map<String, String> paraMap) {
		List<MailVO> sendMailList_recCheck = dao.sendMailList_recCheck(paraMap);
		return sendMailList_recCheck;
	}

	// 총 보낸 메일 수신확인 건수 구해오기 (service 단으로 보내기) 
	@Override
	public int getTotalCount_recCheck(Map<String, String> paraMap) {
		int n = dao.getTotalCount_recCheck(paraMap);
		return n;
	}

	// 상세부서정보 페이지 사원목록 불러오기 
	@Override
	public List<EmployeeVO> addBook_depInfo_select() {
		List<EmployeeVO> empList = dao.addBook_depInfo_select();
		return empList;
	}

	// 로그인한 사용자의 안읽은 메일갯수 가져오기 (rec_status=0)	
	@Override
	public int recMailCount_main(String fk_receiveuser_num) {
		int n = dao.recMailCount_main(fk_receiveuser_num);
		return n;
	}

	// === 검색어 입력 시 자동글 완성하기 4 ===
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordSearchShow = dao.wordSearchShow(paraMap);
		return wordSearchShow;
	}

	
}
