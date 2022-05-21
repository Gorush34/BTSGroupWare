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

	// 직급번호로 직급명 알아오기
	@Override
	public String getKo_rankname(String pk_emp_no) {
		String ko_rankname = sqlsession.selectOne("hwanmo.getKo_rankname", pk_emp_no);
		return ko_rankname;
	}

	// 사원번호로 부서명, 부서장, 부서장 사번 알아오기
	@Override
	public Map<String, String> getDeptInfo(String pk_emp_no) {
		Map<String, String> paraMap = sqlsession.selectOne("hwanmo.getDeptInfo", pk_emp_no);
		return paraMap;
	}

	// 사원번호로 연차테이블 불러오기
	@Override
	public Map<String, String> getLeaveInfo(String pk_emp_no) {
		Map<String, String> paraMap = sqlsession.selectOne("hwanmo.getLeaveInfo", pk_emp_no);
		return paraMap;
	}

	// 연차구분테이블 불러오기
	@Override
	public List<Map<String, Object>> getAttSortInfo() {
		List<Map<String, Object>> attSortList = sqlsession.selectList("hwanmo.getAttSortInfo");
		return attSortList;
	}

	// 첨부파일이 없는 연차신청 작성
	@Override
	public int reportVacation(AttendanceVO attVO) {
		int n = sqlsession.insert("hwanmo.reportVacation", attVO);
		return n;
	}

	// 첨부파일이 있는 연차신청 작성
	@Override
	public int reportVacation_withFile(AttendanceVO attVO) {
		int n = sqlsession.insert("hwanmo.reportVacation_withFile", attVO);
		return n;
	}

	// 사원의 연차테이블 최신화
	@Override
	public int updateLeave(Map<String, String> paraMap) {
		int n = sqlsession.update("hwanmo.updateLeave", paraMap);
		return n;
	}

	// 로그인한 사용자의 연차테이블 불러오기
	@Override
	public LeaveVO getOneLeave(String fk_emp_no) {
		LeaveVO leavevo = sqlsession.selectOne("hwanmo.getOneLeave", fk_emp_no);
		return leavevo;
	}

	// 총 올린  연차신청 수 가져오기
	@Override
	public int getTotalVacReportCount(String fk_emp_no) {
		int totalCount = sqlsession.selectOne("hwanmo.getTotalVacReportCount", fk_emp_no);
		return totalCount;
	}

	// 페이징처리 한 받은 공가/경조신청목록 
	@Override
	public List<Map<String, Object>> getMyAttListWithPaging(Map<String, String> paraMap) {
		List<Map<String, Object>> myAttList = sqlsession.selectList("hwanmo.getMyAttListWithPaging", paraMap);
		return myAttList;
	}

	// 근태신청번호로 공가/경조신청 상세내역 담아오기
	@Override
	public List<Map<String, Object>> getVacReportList(int pk_att_num) {
		List<Map<String, Object>> vacReportList = sqlsession.selectList("hwanmo.getVacReportList", pk_att_num);
		return vacReportList;
	}

	// 부서장인지 확인하기
	@Override
	public int checkManager(String fk_emp_no) {
		int isManager = sqlsession.selectOne("hwanmo.checkManager", fk_emp_no);
		return isManager;
	}

	// 결재상황 업데이트하기
	@Override
	public int goSign(Map<String, String> paraMap) {
		int n = sqlsession.update("hwanmo.goSign", paraMap);
		return n;
	}

	// 총 올린 결재대기중인 연차신청 수 가져오기
	@Override
	public int getTotalVacReportNoSignCount(String fk_emp_no) {
		int totalCount = sqlsession.selectOne("hwanmo.getTotalVacReportNoSignCount", fk_emp_no);
		return totalCount;
	}

	// 페이징처리 한 결재대기중인 공가/경조신청목록 
	@Override
	public List<Map<String, Object>> getMyAttListNoSignWithPaging(Map<String, String> paraMap) {
		List<Map<String, Object>> myAttList = sqlsession.selectList("hwanmo.getMyAttListNoSignWithPaging", paraMap);
		return myAttList;
	}

	// 메인화면 연차결재대기문서 갯수 가져오기
	@Override
	public int vacCount(int pk_emp_no) {
		int n = sqlsession.selectOne("hwanmo.vacCount", pk_emp_no);
		return n;
	}

	// 관리자페이지 - 총 연차신청서 개수 가져오기
	@Override
	public int getTotalCountVacReport_all(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("hwanmo.getTotalCountVacReport_all", paraMap);
		return totalCount;
	}

	// 관리자페이지 - 페이징처리 한 결재대기중인 공가/경조신청목록 
	@Override
	public List<Map<String, Object>> getAttListAllWithPaging(Map<String, String> paraMap) {
		List<Map<String, Object>> allAttList = sqlsession.selectList("hwanmo.getAttListAllWithPaging", paraMap);
		return allAttList;
	}

	// 연차신청서 삭제하기
	@Override
	public int deleteReport(int pk_att_num) {
		int n = sqlsession.delete("hwanmo.deleteReport", pk_att_num);
		return n;
	}
	
	
}
