package com.spring.bts.hwanmo.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AttendanceDAO implements InterAttendanceDAO {

	// === #33. 의존객체 주입하기(DI: Dependency Injection) ===
	   // >>> 의존 객체 자동 주입(Automatic Dependency Injection)은
	   //     스프링 컨테이너가 자동적으로 의존 대상 객체를 찾아서 해당 객체에 필요한 의존객체를 주입하는 것을 말한다. 
	   //     단, 의존객체는 스프링 컨테이너속에 bean 으로 등록되어 있어야 한다. 

	   //     의존 객체 자동 주입(Automatic Dependency Injection)방법 3가지 
	   //     1. @Autowired ==> Spring Framework에서 지원하는 어노테이션이다. 
	   //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
	   
	   //     2. @Resource  ==> Java 에서 지원하는 어노테이션이다.
	   //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 필드명(이름)을 찾아서 연결(의존객체주입)한다.
	   
	   //     3. @Inject    ==> Java 에서 지원하는 어노테이션이다.
	    //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.   

	@Autowired
	private SqlSessionTemplate sqlsession;
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  sqlsession 에 주입시켜준다. 
	// 그러므로 sqlsession 는 null 이 아니다. 이름 맘대로해도됨

	// 가입과 동시에 연차테이블 등록하기
	@Override
	public int registerLeave(int pk_emp_no) {
		int m = sqlsession.insert("hwanmo.registerLeave", pk_emp_no);
		return m;
	}

	// 오늘 출퇴근기록 조회
	@Override
	public int getTodayCommute(Map<String, String> paraMap) {
		int isExist = sqlsession.selectOne("hwanmo.getTodayCommute", paraMap);
		return isExist;
	}

	// 날짜, 출근시간 입력한 테이블 insert
	@Override
	public int insertTodayCommute(Map<String, String> paraMap) {
		int n = sqlsession.insert("hwanmo.insertTodayCommute", paraMap);
		return n;
	}

	// 출퇴근시간 알아오기
	@Override
	public Map<String, String> getTodayworkInOutTime(Map<String, String> paraMap) {
		Map<String, String> workInOut = sqlsession.selectOne("hwanmo.getTodayworkInOutTime", paraMap);
		return workInOut;
	}

	// 퇴근시간 및 하루 근무시간 update하기
	@Override
	public int updateTodayOutTime(Map<String, String> paraMap) {
		int n = sqlsession.update("hwanmo.updateTodayOutTime", paraMap);
		return n;
	}

	// 00시가 되면 출퇴근 초기화하기
	@Override
	public int checkTomorrow(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("hwanmo.checkTomorrow", paraMap);
		return n;
	}


	// 총 출퇴근 건수 알아오기
	@Override
	public int getTotalCommuteCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("hwanmo.getTotalCommuteCount", paraMap);
		return n;
	}

	
	// 페이징처리가 있는 한 사원에 대한 출퇴근기록 가져오기
	@Override
	public List<CommuteVO> getMyCommute(Map<String, String> paraMap) {
		List<CommuteVO> cmtlist = sqlsession.selectList("hwanmo.getMyCommute", paraMap);
		return cmtlist;
	}
	
	
}
