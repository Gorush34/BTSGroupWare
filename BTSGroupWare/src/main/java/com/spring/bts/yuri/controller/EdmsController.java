package com.spring.bts.yuri.controller;

// import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.common.FileManager;
import com.spring.bts.common.MyUtil;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.yuri.model.ApprVO;
import com.spring.bts.yuri.service.InterEdmsService;

//=== 컨트롤러 선언 === //
@Component
/* 
	XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
	그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다.
	즉, 여기서 bean의 이름은 boardController 이 된다.
	여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller /* Bean + controller 기능을 모듀 포함 */
public class EdmsController {

	@Autowired    // Type에 따라 알아서 Bean 을 주입해준다.
    private InterEdmsService service;
	
	// === 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===  
	@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;	
	
	
	// === 전자결재 홈 페이지 === //
	@RequestMapping(value="/edms/edmsHome.bts")
	public ModelAndView requiredLogin_edmsHome(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");
		paraMap.put("startRno", "1");
		paraMap.put("endRno", "5");
		
		// 상태 상관없이 전체 리스트 불러오기
		List<Map<String, Object>> allList = service.getAllList(paraMap);
		
		// 상태가 승인됨인 리스트 불러오기
		List<Map<String, Object>> acceptList = service.getAcceptList(paraMap);
		
		// 상태가 반려됨인 리스트 불러오기
		List<Map<String, Object>> rejectList = service.getRejectList(paraMap);
		
		mav.addObject("all", allList);				// 전체목록 넣어줌
		mav.addObject("accept", acceptList);		// 승인목록 넣어줌
		mav.addObject("reject", rejectList);		// 반려목록 넣어줌
		
		mav.setViewName("edmsHome.edms");
		return mav;		
	}
	
			
	// === 전자결재 문서작성 폼페이지 요청 === //
	@RequestMapping(value="/edms/edmsAdd.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView requiredLogin_addEdms(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request);
		// 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
	
		/* 병윤 - 조직도 시작 */
	/*	
		System.out.println("~~~ 조직도 시작 ~~~");
		System.out.println("중간결재자 사번 => " + request.getParameter("middle_empno"));
		System.out.println("중간결재자 이름 => " + request.getParameter("middle_name"));
		System.out.println("중간결재자 직급 => " + request.getParameter("middle_rank"));
		System.out.println("중간결재자 부서 => " + request.getParameter("middle_dept"));
		System.out.println("~~~ 조직도 끝 ~~~\n");
	*/
		
		HttpSession session = request.getSession();
        EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
      
        List<EmployeeVO> empList = service.addBook_depInfo_select();
         
        /*
          String mid_test_1 = request.getParameter("mid_test_1");
          String mid_test_2 = request.getParameter("mid_test_2");
          String mid_test_3 = request.getParameter("mid_test_3");
          String last_test_1 = request.getParameter("last_test_1");
          String last_test_2 = request.getParameter("last_test_2");
          String last_test_3 = request.getParameter("last_test_3");
          
          System.out.println(mid_test_1);
          System.out.println(mid_test_2);
          System.out.println(mid_test_3);
          System.out.println(last_test_1);
          System.out.println(last_test_2);
          System.out.println(last_test_3);
        */
        
        mav.addObject("loginuser", loginuser);
        mav.addObject("empList", empList);
        
        /* 병윤 - 조직도 끝 */
	    
        mav.setViewName("add.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/add.jsp 페이지를 만들어야 한다.
		return mav;
		
	}
		
	// === (파일첨부가 있는)전자결재 문서작성 완료 요청 === //
	@RequestMapping(value="/edms/edmsAddEnd.bts", method= {RequestMethod.POST})
	public ModelAndView edmsAddEnd(Map<String,String> paraMap, ModelAndView mav, ApprVO apprvo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기 및 파일 첨부하기
	
		// ===== 들어왔는지 찍어보는 곳 시작 ===== // 
		// " 확인용은 getParameter 가 아닌 VO의 getter를 사용한다 " 또한 form 태그의 name은 vo의 필드명, 테이블의 컬럼명과 동일해야 한다!

		// form태그 name = VO 필드명 = DB 컬럼명
		// request.getParameter("폼태그네임"); 없이도 자동으로 ApprVO apprvo 에 set 됨
		
		// 잘못된 예시  
	//	String docform  = mrequest.getParameter("docform");
			
		// 올바른 예시
	//	System.out.println("~~~~~ 결재번호 apprvo.getPk_appr_no() => " + apprvo.getPk_appr_no());
	/*
		MultipartHttpServletRequest mrequest 를 사용하기 위해서는 servlet-context.xml 에서 파일 업로드 및 파일 다운로드에 필요한 의존객체 설정  

		웹페이지에 요청 form이 enctype="multipart/form-data" 으로 되어있어서 Multipart 요청(파일처리 요청)이 들어올때 
		컨트롤러에서는 HttpServletRequest 대신 MultipartHttpServletRequest 인터페이스를 사용해야 한다.
		MultipartHttpServletRequest 인터페이스는 HttpServletRequest 인터페이스와  MultipartRequest 인터페이스를 상속받고있다.
		즉, 웹 요청 정보를 얻기 위한 getParameter()와 같은 메소드와 Multipart(파일처리) 관련 메소드를 모두 사용가능하다.  	
	*/	
		
		// !!! === 첨부파일이 있는 경우 시작 !!! === // 
		MultipartFile attach = apprvo.getAttach();
		
		// 첨부파일이 있는 경우
		if( !attach.isEmpty() ) {
		/*
		   1.사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
		   >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
		   		우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
				조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
		*/
			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			
			System.out.println("~~~~ 확인용  webapp 의 절대경로 => " + root);
			// ~~~~ 확인용  webapp 의 절대경로 =>  
			
			String path = root+"resources"+File.separator+"files";
			/*  File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
				운영체제가 Windows 이라면 File.separator 는  "\" 이고,
				운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
		    */
			
			// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			System.out.println("~~~~ 확인용  path => " + path);
			// ~~~~ 확인용  path => 
			
			
		/*
		   2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기 
		*/
			
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명 
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것 
			
			long fileSize = 0;
			// 첨부파일의 크기 
			
			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				
				String originalFilename = attach.getOriginalFilename();
				// getOrgFilename 이 아니다! ApprVO가 아니라 MultipartFile에 정의된 것!
				
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
				System.out.println("~~~~ 확인용 originalFilename => " + originalFilename);
				// ~~~~ 확인용 originalFilename => 
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
				
				System.out.println(">>> 확인용 newFileName => " + newFileName);
				// >>> 확인용 newFileName => 
			
		/*
		   3. ApprVO apprvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기 
		*/
				
				apprvo.setFilename(newFileName);
				// WAS(톰캣)에 저장될 파일명(2022042912181535243254235235234.png)
				
				apprvo.setOrgfilename(originalFilename);
				// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
				// 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
				
				fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
				apprvo.setFileSize(String.valueOf(fileSize));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		// !!! === 첨부파일이 있는 경우 종료 !!! === //
		//  === 파일첨부가 있는 글쓰기 또는 파일첨부가 없는 글쓰기로 나뉘어서 service 호출하기 === // 
		//  먼저 위의  int n = service.add(boardvo); 부분을 주석처리 하고서 아래와 같이 한다.	
		
		int n = 0;
		
		if( attach.isEmpty() ) {
			// 파일첨부가 없는 경우라면 
			n = service.edmsAdd(apprvo);
		}
		else {
			// 파일첨부가 있는 경우라면 
			n = service.edmsAdd_withFile(apprvo);
		}
		
		if(n==1) {
			mav.setViewName("redirect:/edms/edmsHome.bts");
			//  /bts/edmsHome.bts 페이지로 redirect(페이지이동)
		}
		else {
			mav.setViewName("bts/error/add_error.edms");
			//  /WEB-INF/views/edms/bts/error/add_error.jsp 파일을 생성
		}
				
		return mav;
	}
	

	////////////////////////////////////////////////////////////////////////	
	
	
	// 전체 글목록 보기 //
	@RequestMapping(value="/edms/list.bts")
	public ModelAndView list(ModelAndView mav, HttpServletRequest request) {
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출
		
		List<Map<String, Object>> edmsList = null;
		
		// 조회수 증가 확인을 위한 session값 얻어오기
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");

		// === 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 시작 === //
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String emp_name = request.getParameter("emp_name"); // 이거 추가
		
		// System.out.println("~~~ searchWord : " + searchWord);
		
		if(searchType == null || (!"title".equals(searchType) && !"emp_name".equals(searchType)) ) {
			searchType = "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("emp_name", emp_name); // 이거 추가
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다. 
		int totalCount = 0;			// 총 게시물 건수
		int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;	// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;			// 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0;			// 시작 행번호
		int endRno = 0;				// 끝 행번호
		
		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalCount(paraMap);
		// System.out.println("~~~~~ 확인용 totalCount : " + totalCount);
	
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		// (double)127/10 ==> 12.7 ==> Math.ceil(12.7) ==> 13.0 ==> (int)13.0 ==> 13
		// (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> 12.0 ==> (int)12.0 ==> 12
		
		if(str_currentShowPageNo == null) {		// 게시판에 보여지는 초기화면
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo); 
				if( currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		// *** 가져올 게시글의 범위 구하기 시작 *** //		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));		
		
		edmsList = service.getAllList(paraMap);
		// 페이징한 대기문서 목록 가져오기(검색유무 상관없이 모두 가져온다.)
		
		// 검색대상 컬럼과 검색어 유지
		if( !"".equals(searchType) && !"".equals(searchWord) ) {
			mav.addObject("paraMap", paraMap);
		}
		
		// 페이지바 만들기
		int blockSize = 10; // 1개의 블록마다 보여질 페이지번호의 개수 1 2 3 ... 10 [다음] 이런 식!
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "list.bts";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		/*
		 * 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		 * 사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해 
		 * 현재 페이지 주소를 뷰단으로 넘겨준다.
		 */		
		String gobackURL = MyUtil.getCurrentURL(request);
		// System.out.println("~~~++~~ 확인용 gobackURL : " + gobackURL);
		
		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
		// ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ====
		///////////////////////////////////////////////////////////////
		
		mav.addObject("edmsList", edmsList);
		mav.setViewName("list.edms");
		// /WEB-INF/views/edms/list.jsp 페이지를 만들어야 한다.
		
		return mav;		
	}
	
	
	// === 대기중인 보기 페이지 요청 === //
	@RequestMapping(value="/edms/wait/list.bts")
	public ModelAndView list_wait(ModelAndView mav, HttpServletRequest request) {
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출
		
		List<Map<String, Object>> companyWaitList = null;
		
		// 조회수 증가 확인을 위한 session값 얻어오기
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");

		// === 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 시작 === //
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String emp_name = request.getParameter("emp_name"); // 이거 추가
		
		// System.out.println("~~~ searchWord : " + searchWord);
		
		if(searchType == null || (!"title".equals(searchType) && !"emp_name".equals(searchType)) ) {
			searchType = "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("emp_name", emp_name); // 이거 추가
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다. 
		int totalCount = 0;			// 총 게시물 건수
		int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;	// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;			// 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0;			// 시작 행번호
		int endRno = 0;				// 끝 행번호
		
		// 총 게시물 건수(totalCount)
		totalCount = service.getcompanyWaitList_Cnt(paraMap);
		// System.out.println("~~~~~ 확인용 totalCount : " + totalCount);
	
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		// (double)127/10 ==> 12.7 ==> Math.ceil(12.7) ==> 13.0 ==> (int)13.0 ==> 13
		// (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> 12.0 ==> (int)12.0 ==> 12
		
		if(str_currentShowPageNo == null) {		// 게시판에 보여지는 초기화면
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo); 
				if( currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		// *** 가져올 게시글의 범위 구하기 시작 *** //		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));		
		
		companyWaitList = service.getcompanyWaitList(paraMap);
		// 페이징한 대기문서 목록 가져오기(검색유무 상관없이 모두 가져온다.)
		
		// 검색대상 컬럼과 검색어 유지
		if( !"".equals(searchType) && !"".equals(searchWord) ) {
			mav.addObject("paraMap", paraMap);
		}
		
		// 페이지바 만들기
		int blockSize = 10; // 1개의 블록마다 보여질 페이지번호의 개수 1 2 3 ... 10 [다음] 이런 식!
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "list.bts";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		/*
		 * 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		 * 사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해 
		 * 현재 페이지 주소를 뷰단으로 넘겨준다.
		 */		
		String gobackURL = MyUtil.getCurrentURL(request);
		// System.out.println("~~~++~~ 확인용 gobackURL : " + gobackURL);
		
		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
		// ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ====
		///////////////////////////////////////////////////////////////
		
		mav.addObject("companyWaitList", companyWaitList);
		mav.setViewName("wait/list.edms");
		// /WEB-INF/views/edms/list.jsp 페이지를 만들어야 한다.
		
		return mav;	
	}
	
	
	
	
	
	// === 내문서함-승인문서함 페이지 요청 === //
	@RequestMapping(value="/edms/accept/list.bts")
	public ModelAndView list_accept(ModelAndView mav, HttpServletRequest request) {
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchType == null || (!"title".equals(searchType) && !"emp_name".equals(searchType)) ) {
			searchType = "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다. 
		int totalCount = 0;			// 총 게시물 건수
		int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;	// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;			// 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0;			// 시작 행번호
		int endRno = 0;				// 끝 행번호
		
		// 내문서함 - 승인문서함 총 게시물 건수(totalCount)
		totalCount = service.getTotalCount_accept(paraMap);
		// System.out.println("~~~~~ 내문서함 - 승인문서함 totalCount : " + totalCount);
		
		// 만약에 총 게시물 건수(totalCount)가 127개 이라면 총 페이지수(totalPage)는 13개가 되어야 한다.
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		
		if(str_currentShowPageNo == null) { // 게시판에 보여지는 초기화면
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if( currentShowPageNo < 1 || currentShowPageNo > totalPage) { currentShowPageNo = 1; }
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		// *** 가져올 게시글의 범위 구하기 시작 *** //		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));		
		
		List<Map<String, Object>> acceptList = service.getAcceptList(paraMap);
		// 페이징한 대기문서 목록 가져오기(검색유무 상관없이 모두 가져온다.)
		
		// 검색대상 컬럼과 검색어 유지
		if( !"".equals(searchType) && !"".equals(searchWord) ) {
			mav.addObject("paraMap", paraMap);
		}
		
		// 페이지바 만들기
		int blockSize = 10; // 1개의 블록마다 보여질 페이지번호의 개수 1 2 3 ... 10 [다음] 이런 식!
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "list.bts";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		while( !(loop > blockSize || pageNo > totalPage) ) {
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		mav.addObject("pageBar", pageBar);
		
		String gobackURL = MyUtil.getCurrentURL(request);
		
		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
		// ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ====
		
		mav.addObject("acceptList", acceptList);
		mav.setViewName("accept/list.edms");
		
		return mav;		
	}
	
	
	
	
	// === 반려문서 보기 페이지 요청 === //
	@RequestMapping(value="/edms/reject/list.bts")
	public ModelAndView list_reject(ModelAndView mav, HttpServletRequest request) {
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchType == null || (!"title".equals(searchType) && !"emp_name".equals(searchType)) ) {
			searchType = "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다. 
		int totalCount = 0;			// 총 게시물 건수
		int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;	// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;			// 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0;			// 시작 행번호
		int endRno = 0;				// 끝 행번호
		
		// 내문서함 - 반려문서함 총 게시물 건수(totalCount)
		totalCount = service.getTotalCount_reject(paraMap);
		// System.out.println("~~~~~ 내문서함 - 반려문서함 totalCount : " + totalCount);
		
		// 만약에 총 게시물 건수(totalCount)가 127개 이라면 총 페이지수(totalPage)는 13개가 되어야 한다.
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		
		if(str_currentShowPageNo == null) { // 게시판에 보여지는 초기화면
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if( currentShowPageNo < 1 || currentShowPageNo > totalPage) { currentShowPageNo = 1; }
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		// *** 가져올 게시글의 범위 구하기 시작 *** //		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));		
		
		List<Map<String, Object>> rejectList = service.getRejectList(paraMap);
		// 페이징한 대기문서 목록 가져오기(검색유무 상관없이 모두 가져온다.)
		
		// 검색대상 컬럼과 검색어 유지
		if( !"".equals(searchType) && !"".equals(searchWord) ) {
			mav.addObject("paraMap", paraMap);
		}
		
		// 페이지바 만들기
		int blockSize = 10; // 1개의 블록마다 보여질 페이지번호의 개수 1 2 3 ... 10 [다음] 이런 식!
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "list.bts";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		while( !(loop > blockSize || pageNo > totalPage) ) {
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		mav.addObject("pageBar", pageBar);
		
		String gobackURL = MyUtil.getCurrentURL(request);
		
		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
		// ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ====
		
		mav.addObject("rejectList", rejectList);
		mav.setViewName("reject/list.edms");
		
		return mav;		
	}
	
	
	
	
	
	
	
	
	// === 전자결재 대기문서 상세보기 페이지 === //
	@RequestMapping(value="/edms/view.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView requiredLogin_view(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		// 조회하고자 하는 글번호 받아오기
	 	String pk_appr_no = request.getParameter("pk_appr_no");
	 	// 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다. 

	 	// 문서번호로 결재자 이름 알아오기
	 	Map<String, String> signMap = new HashMap<>();
	 	signMap = service.getApprSignInfo(pk_appr_no);
	 	
	 	mav.addObject("apprname", signMap); // 이름 넣어줌
	 	
	 	// 문서번호로 중간결재자의 부서명 알아오기
	 	Map<String, String> midDepName = new HashMap<>();
	 	midDepName = service.getMidDepName(pk_appr_no);
	 	mav.addObject("midDepName", midDepName);
	 	
	 	// 문서번호로 최종결재자의 부서명 알아오기
	 	Map<String, String> finDepName = new HashMap<>();
	 	finDepName = service.getFinDepName(pk_appr_no);
	 	mav.addObject("finDepName", finDepName);
	 	
	 	String fk_emp_no = request.getParameter("fk_emp_no");			// 글 작성자의 사번
	 	String fk_mid_empno = request.getParameter("fk_mid_empno");		// 중간결재자의 사번
	 	String fk_fin_empno = request.getParameter("fk_fin_empno");		// 최종결재자의 사번
	 	
	 	String searchType = request.getParameter("searchType");
	 	String searchWord = request.getParameter("searchWord");
	 	
	 	if(searchType == null || (!"title".equals(searchType) )) {
	 		searchType = "title";
	 	}
	 	
	 	if(searchWord == null) {
	 		searchWord = "";
	 	}
	 	
	 	/*
		 * 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		 * 사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해 
		 * 현재 페이지 주소를 뷰단으로 넘겨준다.
		 */
	 	String gobackURL = request.getParameter("gobackURL");
	 //	System.out.println("~~~ 확인용 gobackURL : " + gobackURL);
	 	
	 	if( gobackURL != null && gobackURL.contains(" ") ) {
	 		gobackURL = gobackURL.replaceAll(" ", "&");
	 	}
	 	
	 //	System.out.println("~~~ 확인용 gobackURL : " + gobackURL);
	 	
	 //	System.out.println("~~~~ view 의 searchType : " + searchType);
	 //	System.out.println("~~~~ view 의 searchWord : " + searchWord);
	 //	System.out.println("~~~~ view 의 gobackURL : " + gobackURL);
	 	
	 	mav.addObject("gobackURL", gobackURL);
	 	
	 	try {
	 		Integer.parseInt(pk_appr_no);
	 		
	 		Map<String, String> paraMap = new HashMap<>();
	 		paraMap.put("pk_appr_no", pk_appr_no);
	 		
	 		paraMap.put("searchType", searchType);
	 		paraMap.put("searchWord", searchWord);
	 		// view.jsp 에서 이전글제목 및 다음글제목 클릭시 사용하기 위해서 임.
	 		
	 		paraMap.put("fk_emp_no", fk_emp_no);
	 		paraMap.put("fk_mid_empno", fk_mid_empno);
	 		paraMap.put("fk_fin_empno", fk_fin_empno);
	 		
	 		HttpSession session = request.getSession();
	 		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	 		
	 		int loginuser_empno = 0;
	 		if(loginuser != null) {
	 			loginuser_empno = loginuser.getPk_emp_no();
		 	   // loginuser_empno 는 로그인 되어진 사용자의 사원번호 이다.
		 	}
	 		paraMap.put("loginuser_empno", String.valueOf(loginuser_empno));
	 			 		
		 	// 웹브라우저에서 페이지 새로고침(F5)을 했을 때는 단순히 select만 해주고 sDML문(지금은 글조회수 증가인 update문)은 실행하지 않도록 해주어야 한다.
		 	 
		 	ApprVO apprvo = null;
		 	if( "yes".equals(session.getAttribute("readCountPermission")) ) {
		 		// 글목록보기를 클릭한 다음에 특정글을 조회해온 경우이다.
		 	 
		 		apprvo = service.getView(paraMap);
			 	// 글조회수 증가와 함께 글1개를 조회를 해주는 것 
		 		
		 		session.removeAttribute("readCountPermission");
		 		// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
		 		
		 //		System.out.println("~~~~~ view.bts에서 확인용 apprvo.getFk_emp_no1 => " + apprvo.getFk_emp_no());
		 	}
		 	else {
		 		// 웹브라우저에서 새로고침(F5)을 클릭한 경우이다. 
		 		
		 		apprvo = service.getViewWithNoAddCount(paraMap);
		 //		System.out.println("~~~~~ view.bts에서 확인용 apprvo.getFk_emp_no2 => " + apprvo.getFk_emp_no());
			 	// 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것이다.  
		 	}
		 	
		 	mav.addObject("apprvo", apprvo);
		 	mav.addObject("paraMap", paraMap);
		 	// System.out.println("확인용 apprvo 작성일자 => " + apprvo.getWriteday());
		 	
		 	//////////////////////////////////////////
		 	
	 	} catch(NumberFormatException e) {
	 		
	 	}

		mav.setViewName("view.edms");
		// /WEB-INF/views/edms/{1}/{2}.jsp
		// /WEB-INF/views/edms/view.jsp 페이지를 만들어야 한다.
		
		return mav;
	}
	
	@RequestMapping(value="/edms/view_2.bts")
	public ModelAndView view_2(ModelAndView mav, HttpServletRequest request) {
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
		
		// 조회하고자 하는 글번호 받아오기 
	 	String pk_appr_no = request.getParameter("pk_appr_no");
	 	
	 	String searchType = request.getParameter("searchType");
	 	String searchWord = request.getParameter("searchWord");
	 	String gobackURL = request.getParameter("gobackURL");
	 	
	 //	System.out.println("~~~~ view_2 의 searchType : " + searchType);
	 //	System.out.println("~~~~ view_2 의 searchWord : " + searchWord);
	 //	System.out.println("~~~~ view_2 의 gobackURL : " + gobackURL);
	 	
	 	HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		try {
			searchWord = URLEncoder.encode(searchWord, "UTF-8"); // 한글이 웹브라우저 주소창에서 사용되어질때 한글이 ? 처럼 안깨지게 하려고 하는 것임.  
			gobackURL = URLEncoder.encode(gobackURL, "UTF-8");   // 한글이 웹브라우저 주소창에서 사용되어질때 한글이 ? 처럼 안깨지게 하려고 하는 것임.
		/*	
			System.out.println("~~~~ view2 의 URLEncoder.encode(searchWord, \"UTF-8\") : " + searchWord);
			System.out.println("~~~~ view2 의 URLEncoder.encode(gobackURL, \"UTF-8\") : " + gobackURL);
			
			System.out.println(URLDecoder.decode(searchWord, "UTF-8")); // URL인코딩 되어진 한글을 원래 한글모양으로 되돌려 주는 것임. 
			System.out.println(URLDecoder.decode(gobackURL, "UTF-8"));  // URL인코딩 되어진 한글을 원래 한글모양으로 되돌려 주는 것임. 
		*/	
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		
	 	mav.setViewName("redirect:/view.bts?pk_appr_no="+pk_appr_no+"&searchType="+searchType+"&searchWord="+searchWord+"&gobackURL="+gobackURL);
	 	
		return mav;
	}
	
	
	// === 글 수정페이지 요청 === //
	@RequestMapping(value="/edms/edit.bts")
	public ModelAndView requiredLogin_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 수정해야 할 글번호 가져오기
		String pk_appr_no = request.getParameter("pk_appr_no");
		
		// 수정해야할 글1개 내용 가져오기 
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_appr_no", pk_appr_no);
		
		///////////////////////////////
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");
        ///////////////////////////////
		
		ApprVO apprvo = service.getViewWithNoAddCount(paraMap);
		// 글조회수(readCount) 증가 없이 단순히 글1개만 조회해주는 것이다.
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		// 자신의 글을 수정하는 경우 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
		if( loginuser.getPk_emp_no() == apprvo.getFk_emp_no() ) {
			mav.addObject("apprvo", apprvo);
			mav.setViewName("edit.edms");
		}
		else {
			String message = "다른 사용자의 글은 수정이 불가합니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}
		
		return mav;
	}
		
		
		
	// === 글수정 페이지 완료하기 === //
	@RequestMapping(value="/edms/editEnd.bts", method= {RequestMethod.POST})
	public ModelAndView editEnd(ModelAndView mav, ApprVO apprvo, HttpServletRequest request) {
		
		int n = service.edit(apprvo);
		// n 이 1 이라면 정상적으로 변경, 0 이라면 변경 실패
		
		if(n==0) {
			mav.addObject("message", "글 수정 실패!!");
			mav.addObject("loc", "javascript:history.back()");
		}
		else {
			mav.addObject("message", "글 수정 성공!!");
			mav.addObject("loc", request.getContextPath()+"/view.bts?pk_appr_no="+apprvo.getPk_appr_no());
		}
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	// 오류 원인
	// 1. 서비스에서 filename을 fileName이라고 가져옴
	// 2. view.jsp에서 viewfrm이라고 적었는데 그런 거 없음
	// 3. delFrm으로 감싼 부분에 pk_appr_no이 없어서 sys로 찍어보니 null 이 나와서 담아줌
	
	// === 글삭제 페이지 완료하기 === //
	@RequestMapping(value="/edms/delEnd.bts", method= {RequestMethod.POST})
	public ModelAndView delEnd(ModelAndView mav, HttpServletRequest request) {

		// 삭제해야 할 글번호 가져오기
		String pk_appr_no = request.getParameter("pk_appr_no"); // 글 번호
		String fk_emp_no1 = request.getParameter("fk_emp_no");	// 작성자 사번
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_appr_no", pk_appr_no);
		
		/////////////////////////////// GoBackURL 때문에 넣어준 것이다.
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");
		///////////////////////////////
		
		// 글조회수(readCount) 증가 없이 1개의 글 조회하기
		ApprVO apprvo = service.getViewWithNoAddCount(paraMap);
		
		// 로그인한 사용자의 정보 가져오기
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		int loginuser_empno = 0;
		if(loginuser != null) {
			loginuser_empno = loginuser.getPk_emp_no();	// 로그인한 사용자의 사번을 담아준다.
		}
		
		// 로그인한 사람이 쓴 글이라면 글삭제가 가능하지만 다른 사람이 쓴 글은 삭제가 불가하도록 해야 한다.
		int int_fk_emp_no1 = Integer.parseInt(fk_emp_no1);
		
		// 로그인유저의 사번과 글쓴 사람의 사번이 같은 경우
		if( loginuser_empno == int_fk_emp_no1 || loginuser.getPk_emp_no() == 80000001 ) {
			
			apprvo = service.getViewWithNoAddCount(paraMap);
			
			String filename = apprvo.getFilename();
			
			if( filename != null && !"".equals("") ) {
				session = request.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root+"resources"+File.separator+"files";
				
				paraMap.put("path", path); // 삭제해야할 파일이 저장된 경로
				paraMap.put("filename", filename); // 삭제해야할 파일명
			}
			
			int n = service.del(paraMap);
			
			if(n==1) {
				mav.addObject("message", "글 삭제 성공!!");
				
				// 작성자 본인인 경우 결재 전이므로 대기문서 목록으로 보낸다.
				if( loginuser.getPk_emp_no() == apprvo.getFk_emp_no() ) {
					mav.addObject("loc", request.getContextPath()+"/edms/mydoc/waitlist.bts");
				}
				// 관리자인 경우 전체목록으로 보낸다.
				if( loginuser.getPk_emp_no() == 80000001 ) {
					mav.addObject("loc", request.getContextPath()+"/edms/list.bts");
				}
			}
			else {
				mav.addObject("message", "글 삭제 실패!!");
				mav.addObject("loc", "javascript:history.back()");
			}
			
			mav.setViewName("msg");	
		}
		
		else {
			String message = "다른 사용자의 글은 삭제가 불가합니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}
		return mav;

	} // end of public ModelAndView delEnd ----------------------------------------------------------

	
	// === 승인하기 페이지 요청하기 === //
	@RequestMapping(value="/edms/appr/accept.bts")
	public ModelAndView requiredLogin_accept(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ApprVO apprvo) { 
		
		// 승인할 문서번호 가져오기
		String pk_appr_no = request.getParameter("pk_appr_no");
		
		// 문서번호 통해 문서정보 가져오기
		apprvo = service.getApprInfo(pk_appr_no);
		
		mav.addObject("apprvo", apprvo);
		mav.setViewName("appr/accept.edms");
		return mav;
	}

	// === 반려하기 페이지 요청하기 === //
	@RequestMapping(value="/edms/appr/reject.bts")
	public ModelAndView requiredLogin_reject(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ApprVO apprvo) { 
		
		// 반려할 문서번호 가져오기
		String pk_appr_no = request.getParameter("pk_appr_no");
		
		// 문서번호 통해 문서정보 가져오기
		apprvo = service.getApprInfo(pk_appr_no);
		
		mav.addObject("apprvo", apprvo);
		mav.setViewName("appr/reject.edms");
		
		return mav;
	} // end of public ModelAndView requiredLogin_reject(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 

	
	// === 승인하기 페이지 완료하기 === //
	@RequestMapping(value="/edms/appr/acceptEnd.bts", method= {RequestMethod.POST})
	public ModelAndView acceptEnd(ModelAndView mav, HttpServletRequest request, ApprVO apprvo) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		int pk_emp_no = loginuser.getPk_emp_no();
		
		if(apprvo.getMid_opinion() == null) {
			apprvo.setMid_opinion("");
		}
		
		if(apprvo.getFin_opinion() == null) {
			apprvo.setFin_opinion("");
		}
		
		if(pk_emp_no == apprvo.getFk_mid_empno()) {
			// 중간관리자라면
			apprvo.setMid_accept("1"); // 승인 값 넣어줌
		}
		else if(pk_emp_no == apprvo.getFk_fin_empno()) {
			// 최종관리자라면
			apprvo.setFin_accept("1"); // 승인 값 넣어줌
		}
		
		// 승인 처리하기
		int n = service.updateAppr(apprvo);
		
		if(n==1) {
			mav.addObject("message", "승인 성공!!");
			mav.addObject("loc", request.getContextPath()+"/edms/list.bts");
		}
		else {
			mav.addObject("message", "승인 실패!!");
			mav.addObject("loc", "javascript:history.back()");
		}
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	

	
	// === 반려하기 페이지 완료하기 === //
	@RequestMapping(value="/edms/appr/rejectEnd.bts", method= {RequestMethod.POST})
	public ModelAndView rejectEnd(ModelAndView mav, HttpServletRequest request, ApprVO apprvo) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		int pk_emp_no = loginuser.getPk_emp_no();
		
		if(apprvo.getMid_opinion() == null) {
			apprvo.setMid_opinion("의견없음");
		}
		
		if(apprvo.getFin_opinion() == null) {
			apprvo.setFin_opinion("의견없음");
		}
		
		
		if(pk_emp_no == apprvo.getFk_mid_empno() && "0".equals(apprvo.getFin_accept()) ) {
			// 중간관리자라면
			apprvo.setMid_accept("2"); // 반려 값 넣어줌
		}
		
		if(pk_emp_no == apprvo.getFk_fin_empno() && "1".equals(apprvo.getMid_accept()) ) {
			// 최종관리자라면
			apprvo.setFin_accept("2"); // 반려 값 넣어줌
		}
		
		
	//	System.out.println("최종반려 : " + apprvo.getFin_accept());
		
		// 반려 처리하기
		int n = service.updateAppr(apprvo);
		
		if(n==1) {
			mav.addObject("message", "반려 성공!!");
			mav.addObject("loc", request.getContextPath()+"/edms/list.bts");
		}
		else {
			mav.addObject("message", "반려 실패!!");
			mav.addObject("loc", "javascript:history.back()");
		}
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	// 검색어 입력시 자동글 완성 searchAutoComplete
	@ResponseBody
	@RequestMapping(value="/edms/wordSearchShow.bts", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String wordSearchShow(HttpServletRequest request) {
		
	//	String emp_name = request.getParameter("emp_name");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		List<String> wordList = service.wordSearchShow(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(wordList != null) {
			for(String word : wordList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("word", word);
				
				jsonArr.put(jsonObj);
			}// end of for-----------------
		}
		
		return jsonArr.toString();
	}
	
	// === 전자결재 내문서함(전체문서함) 페이지 === //
/*
	@RequestMapping(value="/edms/mylist.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsMydoc(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsMydoc.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsMydoc.jsp 페이지를 만들어야 한다.
		return mav;
	}
*/	
	
	// ==== 첨부파일 다운로드 받기 ==== //
	@RequestMapping(value="/edms/download.bts")
	public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
		
		String pk_appr_no = request.getParameter("pk_appr_no");
	//	System.out.println("++ 다운로드 확인용 pk_appr_no : "+pk_appr_no);
		// 첨부파일이 있는 글번호 
		
		/*
			첨부파일이 있는 글번호에서
			20220429141939883981362180900.jpg 처럼
			이러한 fileName 값을 DB에서 가져와야 한다.
			또한 orgFilename 값도  DB에서 가져와야 한다.
		 */
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");
		paraMap.put("pk_appr_no", pk_appr_no);
		
		System.out.println("++ 다운로드 확인용 searchType : "+ paraMap.get("searchType"));
		System.out.println("++ 다운로드 확인용 searchWord : "+ paraMap.get("searchWord"));
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null;
		// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
		
		try {
			Integer.parseInt(pk_appr_no);
			ApprVO apprvo = service.getViewWithNoAddCount(paraMap);
			
			if(apprvo == null || (apprvo != null && apprvo.getFilename() == null ) ) {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
				
				out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
				return; // 종료
			}
			else {
				// 정상적으로 다운로드를 할 경우
				
				String fileName = apprvo.getFilename();
				// 20220429141939883981362180900.jpg  이것인 바로 WAS(톰캣) 디스크에 저장된 파일명이다. 
				
				String orgFilename = apprvo.getOrgfilename();
				// 쉐보레전면.jpg  다운로드시 보여줄 파일명 
				
				
				// 첨부파일이 저장되어 있는 WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
	            // 이 경로는 우리가 파일첨부를 위해서 /edmsAddEnd.bts 에서 설정해두었던 경로와 똑같아야 한다.
	            // WAS 의 webapp 의 절대경로를 알아와야 한다.
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");
				
				System.out.println("++ 다운로드 확인용  webapp 의 절대경로 => " + root);
				// C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\ 
				// C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\BTSGroupWare\
				
				String path = root+"resources"+File.separator+"files";
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			            운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			            운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
			    */
				
				// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
				System.out.println("++ 다운로드 확인용  path => " + path);
				// C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
				// C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\BTSGroupWare\resources\files 
				
				// **** file 다운로드 하기 **** //
				boolean flag = false; // file 다운로드 성공, 실패를 알려주는 용도
				flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
				// file 다운로드 성공시 flag 는 true, 
				// file 다운로드 실패시 flag 는 false 를 가진다. 
				
				if(!flag) {
					// 다운로드가 실패할 경우 메시지를 띄워준다.
					out = response.getWriter();
					// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
					
					out.println("<script type='text/javascript'>alert('파일다운로드가 실패되었습니다.'); history.back();</script>");
				}
				
			}
			
		} catch(NumberFormatException | IOException e) {
			try {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
				
				out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
			} catch (IOException e1) {
				e1.printStackTrace();
			}

		}
		
	}
	
	
	
	// ==== #168. 스마트에디터. 드래그앤드롭을 사용한 다중사진 파일 업로드 ==== //
	@RequestMapping(value="/image/multiplePhotoUpload.bts", method= {RequestMethod.POST} )
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
	/*
		1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
		>>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
		우리는 WAS 의 webapp/resources/photo_upload 라는 폴더로 지정해준다.
	*/
	      
		// WAS 의 webapp 의 절대경로를 알아와야 한다.
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources" + File.separator + "photo_upload"; 
		// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다.
		System.out.println("~~~~ 확인용  webapp 의 절대경로 => " + root);
	      
		System.out.println("~~~~ 확인용 path => " + path);
		// ~~~~ 확인용  webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\photo_upload 
		
		// 경로에 파일 올리기
		File dir = new File(path);
		
		if(!dir.exists()) {	// photo_upload 라는 이름의 폴더가 존재하지 않는 경우 만들어준다.
			dir.mkdirs();	// s가 붙으면 서브폴더까지 만들라는 뜻이다!s
		}
	      
		try {
			String filename = request.getHeader("file-name"); // 파일명(문자열)을 받는다 - 일반 원본파일명
			// 네이버 스마트에디터를 사용한 파일업로드시 싱글파일업로드와는 다르게 멀티파일업로드는 파일명이 header 속에 담겨져 넘어오게 되어있다. 
	         
		/*
			[참고]
			HttpServletRequest의 getHeader() 메소드를 통해 클라이언트 사용자의 정보를 알아올 수 있다. 
	   
			request.getHeader("referer");           // 접속 경로(이전 URL)
			request.getHeader("user-agent");        // 클라이언트 사용자의 시스템 정보
			request.getHeader("User-Agent");        // 클라이언트 브라우저 정보 
			request.getHeader("X-Forwarded-For");   // 클라이언트 ip 주소 
			request.getHeader("host");              // Host 네임  예: 로컬 환경일 경우 ==> localhost:9090    
		  */
	         
			System.out.println(">>> 확인용 filename ==> " + filename);
			// >>> 확인용 filename ==> berkelekle%EB%8B%A8%EA%B0%80%EB%9D%BC%ED%8F%AC%EC%9D%B8%ED%8A%B803.jpg 
	         
			InputStream is = request.getInputStream(); // is는 네이버 스마트 에디터를 사용하여 사진첨부하기 된 이미지 파일임.
						
			String newFilename = fileManager.doFileUpload(is, filename, path);
			
			String ctxPath = request.getContextPath(); //  /board
						
			String strURL = "";
			strURL += "&bNewLine=true&sFileName=" + newFilename;
			
			strURL += "&sWidth=";		// 너비 &sWidth=50 이런 식으로 쓰면 되는데 지금 안된다 나중에 알려주겠음?
			
			strURL += "&sFileURL=" + ctxPath + "/resources/photo_upload/" + newFilename;
			// 틀린 것 : strURL += "&sFileURL=" + ctxPath + "/resources/photo_upload" + newFilename;
						
			// === 웹브라우저 상에 사진 이미지를 쓰기 === //
			PrintWriter out = response.getWriter();
			out.print(strURL);
	
		} catch (Exception e) {
			e.printStackTrace();
		}	      
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////
	// 정환모 작업공간 끝
	
	// === 로그인유저의 결재대기목록 페이지 === //
	@RequestMapping(value="/edms/waitingSignList.bts")
	public ModelAndView requiredLogin_waitingSignList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		String pk_emp_no = String.valueOf(loginuser.getPk_emp_no());
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchType == null || (!"title".equals(searchType) && !"emp_name".equals(searchType)) ) {
			searchType = "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("pk_emp_no", pk_emp_no);
		
		int totalCount = 0;        // 총 게시물 건수
		int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0; // 시작 행번호
		int endRno = 0;   // 끝 행번호
		 
		// System.out.println(" 결재대기 searchType : " + searchType);
		// System.out.println(" 결재대기 searchWord : " + searchWord);
		
		// 로그인유저의 결재대기문서 총 갯수  가져오기
		totalCount = service.getTotalCountWaitingSign(paraMap);
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		
		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo); 
				if( currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;

		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		// 페이징 처리한 로그인유저의 결재대기목록 가져오기
		List<Map<String, Object>> waitingList = service.waitingSignListWithPaging(paraMap);
		
		// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		if( !"".equals(searchType) && !"".equals(searchWord)) {
			mav.addObject("paraMap", paraMap);
		}
		
		// === 페이지바 만들기 === //
		int blockSize = 10;
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "waitingSignList.bts";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a style='color: black;' href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		String gobackURL = MyUtil.getCurrentURL(request);

		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
		mav.addObject("waitingList", waitingList);
		
		/////////////////////////////////////
		
		mav.setViewName("waitingSignList.edms");
		
		return mav;		
	} // end of public ModelAndView requiredLogin_waitingSignList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {-------------
	
	
	
	
	// 정환모 작업공간 끝
	////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	
	
	
	
	// /edms/waitListCntForMain.bts
	// 유리
	// 메인 페이지 인덱스 index.bts에 불러올 전자결재 수신대기 문서의 개수
	// 로그인유저의 결재대기문서 총 갯수  가져오기
	/*
	 @RequestMapping(value = "/edms/waitListCntForMain.bts")
	 
	public String waitListCntForMain(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		int fk_emp_no = loginuser.getPk_emp_no();
		System.out.println("fk_emp_no => " + fk_emp_no);
		int n = service.waitListCntForMain(fk_emp_no);
		System.out.println("main용 n => " + n);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	*/
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	// === 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성 === //
	public void getCurrentURL(HttpServletRequest request) {
	HttpSession session = request.getSession();
	session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// === 진행중인 나의 문서함 요청 === //
	@RequestMapping(value="/edms/mydoc/waitlist.bts")
	public ModelAndView mywaitlist(ModelAndView mav, HttpServletRequest request) {
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출
		
		List<Map<String, Object>> mywaitlist = null;
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		// 본인글만 보기 위해 paraMap에 로그인한 사원의 사번 추가함
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
 		
		int loginuser_empno = 0;
 		if(loginuser != null) {
 			loginuser_empno = loginuser.getPk_emp_no();
	 	   // loginuser_empno 는 로그인 되어진 사용자의 사원번호 이다.
	 	}
		
 	//	System.out.println("loginuser_empno" + loginuser_empno);
 		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchType == null || (!"title".equals(searchType) && !"emp_name".equals(searchType)) ) {
			searchType = "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("loginuser_empno", String.valueOf(loginuser_empno));
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다. 
		int totalCount = 0;			// 총 게시물 건수
		int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;	// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;			// 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0;			// 시작 행번호
		int endRno = 0;				// 끝 행번호
		
		// 내문서함 - 대기/진행중인문서함 총 게시물 건수(totalCount)
		totalCount = service.mywaitlist_cnt(paraMap);
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		
		if(str_currentShowPageNo == null) { // 게시판에 보여지는 초기화면
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if( currentShowPageNo < 1 || currentShowPageNo > totalPage) { currentShowPageNo = 1; }
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		// *** 가져올 게시글의 범위 구하기 시작 *** //		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));		
		
		// 상태가 대기/진행중인 나의 문서 불러오기
		mywaitlist = service.mywaitlist_paging(paraMap);
		
		// 검색대상 컬럼과 검색어 유지
		if( !"".equals(searchType) && !"".equals(searchWord) ) {
			mav.addObject("paraMap", paraMap);
		}
		
		// 페이지바 만들기
		int blockSize = 10; // 1개의 블록마다 보여질 페이지번호의 개수 1 2 3 ... 10 [다음] 이런 식!
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "waitlist.bts";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		while( !(loop > blockSize || pageNo > totalPage) ) {
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		mav.addObject("pageBar", pageBar);
		
		String gobackURL = MyUtil.getCurrentURL(request);
		
		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
		// ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ====
		
		mav.addObject("mywaitlist", mywaitlist);
		mav.setViewName("mydoc/waitlist.edms");
		
		return mav;		
	}
	
	@RequestMapping(value="/edms/mydoc/acceptlist.bts")
	public ModelAndView myacceptlist(ModelAndView mav, HttpServletRequest request) {
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출
		
		HttpSession session = request.getSession();
		// session.setAttribute("readCountPermission", "yes");
		
		// 본인글만 보기 위해 paraMap에 로그인한 사원의 사번 추가함
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
 		
		int loginuser_empno = loginuser.getPk_emp_no();
 		/*
		if(loginuser != null) {
 			loginuser_empno = loginuser.getPk_emp_no();
	 	   // loginuser_empno 는 로그인 되어진 사용자의 사원번호 이다.
	 	}
		*/
 		// System.out.println("accept의 loginuser_empno =>" + loginuser_empno );
 		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchType == null || (!"title".equals(searchType) && !"emp_name".equals(searchType)) ) {
			searchType = "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("loginuser_empno", String.valueOf(loginuser_empno));
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다. 
		int totalCount = 0;			// 총 게시물 건수
		int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;	// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;			// 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0;			// 시작 행번호
		int endRno = 0;				// 끝 행번호
		
		// 내문서함 - 대기/진행중인문서함 총 게시물 건수(totalCount)
		totalCount = service.myacceptlist_cnt(paraMap);
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		
		if(str_currentShowPageNo == null) { // 게시판에 보여지는 초기화면
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if( currentShowPageNo < 1 || currentShowPageNo > totalPage) { currentShowPageNo = 1; }
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		// *** 가져올 게시글의 범위 구하기 시작 *** //		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));		
		
		// 상태가 대기/진행중인 나의 문서 불러오기
		List<Map<String, Object>> myAcc = service.myacceptlist_paging(paraMap);
		
		// 검색대상 컬럼과 검색어 유지
		if( !"".equals(searchType) && !"".equals(searchWord) ) {
			mav.addObject("paraMap", paraMap);
		}
		
		// 페이지바 만들기
		int blockSize = 10; // 1개의 블록마다 보여질 페이지번호의 개수 1 2 3 ... 10 [다음] 이런 식!
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "acceptlist.bts";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		while( !(loop > blockSize || pageNo > totalPage) ) {
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		mav.addObject("pageBar", pageBar);
		mav.addObject("myAcc", myAcc);
		String gobackURL = MyUtil.getCurrentURL(request);
		
		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
		// ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ====
		
		
		mav.setViewName("mydoc/acceptlist.edms");
		
		return mav;		
	}
	
	
	@RequestMapping(value="/edms/mydoc/rejectlist.bts")
	public ModelAndView myrejectlist(ModelAndView mav, HttpServletRequest request) {
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출
		
		List<Map<String, Object>> myrejectlist = null;
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		// 본인글만 보기 위해 paraMap에 로그인한 사원의 사번 추가함
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
 		
		int loginuser_empno = 0;
 		if(loginuser != null) {
 			loginuser_empno = loginuser.getPk_emp_no();
	 	   // loginuser_empno 는 로그인 되어진 사용자의 사원번호 이다.
	 	}
		
 	//	System.out.println("loginuser_empno" + loginuser_empno);
 		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchType == null || (!"title".equals(searchType) && !"emp_name".equals(searchType)) ) {
			searchType = "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("loginuser_empno", String.valueOf(loginuser_empno));
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다. 
		int totalCount = 0;			// 총 게시물 건수
		int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;	// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;			// 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0;			// 시작 행번호
		int endRno = 0;				// 끝 행번호
		
		// 내문서함 - 대기/진행중인문서함 총 게시물 건수(totalCount)
		totalCount = service.myrejectlist_cnt(paraMap);
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		
		if(str_currentShowPageNo == null) { // 게시판에 보여지는 초기화면
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if( currentShowPageNo < 1 || currentShowPageNo > totalPage) { currentShowPageNo = 1; }
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		// *** 가져올 게시글의 범위 구하기 시작 *** //		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));		
		
		// 상태가 대기/진행중인 나의 문서 불러오기
		myrejectlist = service.myrejectlist_paging(paraMap);
		
		// 검색대상 컬럼과 검색어 유지
		if( !"".equals(searchType) && !"".equals(searchWord) ) {
			mav.addObject("paraMap", paraMap);
		}
		
		// 페이지바 만들기
		int blockSize = 10; // 1개의 블록마다 보여질 페이지번호의 개수 1 2 3 ... 10 [다음] 이런 식!
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "rejectlist.bts";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		while( !(loop > blockSize || pageNo > totalPage) ) {
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		mav.addObject("pageBar", pageBar);
		
		String gobackURL = MyUtil.getCurrentURL(request);
		
		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
		// ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ====
		
		mav.addObject("myrejectlist", myrejectlist);
		mav.setViewName("mydoc/rejectlist.edms");
		
		return mav;		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// totalCount = service.getTotalCountWaitingSign(paraMap);

	
	
	@RequestMapping(value="/edms/getWaitingSignListCount.bts")
	public @ResponseBody Map<String, Integer> waitingSignListCount(HttpServletRequest request) {
		
		Map<String, String> paramMap = new HashMap<>();
		
		HttpSession session = request.getSession();
        EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
        
        paramMap.put("pk_emp_no", String.valueOf(loginuser.getPk_emp_no()));
        paramMap.put("mid_accept", "0"); // 대기중(중간결재 대기) 문서 가져오기
	
		int middleCount = service.getWaitingSignListCount(paramMap);
		paramMap.put("mid_accept", "1"); // 진행중(최종결재 대기) 문서 가져오기
		
		int finalCount = service.getWaitingSignListCount(paramMap);
		Map<String, Integer> map = new HashMap<>();
		map.put("totalCount", middleCount + finalCount);
		
		return map;
	}
	
	
}