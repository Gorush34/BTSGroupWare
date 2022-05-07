package com.spring.bts.jieun.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

//=== #32. DAO 선언 === 
@Repository
public class CalendarDAO implements InterCalendarDAO {
	
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
	
	
	@Resource
	private SqlSessionTemplate sqlsession; // 로컬DB mymvc_user 에 연결
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의  sqlsession bean 을  sqlsession 에 주입시켜준다. 
    // 그러므로 sqlsession 는 null 이 아니다.

	// === 일정 등록 하기 === //
	@Override
	public int scheduleRegisterInsert(Map<String, String> paraMap) {
		int n = sqlsession.insert("jieun.scheduleRegisterInsert", paraMap);
		return n;
	}

	// === 서브 캘린더 가져오기 === //
	@Override
	public List<CalendarVO> selectCalNo(Map<String, String> paraMap) {
		List<CalendarVO> calendarvoList = sqlsession.selectList("jieun.selectCalNo", paraMap);
		return calendarvoList;
	}

	// === 사내 캘린더에 사내 캘린더 소분류 추가하기 === //
	@Override
	public int addComCalendar(Map<String, String> paraMap) {
		int n = sqlsession.insert("jieun.addComCalendar", paraMap);
		return n;
	}
		// 사내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
		@Override
		public int existComCalendar(String addCom_calname) {
			int m = sqlsession.selectOne("jieun.existComCalendar", addCom_calname);
			return m;
		}
		

	// === 사내 캘린더에 사내 캘린더 소분류 보여주기 === //
	@Override
	public List<CalendarVO> showCompanyCalendar() {
		List<CalendarVO> companyCalList = sqlsession.selectList("jieun.showCompanyCalendar");
		return companyCalList;
	}

	// === 내 캘린더에 내 캘린더 소분류 추가하기 === //
	@Override
	public int addMyCalendar(Map<String, String> paraMap) {
		int n = sqlsession.insert("jieun.addMyCalendar", paraMap);
		return n;
	}
			// 내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
			@Override
			public int existMyCalendar(String addMy_calname) {
				int n = sqlsession.selectOne("jieun.existMyCalendar", addMy_calname);
				return n;
			}

	// === 내 캘린더에 내 캘린더 소분류 보여주기 === //
	@Override
	public List<CalendarVO> showMyCalendar(String fk_emp_no) {
		List<CalendarVO> myCalList = sqlsession.selectList("jieun.showMyCalendar", fk_emp_no);
		return myCalList;
	}

	

	
	

	
	
	
}
