package com.spring.bts.hwanmo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.common.AES256;
import com.spring.bts.hwanmo.model.CommuteVO;
import com.spring.bts.hwanmo.model.InterAttendanceDAO;

//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class AttendanceService implements InterAttendanceService {

	@Autowired
	private InterAttendanceDAO attDAO;
	
	// === #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private AES256 aes;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.common.AES256 의 bean 을  aes 에 주입시켜준다. 
	// 그러므로 aes 는 null 이 아니다.
	// com.spring.board.common.AES256 의 bean 은 /webapp/WEB-INF/spring/appServlet/servlet-context.xml 파일에서 bean 으로 등록시켜주었음.
		
	
	// 가입과 동시에 연차테이블 등록하기
	@Override
	public int registerLeave(int pk_emp_no) {
		int m = attDAO.registerLeave(pk_emp_no);
		return m;
	}

	// 오늘 출퇴근기록 조회
	@Override
	public int getTodayCommute(Map<String, String> paraMap) {
		int isExist = attDAO.getTodayCommute(paraMap);
		return isExist;
	}

	// 날짜, 출근시간 입력한 테이블 insert
	@Override
	public int insertTodayCommute(Map<String, String> paraMap) {
		int n = attDAO.insertTodayCommute(paraMap);
		return n;
	}

	// 출퇴근시간 알아오기
	@Override
	public Map<String, String> getTodayworkInOutTime(Map<String, String> paraMap) {
		Map<String, String> workInOut = attDAO.getTodayworkInOutTime(paraMap);
		return workInOut;
	}

	// 퇴근시간 및 하루 근무시간 update하기
	@Override
	public int updateTodayOutTime(Map<String, String> paraMap) {
		int n = attDAO.updateTodayOutTime(paraMap);
		return n;
	}

	// 00시가 되면 출퇴근 초기화하기
	@Override
	public int checkTomorrow(Map<String, String> paraMap) {
		int n = attDAO.checkTomorrow(paraMap);
		return n;
	}

	// 한 사원에 대한 출퇴근기록 가져오기
	@Override
	public List<CommuteVO> getMyCommute(int pk_emp_no) {
		List<CommuteVO> cmtList = attDAO.getMyCommute(pk_emp_no);
		return cmtList;
	}


}
