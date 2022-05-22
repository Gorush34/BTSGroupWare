package com.spring.bts.hwanmo.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.SQLException;
import java.util.List;
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

	// email 중복검사 (tbl_employees 테이블에서 email 이 존재하면 true를 리턴해주고, email 이 존재하지 않으면 false를 리턴한다) 
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

	// 사용자가 존재하는지 확인
	@Override
	public boolean isUserExist(Map<String, String> paraMap) {
		boolean isUserExist = empDAO.isUserExist(paraMap);
		return isUserExist;
	} // end of public boolean isUserExist(Map<String, String> paraMap) {})------------
	
	// 비밀번호 변경
	@Override
	public int pwdUpdate(Map<String, String> paraMap) {
		int n = empDAO.pwdUpdate(paraMap);
		return n;
	}

	// 원시인(생일구하기)
	@Override
	public Map<String, String> getBirthday(int pk_emp_no) {
		Map<String, String> paraMap = empDAO.getBirthday(pk_emp_no);
		return paraMap;
	}

	// 프로필 사진 업데이트
	@Override
	public int updateEmpImg(EmployeeVO empVO) {
		int n = empDAO.updateEmpImg(empVO);
		return n;
	}

	// 회원정보 수정
	@Override
	public int updateMember(EmployeeVO empvo) {
		int n = empDAO.updateMember(empvo);
		return n;
	}

	// 회원정보 받아오기
	@Override
	public List<Map<String, Object>> getEmpInfo(int pk_emp_no) {
		List<Map<String, Object>> empList = empDAO.getEmpInfo(pk_emp_no);
		return empList;
	}

	// 로그인 유저의 정보 받아오기
	@Override
	public EmployeeVO getLoginMember(Map<String, String> paraMap) {
		
		EmployeeVO loginuser = empDAO.getLoginMember(paraMap);
		if(loginuser != null && loginuser.getPwdchangegap() >= 3 ) {
			// 마지막으로 암호를 변경한 날짜가 현재시각으로부터 3개월이 지났으면
			loginuser.setRequirePwdChange(true); // 로그인시 암호를 변경하라는 alert를 띄우도록 한다.
		}
		if(loginuser != null) {
			String email = "";
			try {
				email = aes.decrypt(loginuser.getUq_email()); // 이메일을 복호화
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
			loginuser.setUq_email(email); // 복호화된 값을 다시 넣어줌	
		}
		return loginuser;
	}
	
	// 관리자페이지 - 총 사원 수 가져오기
	@Override
	public int getTotalCountEmp(Map<String, String> paraMap) {
		int n = empDAO.getTotalCountEmp(paraMap);
		return n;
	}

	// 관리자페이지 - 총 사원 목록 가져오기
	@Override
	public List<Map<String, Object>> getEmpAllWithPaging(Map<String, String> paraMap) {
		
		List<Map<String, Object>> empList = empDAO.getEmpAllWithPaging(paraMap);
		
		String email = "";
		String phone = "";
		
		if(empList.size() > 0) {
			
			for(int i=0; i<empList.size(); i++) {
			
				email = (String) empList.get(i).get("uq_email");
				phone = (String) empList.get(i).get("uq_phone");
				
				try {
					email = aes.decrypt(email); // 이메일을 복호화
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				}
				
				try {
					phone = aes.decrypt(phone); // 이메일을 복호화
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				}
				
				// System.out.println("복호화 되니? : " + email);
				
				empList.get(i).put("uq_email", email); // 복호화된 값을 다시 넣어줌	
				empList.get(i).put("uq_phone", phone);
				
			} // end of for --------------------
		
		} // end of if------------------
		
		return empList;
	}

	// 사원번호를 통해 정보를 받아옴
	@Override
	public Map<String, Object> getMemberOne(int pk_emp_no) {
		Map<String, Object> empMap = empDAO.getMemberOne(pk_emp_no);
		
		// 복호화 및 분리
		String uq_email = ((String) empMap.get("uq_email")).replaceAll(" ", "+");
		String uq_phone = ((String) empMap.get("uq_phone")).replaceAll(" ", "+");
		
		try {
			uq_email = aes.decrypt(uq_email);	 
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		try {
			uq_phone = aes.decrypt(uq_phone);	 
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		// 복호화된 이메일 삽입
		empMap.put("uq_email", uq_email);
		// 복호화된 폰번호 삽입
		empMap.put("hp2", uq_phone.substring( (uq_phone.indexOf("-")+1), uq_phone.lastIndexOf("-") ) );
		empMap.put("hp3", uq_phone.substring( (uq_phone.lastIndexOf("-")+1) ) );
		
		String com_tel = (String) empMap.get("com_tel");
		
		if( com_tel != null ) { // 회사번호 있으면 회사번호 넣어라.
			empMap.put("num1", com_tel.substring( 0, uq_phone.indexOf("-") ) );
			empMap.put("num2", com_tel.substring( (com_tel.indexOf("-")+1), com_tel.lastIndexOf("-") )  );
			empMap.put("num3", com_tel.substring( (com_tel.lastIndexOf("-")+1) ) );
		}

		return empMap;
	}

	// 배열에 담긴 사번에 따른 탈퇴처리
	@Override
	public int updateHire(Map<String, String> paraMap) {
		int result = empDAO.updateHire(paraMap);
		return result;
	}

	@Override
	public int updateHireOne(String emp_no) {
		int result = empDAO.updateHireOne(emp_no);
		return result;
	}

}
