package com.spring.bts.hwanmo.service;

import java.util.List;
import java.util.Map;

import com.spring.bts.hwanmo.model.AttendanceVO;
import com.spring.bts.hwanmo.model.CommuteVO;
import com.spring.bts.hwanmo.model.LeaveVO;

public interface InterAttendanceService {

	// 가입과 동시에 연차테이블 등록하기
	int registerLeave(int pk_emp_no);

	// 오늘 출퇴근기록 조회
	int getTodayCommute(Map<String, String> paraMap);

	// 날짜, 출근시간 입력한 테이블 insert
	int insertTodayCommute(Map<String, String> paraMap);

	// 출퇴근시간 알아오기
	Map<String, String> getTodayworkInOutTime(Map<String, String> paraMap);

	// 퇴근시간 및 하루 근무시간 update하기
	int updateTodayOutTime(Map<String, String> paraMap);

	// 00시가 되면 출퇴근 초기화하기
	int checkTomorrow(Map<String, String> paraMap);

	// 총 출퇴근 건수 알아오기
	int getTotalCommuteCount(Map<String, String> paraMap);

	// 페이징처리가 있는 한 사원에 대한 출퇴근기록 가져오기
	List<CommuteVO> getMyCommute(Map<String, String> paraMap);

	// 직급번호로 직급명 알아오기
	String getKo_rankname(String pk_emp_no);
	
	// 사원번호로 부서명, 부서장, 부서장 사번 알아오기
	Map<String, String> getDeptInfo(String pk_emp_no);

	// 사원번호로 연차테이블 불러오기
	Map<String, String> getLeaveInfo(String pk_emp_no);

	// 연차구분테이블 불러오기
	List<Map<String, Object>> getAttSortInfo();

	// 첨부파일이 없는 연차신청 작성
	int reportVacation(AttendanceVO attVO);

	// 첨부파일이 있는 연차신청 작성
	int reportVacation_withFile(AttendanceVO attVO);

	// 사원의 연차테이블 최신화
	int updateLeave(Map<String, String> paraMap);

	// 로그인한 사용자의 연차테이블 불러오기
	LeaveVO getOneLeave(String fk_emp_no);

	// 총 올린  연차신청 수 가져오기
	int getTotalVacReportCount(String fk_emp_no);

	// 페이징처리 한 받은 공가/경조신청목록 
	List<Map<String, Object>> getMyAttListWithPaging(Map<String, String> paraMap);

	// 근태신청번호로 공가/경조신청 상세내역 담아오기
	List<Map<String, Object>> getVacReportList(int pk_att_num);

	// 관리자인지 확인하기
	int checkManager(String fk_emp_no);

}
