package com.spring.bts.minjeong.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository	// @component 가 포함되어 있는 것이다. 자동적으로 bean 으로 올라간다.
public class MailDAO implements InterMailDAO {

	// === #33. 의존객체 주입하기(DI: Dependency Injection) ===
	   // >>> 의존 객체 자동 주입(Automatic Dependency Injection)은
	   //     스프링 컨테이너가 자동적으로 의존 대상 객체를 찾아서 해당 객체에 필요한 의존객체를 주입하는 것을 말한다. 
	   //     단, 의존객체는 스프링 컨테이너속에 bean 으로 등록되어 있어야 한다. 

	   //     의존 객체 자동 주입(Automatic Dependency Injection)방법 3가지 
	   //     1. @Autowired ==> Spring Framework에서 지원하는 어노테이션이다. 
	   //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
	   
	   //     2. @Resource  ==> Java 에서 지원하는 어노테이션이다. (JDK)
	   //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 필드명(이름)을 찾아서 연결(의존객체주입)한다.
	   
	   //     3. @Inject    ==> Java 에서 지원하는 어노테이션이다. (JDK) @Autowired 와 기능은 똑같지만 JAVA 인 JDK 에 속해있다.
	   //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.   
		
	/*
		// 이제 DAO 에서 Spring 은 Connection 을 얻어올 필요가 없다.
		// root-context.xml 파일을 참조한다.
		@Autowired	// bean 에 올라간것 중 SqlSessionTemplate 에 들어간 것을 넣어준다.
		private SqlSessionTemplate abc;		// @Autowired 로 인해 abc 는 null 이 아니게됨. abc 는  myBatis로  DB 이다.
											// SqlSessionTemplate : DBCP 연결 , abc 에는 sqlsession 이 들어와 있는 것이다.
		// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  abc 에 주입시켜준다. 
	    // 그러므로 abc 는 null 이 아니다.
	*/
	
	@Resource
	private SqlSessionTemplate sqlsession;
	// Type 에 따라 Spring 컨테이너가 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의  sqlsession bean 을  sqlsession 에 주입시켜준다. 
    // 그러므로 sqlsession 는 null 이 아니다.
	
	@Override
	public List<MailVO> getReceiveMailList() {
		List<MailVO> receiveMailList = sqlsession.selectList("minjeong.getReceiveMailList");
		return receiveMailList;
	}

	// 총 받은메일 개수 구해오기
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("minjeong.getTotalCount", paraMap);
		return n;
	}
	
	// 페이징처리 한 받은 메일목록 (검색 있든, 없든 모두 다 포함)
	@Override
	public List<MailVO> recMailListSearchWithPaging(Map<String, String> paraMap) {
		List<MailVO> receiveMailList = sqlsession.selectList("minjeong.recMailListSearchWithPaging", paraMap);
		//	System.out.println("확인용 dao");		
		return receiveMailList;
	}

	// 총 보낸메일 개수 구해오기
	@Override
	public int getTotalCount_send(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("minjeong.getTotalCount_send", paraMap);
		return n;
	}

	// 페이징처리 한 보낸 메일목록 (검색 있든, 없든 모두 다 포함)
	@Override
	public List<MailVO> sendMailListSearchWithPaging(Map<String, String> paraMap) {
		List<MailVO> sendMailList = sqlsession.selectList("minjeong.sendMailListSearchWithPaging", paraMap);
		return sendMailList;
	}

	// 메일주소로 사원이름, 사원번호 알아오기 (메일쓰기 받는사람 입력)
	@Override
	public Map<String, String> getEmpnameAndNum(String uq_email) {
		Map<String, String> recEmpnameAndNum = sqlsession.selectOne("minjeong.getEmpnameAndNum", uq_email);
		return recEmpnameAndNum;
	}
	
	// 메일쓰기 (파일첨부가 없는 메일쓰기)
	@Override
	public int add(MailVO mailvo) {
		int n = sqlsession.insert("minjeong.add", mailvo);
		return n;
	}

	// 메일쓰기 (파일첨부가 있는 메일쓰기)
	@Override
	public int add_withFile(MailVO mailvo) {
		int n = sqlsession.insert("minjeong.add_withFile", mailvo);
		return n;
	}

	// 보낸 메일 1개 상세내용을 읽어오기
	@Override
	public MailVO getRecMailView(Map<String, String> paraMap) {
		MailVO mailvo = sqlsession.selectOne("minjeong.getRecMailView", paraMap);
		return mailvo;
	}

	// 받은 메일 1개 상세내용을 읽어오기
	@Override
	public MailVO getSendMailView(Map<String, String> paraMap) {
		MailVO mailvo = sqlsession.selectOne("minjeong.getSendMailView", paraMap);
		return mailvo;
	}

	// 받은메일함에서 선택한 글번호에 해당하는 메일을 삭제 시, 메일 테이블에서 해당 메일번호의 삭제 상태를 1로 변경해주기
	@Override
	public int updateFromTblMailDelStatus(Map<String, String> paraMap) {
		int n = sqlsession.update("minjeong.updateFromTblMailDelStatus", paraMap);
		return n;
	}

	// 총 게시물 건수 구해오기 - 휴지통 (service 단으로 보내기)
	@Override
	public int getTotalCount_recyclebin(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("minjeong.getTotalCount_recyclebin", paraMap);
		return n;
	}
	
	 // 페이징처리 한 휴지통 목록 (검색 있든, 없든 모두 다 포함) 
	@Override
	public List<MailVO> RecyclebinMailListSearchWithPaging(Map<String, String> paraMap) {
		List<MailVO> recyclebinMailList = sqlsession.selectList("minjeong.RecyclebinMailListSearchWithPaging", paraMap);
		return recyclebinMailList;
	}

	// 휴지통 메일함 1개 상세내용을 읽어오기
	@Override
	public MailVO getRecyclebinMailView(Map<String, String> paraMap) {
		MailVO mailvo = sqlsession.selectOne("minjeong.getRecyclebinMailView", paraMap);
		return mailvo;
	}

	// 휴지통에서 선택한 글들을 mail 테이블에서 삭제하기
	@Override
	public int deleteFromTblMail(Map<String, String> paraMap) {
		int n = sqlsession.delete("minjeong.deleteFromTblMail", paraMap);
		return n;
	}

	// ==== 예약메일함 시작 ==== //
	// 총 게시물 건수 구해오기 - 예약메일함 (service 단으로 보내기)
	@Override
	public int getTotalCount_reservation(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("minjeong.getTotalCount_reservation", paraMap);
		return n;
	}

	// 페이징처리 한 예약메일함 목록 (검색 있든, 없든 모두 다 포함 // reservation_status = 1 인 글만 보여주기)
	@Override
	public List<MailVO> getReservationListWithPaging(Map<String, String> paraMap) {
		List<MailVO> reservationList = sqlsession.selectList("minjeong.getReservationListWithPaging", paraMap);
		return reservationList;
	}

	// 페이징처리 한 예약메일함 목록 (검색 있든, 없든 모두 다 포함 // reservation_status = 1 인 글만 보여주기 
	// 파라미터 없음 (스프링스케줄러)
	@Override
	public List<MailVO> getReservationListWithPaging() {

		return null;
	}
	// ==== 예약메일함 끝 ==== //



}
