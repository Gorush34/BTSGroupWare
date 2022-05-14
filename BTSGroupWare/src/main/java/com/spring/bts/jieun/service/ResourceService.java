package com.spring.bts.jieun.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.jieun.model.InterResourceDAO;

//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class ResourceService implements InterResourceService {
	@Autowired
	private InterResourceDAO dao;

	// === 예약 페이지에 띄울 자원 리스트 가져오기 === //
	@Override
	public List<Map<String, String>> resourceReservation() {
		List<Map<String, String>> resourceList = dao.resourceReservation();
		return resourceList;
	}

	// === 해당 자원 예약내용 가져오기 === //
	@Override
	public List<Map<String, String>> resourceSpecialReservation(Map<String, String> paraMap) {
		List<Map<String, String>> reservationEmployeeList = dao.resourceSpecialReservation(paraMap);
		return reservationEmployeeList;
	}

	@Override
	public List<Map<String, String>> classSelect() {
		List<Map<String, String>> classList = dao.classSelect();
		return classList;
	}
	
}
