package com.spring.bts.jieun.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.jieun.model.InterCalendarDAO;


//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class CalendarService implements InterCalendarService {
	
	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private InterCalendarDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO 의 bean 을  dao 에 주입시켜준다. 
    // 그러므로 dao 는 null 이 아니다.
	
	// ======== ***** 파이널 옮기기 시작 ***** ======== //
	/*	// === 일정 체크 박스 추가 === //
		@Override
		public int addCalenderName(CalenderVO calendervo) {
			int n = dao.addCalenderName(calendervo);
			return n;
		}
	*/
}
