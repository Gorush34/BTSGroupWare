package com.spring.bts.jieun.service;

import java.util.List;
import java.util.Map;

public interface InterResourceService {

	// === 예약 페이지에 띄울 자원 리스트 가져오기 === //
	List<Map<String, String>> resourceReservation();

	// === 해당 자원 예약내용 가져오기 === //
	List<Map<String, String>> resourceSpecialReservation(Map<String, String> paraMap);

	List<Map<String, String>> classSelect();

	// == 예약 등록하기 == //
	int addReservation(Map<String, String> paraMap);
	
	// 자원 등록 모달에 select 자원 가져오기//
	List<Map<String, String>> resourceSelect(Map<String, String> paraMap);

	// === 예약상세보기 === //
	List<Map<String, String>> reservationDetail(String pk_rserno);

	// === 예약취소 === //
	int cancelReservation(String pk_rserno);

	// === 자원 등록 하기 : 관리자 === //
	int resourceRegister_end(Map<String, String> paraMap);

	// == 자원 수정 페이지 == //
	List<Map<String, String>> resourceEdit(String pk_rno);

	// == 자원 수정 == //
	int resourceEditEnd(Map<String, String> paraMap);

	// == 자원 삭제 == //
	int deleteResource(String pk_rno);

}
