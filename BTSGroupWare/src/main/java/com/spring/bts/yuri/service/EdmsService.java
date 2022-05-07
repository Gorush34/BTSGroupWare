package com.spring.bts.yuri.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.yuri.model.ApprVO;
import com.spring.bts.yuri.model.InterEdmsDAO;

// === Service 선언 === //
// 트랜잭션 처리를 담당하는 곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
/* 자동적으로 @Component 가 올라와 있다! */

public class EdmsService implements InterEdmsService {

	// === 의존객체 주입하기(DI: Dependency Injection) === //
	@Autowired /* 인터페이스인데 인터페이스를 구현한 클래스 BoardDAO를 찾아서 여기에 끼워넣어준다. 한 마디로 객체를 new 해준 것 */
	// Type에 따라 알아서 Bean을 주입해준다. 의존객체주입
	// DAO 필드가 필요하다
	private InterEdmsDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO 의 bean 을  dao 에 주입시켜준다. 
    // 그러므로 dao 는 null 이 아니다.
	
	
	// === 로그인된 사원 정보 가져오기 === //
	@Override
	public EmployeeVO getLoginMember(Map<String, String> paraMap) {
		
		EmployeeVO loginuser = dao.getLoginMember(paraMap);
		
		// 로그인하지 않은 경우? => AOP에서 이미 처리?
 		
		return loginuser;
	}	
	
	// === 파일첨부가 없는 전자결재 문서작성 === //
	@Override
	public int edmsAdd(ApprVO apprvo) {
		int n = dao.add(apprvo);
		return n;
	}




}