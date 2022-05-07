package com.spring.bts.hwanmo.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.common.AES256;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.hwanmo.model.InterEmployeeDAO;

//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class EmployeeService implements InterEmployeeService {

	@Autowired
	private InterEmployeeDAO empDAO; 
	
	// === #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private AES256 aes;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.common.AES256 의 bean 을  aes 에 주입시켜준다. 
	// 그러므로 aes 는 null 이 아니다.
	// com.spring.board.common.AES256 의 bean 은 /webapp/WEB-INF/spring/appServlet/servlet-context.xml 파일에서 bean 으로 등록시켜주었음.
	
	
	
	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
	@Override
	public boolean idDuplicateCheck(String pk_emp_no) {
		boolean isExist = empDAO.idDuplicateCheck(pk_emp_no);
		return isExist;
	}

	// email 중복검사 (tbl_member 테이블에서 email 이 존재하면 true를 리턴해주고, email 이 존재하지 않으면 false를 리턴한다) 
	@Override
	public boolean emailDuplicateCheck(String uq_email) {
		
		try {
			uq_email = aes.encrypt(uq_email); // 이메일을 암호화
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		boolean isExist = empDAO.emailDuplicateCheck(uq_email);
		return isExist;
	}

	// 사원 가입하기
	@Override
	public int registerMember(EmployeeVO empvo) throws SQLException {
		int n = empDAO.registerMember(empvo);
		return n;
	}

	// 아이디 찾기
	@Override
	public String findEmpNo(Map<String, String> paraMap) {
		String pk_emp_no = empDAO.findEmpNo(paraMap);
		return pk_emp_no;
	}

}
