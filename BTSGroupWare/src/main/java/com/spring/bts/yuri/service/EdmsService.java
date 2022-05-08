package com.spring.bts.yuri.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.yuri.model.ApprVO;
import com.spring.bts.yuri.model.InterEdmsDAO;

// === Service 선언 === //
// 트랜잭션 처리를 담당하는 곳 , 업무를 처리하는 곳, 비지니스(Business)단
/* 자동적으로 @Component 가 올라와 있다! */
@Service
public class EdmsService implements InterEdmsService {

	// === 의존객체 주입하기(DI: Dependency Injection) === //
	@Autowired
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
		int n = dao.edmsAdd(apprvo);
		return n;
	}
	
	// === 전자결재 양식선택(업무기안서, 휴가신청서 등..)을 위한 것 === //
/*
	@Override
	public List<String> getApprsortList() {
		List<String> apprsortList = dao.getApprsortList();
		return apprsortList;
	}
*/
	







}