package com.spring.bts.hwanmo.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.common.AES256;
import com.spring.bts.common.MyUtil;
import com.spring.bts.common.Sha256;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.hwanmo.service.InterEmployeeService;

//=== #30. 컨트롤러 선언 === // 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
즉, 여기서 bean의 이름은  btsController 이 된다. 
여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BtsController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller
public class EmployeeController {

	@Autowired
	private AES256 aes;
	
	@Autowired
	private InterEmployeeService empService;
	
	// 사원등록 페이지 요청
	@RequestMapping(value="/emp/registerEmp.bts")
	public ModelAndView requiredLogin_registerEmp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// getCurrentURL(request); // 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출 
		mav.setViewName("registerEmp.emp");
		
		return mav;
	} // public ModelAndView registerEmp(ModelAndView mav, HttpServletRequest request)-------
	
	
	// 사번중복
	@ResponseBody
	@RequestMapping(value="/emp/idDuplicateCheck.bts", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String idDuplicateCheck(HttpServletRequest request) { 
	
		String pk_emp_no = request.getParameter("pk_emp_no"); 
		// System.out.println(">>> 확인용 pk_emp_no =>"+ pk_emp_no );	// 내가 입력한 아이디 값
			
		boolean isExist = empService.idDuplicateCheck(pk_emp_no);
		
		JSONObject jsonObj = new JSONObject(); 	// {}
		jsonObj.put("isExist", isExist);			// {"isExist":true} 또는 {"isExist":false} 으로 만들어준다. 
			
			String json = jsonObj.toString();	// 문자열 형태인 "{"isExist":true}" 또는 "{"isExist":false}" 으로 만들어준다.
		//	System.out.println(">>> 확인용 json =>"+ json );	
		//	>>> 확인용 json =>{"isExist":false}
		//	또는	
		//	>>> 확인용 json =>{"isExist":true}
			
		request.setAttribute("json",json);
			
		return json;
	} // end of public String idDuplicateCheck(HttpServletRequest request) {}---------------------------
	
	
	
	// 이메일 중복체크
	@ResponseBody
	@RequestMapping(value="/emp/emailDuplicateCheck.bts", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String emailDuplicateCheck(HttpServletRequest request) { 
	
		String uq_email = request.getParameter("uq_email"); 
		// System.out.println(">>> 확인용 uq_email =>"+ uq_email );	// 내가 입력한 아이디 값
		
		boolean isExist = empService.emailDuplicateCheck(uq_email);
		
		JSONObject jsonObj = new JSONObject(); 	// {}
		jsonObj.put("isExist", isExist);			// {"isExist":true} 또는 {"isExist":false} 으로 만들어준다. 
			
			String json = jsonObj.toString();	// 문자열 형태인 "{"isExist":true}" 또는 "{"isExist":false}" 으로 만들어준다.
			// System.out.println(">>> 확인용 json =>"+ json );	
		//	>>> 확인용 json =>{"isExist":false}
		//	또는	
		//	>>> 확인용 json =>{"isExist":true}
			
		request.setAttribute("json",json);
			
		return json;
		
	} // public String emailDuplicateCheck(HttpServletRequest request) { }----------------------
	
	// 사원등록 버튼 클릭시
	@ResponseBody
	@RequestMapping(value="/emp/registerEmpSubmit.bts", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public ModelAndView registerEmpSubmit(ModelAndView mav, HttpServletRequest request) {
	
		
		int pk_emp_no = Integer.parseInt(request.getParameter("pk_emp_no")); 					/* 사원번호 */
		int fk_department_id = Integer.parseInt(request.getParameter("fk_department_id")); 		/* 부서명구분번호 */
		int fk_rank_id = Integer.parseInt(request.getParameter("fk_rank_id")); 					/* 직급구분번호 */
		String emp_name = request.getParameter("emp_name");										/* 이름 */
		String emp_pwd = Sha256.encrypt(request.getParameter("emp_pwd"));						/* 비밀번호 */						
		String num1 = request.getParameter("num1");												/* 사내번호1 */
		String num2 = request.getParameter("num2");												/* 사내번호2 */
		String num3 = request.getParameter("num3");												/* 사내번호3 */
		String hp1 = request.getParameter("hp1");												/* 휴대전화1 */
		String hp2 = request.getParameter("hp2");												/* 휴대전화2 */
		String hp3 = request.getParameter("hp3");												/* 휴대전화3 */
		String postal = request.getParameter("postcode");										/* 우편번호*/	
		String address = request.getParameter("address");										/* 주소 */	
		String detailaddress = request.getParameter("detailAddress");							/* 상세주소 */	
		String extraaddress = request.getParameter("extraAddress");								/* 주소참고항목 */	
		String gender = request.getParameter("gender");											/* 성별 */	
		String birthday = request.getParameter("birthday");										/* 생년월일 */	
		
		String com_tel = "";
		if( num2 == "" && num3 == "") {
			com_tel = "";
		}else {
			com_tel = num1+"-"+num2+"-"+num3;
		}
		String uq_phone = hp1+"-"+hp2+"-"+hp3;
		
		String uq_email = "";
		try {
			uq_email = aes.encrypt(request.getParameter("uq_email"));	 /* 이메일 */
			uq_phone = aes.encrypt(uq_phone);							 /* 합친 휴대전화 암호화 */
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}	
		
		EmployeeVO empvo = new EmployeeVO(pk_emp_no, fk_department_id, fk_rank_id, emp_name, emp_pwd, com_tel, postal, address, detailaddress
										  , extraaddress, uq_phone, uq_email, birthday, gender);
		
		String message = "";
		String loc = "";
		try {
			int n = empService.registerMember(empvo);
			
			if(n==1) {
				message = "회원가입 성공!";
				loc =  request.getContextPath()+"/emp/registerEmp.bts"; 
			}
		
		} catch (SQLException e) {
			message = "SQL 구문 에러발생";
			loc = "javascript:history.back()";// 자바스크립트를 이용한 이전페이지로 이동한다.
			e.printStackTrace();
		}
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		
		// ##### 회원가입이 성공되면 자동으로 로그인 되도록 하겠다. #####
		/*
		try {
			int n = empService.registerMember(empvo);
			
			if(n==1) {
				
				request.setAttribute("pk_emp_no", pk_emp_no);
				request.setAttribute("emp_pwd", emp_pwd);
				request.setAttribute("emp_name", emp_name);
				
				mav.setViewName("/tiles1/main/registerAfterAutoLogin");
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
			
			String message = "SQL구문 에러발생";
			String loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
        
			mav.addObject("message", message);
			mav.addObject("loc", loc);
           
			mav.setViewName("msg");
		}
		
		*/
		return mav;
		
		
	} // public String emailDuplicateCheck(HttpServletRequest request) { }----------------------
	
	// 아이디찾기 페이지 요청
	@RequestMapping(value="/idFind.bts", method = {RequestMethod.GET})
	public ModelAndView idFind(ModelAndView mav, HttpServletRequest request) {
		
		String method = request.getMethod();
		mav.addObject("method", method);
		
		mav.setViewName("/tiles1/main/idFind");
		
		return mav;
	} // end of public ModelAndView idFind(ModelAndView mav, HttpServletRequest request) ---------------
	
	// 아이디찾기 버튼 클릭시
	@RequestMapping(value="/idFindEnd.bts")
	public ModelAndView idFindEnd(ModelAndView mav, HttpServletRequest request) {
		
		String method = request.getMethod();
		mav.addObject("method", method);
		
		String emp_name = request.getParameter("emp_name");
		String uq_email = request.getParameter("uq_email");
		
		try {
			uq_email = aes.encrypt(request.getParameter("uq_email"));	 /* 이메일 */
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}	
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("emp_name", emp_name);
		paraMap.put("uq_email", uq_email);
		
		String pk_emp_no = empService.findEmpNo(paraMap);
		
		mav.addObject("pk_emp_no", pk_emp_no);
		mav.setViewName("/tiles1/main/idFind");
		
		
		return mav;
	} // public ModelAndView idFindEnd(ModelAndView mav, HttpServletRequest request)---------------
	
	// 비밀번호 찾기 페이지 요청
	@RequestMapping(value="/pwdFind.bts", method = {RequestMethod.GET})
	public ModelAndView pwdFind(ModelAndView mav, HttpServletRequest request) {
		
		String method = request.getMethod();
		mav.addObject("method", method);
		
		mav.setViewName("/tiles1/main/pwdFind");
		
		return mav;
	} // end of public ModelAndView pwdFind(ModelAndView mav, HttpServletRequest request)----------------
	
	// 비밀번호 찾기 버튼 클릭시
	@RequestMapping(value="/pwdFindEnd.bts", method = {RequestMethod.POST})
	public ModelAndView fwdFindEnd(ModelAndView mav, HttpServletRequest request) {
		
		String method = request.getMethod();
		
		String pk_emp_no = request.getParameter("pk_emp_no");
		String uq_email = request.getParameter("uq_email");
		
		try {
			uq_email = aes.encrypt(request.getParameter("uq_email"));	 /* 이메일 */
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}	
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_emp_no", pk_emp_no);
		paraMap.put("uq_email", uq_email);
		
		boolean isUserExist = empService.isUserExist(paraMap);
		
		boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
		
		String email = "";
		
		if(isUserExist) {
			// 회원으로 존재하는 경우
			
			// 이메일을 복호화한다.
			try {
			    email = aes.decrypt(uq_email);
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}	
			// 인증키를 랜덤하게 생성하도록 한다.
			Random rnd = new Random();
			
			String certificationCode = "";
			// 인증키는 영문소문자 5글자 + 숫자 7글자 로 만들겠습니다.
			// 예: certificationCode ==> dmgrm4745003
			
			char randchar = ' ';
			for(int i=0; i<5; i++) {
				/*
                min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
                int rndnum = rnd.nextInt(max - min + 1) + min;
                   영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.     
				*/
				
				randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
				certificationCode += randchar;
						
			} // end of for------------------
			
			int randnum = 0;
			for(int i=0; i<7; i++) {
				int rndnum = rnd.nextInt(9 - 0 + 1) + 0;
				certificationCode += rndnum;
			} // end of for------------------
			
			//System.out.println(" ~~~~ 확인용 certificationCode => " + certificationCode);
			//  ~~~~ 확인용 certificationCode => gmrfp8347317
			
			// 랜덤하게 생성한 인증코드(certificationCode)를 비밀번호 찾기를 하고자 하는 사용자의 email로 
			GoogleMail mail = new GoogleMail();
			
			try {
				mail.sendmail(email, certificationCode);
				sendMailSuccess = true; // 메일 전송이 성공했음을 기록
				
				// 세션 불러오기
				HttpSession session = request.getSession();
				session.setAttribute( "certificationCode", certificationCode );
				// 발급한 인증코드를 세션에 저장시킴.
				
			
			} catch(Exception e) {
				// 메일 전송이 실패한 경우
				e.printStackTrace();
				sendMailSuccess = false; // 메일 전송이 실패했음을 기록
			}
			
		}// end of if(isUserExist)---------------------------
		
		mav.addObject("isUserExist", isUserExist);
		mav.addObject("sendMailSuccess", sendMailSuccess);
		mav.addObject("method", method);
		mav.addObject("uq_email", email);
		mav.addObject("pk_emp_no", pk_emp_no);
		mav.setViewName("/tiles1/main/pwdFind");
		
		
		return mav;
	} // end of public ModelAndView fwdFindEnd(ModelAndView mav, HttpServletRequest request) {})------------
	
	
	// 비밀번호 찾기 페이지 요청
	@RequestMapping(value="/emp/verifyCertification.bts", method = {RequestMethod.POST})
	public ModelAndView verifyCertification(ModelAndView mav, HttpServletRequest request) {
		
		String userCertificationCode = request.getParameter("userCertificationCode");
		String pk_emp_no = request.getParameter("pk_emp_no");
		mav.addObject("pk_emp_no", pk_emp_no);
		
		HttpSession session = request.getSession(); // 세션 불러오기
		String certificationCode = (String) session.getAttribute("certificationCode"); // 세션에 저장된 인들코드 가져오기
		
		String message = "";
		String loc = "";
		
		if( certificationCode.equals(userCertificationCode) ) {
			message = "인증이 성공하였습니다.";
			loc = request.getContextPath()+"/pwdUpdate.bts?pk_emp_no="+pk_emp_no;
		}
		else {	
			message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!";
			loc = request.getContextPath()+"/pwdFind.bts"; 
		}
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		mav.setViewName("msg");
		
		// !!! 중요 !!!
		// !!! 세션에 저장된 인증코드를 삭제하기 !!! //
		session.removeAttribute("certificationCode");
		
		return mav;
	} // end of public ModelAndView pwdFind(ModelAndView mav, HttpServletRequest request)----------------
	
	@RequestMapping(value="/pwdUpdate.bts")
	public ModelAndView pwdUpdate(ModelAndView mav, HttpServletRequest request) {
		String method = request.getMethod();
		mav.addObject("method", method);
		String pk_emp_no = request.getParameter("pk_emp_no");
		mav.addObject("pk_emp_no", pk_emp_no);
		
		mav.setViewName("/tiles1/main/pwdUpdate");
		
		return mav;
	}
		
	@RequestMapping(value="/pwdUpdateEnd.bts", method = {RequestMethod.POST})
	public ModelAndView pwdUpdateEnd(ModelAndView mav, HttpServletRequest request) {
		
		String method = request.getMethod();
		String pk_emp_no = request.getParameter("pk_emp_no");
		String emp_pwd = request.getParameter("emp_pwd");
		emp_pwd = Sha256.encrypt(emp_pwd);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("emp_pwd", emp_pwd);
		paraMap.put("pk_emp_no", pk_emp_no);
		
		
		int n = empService.pwdUpdate(paraMap);
		
		mav.addObject("n", n);
		mav.addObject("pk_emp_no", pk_emp_no);
		mav.addObject("method", method);
		mav.setViewName("/tiles1/main/pwdUpdate");
		
		return mav;
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	// === 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성 === //
	public void getCurrentURL(HttpServletRequest request) {
	HttpSession session = request.getSession();
	session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	
}
