package com.spring.bts.hwanmo.model;

import java.sql.SQLException;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmployeeDAO implements InterEmployeeDAO {

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
	
	/*
	@Resource
	private SqlSessionTemplate sqlsession; // 로컬DB mymvc_user 에 연결
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의  sqlsession bean 을  sqlsession 에 주입시켜준다. 
	// 그러므로 sqlsession 는 null 이 아니다.
	*/

	@Autowired
	private SqlSessionTemplate sqlsession;
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  sqlsession 에 주입시켜준다. 
	// 그러므로 sqlsession 는 null 이 아니다. 이름 맘대로해도됨

	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
	@Override
	public boolean idDuplicateCheck(String pk_emp_no) {
		boolean isExist = sqlsession.selectOne("hwanmo.idDuplicateCheck", pk_emp_no);
		return isExist;
	}

	// email 중복검사 (tbl_member 테이블에서 email 이 존재하면 true를 리턴해주고, email 이 존재하지 않으면 false를 리턴한다) 
	@Override
	public boolean emailDuplicateCheck(String uq_email) {
		boolean isExist = sqlsession.selectOne("hwanmo.emailDuplicateCheck", uq_email);
		return isExist;
	}

	// 사원 등록하기
	@Override
	public int registerMember(EmployeeVO empvo) throws SQLException {
		int n = sqlsession.insert("hwanmo.registerMember", empvo);
		return n;
	}

	// 아이디 찾기
	@Override
	public String findEmpNo(Map<String, String> paraMap) {
		String pk_emp_no = sqlsession.selectOne("hwanmo.findEmpNo", paraMap);
		return pk_emp_no;
	}

	// 사용자가 존재하는지 
	@Override
	public boolean isUserExist(Map<String, String> paraMap) {
		String emp_no = sqlsession.selectOne("hwanmo.isUserExist", paraMap);
		boolean isUserExist = false;
		if(emp_no.equals(paraMap.get("pk_emp_no"))) {
			isUserExist = true;
		}
		// System.out.println("isUserExist : " + isUserExist);
		
		return isUserExist;
	}

	// 비밀번호 변경
	@Override
	public int pwdUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("hwanmo.pwdUpdate", paraMap);
		return n;
	}

	// 원시인(생일구하기)
	@Override
	public Map<String, String> getBirthday(int pk_emp_no) {
		Map<String, String> paraMap = sqlsession.selectOne("hwanmo.getBirthday", pk_emp_no);
		return paraMap;
	}

	// 프로필 사진 업데이트
	@Override
	public int updateEmpImg(EmployeeVO empVO) {
		int n = sqlsession.update("hwanmo.updateEmpImg", empVO);
		return n;
	}
	
	
	
}
