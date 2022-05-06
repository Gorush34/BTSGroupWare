package com.spring.bts.minjeong.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.hwanmo.model.EmployeeVO;
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
	
	/*
	 * // === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency
	 * Injection) ===
	 * 
	 * @Autowired // Type에 따라 알아서 Bean 을 주입해준다. private FileManager fileManager; //
	 * type (FileManager) 만 맞으면 다 주입해준다.
	 */	
	
	// 메일 쓰기 폼페이지 요청 (추후 로그인 AOP 추가 requiredLogin_) 
	@RequestMapping(value = "/mail/mailWrite.bts", produces = "text/plain; charset=UTF-8")	
	public ModelAndView mailWrite(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
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
	
	// 메일 쓰기 완료 페이지 요청
	@RequestMapping(value = "/mail/mailWriteEnd.bts", method= {RequestMethod.POST})	
	public String mailWriteEnd(MultipartHttpServletRequest mrequest) {

		// form 태그로 보낸 정보들을 받아오자.
		// 받는사원번호 및 사원명이 여러명이므로 배열로 받아온다.
		
		
		
		
		// 성공 시 보낸 쪽지함으로 이동
		
		// 실패 시 메일쓰기로 이동 (back)
		
		return "";
	}	
	
	
	
	
	// 받은메일함 목록 보기 페이지 요청 (페이징 처리 및 검색기능 포함)
	@RequestMapping(value = "/mail/mailReceiveList.bts")	
	// URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
	// http://localhost:9090/bts/tiles1/mailList.bts
	public ModelAndView mailList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		List<MailVO> receiveMailList = null;
	
		// 검색 목록
		String searchType = request.getParameter("searchType");		// 사용자가 선택한 검색 타입
		String searchWord = request.getParameter("searchWord");		// 사용자가 입력한 검색어
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");	// 현재 페이지 번호
		
		// searchType 에는 제목 및 사원명이 있는데, 이 외의 것들이 들어오게 되면 기본값으로 보여준다
		if(searchType == null || (!"subject".equals(searchType)) && (!"receiveuser_name".equals(searchType)) ) {
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
			pageBar += "<li><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'></a>[맨처음]</li>";
			pageBar += "<li><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1"+(pageNo-1)+"'></a>[이전]</li>";
		}
		
		while ( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li>"+pageNo+"</li>";				
			}
			else {
				pageBar += "<li><a href='"+url+"?searchType='"+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";				
			}
			
			loop++;
			pageNo++;
		}
		
		
		// [다음][마지막] 만들기
		if(pageNo <= totalPage) {
			pageBar += "<li><a href='"+url+"?searchType='"+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";	
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		
		// 	받은 메일함 글목록 보여주기 
		// 	receiveMailList = service.getReceiveMailList();
				
		mav.addObject("receiveMailList", receiveMailList);		
		mav.setViewName("mailReceiveList.mail");
		
		return mav;
	  //  return "/tiles1/mailList.jsp";	// 아래와 같이 써서 오류가 났음.
	}
	
	
	// 받은메일함 내용 읽기
	@RequestMapping(value = "/mail/mailReceiveDetail.bts")	
	// URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
	// http://localhost:9090/bts/tiles1/mailList.bts
	public String mailReceiveDetail(HttpServletRequest request) {

		// 첨부파일 다운로드 받기	
		
		// 이전글 및 다음글 보여주기
		
		return "mailReceiveDetail.mail";
    //  return "/tiles1/mailList.jsp";	// 아래와 같이 써서 오류가 났음.
	}	
	
	
	// 보낸메일함
	@RequestMapping(value = "/mail/mailSend.bts")	
	public String mailSend(HttpServletRequest request) {
		
		return "mailSendList.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}	

	
	// 보낸메일함 내용 읽기
	@RequestMapping(value = "/mail/mailSendDetail.bts")	
	public String mailSendDetail(HttpServletRequest request) {
		
		return "mailSendDetail.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}		
		
	
	// 중요메일함
	@RequestMapping(value = "/mail/mailImportant.bts")	
	public String mailImportant(HttpServletRequest request) {
		
		return "mailImportant.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}	
	
	// 중요메일함 내용 읽기
	@RequestMapping(value = "/mail/mailImportantDetail.bts")	
	public String mailImportantDetail(HttpServletRequest request) {
		
		return "mailImportantDetail.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}		
	
	
	// 임시보관함
	@RequestMapping(value = "/mail/mailTemporary.bts")	
	public String mailTemporary(HttpServletRequest request) {
		
		return "mailTemporary.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}	
	
	
	// 임시보관함 내용 읽기
	@RequestMapping(value = "/mail/mailTemporaryDetail.bts")	
	public String mailTemporaryDetail(HttpServletRequest request) {
		
		return "mailTemporaryDetail.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}		
	
	
	
	// 예약메일함
	@RequestMapping(value = "/mail/mailReservation.bts")	
	public String mailReservation(HttpServletRequest request) {
		
		return "mailReservation.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}	
	
	// 예약메일함 내용 읽기
	@RequestMapping(value = "/mail/mailReservationDetail.bts")	
	public String mailReservationDetail(HttpServletRequest request) {
		
		return "mailReservationDetail.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}		
			
	
	// 휴지통 목록 보여주기
	@RequestMapping(value = "/mail/mailRecyclebin.bts")	
	public String mailRecyclebin(HttpServletRequest request) {
		
		return "mailRecyclebin.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}	

	// 휴지통 내용 읽기
	@RequestMapping(value = "/mail/mailRecyclebinDetail.bts")	
	public String mailRecyclebinDetail(HttpServletRequest request) {
		
		return "mailRecyclebinDetail.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}		
	
	// 휴지통 목록 삭제하기
	@RequestMapping(value = "/mail/mailRecyclebinClear.bts")	
	public String mailRecyclebinClear(HttpServletRequest request) {
		
		return "mailRecyclebinClear.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}		
	
}
