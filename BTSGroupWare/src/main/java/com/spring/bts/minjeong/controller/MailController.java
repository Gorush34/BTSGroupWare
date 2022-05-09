package com.spring.bts.minjeong.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.common.AES256;
import com.spring.bts.common.FileManager;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.minjeong.model.MailTempVO;
import com.spring.bts.minjeong.model.MailVO;
import com.spring.bts.minjeong.service.InterMailService;

@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
    그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
    즉, 여기서 bean의 이름은 boardController 이 된다. 
    여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller	// Bean 기능 + Controller 기능 ( @Component 를 빼도, 안빼도 무방하다. )
public class MailController {

	// #### 의존객체 목록 #### //
	// Spring 은 항상 Service 가 필요하다! (Controller 는 service를 의존객체로 한다.)
	@Autowired	// Type에 따라 알아서 Bean 을 주입해준다. (service 를 null 로 만들지 않음.)
	private InterMailService service;	// 필요할 땐 사용하고, 필요하지 않을땐 사용하지 않기 (느슨한 결합)
	
	
	// === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : DependencyInjection) ===	  
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다. 
	private FileManager fileManager; // type (FileManager) 만 맞으면 다 주입해준다.

	@Autowired
    private AES256 aes;
	
	// 메일 쓰기 폼페이지 요청 (추후 로그인 AOP 추가 requiredLogin_) 
	@RequestMapping(value = "/mail/mailWrite.bts", produces = "text/plain; charset=UTF-8")	
	public ModelAndView requiredLogin_mailWrite(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		/*
		 * // 로그인 세션 요청하기 HttpSession session = request.getSession(); 
		 * EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		 * 
		 * mav.addObject("loginuser", loginuser);
		 */
		// 메일 쓰기 폼 띄우기		
		mav.setViewName("mailWrite.mail");	// view 단
		
		return mav;
	}
	
	// 메일 쓰기 완료 페이지 요청 (DB 에 글쓴 내용을 보내기)
	@RequestMapping(value = "/mail/mailWriteEnd.bts", method= {RequestMethod.POST})	
	public ModelAndView mailWriteEnd(ModelAndView mav, MultipartHttpServletRequest mrequest, MailVO mailvo) {

		// form 태그로 보낸 정보들을 받아오자.
		// 받는사원번호 및 사원명이 여러명이므로 배열로 받아온다.
		/*
	       form 태그의 name 명과  BoardVO 의 필드명이 같다면 
	       request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
	              자동적으로 BoardVO boardvo 에 set 되어진다. (xml(Mapper)파일에서 일일이 set 을 해주지 않아도 된다.)
	    */			
		
		/*
		 * // 제목 String subject = mrequest.getParameter("subject");
		 * System.out.println("확인용 subject(제목) :" + subject);
		 * 
		 * // 메일쓰기 시 체크박스 체크여부 (체크 :1, 체크X :0) String importanceVal =
		 * mrequest.getParameter("importanceVal");
		 * System.out.println("확인용 importanceVal(중요체크박스 체크여부) :" + importanceVal);
		 * 
		 * // 첨부 파일 // String attach = mrequest.getParameter("attach"); //
		 * System.out.println("확인용 attach(첨부파일) :" + attach);
		 * 
		 * // 메일 내용 String content = mrequest.getParameter("content");
		 * System.out.println("확인용 content(메일 내용) :" + content);
		 * 
		 */
		
		/*
		 * mav.addObject("fk_receiveuser_num", fk_receiveuser_num);
		 * mav.addObject("empname", empname); mav.addObject("subject", subject);
		 * mav.addObject("importanceVal", importanceVal); mav.addObject("mail_attach",
		 * mail_attach); mav.addObject("content", content);
		 */
		
		/*
		 	확인용 fk_receiveuser_num(사원번호) :admin@bts.com
			확인용 empname(사원명) :
			확인용 subject(제목) :메일쓰기 테스트
			확인용 importanceVal(중요체크박스 체크여부) :0
			확인용 mail_attach(첨부파일) :null
			확인용 content(메일 내용) :메일쓰기 테스트 입니다.&nbsp;
		 */
		
		
		String uq_email = "";	   /* 이메일 */
        try {
			uq_email = aes.encrypt(mrequest.getParameter("recemail"));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
        
        // 값을 1개만 보낼때에는 String 으로 보내고, 
        // return 타입으로 받아올 때에는 List 또는 Map 으로 받아온다.
        
        Map<String, String> recEmpnameAndNum = new HashMap<>();
        
        recEmpnameAndNum = service.getEmpnameAndNum(uq_email);
        
        String emp_name = recEmpnameAndNum.get("emp_name");
        String pk_emp_no = recEmpnameAndNum.get("pk_emp_no");
        
        mailvo.setRecempname(emp_name);
        mailvo.setFk_receiveuser_num(pk_emp_no);
        
   //   System.out.println("확인용 emp_name :" + emp_name);
   //   System.out.println("확인용 pk_emp_no :" + pk_emp_no);
   //   System.out.println("확인용 uq_email : " + uq_email);
               
        /*
        service.getRecEmpname(uq_email);
   
        mailvo.setRecempname(recempname);
         */
        
		// 사용자가 쓴 메일에 파일이 첨부되어 있는지 아닌지를 구분지어준다.
		
		/////////////////// 첨부파일 있는 경우 시작 (스마트에디터 X) ///////////////////////
		MultipartFile attach = mailvo.getAttach();		// 실제 첨부된 파일
		
		if( !attach.isEmpty() ) {	// 첨부파일 존재시 true, 존재X시 false
			// 첨부파일이 존재한다면 (true) 업로드 해야한다.
			// 1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해준다.
			// WAS 의 절대경로를 알아와야 한다.
			
			HttpSession session = mrequest.getSession();
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
		
		// 메일 data 를 DB 로 보낸다. (첨부파일 있을 때 / 첨부파일 없을 때)
		int n = 0;
		
		if(attach.isEmpty()) {
			// 첨부파일이 없을 때
			n = service.add(mailvo);
		}
		else {
			// 첨부파일 있을 때
			n = service.add_withFile(mailvo);
		}
		
		// 성공 시 보낸 쪽지함으로 이동 or 메일 발송 성공 페이지로 이동
		// insert 가 성공적으로 됐을 때 / 실패했을 때
		if(n==1) {
			mav.setViewName("redirect:/mail/mailSendList.bts");
		}
		else {// 실패 시 메일쓰기로 이동 (back)		
	//		mav.setViewName("redirect:/mailReceiveList.bts");
		}

		return mav;
	}	
	
	
	
	
	// 받은메일함 목록 보기 페이지 요청 (페이징 처리 및 검색기능 포함)
	@RequestMapping(value = "/mail/mailReceiveList.bts")	
	// URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
	// http://localhost:9090/bts/tiles1/mailList.bts
	public ModelAndView requiredLogin_mailList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

	
		// 로그인 세션 받아오기 (로그인 한 사람이 본인의 메일 목록만 볼 수 있도록)
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");

		
	//	System.out.println("받은쪽지함 페이지에서 로그인한 사용자 id (사원번호) 받아오기 " + loginuser.getPk_emp_no());
		
		String fk_receiveuser_num = String.valueOf(loginuser.getPk_emp_no());
		String empname = String.valueOf(loginuser.getEmp_name());
				
		List<MailVO> receiveMailList = null;
		
		// 검색 목록
		String searchType = request.getParameter("searchType");		// 사용자가 선택한 검색 타입
		String searchWord = request.getParameter("searchWord");		// 사용자가 입력한 검색어
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");	// 현재 페이지 번호
		
		// searchType 에는 제목 및 사원명이 있는데, 이 외의 것들이 들어오게 되면 기본값으로 보여준다
		if(searchType == null || (!"subject".equals(searchType)) && (!"sendempname".equals(searchType)) ) {
			searchType = "";
		}
		
		// 검색 입력창에 아무것도 입력하지 않았을 때 or 공백일 때 기본값을 보여주도록 한다.
		if(searchWord == null || "".equals(searchWord) && searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		// DB 로 보내기 위해 요청된 정보를 Map에 담는다.
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);

		paraMap.put("fk_receiveuser_num",fk_receiveuser_num);	// 로그인한 사용자의 사원번호 map 에 담아서 보내주기
		
		// 먼저 총 받은 메일 수(totalCount)를 구해와야 한다.
		// 총 게시물 건수는 검색조건이 있을 때와 없을 때로 나뉜다.
		int totalCount = 0;
		int sizePerPage = 10;
		int currentShowPageNo = 0;
		int totalPage = 0;
		
		int startRno = 0;
		int endRno = 0;
		
		// 총 받은 메일 건수 구해오기 (service 단으로 보내기) 
		totalCount =service.getTotalCount(paraMap); // 검색기능 포함시 paraMap 에 담아서 파라미터에 넣을 것
		 		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);	// 총 페이지 수 (전체게시물 / 페이지당 보여줄 갯수)

		if(str_currentShowPageNo == null) {
			// 페이지바를 거치지 않은 맨 처음 화면
			currentShowPageNo = 1;
		}
		else {	
			try {	// 사용자가 페이지 넘버에 정수만 입력할 수 있도록 설정		
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					// 1 미만의 페이지 또는 총 페이지 수를 넘어서는 페이지수 입력 시 기본페이지로
					currentShowPageNo = 1;
				}				
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		startRno = ( (currentShowPageNo - 1) * sizePerPage ) + 1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		 // 페이징처리 한 받은 메일목록 (검색 있든, 없든 모두 다 포함) 
		receiveMailList = service.recMailListSearchWithPaging(paraMap);
		
		// 검색대상 컬럼(searchType) 및 검색어(searchWord) 유지시키기 위함
		if(!"".equals(searchType) && !"".equals(searchWord)) {
			mav.addObject("paraMap", paraMap);
		}
		
		
		// === 페이지바 만들기 시작
		int blockSize = 3;
		// blockSize 는 1개 블럭(토막) 당 보여지는 페이지번호의 개수이다.
		/*
	        		1  2  3  4  5  6  7  8  9 10 [다음][마지막]  -- 1개블럭
			[맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
			[맨처음][이전]  21 22 23
		*/		
		
		int loop = 1;
		/*
    		loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		*/		
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style:none;'>";
		String url = "mailReceiveList.bts";	// 상대경로 mailReceiveList.bts	(앞에 /mail 붙이지 말고 맨 끝에 부분만 붙이도록 한다.)
		
		
		// [맨처음][이전] 만들기
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while ( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; color:black; padding: 2px 4px;'>"+pageNo+"</li>";				
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";				
			}
			
			loop++;
			pageNo++;
			
		}// end of while------------------------------------------
		
		
		// [다음][마지막] 만들기
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";	
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);


		// === 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		//     사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		//     현재 페이지 주소를 뷰단으로 넘겨준다.
	//	String goBackURL = MyUtil.getCurrnetURL(request);
	//	System.out.println("*** 확인용 goBackURL : "+goBackURL);
		/*
			*** 확인용 goBackURL : /list.action
			*** 확인용 goBackURL : /list.action?searchType= searchWord=%20 currentShowPageNo=2
			*** 확인용 goBackURL : /list.action?searchType=subject searchWord=j
			*** 확인용 goBackURL : /list.action?searchType=subject searchWord=j%20 currentShowPageNo=2
		*/
	//	mav.addObject("goBackURL", goBackURL.replaceAll("&", " "));		// view 단에 넘겨주자. & 을 " " 로 바꿔준 결과값들.
		// === 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 === //	
		///////////////////////////////////////////////////////////////////////////////////////////

		
		// 	받은 메일함 글목록 보여주기 
		// 	receiveMailList = service.getReceiveMailList();
				
		mav.addObject("receiveMailList", receiveMailList);		
		mav.addObject("fk_receiveuser_num", fk_receiveuser_num);
		mav.addObject("empname", empname);
		
		mav.setViewName("mailReceiveList.mail");
		
		return mav;
	}
	
	
	// 받은메일함 내용 읽기 (1개 메일함 상세내용 보여주는 페이지 요청)
	@RequestMapping(value = "/mail/mailReceiveDetail.bts")	
	// URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
	// http://localhost:9090/bts/tiles1/mailList.bts
	public ModelAndView requiredLogin_mailReceiveDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		//	getCurrentURL(request);	// 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		
		// view 단에서 요청한 검색타입 및 검색어, 글번호 받아오기
		String pk_mail_num = request.getParameter("pk_mail_num");	// 글번호
		String searchType = request.getParameter("searchType");		// 검색타입
		String searchWord = request.getParameter("searchWord");		// 검색어
		
		// 사용자가 검색타입 및 검색어를 입력하지 않았을 경우
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
		
		// 사용자가 메일번호(pk_mail_num=?) 뒤에 정수외의 것을 입력하지 않도록 exception 처리를 한다.
		try {
			Integer.parseInt(pk_mail_num);			

		
			// 글 내용 한개 뿐만 아니라 검색도 해야하므로 Map 에 담는다.
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("pk_mail_num", pk_mail_num);
			
			// mapper 로 사용자가 입력한 검색타입과 검색어를 map 에 담아서 보낸다.
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			// map 에 담은 검색타입과 검색어를 view 단으로 보낸다.
			mav.addObject("paraMap", paraMap);
			
			// 메일 1개 상세내용을 읽어오기 (service 로 보낸다.)
			MailVO mailvo = null;
			mailvo = service.getRecMailView(paraMap);
			mav.addObject("mailvo", mailvo);
			
			// 첨부파일 다운로드 받기				
			// 이전글 및 다음글 보여주기
			
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		
		mav.setViewName("mailReceiveDetail.mail");
		return mav;
	}		
	
	
	
	// 보낸메일함 목록 보기 페이지 요청 (페이징 처리 및 검색기능 포함)
	@RequestMapping(value = "/mail/mailSendList.bts")	
	public ModelAndView mailSend(HttpServletRequest request, ModelAndView mav) {

		// 로그인 세션 받아오기 (로그인 한 사람이 본인의 메일 목록만 볼 수 있도록)
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");

		
	//	System.out.println("보낸메일함 페이지에서 로그인한 사용자 id (사원번호) 받아오기 " + loginuser.getPk_emp_no());
		
		String fk_senduser_num = String.valueOf(loginuser.getPk_emp_no());
		String empname = String.valueOf(loginuser.getEmp_name());
				
		
		List<MailVO> SendMailList = null;
	
		// 검색 목록
		String searchType = request.getParameter("searchType");		// 사용자가 선택한 검색 타입
		String searchWord = request.getParameter("searchWord");		// 사용자가 입력한 검색어
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");	// 현재 페이지 번호
		
		// searchType 에는 제목 및 사원명이 있는데, 이 외의 것들이 들어오게 되면 기본값으로 보여준다
		if(searchType == null || (!"subject".equals(searchType)) && (!"recempname".equals(searchType)) ) {
			searchType = "";
		}
		
		// 검색 입력창에 아무것도 입력하지 않았을 때 or 공백일 때 기본값을 보여주도록 한다.
		if(searchWord == null || "".equals(searchWord) && searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		// DB 로 보내기 위해 요청된 정보를 Map에 담는다.
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);

		paraMap.put("fk_senduser_num",fk_senduser_num);	// 로그인한 사용자의 사원번호 map 에 담아서 보내주기
		
		// 먼저 총 받은 메일 수(totalCount)를 구해와야 한다.
		// 총 게시물 건수는 검색조건이 있을 때와 없을 때로 나뉜다.
		int totalCount = 0;
		int sizePerPage = 10;
		int currentShowPageNo = 0;
		int totalPage = 0;
		
		int startRno = 0;
		int endRno = 0;
		
		// 총 받은 메일 건수 구해오기 (service 단으로 보내기) 
		totalCount =service.getTotalCount_send(paraMap); // 검색기능 포함시 paraMap 에 담아서 파라미터에 넣을 것
		 		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);	// 총 페이지 수 (전체게시물 / 페이지당 보여줄 갯수)

		if(str_currentShowPageNo == null) {
			// 페이지바를 거치지 않은 맨 처음 화면
			currentShowPageNo = 1;
		}
		else {	
			try {	// 사용자가 페이지 넘버에 정수만 입력할 수 있도록 설정		
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					// 1 미만의 페이지 또는 총 페이지 수를 넘어서는 페이지수 입력 시 기본페이지로
					currentShowPageNo = 1;
				}				
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		startRno = ( (currentShowPageNo - 1) * sizePerPage ) + 1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		 // 페이징처리 한 보낸 메일목록 (검색 있든, 없든 모두 다 포함) 
		SendMailList = service.sendMailListSearchWithPaging(paraMap);
		
		// 검색대상 컬럼(searchType) 및 검색어(searchWord) 유지시키기 위함
		if(!"".equals(searchType) && !"".equals(searchWord)) {
			mav.addObject("paraMap", paraMap);
		}
		
		
		// === 페이지바 만들기 시작
		int blockSize = 3;
		// blockSize 는 1개 블럭(토막) 당 보여지는 페이지번호의 개수이다.
		/*
	        		1  2  3  4  5  6  7  8  9 10 [다음][마지막]  -- 1개블럭
			[맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
			[맨처음][이전]  21 22 23
		*/		
		
		int loop = 1;
		/*
    		loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		*/		
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style:none;'>";
		String url = "mailSendList.bts";	// 상대경로 mailReceiveList.bts	(앞에 /mail 붙이지 말고 맨 끝에 부분만 붙이도록 한다.)
		
		
		// [맨처음][이전] 만들기
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while ( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; color:black; padding: 2px 4px;'>"+pageNo+"</li>";				
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";				
			}
			
			loop++;
			pageNo++;
			
		}// end of while------------------------------------------
		
		
		// [다음][마지막] 만들기
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";	
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);


		// === 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		//     사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		//     현재 페이지 주소를 뷰단으로 넘겨준다.
	//	String goBackURL = MyUtil.getCurrnetURL(request);
	//	System.out.println("*** 확인용 goBackURL : "+goBackURL);
		/*
			*** 확인용 goBackURL : /list.action
			*** 확인용 goBackURL : /list.action?searchType= searchWord=%20 currentShowPageNo=2
			*** 확인용 goBackURL : /list.action?searchType=subject searchWord=j
			*** 확인용 goBackURL : /list.action?searchType=subject searchWord=j%20 currentShowPageNo=2
		*/
	//	mav.addObject("goBackURL", goBackURL.replaceAll("&", " "));		// view 단에 넘겨주자. & 을 " " 로 바꿔준 결과값들.
		// === 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 === //	
		///////////////////////////////////////////////////////////////////////////////////////////

		
		// 	보낸 메일함 글목록 보여주기 
		// 	receiveMailList = service.getReceiveMailList();
				
		mav.addObject("fk_senduser_num", fk_senduser_num);
		mav.addObject("SendMailList", SendMailList);				
		mav.addObject("empname", empname);
		mav.setViewName("mailSendList.mail");
		return mav;
	}	

	
	// 보낸메일함 내용 읽기 (1개 메일함 상세내용 보여주는 페이지 요청)
	@RequestMapping(value = "/mail/mailSendDetail.bts")	
	public ModelAndView mailSendDetail(HttpServletRequest request, ModelAndView mav) {
		
		//	getCurrentURL(request);	// 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		
		// view 단에서 요청한 검색타입 및 검색어, 글번호 받아오기
		String pk_mail_num = request.getParameter("pk_mail_num");	// 글번호
		String searchType = request.getParameter("searchType");		// 검색타입
		String searchWord = request.getParameter("searchWord");		// 검색어
		
		// 사용자가 검색타입 및 검색어를 입력하지 않았을 경우
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
		
		// 사용자가 메일번호(pk_mail_num=?) 뒤에 정수외의 것을 입력하지 않도록 exception 처리를 한다.
		try {
			Integer.parseInt(pk_mail_num);			

		
			// 글 내용 한개 뿐만 아니라 검색도 해야하므로 Map 에 담는다.
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("pk_mail_num", pk_mail_num);
			
			// mapper 로 사용자가 입력한 검색타입과 검색어를 map 에 담아서 보낸다.
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			// map 에 담은 검색타입과 검색어를 view 단으로 보낸다.
			mav.addObject("paraMap", paraMap);
			
			// 메일 1개 상세내용을 읽어오기 (service 로 보낸다.)
			MailVO mailvo = null;
			mailvo = service.getSendMailView(paraMap);
			mav.addObject("mailvo", mailvo);
			
			// 첨부파일 다운로드 받기				
			// 이전글 및 다음글 보여주기
			
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
				
		
		mav.setViewName("mailSendDetail.mail");
		return mav;
	}		
		
	
	// 중요메일함
	@RequestMapping(value = "/mail/mailImportantList.bts")	
	public ModelAndView mailImportant(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("mailImportant.mail");
		return mav;
	}	
	
	// 중요메일함 내용 읽기
	@RequestMapping(value = "/mail/mailImportantDetail.bts")	
	public ModelAndView mailImportantDetail(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("mailImportantDetail.mail");
		return mav;
	}		
	
	
	// 임시보관함 완료 페이지 요청 (MailTempVO 따로 사용)
	@RequestMapping(value = "/mail/mailTemporaryEnd.bts")	
	public ModelAndView mailTemporaryEnd(MultipartHttpServletRequest mrequest, ModelAndView mav, MailTempVO mailtempvo) {
		
		
		  // 받는사원 ID 
		  String fk_receiveuser_num = mrequest.getParameter("fk_receiveuser_num"); 
		  System.out.println("확인용 fk_receiveuser_num(사원번호) :" + fk_receiveuser_num);
		  
		  // 받는사원 사원명 
		  String empname = mrequest.getParameter("empname"); 
		  System.out.println("확인용 empname(사원명) :" + empname);

		  // 받는사원 이메일 
		  String email = mrequest.getParameter("email"); 
		  System.out.println("확인용 email(이메일) :" + email);
		  
		  // 제목 
		  String subject = mrequest.getParameter("subject"); 
		  System.out.println("확인용 subject(제목) :" + subject);
		  
		  // 메일쓰기 시 체크박스 체크여부 (체크 :1, 체크X :0) 
		  String importanceVal = mrequest.getParameter("importanceVal"); 
		  System.out.println("확인용 importanceVal(중요체크박스 체크여부) :" + importanceVal);
		  
		  // 첨부 파일 
		  String mail_attach = mrequest.getParameter("mail_attach"); 
		  System.out.println("확인용 mail_attach(첨부파일) :" + mail_attach);
		  
		  
		  // 메일 내용 
		  String content = mrequest.getParameter("content"); 
		  System.out.println("확인용 content(메일 내용) :" + content);
		 			
	//	mav.setViewName("mailTemporary.mail");
		return mav;
	}		
	
	// 임시보관함
	@RequestMapping(value = "/mail/mailTemporaryList.bts")	
	public ModelAndView mailTemporary(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("mailTemporary.mail");
		return mav;
	}	

	
	// 임시보관함 내용 읽기
	@RequestMapping(value = "/mail/mailTemporaryDetail.bts")	
	public ModelAndView mailTemporaryDetail(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("mailTemporaryDetail.mail");
		return mav;
	}		
	
	
	
	// 예약메일함
	@RequestMapping(value = "/mail/mailReservationList.bts")	
	public ModelAndView mailReservation(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("mailReservation.mail");
		return mav;
	}	
	
	// 예약메일함 내용 읽기
	@RequestMapping(value = "/mail/mailReservationDetail.bts")	
	public ModelAndView mailReservationDetail(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("mailReservationDetail.mail");
		return mav;
	}		
			

	// 받은메일함에서 메일 선택 시 휴지통으로 이동하기 (aJax, @ResponseBody)
	// 받은메일함에서 삭제할 메일 선택 후 삭제버튼 클릭 시 휴지통목록으로 해당 쪽지 이동
	@ResponseBody
	@RequestMapping(value = "/mail/RecmailMoveToRecyclebin.bts", produces = "text/plain; charset=UTF-8")	
	public String RecmailMoveToRecyclebin(HttpServletRequest request, MailVO mailvo) {
	
		// 삭제할 메일번호(문자열) , aJax로 보낸 데이터를 잘 받아오나 확인하자
		String pk_mail_num = request.getParameter("pk_mail_num");
		System.out.println("확인용 pk_mail_num : "+ pk_mail_num);
		
		// 삭제할 메일 개수
		String cnt = request.getParameter("cnt");
		System.out.println("확인용 cnt : "+ cnt);
		
		// 삭제 버튼을 누른 사원 id
		String fk_receiveuser_num = request.getParameter("fk_receiveuser_num");
		System.out.println("확인용 fk_receiveuser_num : "+ fk_receiveuser_num);

		/*
			확인용 pk_mail_num : ["chkBox","chkBox"]
			확인용 cnt : 2
			확인용 fk_receiveuser_num : 80000010
		*/
		
		// 배열의 [,] 를 제거한다.
		pk_mail_num = pk_mail_num.replaceAll("\\[", "");
		pk_mail_num = pk_mail_num.replaceAll("\\]", "");
		pk_mail_num = pk_mail_num.replaceAll("\"", "");
		pk_mail_num = pk_mail_num.trim();	// 공백 제거
		
		String[] arr_pk_mail_num = pk_mail_num.split(",");
		
		int n = 0;
		int m = 0;
		int result = 0;
		
		for (int i=0; i<arr_pk_mail_num.length; i++) {
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("pk_mail_num",arr_pk_mail_num[i]);
			/*
			 * // 메일 클릭 시 1개의 상세내용을 불러오도록 하자. (VO 에 담는다.) mailvo =
			 * service.getRecMailView(paraMap);
			 * 
			 * paraMap.put("pk_mail_num", mailvo.getPk_mail_num());
			 * paraMap.put("fk_senduser_num", mailvo.getFk_senduser_num());
			 * paraMap.put("fk_receiveuser_num", mailvo.getFk_receiveuser_num());
			 * paraMap.put("email", mailvo.getEmail()); paraMap.put("empname",
			 * mailvo.getEmpname()); paraMap.put("subject", mailvo.getSubject());
			 * paraMap.put("content", mailvo.getContent()); paraMap.put("filename",
			 * mailvo.getFilename()); paraMap.put("orgfilename", mailvo.getOrgfilename());
			 * paraMap.put("filesize", mailvo.getFilesize()); // paraMap.put("importance",
			 * mailvo.getImportance()); // paraMap.put("reservation_status",
			 * mailvo.getReservation_status()); // paraMap.put("read_status",
			 * mailvo.getRead_status()); paraMap.put("reg_date", mailvo.getReg_date()); //
			 * paraMap.put("reservation_date", mailvo.getReservation_date()); //
			 * paraMap.put("senduser_del_status", mailvo.getSenduser_del_status()); //
			 * paraMap.put("rcvuser_del_status", mailvo.getRcvuser_del_status());
			 * 
			 * // 삭제버튼 누른 사원의 id 를 paraMap 에 넣는다.
			 * paraMap.put("fk_receiveuser_num",fk_receiveuser_num);
			 */

			// 휴지통 테이블에 insert 하기 (첨부파일 유무에 따라 두가지 경우의수로 나누기)
			if(mailvo.getFilename() != null) {
				// 휴지통 테이블에 insert 한다. (첨부파일 있을 때)
				n = service.moveToRecyclebin(paraMap);
			}
			else {
			// 휴지통 테이블에 insert 한다. (첨부파일 없을 때)
				n = service.moveToRecyclebinNoFile(paraMap);
			}
			/*
			 * // 휴지통 테이블에 insert 성공 시 메일 테이블에서 해당 pk_mail_num 삭제하기 // 삭제가 아니라 받은 사원 삭제 여부를
			 * 1로 변경하기 if(n==1) { m = service.updateFromTblMailRecDelStatus(paraMap); }
			 */
		}
		
		JSONObject jsonObj = new JSONObject();
		
		// 휴지통 테이블에 insert (n==1) && 메일 테이블에서 해당 메일번호 삭제여부 1로 변경
		if(n==1 && m==1) {
			result = 1;
			jsonObj.put("result",result);
		}
		
		return jsonObj.toString();
	}		
	
	
	// 보낸메일함에서 메일 선택 시 휴지통으로 이동하기 (aJax, @ResponseBody)
	// 보낸메일함에서 삭제할 메일 선택 후 삭제버튼 클릭 시 휴지통목록으로 해당 쪽지 이동
	@ResponseBody
	@RequestMapping(value = "/mail/SendmailMoveToRecyclebin.bts", produces = "text/plain; charset=UTF-8")	
	public String SendmailMoveToRecyclebin(HttpServletRequest request) {
	
		
		
		return "";
	}		
	
	
	
	// 휴지통 목록 보여주기
	@RequestMapping(value = "/mail/mailRecyclebinList.bts")	
	public ModelAndView mailRecyclebin(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("mailRecyclebin.mail");
		return mav;
	}	

	// 휴지통 내용 읽기
	@RequestMapping(value = "/mail/mailRecyclebinDetail.bts")	
	public ModelAndView mailRecyclebinDetail(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("mailRecyclebinDetail.mail");
		return mav;
	}		
	
	// 휴지통 목록 삭제하기
	@RequestMapping(value = "/mail/mailRecyclebinClear.bts")	
	public ModelAndView mailRecyclebinClear(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("mailRecyclebinClear.mail");
		return mav;
	}		
	

	
	
	// 첨부파일 다운로드 하기 (메일 상세내용 보기 클릭 시 첨부된 파일 다운로드)
	@RequestMapping(value = "/mail/download.bts")
	public void download(HttpServletRequest request, HttpServletResponse response) {
	// 파일 다운로드만 받기 때문에 return 타입은 없다.
	// 원글에 대한 첨부파일 다운로드 이므로, 원글번호를 알아와야 한다.
	// 로그인 하지 않은 사용자가 url 에 주소를 입력하고 바로 들어올 수도 있다. (파일 다운로드는 로그인 해야만 다운받을 수 있다. 로그인을 했는지 안했는지 검사한다.)
	// 따라서 before,after 를 통해 로그인 유무를 검사해야한다.		
		String pk_mail_num = request.getParameter("pk_mail_num");
		
		/*
		 	첨부파일이 있는 글번호에서
		 	202204291419371025088801698800.jpg 처럼
		 	이러한 fileName 값을 DB 에서 가져와야 한다.
		 	또한 orgFilename 값도 DB 에서 가져와야 한다.
		 */

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");
		paraMap.put("pk_mail_num", pk_mail_num);
		
		// HttpServletResponse response 객체는 넘어온 데이터를 조작해서 결과물을 나타내고자 할 때 쓰인다. (웹에 보여주도록 하겠다.)
		response.setContentType("text/html; charset=UTF-8");	// content 타입을 셋팅한다.
		PrintWriter out = null;
		// out 은 웹브라우저에 기술하는 대상체라고 생각하자.

		try {
			
			Integer.parseInt(pk_mail_num);	// 글번호 자리에 숫자만 들어오도록 한다.
			MailVO mailvo = service.getRecMailView(paraMap);	// return 타입은 mailVO (글 1개를 얻어옴)
			
			// 글은 존재하지만 파일이 존재하지 않는 경우 (파일명이 존재하지 않는것 --> 파일이 존재 X)
			if(mailvo == null || (mailvo != null && mailvo.getFilename() == null) ) {
				out = response.getWriter();
				
				out.println("<script type='text/javascript'>alert('존재하지 않는 글번호이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다.'); history.back(); <script>");
				return;	// 종료
				
			}
			else {
				// 글도 존재하고 파일도 존재하는 경우 (올바르게 다운로드 될 수 있도록 한다.)
				String filename = mailvo.getFilename();
				// WAS(톰캣) 디스크에 저장된 파일명이다.
				
				String orgfilename = mailvo.getOrgfilename();
				// 다운로드를 받을 때에는 orgName 으로 받아야 한다. (숫자로 된 파일명을 다운받을 순 없으니..)
				
				// 첨부파일이 저장되어 있는 WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
	            // 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
	            // WAS 의 webapp 의 절대경로를 알아와야 한다.
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");	// /webapp
				
				String path = root+"resources"+File.separator+"files";
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
				      운영체제가 Windows 이라면 File.separator 는  "\" 이고,
				      운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
				*/				
				
				// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다. --> path 에 파일을 업로드 한다.
				// System.out.println("**** 확인용 path 의 절대경로 "+ path);
			
				// **** file 다운로드 하기 **** // 경로명을 알아왔으니 파일을 다운로드 받자.
				// fileManager 에서 파일다운로드 하기 부분을 참고하자. (의존객체 DI)	
				boolean flag = false;
				flag = fileManager.doFileDownload(filename, orgfilename, path, response);
				// fileName : 저장된 파일명, orgFilename : 다운로드 받을 때 필요 , path : 저장된 경로, response : 파라미터에 존재)
				// 파일 다운로드 성공시 flag는 true, 실패하면 flag는 false를 가진다.
				
				if(!flag) {
					// 다운로드 실패 시 메시지를 띄운다.
					out = response.getWriter();
					
					out.println("<script type='text/javascript'>alert('파일 다운로드에 실패했습니다.'); history.back(); <script>");
				}
				
			}
			
			
		} catch (NumberFormatException | IOException e) {
			// 숫자 이외의 것이 들어왔을 때 대비해서 예외처리 / 입출력 예외처리			
			try {
				out = response.getWriter();
				
				out.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다.'); history.back(); <script>");
			} catch (Exception e1) {
				e.printStackTrace();	
			}
			
		}
		
		
		
		
		
	}
	
	
}
