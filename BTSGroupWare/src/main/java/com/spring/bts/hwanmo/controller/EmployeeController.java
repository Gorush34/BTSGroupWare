package com.spring.bts.hwanmo.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.DefaultNamingPolicy;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.byungyoon.service.InterAddBookService;
import com.spring.bts.common.AES256;
import com.spring.bts.common.FileManager;
import com.spring.bts.common.MyUtil;
import com.spring.bts.common.Sha256;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.hwanmo.service.InterAttendanceService;
import com.spring.bts.hwanmo.service.InterEmployeeService;
import com.spring.bts.minjeong.model.MailVO;
import com.spring.bts.minjeong.service.InterMailService;

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
	
	@Autowired
	private InterAttendanceService attService;
	
	@Autowired
	private InterAddBookService addBookService;
	
	@Autowired	// Type에 따라 알아서 Bean 을 주입해준다. (service 를 null 로 만들지 않음.)
	private InterMailService service;	// 필요할 땐 사용하고, 필요하지 않을땐 사용하지 않기 (느슨한 결합)
	
	// === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : DependencyInjection) ===	  
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다. 
	private FileManager fileManager; // type (FileManager) 만 맞으면 다 주입해준다.
	
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
	
		/*
        form 태그의 name 명과  BoardVO 의 필드명이 같다면 
        request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
               자동적으로 BoardVO boardvo 에 set 되어진다. (xml(Mapper)파일에서 일일이 set 을 해주지 않아도 된다.)
	    */
		
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
		String img_name = request.getParameter("img_name");								
		String img_path = request.getParameter("img_path");												
		int gradelevel = 0;				//회원가입안되면 지워버려라					
		
		if(img_name == null) {
			img_name = "";
		}
		if(img_path == null) {
			img_path = "";
		}
		if(request.getParameter("gradelevel") != null) {
			gradelevel = Integer.parseInt(request.getParameter("gradelevel"));	
		}
		
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
										  , extraaddress, uq_phone, uq_email, birthday, gender, img_name, img_path, gradelevel);
		
		String message = "";
		String loc = "";
		try {
			int n = empService.registerMember(empvo);
			
			if(n==1) {
				int m = attService.registerLeave(pk_emp_no);
				System.out.println(" 가입과 동시에 연차테이블 삽입 : " + m);
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
	public ModelAndView pwdFindEnd(ModelAndView mav, HttpServletRequest request) {
		
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
			loc = request.getContextPath()+"/pwd`.bts?pk_emp_no="+pk_emp_no;
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
	/*
	@ResponseBody
	@RequestMapping(value="/uploadImage.bts", method = {RequestMethod.POST})
	public ModelAndView uploadImage(ModelAndView mav, Map<String, String> paraMap, EmployeeVO empvo, MultipartHttpServletRequest mtf) {
		
		
		return mav;
	}
	*/
	
	// 내 정보수정 버튼 클릭시
	@RequestMapping(value="/emp/updateEmp.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView requiredLogin_updateEmp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	
		// 세션 불러오기
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		int pk_emp_no = loginuser.getPk_emp_no();
		
		// 복호화 및 분리
		String uq_email = loginuser.getUq_email().replaceAll(" ", "+");
		String uq_phone = loginuser.getUq_phone().replaceAll(" ", "+");
		
		try {
			uq_email = aes.decrypt(uq_email);	 /* 이메일 */
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		try {
			uq_phone = aes.decrypt(uq_phone);	 /* 이메일 */
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		// 복호화된 이메일 삽입
		loginuser.setUq_email(uq_email);
		// 복호화된 폰번호 삽입
		// System.out.println("확인용 폰번호 : " + uq_phone);
		// System.out.println("쪼개놓은거2 : " + uq_phone.substring( (uq_phone.indexOf("-")+1), uq_phone.lastIndexOf("-") ) );
		// System.out.println("쪼개놓은거3 : " +  uq_phone.substring( (uq_phone.lastIndexOf("-")+1) ));
		loginuser.setHp2( uq_phone.substring( (uq_phone.indexOf("-")+1), uq_phone.lastIndexOf("-") ) );
		loginuser.setHp3( uq_phone.substring( (uq_phone.lastIndexOf("-")+1) ) );
		
		if(loginuser.getCom_tel() != null ) { // 회사번호 있으면 회사번호 넣어라.
			loginuser.setNum1( loginuser.getCom_tel().substring( 0, uq_phone.indexOf("-") ) );
			loginuser.setNum2( loginuser.getCom_tel().substring( (loginuser.getCom_tel().indexOf("-")+1), loginuser.getCom_tel().lastIndexOf("-") ) );
			loginuser.setNum3( loginuser.getCom_tel().substring( (loginuser.getCom_tel().lastIndexOf("-")+1) ) );
		}
		
		// System.out.println(" 지역번호 : " + loginuser.getCom_tel() );
		
		//원시인
		Map<String, String> paraMap = new HashMap<>();
		paraMap = empService.getBirthday(pk_emp_no);
		loginuser.setBirthday(paraMap.get("birthday"));
		loginuser.setGender(paraMap.get("gender"));
		loginuser.setImg_name(paraMap.get("img_name"));
		// System.out.println("생년월일 : " + loginuser.getBirthday());
		// System.out.println("성별 : " + loginuser.getGender());
		
		// System.out.println(" 컨트롤러 updateEmp.bts에서 받아진 이미지 이름 : " + loginuser.getImg_name());
		mav.addObject("img", loginuser.getImg_name());
		mav.addObject("loginuser", loginuser);
		
		mav.setViewName("updateEmp.emp");
		
		return mav;
	}
	
	// 프로필 사진 업데이트
	@ResponseBody
	@RequestMapping(value="/emp/updateImg.bts", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String updateImg(MultipartHttpServletRequest mrequest, HttpServletResponse response, EmployeeVO empVO)throws Exception {
		

		/////////////////// 첨부파일 있는 경우 시작 (스마트에디터 X) ///////////////////////
		MultipartFile attach = empVO.getAttach();		// 실제 첨부된 파일
		HttpSession session = mrequest.getSession();
		String path = "";
		
		if( !attach.isEmpty() ) {	// 첨부파일 존재시 true, 존재X시 false
			// 첨부파일이 존재한다면 (true) 업로드 해야한다.
			// 1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해준다.
			// WAS 의 절대경로를 알아와야 한다.
			
			// String root = session.getServletContext().getRealPath("/");
			String root = "C:/NCS/workspace(spring)/BTSGroupWare/BTSGroupWare/src/main/webapp/";
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			empVO.setPk_emp_no(loginuser.getPk_emp_no()); 
			
			// System.out.println("값 들어감? : " + empVO.getPk_emp_no());
			
			path = root+"resources"+File.separator+"files";
			// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다. --> path 에 파일을 업로드 한다.
			// System.out.println("경로 : " + path);
			
			// 2. 파일첨부를 위한 변수 설정 및 값을 초기화 한 후 파일 업로드 하기
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명
		
			// 내용물을 읽어온다.
			byte[] bytes = null;	// bytes 가 null 이라면 내용물이 없다는 것이다.
			// 첨부파일의 내용물을 담는 것, return 타입은 byte 의 배열
			
			long fileSize = 0;		// 첨부파일의 크기
		
			try {
				bytes = attach.getBytes();	// 파일에서 내용물을 꺼내오자. 파일을 올렸을 때 깨진파일이 있다면 (입출력이 안된다!!) 그때 Exception 을 thorws 한다.
				// 첨부파일의 내용물을 읽어오는 것. 그 다음, 첨부한 파일의 파일명을 알아와야 DB 에 넣을 수가 있다. 그러므로 파일명을 알아오도록 하자.
				// 즉 파일을 올리고 성공해야 - 내용물을 읽어올 수 있고 - 파일명을 알아와서 DB 에 넣을 수가 있다.
				
				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일의 파일명(예: 강아지.png) 이다.
		
				// 의존객체인 FileManager 를 불러온다. (String 타입으로 return 함.)
				// 리턴값 : 서버에 저장된 새로운 파일명(예: 2022042912181535243254235235234.png)
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부된 파일을 업로드 한다.
				
				// 파일을 받아와야만 service 에 보낼 수 있다. (DB 에 보내도록 한다.)
				fileSize = attach.getSize();					// 첨부파일의 크기
				empVO.setImg_name(newFileName);			// 톰캣(WAS)에 저장될 파일명
				// System.out.println(" 컨트롤러 updateImg.bts에서 받아진 이미지 이름 : " + newFileName);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
		/////////////////// 첨부파일 있는 경우 끝 (스마트에디터 X) ///////////////////////
		
		// 메일 data 를 DB 로 보낸다. (첨부파일 있을 때 / 첨부파일 없을 때)
		int n = 0;
		
		if(attach.isEmpty()) {
			// 첨부파일이 없을 때
			System.out.println(" 첨부파일 없음!");
		}
		else {
			// 프로필 사진 업데이트
			n = empService.updateEmpImg(empVO);
			System.out.println("업데이트 성공!");
		}
		
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		/*	
		
		// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다. 
		ServletContext svlCtx = session.getServletContext();
		String uploadFileDir = svlCtx.getRealPath("/files/");
		System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir);
		// 가급적이면 하나의 폴더에 넣자!
		
		// ==== 파일의 이름 경로를 알아와서 원하는 위치로 이동시킨다. ==== //
		
		try {
		Path filePath = Paths.get(uploadFileDir+empVO.getImg_name());
		Path filePathToMove2 = Paths.get("C:/NCS/workspace(spring)/BTSGroupWare/BTSGroupWare/src/main/webapp/resources/files/"+empVO.getImg_name());
		Files.move(filePathToMove2, filePath, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException e) {
		e.printStackTrace();
		}
		// ==== 파일의 이름 경로를 알아와서 원하는 위치로 이동시킨다. 끝==== //
		*/
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		jsonObj.put("img_name", empVO.getImg_name());
		jsonObj.put("path", path);
		
		return jsonObj.toString();
			
	} // end of --------------------------------
	
	
	
	// 사원등록 버튼 클릭시
	@ResponseBody
	@RequestMapping(value="/emp/updateEmpEnd.bts", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public ModelAndView updateEmpEnd(ModelAndView mav, HttpServletRequest request, EmployeeVO empvo) {
	
		/*
        form 태그의 name 명과  BoardVO 의 필드명이 같다면 
        request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
               자동적으로 BoardVO boardvo 에 set 되어진다. (xml(Mapper)파일에서 일일이 set 을 해주지 않아도 된다.)
	    */
		
		int pk_emp_no = Integer.parseInt(request.getParameter("pk_emp_no")); 					/* 사원번호 */
		String num1 = request.getParameter("num1");												/* 사내번호1 */
		String num2 = request.getParameter("num2");												/* 사내번호2 */
		String num3 = request.getParameter("num3");												/* 사내번호3 */
		String hp1 = request.getParameter("hp1");												/* 휴대전화1 */
		String hp2 = request.getParameter("hp2");												/* 휴대전화2 */
		String hp3 = request.getParameter("hp3");												/* 휴대전화3 */
		String birthday = request.getParameter("birthday");										/* 생년월일 */	
		String img_name = request.getParameter("img_name");								
		// String img_path = request.getParameter("img_path");												
		
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
		empvo.setPostal(request.getParameter("postcode"));
		empvo.setCom_tel(com_tel);
		empvo.setUq_phone(uq_phone);
		empvo.setUq_email(uq_email);
		
		String message = "";
		String loc = "";
		int n = empService.updateMember(empvo);
			
		if(n == 1) {
			message = "업데이트 성공!";
			loc = "javascript:history.back()";// 자바스크립트를 이용한 이전페이지로 이동한다.
		}
		else {
			message = "SQL 구문 에러발생";
			loc = "javascript:history.back()";// 자바스크립트를 이용한 이전페이지로 이동한다.
		}
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		return mav;
		
		
	} // end of public ModelAndView updateEmpEnd(ModelAndView mav, HttpServletRequest request) {})----------------
	
	
	 // 실험용 페이지
     @RequestMapping(value="/emp/test.bts")
     public ModelAndView test(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	   
	   
		   HttpSession session = request.getSession();
		   EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		 
		   List<EmployeeVO> empList = addBookService.addBook_depInfo_select();
		   
		   for(int i=0; i<empList.size(); i++) {
			   
			   // 이메일을 복호화한다.
				try {
				    String email = empList.get(i).getUq_email(); // i번째 암호화된 이메일을 받아온다. 
				    //				이 리스트의/i번째/어떤 값을 get(가져온다) / set(넣어준다)
				    empList.get(i).setUq_email( aes.decrypt(email) ); // list의 i번째 이메일 값을 복호화해서 넣어준다.
				    
				    // 언제까지? list의 size만큼 반복
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				}
			   
		   } // end of for 
			   
		   
		   mav.addObject("loginuser", loginuser);
		   mav.addObject("empList", empList);
		   
		   mav.setViewName("test.emp");
		   
	      return mav;
   }
     
     // 실험용 페이지
     @RequestMapping(value="/testWriteEnd.bts")
     public ModelAndView testWriteEnd(ModelAndView mav, MultipartHttpServletRequest mrequest, MailVO mailvo) {
	   
	   
		   HttpSession session = mrequest.getSession();
		   EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		 
		   // ==== 임시보관함 경우의수 생각하기 ==== //
			// 임시보관함에서 상세내용 보기 후 메일쓰기를 클릭했을 때 temp_status 가 1인 값들이 넘어온다.
			// 해당 임시보관함에 있던 메일 번호를 받아온다.
			String pk_mail_num = mrequest.getParameter("pk_mail_num");
			HttpSession session_temp = mrequest.getSession();
			session_temp.setAttribute("pk_mail_num", pk_mail_num);
			
			// 임시보관함 첨부파일 
			String filename = mrequest.getParameter("filename");
			String orgfilename = mrequest.getParameter("orgfilename");
			String filesize = mrequest.getParameter("filesize");
			
			String importanceVal = mrequest.getParameter("importanceVal");
			
			String temp_status = mrequest.getParameter("temp_status");
			//	System.out.println("확인용 temp_status : " + temp_status);
		   
			// 다중메일보내기 시작 
		    int cnt = Integer.parseInt( mrequest.getParameter("cnt"));
		    String empMailStr = mrequest.getParameter("empMailStr");
		    String [] strArray = empMailStr.split(",");
		   
            for(int i=0; i<cnt; i++) {
                 String uq_email = (String)strArray[i];
                 try {
	                  // DB에 encrypt(암호화) 해서 보내주도록 한다.
	       			  uq_email = aes.encrypt(mrequest.getParameter("recemail"));
       		     } catch (UnsupportedEncodingException | GeneralSecurityException e) {
       			      e.printStackTrace();
       		     }
               
                 Map<String, String> recEmpnameAndNum = new HashMap<>();
               
                 recEmpnameAndNum = service.getEmpnameAndNum(uq_email);
               
                 String emp_name = recEmpnameAndNum.get("emp_name");
                 String pk_emp_no = recEmpnameAndNum.get("pk_emp_no");
               
                 mailvo.setRecempname(emp_name);
                 mailvo.setFk_receiveuser_num(pk_emp_no);
               
                 // importanceVal 값을 mailvo 에 있는 importance 에 넣어주기
                 mailvo.setImportance(importanceVal);
               
	            // 사용자가 쓴 메일에 파일이 첨부되어 있는지 아닌지를 구분지어준다.
	       		
	       		/////////////////// 첨부파일 있는 경우 시작 (스마트에디터 X) ///////////////////////
	       		MultipartFile attach = mailvo.getAttach();		// 실제 첨부된 파일
	       		
	       		if( !attach.isEmpty() ) {	// 첨부파일 존재시 true, 존재X시 false
	       			// 첨부파일이 존재한다면 (true) 업로드 해야한다.
	       			// 1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해준다.
	       			// WAS 의 절대경로를 알아와야 한다.
	       			
	       			String root = session.getServletContext().getRealPath("/");
	       			
	       			String path = root+"resources"+File.separator+"files";
	       			// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다. --> path 에 파일을 업로드 한다.
	       			
	       			// 2. 파일첨부를 위한 변수 설정 및 값을 초기화 한 후 파일 업로드 하기
	       			String newFileName = "";
	       			// WAS(톰캣)의 디스크에 저장될 파일명
	
	       			// 내용물을 읽어온다.
	       			byte[] bytes = null;	// bytes 가 null 이라면 내용물이 없다는 것이다.
	       			// 첨부파일의 내용물을 담는 것, return 타입은 byte 의 배열
	
	       			long fileSize = 0;		// 첨부파일의 크기
	       		
	       			try {
	       				bytes = attach.getBytes();	// 파일에서 내용물을 꺼내오자. 파일을 올렸을 때 깨진파일이 있다면 (입출력이 안된다!!) 그때 Exception 을 thorws 한다.
	       				// 첨부파일의 내용물을 읽어오는 것. 그 다음, 첨부한 파일의 파일명을 알아와야 DB 에 넣을 수가 있다. 그러므로 파일명을 알아오도록 하자.
	       				// 즉 파일을 올리고 성공해야 - 내용물을 읽어올 수 있고 - 파일명을 알아와서 DB 에 넣을 수가 있다.
	       				
	       				String originalFilename = attach.getOriginalFilename();
	       				// attach.getOriginalFilename() 이 첨부파일의 파일명(예: 강아지.png) 이다.
	       	
	       				// 의존객체인 FileManager 를 불러온다. (String 타입으로 return 함.)
	       				// 리턴값 : 서버에 저장된 새로운 파일명(예: 2022042912181535243254235235234.png)
	       				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
	       				// 첨부된 파일을 업로드 한다.
	       				
	       				// 파일을 받아와야만 service 에 보낼 수 있다. (DB 에 보내도록 한다.)
	       				mailvo.setFilename(newFileName);			// 톰캣(WAS)에 저장될 파일명
	       				mailvo.setOrgfilename(originalFilename); 	// 사용자가 파일 다운로드시 사용되는 파일명
	       				
	       				fileSize = attach.getSize();					// 첨부파일의 크기
	       				mailvo.setFilesize(String.valueOf(fileSize));	// long 타입인 fileSize 를 String 타입으로 바꾼 후 vo 에 set 한다.
	       				
	       			} catch (Exception e) {
	       				e.printStackTrace();
	       			}
	       		}	
	       		/////////////////// 첨부파일 있는 경우 끝 (스마트에디터 X) ///////////////////////
	               
	       		// pk_mail_num 를 통해서 temp_status 조회해오기		
	    		Map<String, String> paraMap = new HashMap<>();
	    		paraMap.put("pk_mail_num", pk_mail_num);
	       		
	    		// 메일 data 를 DB 로 보낸다. (첨부파일 있을 때 / 첨부파일 없을 때)
	    		int n = 0;
	    		
	    		if(attach.isEmpty()) {
	    			// 첨부파일이 없을 때
	//    			mailvo.setTemp_status("0");			// 임시보관함 - 상세내용 보기 - 메일쓰기 클릭 시 임시보관함 status 를 다시 0으로 만들어줘야 보낸메일함에서 조회 가능
	    			if("1".equals(temp_status)) {
	    				mailvo.setReservation_status("0");
	    				service.deleteFromTbltemp(paraMap);	
	    			}
	    			
	    			else {
	    				mailvo.setReservation_status("0");
	    				mailvo.setTemp_status("0");			// 임시보관함 - 상세내용 보기 - 메일쓰기 클릭 시 임시보관함 status 를 다시 0으로 만들어줘야 보낸메일함에서 조회 가능
	    				n = service.add(mailvo);
						String fk_mail_num = service.getPkMailNum(mailvo);
	    			//	System.out.println("확인용 fk_mail_num : " + fk_mail_num);
						n = service.addToMailRead(fk_mail_num);	// 글씀과 동시에 tbl_mailRead 테이블에 해당 글번호의 값을 insert 시켜준다.
	    			}	
	    		}
	    		else {
	    			// 첨부파일 있을 때
	    			mailvo.setReservation_status("0");
	    			mailvo.setTemp_status("0");			// 임시보관함 - 상세내용 보기 - 메일쓰기 클릭 시 임시보관함 status 를 다시 0으로 만들어줘야 보낸메일함에서 조회 가능
	    			n = service.add_withFile(mailvo);
					String fk_mail_num = service.getPkMailNum(mailvo);
				//	System.out.println("확인용 fk_mail_num : " + fk_mail_num);
					n = service.addToMailRead(fk_mail_num);
				}
	    		
	    		// 성공 시 보낸 메일함으로 이동 or 메일 발송 성공 페이지로 이동
	    		// insert 가 성공적으로 됐을 때 / 실패했을 때
	    		if(n==1) {			
	    			
	    			if("1".equals(temp_status)) {
	    				// insert 성공 후, 임시보관함에서 session 에 저장된 메일번호를 넘겨서 삭제하도록 한다.
	    				String str_pk_mail_num = (String)session_temp.getAttribute("pk_mail_num");
	    				
	    				paraMap = new HashMap<>();
	    				paraMap.put("pk_mail_num", str_pk_mail_num);
	    				
	    				// 임시보관함에서 메일 상세내용 보기 후 메일쓰기를 클릭 한 경우 임시보관함에 있던 해당 pk_mail_num 를 삭제한다.
	    				
	    				int m = service.deleteFromTbltemp(paraMap);			
	    				
	    				if(m==1) {
	    					System.out.println("임시보관함에서 "+pk_mail_num+"번 글이 delete 되었습니다. ");
	    				}
	    				else {
	    					System.out.println("임시보관함에서 "+pk_mail_num+"번 글이 delete 에 실패했습니다. ");
	    	
	    				}
	    			}				
	    			// 메일쓰기 성공적으로 됐다는 화면 보여주기.
	    			mav.setViewName("mailSendSuccess.mail");		
	    		}
	    		else {// 실패 시 메일쓰기로 이동 (back)		
	    			//		mav.setViewName("redirect:/mailWriteList.bts");
	    		}

			} // end of for----------------------------------
		   
	      return mav;
    }
     
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	// === 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성 === //
	public void getCurrentURL(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	HttpSession session = request.getSession();
	session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	
}
