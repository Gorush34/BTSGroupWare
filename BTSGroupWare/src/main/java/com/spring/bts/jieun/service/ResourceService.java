package com.spring.bts.jieun.service;

import java.util.HashMap;
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
	
	// == 예약 등록하기 == //
	@Override
	public int addReservation(Map<String, String> paraMap) {
		int n = 0;
		
		String rserstartdate = paraMap.get("rserstartdate");
		String rserenddate = paraMap.get("rserenddate");
		String fk_rno = paraMap.get("fk_rno");
		
		Map<String, String> map = new HashMap<>();
		map.put("rserstartdate", rserstartdate);
		map.put("rserenddate", rserenddate);
		map.put("fk_rno", fk_rno);
		
		// 예약 목록 존재 여부 알아오기
		int m = dao.existReservation(map);
		
		if(m==0) {
			n = dao.addReservation(paraMap);
		}
		
		return n;
	}

	// 자원 등록 모달에 select 자원 가져오기//
	@Override
	public List<Map<String, String>> resourceSelect(Map<String, String> paraMap) {
		List<Map<String, String>> resourceSelctList = dao.resourceSelect(paraMap);
		return resourceSelctList;
	}

	// === 예약상세보기 === //
	@Override
	public List<Map<String, String>> reservationDetail(String pk_rserno) {
		List<Map<String, String>> reservationDetail = dao.reservationDetail(pk_rserno);
		return reservationDetail;
	}

	// === 예약취소 === //
	@Override
	public int cancelReservation(String pk_rserno) {
		int n = dao.cancelReservation(pk_rserno);
		return n;
	}

	// === 자원 등록 하기 : 관리자 === //
	@Override
	public int resourceRegister_end(Map<String, String> paraMap) {
		int n = dao.resourceRegister_end(paraMap);
		return n;
	}

	// == 자원 수정 페이지 == //
	@Override
	public List<Map<String, String>> resourceEdit(String pk_rno) {
		List<Map<String, String>> resourceList = dao.resourceEdit(pk_rno);
		return resourceList;
	}

	// == 자원 수정 == //
	@Override
	public int resourceEditEnd(Map<String, String> paraMap) {
		int n = dao.resourceEditEnd(paraMap);
		return n;
	}

	// == 자원 삭제 == //
	@Override
	public int deleteResource(String pk_rno) {
		int n = dao.deleteResource(pk_rno);
		return n;
	}

	// == 메인 페이지 예약 수 불러오기 == //
	@Override
	public int reservationCount(int pk_emp_no) {
		int n = dao.reservationCount(pk_emp_no);
		return n;
	}
	
}
