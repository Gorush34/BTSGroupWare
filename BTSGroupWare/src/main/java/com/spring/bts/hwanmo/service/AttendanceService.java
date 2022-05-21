package com.spring.bts.hwanmo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.common.AES256;
import com.spring.bts.hwanmo.model.AttendanceVO;
import com.spring.bts.hwanmo.model.CommuteVO;
import com.spring.bts.hwanmo.model.InterAttendanceDAO;
import com.spring.bts.hwanmo.model.LeaveVO;

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

	// 총 출퇴근 건수 알아오기
	@Override
	public int getTotalCommuteCount(Map<String, String> paraMap) {
		int n = attDAO.getTotalCommuteCount(paraMap);
		return n;
	}

	// 페이징처리가 있는 한 사원에 대한 출퇴근기록 가져오기
	@Override
	public List<CommuteVO> getMyCommute(Map<String, String> paraMap) {
		List<CommuteVO> cmtList = attDAO.getMyCommute(paraMap);
		return cmtList;
	}

	// 직급번호로 직급명 알아오기
	@Override
	public String getKo_rankname(String pk_emp_no) {
		String ko_rankname = attDAO.getKo_rankname(pk_emp_no);
		return ko_rankname;
	}

	// 사원번호로 부서명, 부서장, 부서장 사번 알아오기
	@Override
	public Map<String, String> getDeptInfo(String pk_emp_no) {
		Map<String, String> paraMap = attDAO.getDeptInfo(pk_emp_no);
		return paraMap;
	}

	// 사원번호로 연차테이블 불러오기
	@Override
	public Map<String, String> getLeaveInfo(String pk_emp_no) {
		Map<String, String> paraMap = attDAO.getLeaveInfo(pk_emp_no);
		return paraMap;
	}

	// 연차구분테이블 불러오기
	@Override
	public List<Map<String, Object>> getAttSortInfo() {
		List<Map<String, Object>> attSortList = attDAO.getAttSortInfo();
		return attSortList;
	}

	// 첨부파일이 없는 연차신청 작성
	@Override
	public int reportVacation(AttendanceVO attVO) {
		int n = attDAO.reportVacation(attVO);
		return n;
	}

	// 첨부파일이 있는 연차신청 작성
	@Override
	public int reportVacation_withFile(AttendanceVO attVO) {
		int n = attDAO.reportVacation_withFile(attVO);
		return n;
	}

	// 사원의 연차테이블 최신화
	@Override
	public int updateLeave(Map<String, String> paraMap) {
		int n = attDAO.updateLeave(paraMap);
		return n;
	}

	// 로그인한 사용자의 연차테이블 불러오기
	@Override
	public LeaveVO getOneLeave(String fk_emp_no) {
		LeaveVO leavevo = attDAO.getOneLeave(fk_emp_no);
		return leavevo;
	}

	// 총 올린  연차신청 수 가져오기
	@Override
	public int getTotalVacReportCount(String fk_emp_no) {
		int totalCount = attDAO.getTotalVacReportCount(fk_emp_no);
		return totalCount;
	}

	// 페이징처리 한 받은 공가/경조신청목록 
	@Override
	public List<Map<String, Object>> getMyAttListWithPaging(Map<String, String> paraMap) {
		List<Map<String, Object>> myAttList = attDAO.getMyAttListWithPaging(paraMap);
		return myAttList;
	}

	// 근태신청번호로 공가/경조신청 상세내역 담아오기
	@Override
	public List<Map<String, Object>> getVacReportList(int pk_att_num) {
		
		List<Map<String, Object>> vacReportList = attDAO.getVacReportList(pk_att_num);
		return vacReportList;
	}

	// 부서장인지 확인하기
	@Override
	public int checkManager(String fk_emp_no) {
		int isManager = attDAO.checkManager(fk_emp_no);
		return isManager;
	}

	// 결재상황 업데이트하기
	@Override
	public int goSign(Map<String, String> paraMap) {
		int n = attDAO.goSign(paraMap);
		return n;
	}

	// 총 올린 결재대기중인 연차신청 수 가져오기
	@Override
	public int getTotalVacReportNoSignCount(String fk_emp_no) {
		int totalCount = attDAO.getTotalVacReportNoSignCount(fk_emp_no);
		return totalCount;
	}

	// 페이징처리 한 결재대기중인 공가/경조신청목록 
	@Override
	public List<Map<String, Object>> getMyAttListNoSignWithPaging(Map<String, String> paraMap) {
		List<Map<String, Object>> myAttList = attDAO.getMyAttListNoSignWithPaging(paraMap);
		return myAttList;
	}

	// 메인화면 연차결재대기문서 갯수 가져오기
	@Override
	public int vacCount(int pk_emp_no) {
		int n = attDAO.vacCount(pk_emp_no);
		return n;
	}

	// 관리자페이지 - 총 연차신청서 개수 가져오기
	@Override
	public int getTotalCountVacReport_all(Map<String, String> paraMap) {
		int totalPage = attDAO.getTotalCountVacReport_all(paraMap);
		return totalPage;
	}

	// 관리자페이지 - 페이징처리 한 결재대기중인 공가/경조신청목록 
	@Override
	public List<Map<String, Object>> getAttListAllWithPaging(Map<String, String> paraMap) {
		List<Map<String, Object>> allAttList = attDAO.getAttListAllWithPaging(paraMap);
		return allAttList;
	}

	// 연차신청서 삭제하기
	@Override
	public int deleteReport(int pk_att_num) {
		int n = attDAO.deleteReport(pk_att_num);
		return n;
	}



	
}
