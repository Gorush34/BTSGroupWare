package com.spring.bts.jieun.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.bts.hwanmo.model.EmployeeVO;

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

	// === 캘린더 소분류 수정하기 === //
	@Override
	public int editCalendar(Map<String, String> paraMap) {
		int n = sqlsession.update("jieun.editCalendar", paraMap);
		return n;
	}
			// 캘린더에 이름이 있는지 확인
			@Override
			public int existsCalendar(Map<String, String> paraMap) {
				int m = sqlsession.selectOne("jieun.existsCalendar", paraMap);
				return m;
			}

	// === 캘린더 소분류 삭제하기 === //
	@Override
	public int deleteCalendar(String pk_calno) {
		int n = sqlsession.delete("jieun.deleteCalendar", pk_calno);
		return n;
	}

	// === 서브 캘린더 가져오기 === //
	@Override
	public List<CalendarVO> selectCalNo(Map<String, String> paraMap) {
		List<CalendarVO> calendarvoList = sqlsession.selectList("jieun.selectCalNo", paraMap);
		return calendarvoList;
	}
	
	// === 참석자 추가하기 : 사원 명단 불러오기 === //
	@Override
	public List<EmployeeVO> searchJoinUser(String joinUserName) {
		List<EmployeeVO> joinUserList = sqlsession.selectList("jieun.searchJoinUser", joinUserName);
		return joinUserList;
	}
	
	// === 일정 등록 하기 === //
	@Override
	public int scheduleRegisterInsert(Map<String, String> paraMap) {
		int n = sqlsession.insert("jieun.scheduleRegisterInsert", paraMap);
		return n;
	}
	
	
	// === 일정 보여주기 === //
	@Override
	public List<ScheduleVO> selectSchedule(String fk_emp_no) {
		List<ScheduleVO> scheduleList = sqlsession.selectList("jieun.selectSchedule", fk_emp_no);
		return scheduleList;
	}
	
	// === 일정 상세 페이지 === //
	@Override
	public Map<String, String> detailSchedule(String pk_schno) {
		Map<String, String> map = sqlsession.selectOne("jieun.detailSchedule", pk_schno);
		return map;
	}
	
	// === 일정 삭제 하기 === //
	@Override
	public int deleteSchedule(String pk_schno) {
		int n = sqlsession.delete("jieun.deleteSchedule", pk_schno);
		return n;
	}
	
	// == 일정 수정하기 == //
	@Override
	public int editSchedule_end(ScheduleVO svo) {
		int n = sqlsession.update("jieun.editSchedule_end", svo);
		return n;
	}
	
	
	
	

	
	
	
}
