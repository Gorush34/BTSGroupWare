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
	private SqlSessionTemplate sqlsession; 


	// === 사내 캘린더에 사내 캘린더 소분류 추가하기 === //
	@Override
	public int addComCalendar(Map<String, String> paraMap) {
		int n = sqlsession.insert("jieun.addComCalendar", paraMap);
		return n;
	}
		// 사내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
		@Override
		public int existComCalendar(Map<String, String> map) {
			int m = sqlsession.selectOne("jieun.existComCalendar", map);
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
			public int existMyCalendar(Map<String, String> map) {
				int n = sqlsession.selectOne("jieun.existMyCalendar", map);
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
	public List<ScheduleVO> selectSchedule(Map<String, String> paraMap) {
		List<ScheduleVO> scheduleList = sqlsession.selectList("jieun.selectSchedule", paraMap);
		return scheduleList;
	}
	
	// === 일정 상세 페이지 === //
	@Override
	public Map<String, String> detailSchedule(String pk_schno) {
		Map<String, String> map = sqlsession.selectOne("jieun.detailSchedule", pk_schno);
		return map;
	}
	
	// == 상세페이지에서 댓글 적기 == //
	@Override
	public int commentInput(Map<String, String> paraMap) {
		int n = sqlsession.insert("jieun.commentInput", paraMap);
		return n;
	}
	
	// == 상세페이지에서 댓글 보여주기 == //
	@Override
	public List<Map<String, String>> getScheduleComment(String pk_schno) {
		List<Map<String, String>> commentList = sqlsession.selectList("jieun.getScheduleComment", pk_schno);
		return commentList;
	}
	
	// == 상세페이지에서 댓글 삭제 == //
	@Override
	public int delComment(String pk_schecono) {
		int n = sqlsession.delete("jieun.delComment", pk_schecono);
		return n;
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
	
	// == 총 일정 검색 건수(totalCount) == //
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("jieun.getTotalCount", paraMap);
		return n;
	}
	
	// == 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임) == //

	@Override
	public List<Map<String, String>> scheduleListSearchWithPaging(Map<String, String> paraMap) {
		 List<Map<String, String>> calendarSearchList = sqlsession.selectList("jieun.scheduleListSearchWithPaging", paraMap);
		return calendarSearchList;
	}
	
	// 오늘의 일정 수
	@Override
	public int scheduleCount(int pk_emp_no) {
		int n = sqlsession.selectOne("jieun.scheduleCount", pk_emp_no);
		return n;
	}
	
	// == 메인페이지 : 임직원 생일 가져오기 == //
	@Override
	public List<Map<String, String>> employeeBirthIndex() {
		List<Map<String, String>> birthIndexList = sqlsession.selectList("jieun.employeeBirthIndex");
		return birthIndexList;
	}
/*	
	// 총 생일 건수(totalCount)
	@Override
	public int getTotaBirthCount() {
		int n = sqlsession.selectOne("jieun.getTotaBirthCount");
		return n;
	}
*/	
	// == 메인페이지 : 임직원 생일 가져오기 :전월 == //
	@Override
	public List<Map<String, String>> preMonthBirthIndex(String month) {
		List<Map<String, String>> birthIndexList1 = sqlsession.selectList("jieun.preMonthBirthIndex", month);
		return birthIndexList1;
	}
	
	// == 메인페이지 : 임직원 생일 가져오기 :이월 == //
	@Override
	public List<Map<String, String>> nextMonthBirthIndex(String month) {
		List<Map<String, String>> birthIndexList2 = sqlsession.selectList("jieun.nextMonthBirthIndex", month);
		return birthIndexList2;
	}
	
	
	
	
	
}
