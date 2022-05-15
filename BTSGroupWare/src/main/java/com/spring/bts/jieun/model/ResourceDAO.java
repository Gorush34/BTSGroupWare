package com.spring.bts.jieun.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ResourceDAO implements InterResourceDAO {

	@Resource
	private SqlSessionTemplate sqlsession; // 로컬DB mymvc_user 에 연결
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의  sqlsession bean 을  sqlsession 에 주입시켜준다. 
    // 그러므로 sqlsession 는 null 이 아니다.
	
	// === 예약 페이지에 띄울 자원 리스트 가져오기 === //
	@Override
	public List<Map<String, String>> resourceReservation() {
		List<Map<String, String>> resourceList = sqlsession.selectList("jieun.resourceReservation");
		return resourceList;
	}

	// === 해당 자원 예약내용 가져오기 === //
	@Override
	public List<Map<String, String>> resourceSpecialReservation(Map<String, String> paraMap) {
		List<Map<String, String>> reservationEmployeeList = sqlsession.selectList("jieun.resourceSpecialReservation", paraMap);
		return reservationEmployeeList;
	}

	@Override
	public List<Map<String, String>> classSelect() {
		List<Map<String, String>> classList = sqlsession.selectList("jieun.classSelect");
		return classList;
	}

	// == 예약 등록하기 == //
	@Override
	public int addReservation(Map<String, String> paraMap) {
		int n = sqlsession.insert("jieun.addReservation", paraMap);
		return n;
	}

	// 자원 등록 모달에 select 자원 가져오기//
	@Override
	public List<Map<String, String>> resourceSelect(Map<String, String> paraMap) {
		List<Map<String, String>> resourceSelctList = sqlsession.selectList("jieun.resourceSelect", paraMap);
		return resourceSelctList;
	}

	// === 예약상세보기 === //
	@Override
	public List<Map<String, String>> reservationDetail(String pk_rserno) {
		List<Map<String, String>> reservationDetail = sqlsession.selectList("jieun.reservationDetail", pk_rserno);
		return reservationDetail;
	}

	// === 예약취소 === //
	@Override
	public int cancelReservation(String pk_rserno) {
		int n = sqlsession.delete("jieun.cancelReservation", pk_rserno);
		return n;
	}

	// === 자원 등록 하기 : 관리자 === //
	@Override
	public int resourceRegister_end(Map<String, String> paraMap) {
		int n = sqlsession.insert("jieun.resourceRegister_end", paraMap);
		return n;
	}

}
