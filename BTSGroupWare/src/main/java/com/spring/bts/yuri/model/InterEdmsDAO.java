package com.spring.bts.yuri.model;

import java.util.List;
import java.util.Map;

import com.spring.bts.hwanmo.model.EmployeeVO;

public interface InterEdmsDAO {

	// 로그인된 사원 정보 가져오기
	EmployeeVO getLoginMember(Map<String, String> paraMap);

	// 파일첨부가 없는 전자결재 문서작성
	int edmsAdd(ApprVO apprvo);

	// 파일첨부가 없는 전자결재 문서작성
	int edmsAdd_withFile(ApprVO apprvo);

	// 페이징 처리를 안한 검색어가 없는 전체 대기문서 목록 보여주기
	List<ApprVO> waitListNoSearch();

	// 전자결재 양식선택(업무기안서, 휴가신청서 등..)을 위한 것
//	List<String> getApprsortList();

	// 파일첨부가 있는 전자결재 문서작성
	
	// 전자결재 글 수정하기
	
	// 전자결재 글 삭제하기
	
}
