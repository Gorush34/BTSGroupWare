package com.spring.bts.yuri.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

import java.io.File;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.common.FileManager;
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
	
	
	
	
/*
	// === 전자결재 테스트 페이지 === //
	@RequestMapping(value="/edms/edmsTest.bts")
	public ModelAndView edmsTest(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		mav.setViewName("edms_test.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edms_test.jsp 페이지를 만들어야 한다.
		return mav;	
	}
*/
	

	
	// === 전자결재 홈 페이지 === //
	@RequestMapping(value="/edms/edmsHome.bts")
	public ModelAndView requiredLogin_edmsHome(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		mav.setViewName("edmsHome.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsHome.jsp 페이지를 만들어야 한다.
		return mav;		
	}
	
	
	
	// === 전자결재 문서작성 폼페이지 요청 === //
	@RequestMapping(value="/edms/edmsAdd.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView requiredLogin_addEdms(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsAdd.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsAdd.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	// 전자결재 작성 시 주소록 불러오기
	/*
	@ResponseBody
	@RequestMapping(value="/edms/edmsAdd/searchApprEmpList.bts", produces="text/plain;charset=UTF-8")
	public String searchApprEmpList(HttpServletRequest request) {
		
		String apprEmpName = request.getParameter("apprEmpName");
		
		// 사원 명단 불러오기
		List<EmployeeVO> ApprEmpList = service.searchApprEmpList(apprEmpName);

		JSONArray jsonArr = new JSONArray();
		if(ApprEmpList != null && ApprEmpList.size() > 0) {
			for(EmployeeVO evo : ApprEmpList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("userid", evo.getPk_emp_no());
				jsObj.put("name", evo.getEmp_name());
								
				jsonArr.put(jsObj);
			}
		}
				
		return jsonArr.toString();
	}
	*/
	
	// === (파일첨부가 있는)전자결재 문서작성 완료 요청 === //
	@RequestMapping(value="/edms/edmsAddEnd.bts", method= {RequestMethod.POST})
	public ModelAndView edmsAddEnd(Map<String,String> paraMap, ModelAndView mav, ApprVO apprvo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기 및 파일 첨부하기
	
		
	//	apprMidEmpDep
		String apprMidEmpDep = mrequest.getParameter("apprMidEmpDep");
		System.out.println("확인용 apprMidEmpDep => " + apprMidEmpDep);
		
		String contents = mrequest.getParameter("contents");
		System.out.println("확인용 contents => " + contents);
		
		String docformName = mrequest.getParameter("docformName");
		System.out.println("확인용 docformName => " + docformName);
		
	/*
	    form 태그의 name 명과  BoardVO 의 필드명이 같다라면 
	    request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
	        자동적으로 BoardVO boardvo 에 set 되어진다.
	*/
		
		// 전자결재 양식선택(업무기안서, 휴가신청서 등..)을 위한 것
//		List<String> apprsortList = service.getApprsortList();
		
//		mav.addObject("apprsortList", apprsortList);
		
		// !!! === 첨부파일이 있는 경우 종료 !!! === // 
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
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		// !!! === 첨부파일이 있는 경우 종료 !!! === //
		
		// 파일첨부가 없는 전자결재 문서작성
		int n = service.edmsAdd(apprvo);
		
		
		
		// 파일첨부가 있거나 없는 전자결재 문서작성
/*
		int n = 0;
		
		if( attach.isEmpty() ) {
			// 파일첨부가 없는 경우라면 
			n = service.edmsAdd(apprvo);
		}
		else {
			// 파일첨부가 있는 경우라면 
			n = service.edmsAdd_withFile(apprvo);
		}
*/		
		if(n==1) {
			mav.setViewName("redirect:/edmsList.action");
			//  /edmsList.action 페이지로 redirect(페이지이동)해라는 말이다.
		}
		else {
			mav.setViewName("bts/error/add_error.tiles1");
			//  /WEB-INF/views/tiles1/bts/error/add_error.jsp 파일을 생성한다.
		}
		
		return mav;
		
	}
	
	
	// === 전자결재 문서 상세보기 페이지 === //
	@RequestMapping(value="/edms/edmsView.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView viewEdms(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsView.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsView.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	
	// === 전자결재 내문서함(전체문서함) 페이지 === //
	@RequestMapping(value="/edms/edmsMydoc.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsMydoc(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsMydoc.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsMydoc.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	
	// === 전자결재 내문서함(대기문서함) 페이지 === //
	@RequestMapping(value="/edms/edmsMydoc_wait.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsMydoc_wait(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsMydoc_wait.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsMydoc_wait.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	
	// === 전자결재 내문서함(승인문서함) 페이지 === //
	@RequestMapping(value="/edms/edmsMydoc_accepted.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsMydoc_accepted(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsMydoc_accepted.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsMydoc_accepted.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	
	// === 전자결재 내문서함(반려문서함) 페이지 === //
	@RequestMapping(value="/edms/edmsMydoc_rejected.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsMydoc_rejected(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsMydoc_rejected.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsMydoc_rejected.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	
	// === 전자결재 결재하기 페이지 === //
	@RequestMapping(value="/edms/edmsApprove.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsApprove(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsApprove.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsApprove.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
}