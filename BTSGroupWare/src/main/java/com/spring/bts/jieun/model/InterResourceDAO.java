package com.spring.bts.jieun.model;

import java.util.List;
import java.util.Map;

public interface InterResourceDAO {

	// === 예약 페이지에 띄울 자원 리스트 가져오기 === //
	List<Map<String, String>> resourceReservation();

	// === 해당 자원 예약내용 가져오기 === //
	List<Map<String, String>> resourceSpecialReservation(Map<String, String> paraMap);

	List<Map<String, String>> classSelect();

}
