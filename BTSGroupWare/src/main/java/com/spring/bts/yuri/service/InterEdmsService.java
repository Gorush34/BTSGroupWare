package com.spring.bts.yuri.service;

import java.util.List;
import java.util.Map;

import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.yuri.model.ApprVO;

public interface InterEdmsService {

	// 로그인된 사원 정보 가져오기 #yuly
	EmployeeVO getLoginMember(Map<String, String> paraMap);
	
	// 전자결재 양식선택(업무기안서, 휴가신청서 등..)을 위한 것 #yuly
//	List<String> getApprsortList();
	
	// 글쓰기(파일 첨부가 없는 글쓰기)
	int edmsAdd(ApprVO apprvo);
	// 글쓰기(파일첨부가 있는 글쓰기)
	int edmsAdd_withFile(ApprVO apprvo);
	
	// 글 조회수 증가와 함께 글1개를 조회해주는 것
	ApprVO getView(Map<String, String> paraMap);

	// 글 조회수 증가는 없고 단순히 글 1개 조회만을 해주는 것이다.
	ApprVO getViewWithNoAddCount(Map<String, String> paraMap);
	
	// 1개글 수정하기
	int edit(ApprVO apprvo);

	// 1개글 삭제하기
	int del(Map<String, String> paraMap);

	// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	List<ApprVO> edmsListSearchWithPaging(Map<String, String> paraMap);
	
	// 검색어 입력시 자동글 완성하기
	List<String> wordSearchShow(Map<String, String> paraMap);

	// 총 게시물 건수(totalCount) 구하기 - 검색이 있을 때와 검색이 없을 때로 나뉜다.
	int getTotalCount(Map<String, String> paraMap);

	
	
	
	
	// 상세부서정보 페이지 사원목록 불러오기
	List<EmployeeVO> addBook_depInfo_select();

	// 승인하기
	int accept(ApprVO apprvo);
	
	// 반려하기
	int reject(ApprVO apprvo);

	// 대기목록 보기
	List<ApprVO> edmsListSearchWithPaging_wait(Map<String, String> paraMap);

	// 승인 목록 보기
	List<ApprVO> edmsListSearchWithPaging_accept(Map<String, String> paraMap);

	// 반려 목록 보기
	List<ApprVO> edmsListSearchWithPaging_reject(Map<String, String> paraMap);

	// 상태 상관없이 전체 리스트 불러오기
	List<Map<String, Object>> getAllList();

	// 상태가 승인됨인 리스트 불러오기
	List<Map<String, Object>> getAcceptList();

	// 상태가 반려됨인 리스트 불러오기
	List<Map<String, Object>> getRejectList();
	
	
}