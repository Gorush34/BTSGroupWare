package com.spring.bts.minjeong.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	// 받은메일 1개 상세내용을 읽어오기
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


	
}
