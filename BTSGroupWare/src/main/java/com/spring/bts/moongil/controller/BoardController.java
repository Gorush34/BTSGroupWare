package com.spring.bts.moongil.controller;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
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
import com.spring.bts.moongil.model.BoardVO;
import com.spring.bts.moongil.model.CommentVO;
import com.spring.bts.moongil.model.FileboardVO;
import com.spring.bts.moongil.model.LikeVO;
import com.spring.bts.moongil.model.NoticeVO;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.moongil.service.InterBoardService;



//=== #30. 컨트롤러 선언 === // 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
즉, 여기서 bean의 이름은  btsController 이 된다. 
여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BtsController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller
public class BoardController {

	@Autowired
	private InterBoardService service;
		@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
		private FileManager fileManager;
	
	
/*	
		@RequestMapping(value = "/board/main.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
		public ModelAndView main_list(ModelAndView mav, HttpServletRequest request, BoardVO boardvo, NoticeVO noticevo) {
			

			mav.setViewName("board_main.board");
			//  /WEB-INF/views/tiles1/board/list.jsp 파일을 생성한다.
			
			return mav;
		
		}
*/

		@RequestMapping(value="/board/index.bts")
		public ModelAndView index(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
			
				mav.setViewName("index.board");
			
			return mav;
		}		
		
		// === 메인페이지 === //
		@ResponseBody
		@RequestMapping(value = "/board/readNotice.bts", produces = "text/plain;charset=UTF-8")
		public String ajax_getNotice(HttpServletRequest request, HttpServletResponse response) {
			

			List<Map<String, String>> boardList = service.getNoticeboard();
			
			JSONArray jsonArr = new JSONArray();
			
			if(boardList != null && boardList.size() > 0) {
				
				for(Map<String, String> boardMap : boardList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("pk_seq", boardMap.get("pk_seq"));
					jsonObj.put("header", boardMap.get("header"));
					jsonObj.put("subject", boardMap.get("subject"));
					jsonObj.put("user_name", boardMap.get("user_name"));
					jsonObj.put("write_day", boardMap.get("write_day"));
					jsonArr.put(jsonObj);
				}
				
			}
			
			return jsonArr.toString();
		}
						
		
		@ResponseBody
		@RequestMapping(value = "/board/readBoard.bts", produces = "text/plain;charset=UTF-8")
		public String ajax_getBoard(HttpServletRequest request, HttpServletResponse response) {
			

			List<Map<String, String>> boardList = service.getBoard();
			
			JSONArray jsonArr = new JSONArray();
			
			if(boardList != null && boardList.size() > 0) {
				
				for(Map<String, String> boardMap : boardList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("pk_seq", boardMap.get("pk_seq"));
					jsonObj.put("subject", boardMap.get("subject"));
					jsonObj.put("user_name", boardMap.get("user_name"));
					jsonObj.put("write_day", boardMap.get("write_day"));
					jsonObj.put("ko_rankname", boardMap.get("ko_rankname"));
					jsonArr.put(jsonObj);
				}
				
			}
			
			return jsonArr.toString();
		}
		
		@ResponseBody
		@RequestMapping(value = "/board/readFileboard.bts", produces = "text/plain;charset=UTF-8")
		public String ajax_getFileboard(HttpServletRequest request, HttpServletResponse response) {
			
			List<Map<String, String>> boardList = service.getFileboard();
			
			JSONArray jsonArr = new JSONArray();
			
			if(boardList != null && boardList.size() > 0) {
				
				for(Map<String, String> boardMap : boardList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("pk_seq", boardMap.get("pk_seq"));
					jsonObj.put("subject", boardMap.get("subject"));
					jsonObj.put("user_name", boardMap.get("user_name"));
					jsonObj.put("write_day", boardMap.get("write_day"));
					jsonObj.put("ko_rankname", boardMap.get("ko_rankname"));
					jsonObj.put("ko_depname", boardMap.get("ko_depname"));
					jsonArr.put(jsonObj);
				}
				
			}
			
			return jsonArr.toString();
		}
		
		// === 사이드인포 === //
		@ResponseBody
		@RequestMapping(value = "/board/readBest.bts", produces = "text/plain;charset=UTF-8")
		public String ajax_getBestboard(HttpServletRequest request, HttpServletResponse response) {
			
			Date date = new Date();        
			String now = String.format("%1$tY-%1$tm-%1$td", date);
//			System.out.println(now);
			List<Map<String, String>> boardList = service.getBestboard();
			
			JSONArray jsonArr = new JSONArray();
			
			if(boardList != null && boardList.size() > 0) {
				
				for(Map<String, String> boardMap : boardList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("pk_seq", boardMap.get("pk_seq"));
					jsonObj.put("subject", boardMap.get("subject"));
					jsonObj.put("read_count", boardMap.get("read_count"));
					jsonObj.put("user_name", boardMap.get("user_name"));
					jsonObj.put("now", now);
					jsonArr.put(jsonObj);
				}
				
			}
			
			return jsonArr.toString();
		}
		
		
		@ResponseBody
		@RequestMapping(value = "/board/main.bts", produces = "text/plain;charset=UTF-8")
		public ModelAndView requiredLogin_Boardmain(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, BoardVO boardvo) {
			
			HttpSession session = request.getSession();
			
			getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
			
			List<BoardVO> boardList = null;
		
			 
			session.setAttribute("readCountPermission", "yes");

			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");
				
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
			if(searchType == null || (!"subject".equals(searchType) && !"user_name".equals(searchType)) ) {
				searchType = "";
			}
			
			if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
				searchWord = "";
			}
	//		System.out.println("searchType =>" +searchType);
	//		System.out.println("searchWord =>" +searchWord);
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			int totalCount = 0;        // 총 게시물 건수
			int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
			int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
			int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
			
			int startRno = 0; // 시작 행번호
			int endRno = 0;   // 끝 행번호
			 
			// 총 게시물 건수(totalCount)
			totalCount = service.getTotalCount_total(paraMap);
		
			totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
	//		System.out.println("totalCount =>" +totalCount);
	//		System.out.println("totalPage =>" +totalPage);
			
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
			
			boardList = service.boardListSearchWithPaging_total(paraMap);
			// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
			
			// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
			if( !"".equals(searchType) && !"".equals(searchWord) ) {
				mav.addObject("paraMap", paraMap);
			}
			
			
			// === 페이지바 만들기 === //
			int blockSize = 10;
			
			int loop = 1;
			
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			
			String pageBar = "<ul style='list-style: none;'>";
			String url = "main.bts";
			
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
			

			
			mav.addObject("boardList", boardList);
			
			/////////////////////////////////////
			
			
			mav.setViewName("board_main.board");
			//  /WEB-INF/views/tiles1/board/list.jsp 파일을 생성한다.
			
			return mav;
		}// end of public String requiredLogin_ajax_getIntegratedBoard(HttpServletRequest request, HttpServletResponse response) {}
		
		
	
	// --- 게시판 시작 ---  -----------------
	@RequestMapping(value = "/board/list.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
	public ModelAndView list(ModelAndView mav, HttpServletRequest request, BoardVO boardvo) {
		
		///////////////////////////////////
		
		HttpSession session = request.getSession();
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
		
		List<BoardVO> boardList = null;
	
		 
		session.setAttribute("readCountPermission", "yes");

		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
			
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchType == null || (!"subject".equals(searchType) && !"user_name".equals(searchType)) ) {
			searchType = "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		int totalCount = 0;        // 총 게시물 건수
		int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0; // 시작 행번호
		int endRno = 0;   // 끝 행번호
		 
		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalCount(paraMap);
	
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
		
		boardList = service.boardListSearchWithPaging(paraMap);
		// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
		
		// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		if( !"".equals(searchType) && !"".equals(searchWord) ) {
			mav.addObject("paraMap", paraMap);
		}
		
		
		// === 페이지바 만들기 === //
		int blockSize = 10;
		
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
		

		
		mav.addObject("boardList", boardList);
		
		/////////////////////////////////////
		
		
		mav.setViewName("board/list.board");
		//  /WEB-INF/views/tiles1/board/list.jsp 파일을 생성한다.
		
		return mav;
	
	}
	
	@RequestMapping(value="board/view_2.bts")
	public ModelAndView view_2(ModelAndView mav, HttpServletRequest request) {
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
		
		// 조회하고자 하는 글번호 받아오기 
	 	String pk_seq = request.getParameter("pk_seq");
	 	
	 	String searchType = request.getParameter("searchType");
	 	String searchWord = request.getParameter("searchWord");
	 	String gobackURL = request.getParameter("gobackURL");

	 	
	 	HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
	 	
		try {
	         searchWord = URLEncoder.encode(searchWord, "UTF-8"); // 한글이 웹브라우저 주소창에서 사용되어질때 한글이 ? 처럼 안깨지게 하려고 하는 것임.  
	         gobackURL = URLEncoder.encode(gobackURL, "UTF-8");   // 한글이 웹브라우저 주소창에서 사용되어질때 한글이 ? 처럼 안깨지게 하려고 하는 것임.

	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      } 
		
	 	mav.setViewName("redirect:/board/view.bts?pk_seq="+pk_seq+"&searchType="+searchType+"&searchWord="+searchWord+"&gobackURL="+gobackURL);
	 	
		return mav;
	}	

	
	
	@RequestMapping(value = "/board/temp_list.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
	public ModelAndView temp_list(ModelAndView mav, HttpServletRequest request, BoardVO boardvo) {
		
		request.getSession();
		
		// 조회하고자 하는 글번호 받아오기 
		String pk_seq = request.getParameter("pk_seq");		 			 	

		String fk_emp_no = request.getParameter("fk_emp_no");
		
	//	System.out.println(fk_emp_no);
		
		List<BoardVO> boardList = null;
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_seq", pk_seq);
		paraMap.put("fk_emp_no", fk_emp_no);
		boardList = service.temp_list(paraMap);
		// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)

		mav.addObject("boardList", boardList);
		
		
		mav.setViewName("board/temp_list.board");
		//  /WEB-INF/views/tiles1/board/list.jsp 파일을 생성한다.
		
		return mav;
	
	}
	
	
	
	// === 게시판 글쓰기 ====
	// === #51. 게시판 글쓰기 폼페이지 요청 === //
		@RequestMapping(value="/board/write.bts")
		public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
			getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
			
			// === #142. 답변글쓰기가 추가된 경우 시작 === //
			String fk_seq = request.getParameter("fk_seq");
			String groupno = request.getParameter("groupno");
			String depthno = request.getParameter("depthno");
			String subject = "[답글] "+request.getParameter("subject");

			if(fk_seq == null) {
				fk_seq = "";
				
				List<BoardVO> boardList = null;
				
				String pk_seq = request.getParameter("pk_seq");		 			 	
				String fk_emp_no = request.getParameter("fk_emp_no");
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("pk_seq", pk_seq);
				paraMap.put("fk_emp_no", fk_emp_no);
				boardList = service.temp_list(paraMap);
				
				mav.addObject("boardList", boardList);
				
			}
			
			mav.addObject("fk_seq", fk_seq);
			mav.addObject("groupno", groupno);
			mav.addObject("depthno", depthno);
			mav.addObject("subject", subject);
			// === 답변글쓰기가 추가된 경우 끝               === //

			mav.setViewName("board/write.board");
			//  /WEB-INF/views/tiles1/board/add.jsp 파일을 생성한다.
		
		    return mav;
		}
		
		// === #54. 게시판 임시저장 요청 === //
			@RequestMapping(value="/board/write_save.bts", method= {RequestMethod.POST})
			public ModelAndView write_save(Map<String,String> paraMap, ModelAndView mav, BoardVO boardvo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기 및 파일 첨부하기 	
				
				// === #153. !!! 첨부파일이 있는 경우 작업 시작 !!! ===
				MultipartFile attach = boardvo.getAttach();
				
				if( !attach.isEmpty() ) {
					HttpSession session = mrequest.getSession();
					String root = session.getServletContext().getRealPath("/");

					String path = root+"resources"+File.separator+"files";
					
					String newFileName = "";
					// WAS(톰캣)의 디스크에 저장될 파일명 
					
					byte[] bytes = null;
					// 첨부파일의 내용물을 담는 것 
					
					long file_size = 0;
					// 첨부파일의 크기 
					
					try {
						bytes = attach.getBytes();
						
						String originalFilename = attach.getOriginalFilename();

						newFileName = fileManager.doFileUpload(bytes, originalFilename, path);

						boardvo.setFilename(newFileName);
						
						boardvo.setOrg_filename(originalFilename);

						
						file_size = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
						boardvo.setFile_size(String.valueOf(file_size));
						
					} catch (Exception e) {
						e.printStackTrace();
					}
					
				}
			
				
				int n = 0;
				
				if( attach.isEmpty() ) {
					// 파일첨부가 없는 경우라면 
					n = service.save(boardvo);
				}
				else {
					// 파일첨부가 있는 경우라면 
					n = service.save_withFile(boardvo);
				}
				
				if(n==1) {
					mav.setViewName("redirect:/board/list.bts");
					//  /list.action 페이지로 redirect(페이지이동)해라는 말이다.
				}
				else {
					mav.setViewName("board/error/add_error.tiles1");
					//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
				}
				
				
			
				return mav;
			}
		
		// === #54. 게시판 글쓰기 완료 요청 === //
		@RequestMapping(value="/board/write_end.bts", method= {RequestMethod.POST})
		public ModelAndView write_end(Map<String,String> paraMap, ModelAndView mav, BoardVO boardvo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기 및 파일 첨부하기 	
			MultipartFile attach = boardvo.getAttach();
			
			if( !attach.isEmpty() ) {
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");

				String path = root+"resources"+File.separator+"files";
				
				String newFileName = "";
				// WAS(톰캣)의 디스크에 저장될 파일명 
				
				byte[] bytes = null;
				// 첨부파일의 내용물을 담는 것 
				
				long fileSize = 0;
				// 첨부파일의 크기 
				
				try {
					bytes = attach.getBytes();

					String originalFilename = attach.getOriginalFilename();

					newFileName = fileManager.doFileUpload(bytes, originalFilename, path);

					boardvo.setFilename(newFileName);

					boardvo.setOrg_filename(originalFilename);

					fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
					boardvo.setFile_size(String.valueOf(fileSize));
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}

			int n = 0;
//			int m = 0;
			
			if( attach.isEmpty() ) {
				n = service.add(boardvo);
			}
			else {
				// 파일첨부가 있는 경우라면 
				n = service.add_withFile(boardvo);
			}

			
			if(n==1) {
				mav.setViewName("redirect:/board/list.bts");
				//  /list.action 페이지로 redirect(페이지이동)해라는 말이다.
			}
			else {
				mav.setViewName("board/error/add_error.tiles1");
				//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
			}
			
			
		
			return mav;
		}
	
	// == 게시판 글쓰기 끝 ==
	
		
		
		
	// == 게시판 글 보기 == //
	// === #62. 글1개를 보여주는 페이지 요청 === //
	@RequestMapping(value="/board/view.bts")
	public ModelAndView view(ModelAndView mav, HttpServletRequest request, LikeVO likevo) {
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
		
		// 조회하고자 하는 글번호 받아오기 
	 	String pk_seq = request.getParameter("pk_seq");
	 	
	 	// 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다. 
	 	String searchType = request.getParameter("searchType");
	 	String searchWord = request.getParameter("searchWord");
	 	
	 	if(searchType == null) {
	 		searchType = "";
	 	}
	 	
	 	if(searchWord == null) {
	 		searchWord = "";
	 	}
	 	
	 	
	 	String gobackURL = request.getParameter("gobackURL");  

	 	if( gobackURL != null && gobackURL.contains(" ") ) {
	 		gobackURL = gobackURL.replaceAll(" ", "&");
	 	}

	 	mav.addObject("gobackURL", gobackURL);
	 	

	 	try {
		 	Integer.parseInt(pk_seq);
		 	
		 	Map<String, String> paraMap = new HashMap<>();
		 	paraMap.put("pk_seq", pk_seq);
		 	
		 	paraMap.put("searchType", searchType);
		 	paraMap.put("searchWord", searchWord);
		 	
		 	mav.addObject("paraMap", paraMap); // view.jsp 에서 이전글제목 및 다음글제목 클릭시 사용하기 위해서 임.
			
		 	HttpSession session = request.getSession();
		 	EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		 	List<LikeVO> likeList = null;
		 	likeList = service.get_heart(paraMap);
		 	
		 	int login_userid1 = 0;
		 	if(loginuser != null) {
		 	   login_userid1 = loginuser.getPk_emp_no();

		 	  
		 	}

		 	String login_userid = Integer.toString(login_userid1);
		 	
	//	 	System.out.println(login_userid);
		 	
		 	paraMap.put("login_userid", login_userid);

		 	BoardVO boardvo = null;
		 	
		 	if( "yes".equals(session.getAttribute("readCountPermission")) ) {
		 		// 글목록보기를 클릭한 다음에 특정글을 조회해온 경우이다.
		 	 
		 		boardvo = service.getView(paraMap);
			 	// 글조회수 증가와 함께 글1개를 조회를 해주는 것 
		 		
		 		session.removeAttribute("readCountPermission");
		 	}
		 	else {
		 		// 웹브라우저에서 새로고침(F5)을 클릭한 경우이다. 
		 		
		 		boardvo = service.getViewWithNoAddCount(paraMap);
			 	// 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것이다.  
		 	}
		 	
		 	
		 	mav.addObject("likeList", likeList);
		 	mav.addObject("boardvo", boardvo);
	 	} catch(NumberFormatException e) {
	 		
	 	}
	 	
	 	mav.setViewName("/board/view.board");
	 	
		return mav; 
	}
	
	
	// ===  댓글쓰기(Ajax 로 처리) === //
		@ResponseBody
		@RequestMapping(value="/board/addComment.bts", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public String addComment(CommentVO commentvo) {
			int n = 0;
			
			try {
				n = service.addComment(commentvo);
			} catch (Throwable e) {
				e.printStackTrace();
			}
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			jsonObj.put("name", commentvo.getName());
			
			return jsonObj.toString();  
		}
		
		

	
		
		// === 원게시물에 딸린 댓글들을 페이징 처리해서 조회해오기(Ajax 로 처리) === //
		@ResponseBody
		@RequestMapping(value="board/commentList.bts", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
		public String commentList(HttpServletRequest request) {
			
			String fk_seq = request.getParameter("fk_seq");
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			int sizePerPage = 5;  // 한 페이지당 5개의 댓글을 보여줄 것임.

			
			int startRno = (( Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
			int endRno = startRno + sizePerPage - 1;
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_seq", fk_seq);
			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));
			
			List<CommentVO> commentList = service.getCommentListPaging(paraMap);
			HttpSession session = request.getSession();
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			JSONArray jsonArr = new JSONArray(); // []
			
			if(commentList != null) {
				for(CommentVO cmtvo : commentList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("content", cmtvo.getContent());
					jsonObj.put("name", cmtvo.getName());
					jsonObj.put("regDate", cmtvo.getRegDate());
					jsonObj.put("pk_seq", cmtvo.getPk_seq());
					jsonObj.put("fk_seq", cmtvo.getFk_seq());
					jsonObj.put("fk_emp_no", cmtvo.getFk_emp_no());
					if(loginuser != null) {
						jsonObj.put("pk_emp_no", loginuser.getPk_emp_no());
					}
					jsonArr.put(jsonObj);
				}// end of for------------------
			}
			
			return jsonArr.toString();
		}
		
		
		
		// === 원게시물에 딸린 댓글 totalPage 알아오기(Ajax 로 처리) === //
		@ResponseBody
		@RequestMapping(value="/board/getCommentTotalPage.bts", method= {RequestMethod.GET})
		public String getCommentTotalPage(HttpServletRequest request) {
			
			String fk_seq = request.getParameter("fk_seq");
			String sizePerPage = request.getParameter("sizePerPage");
	//		System.out.println(sizePerPage);
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_seq", fk_seq);
			paraMap.put("sizePerPage", sizePerPage);
			
			// 원글 글번호(parentSeq)에 해당하는 댓글의 totalPage 수 알아오기 
			int totalPage = service.getCommentTotalPage(paraMap);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("totalPage", totalPage);   // {"totalPage":5}
			
			return jsonObj.toString();
		}

		// === 댓글삭제 === //
		@ResponseBody
		@RequestMapping(value="/board/delComment.bts")
		public String delComment(HttpServletRequest request, CommentVO commentvo) {
			
			String pk_seq =request.getParameter("pk_seq");
			String fk_seq =request.getParameter("fk_seq");
	//		System.out.println("댓글 fk_seq => "+fk_seq);
			
			int n = service.delComment(pk_seq); // 댓글 삭제하기
			
			int m = service.minusCommentCount(fk_seq); // 
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			jsonObj.put("m", m);
			jsonObj.put("fk_seq", fk_seq);
			
			return jsonObj.toString();
		}
		


		
	// == 게시판 글보기 끝  == //
	
	
	
	// 좋아요 기능
	@ResponseBody
	@RequestMapping(value = "/board/updateLike.bts" , method = RequestMethod.POST)
	public int updateLike(int fk_emp_no, int fk_seq)throws Exception{
		
			int likeCheck = service.likeCheck(fk_seq, fk_emp_no);
			if(likeCheck == 0) {
				//좋아요 처음누름
				service.insertLike(fk_seq, fk_emp_no); //like테이블 삽입
				service.updateLike(fk_seq);	//게시판테이블 +1
			}else if(likeCheck == 1) {
                service.updateLikeCancel(fk_seq); //게시판테이블 - 1
				service.deleteLike(fk_seq, fk_emp_no); //like테이블 삭제
			}
			return likeCheck;
	}
	
	// === #76. 글삭제 페이지 요청 === //
	@RequestMapping(value="/board/del.bts")
	public ModelAndView requiredLogin_del(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
				// 삭제해야 할 글번호 가져오기
				String pk_seq = request.getParameter("pk_seq");
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("pk_seq", pk_seq);
				
				///////////////////////////////
				paraMap.put("searchType", "");
				paraMap.put("searchWord", "");
				///////////////////////////////
				
				BoardVO boardvo = service.getViewWithNoAddCount(paraMap);
				// 글조회수(readCount) 증가 없이 단순히 글1개만 조회해주는 것이다.
				
				HttpSession session = request.getSession();
				EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

			 	int login_userid1 = 0;
			 	if(loginuser != null) {
			 	   login_userid1 = loginuser.getPk_emp_no();
			 	   // login_userid 는 로그인 되어진 사용자의 userid 이다.
			 	}

			 	String login_userid = Integer.toString(login_userid1);

			 	
				if( !login_userid.equals(boardvo.getFk_emp_no()) ) {
					String message = "다른 사용자의 글은 삭제가 불가합니다.";
					String loc = "javascript:history.back()";
					
					mav.addObject("message", message);
					mav.addObject("loc", loc);
					mav.setViewName("msg");
				}
				else {
					// 자신의 글을 삭제할 경우
					// 글작성시 입력해준 글암호와 일치하는지 여부를 알아오도록 암호를 입력받아주는 del.jsp 페이지를 띄우도록 한다. 
					mav.addObject("pw", boardvo.getPw());
					mav.addObject("pk_seq", pk_seq);
					mav.setViewName("board/del.board");
				}
		
		return mav;
	}
	
	
	// === #77. 글삭제 페이지 완료하기 === //
	@RequestMapping(value="/board/delEnd.bts", method= {RequestMethod.POST})
	public ModelAndView delEnd(ModelAndView mav, HttpServletRequest request) {
		
		String pk_seq = request.getParameter("pk_seq");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_seq", pk_seq);
		
		////////////////////////////////////////////////////
		// === #164. 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파이을 삭제해주어야 한다. === //
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");
		
		BoardVO boardvo = service.getViewWithNoAddCount(paraMap);
		String filename = boardvo.getFilename();
		
		if( filename != null && !"".equals(filename)) {
			
			HttpSession session = request.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root+"resources"+File.separator+"files";

			paraMap.put("path", path); // 삭제해야 할 파일이 저장된 경로
			paraMap.put("filename", filename);// 삭제해야할 파일명
			
		}
		// === 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파이을 삭제해주어야 한다. 끝 === //
		////////////////////////////////////////////////////////////
		
		int n = service.del(paraMap);
		
		if(n==1) {
			mav.addObject("message", "글 삭제 성공!!");
			mav.addObject("loc", request.getContextPath()+"/board/list.bts");
		}
		else {
			mav.addObject("message", "글 삭제 실패!!");
			mav.addObject("loc", "javascript:history.back()");
		}
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	
	
	
	// === #71. 글 수정페이지 요청 === //
	@RequestMapping(value="/board/edit.bts")
	public ModelAndView requiredLogin_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		request.getSession();
		
		// 조회하고자 하는 글번호 받아오기 
		String fk_emp_no = request.getParameter("fk_emp_no");
		
		// 글 수정해야 할 글번호 가져오기
		String pk_seq = request.getParameter("pk_seq");
		
		// 글 수정해야할 글1개 내용 가져오기 
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_seq", pk_seq);
		paraMap.put("fk_emp_no", fk_emp_no);
		///////////////////////////////
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");
        ///////////////////////////////
		
		BoardVO boardvo = service.getViewWithNoAddCount(paraMap);
		// 글조회수(readCount) 증가 없이 단순히 글1개만 조회해주는 것이다.
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		int getFk_emp_no1 = Integer.parseInt(boardvo.getFk_emp_no());
		
		
		if( loginuser.getPk_emp_no()!=getFk_emp_no1 ) {
			String message = "다른 사용자의 글은 수정이 불가합니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}
		else {
			// 자신의 글을 수정할 경우
			// 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
			mav.addObject("boardvo", boardvo);
			mav.setViewName("board/edit.board");
		}
		
		return mav;
	}
	
	
	// === 임시저장글 작성 === //
		@RequestMapping(value="/board/tmp_write.bts")
		public ModelAndView requiredLogin_edit2(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
			String gobackURL = request.getParameter("gobackURL");  
		 	
			request.getSession();
			
			// 조회하고자 하는 글번호 받아오기 
			String fk_emp_no = request.getParameter("fk_emp_no");
			
			// 글 수정해야 할 글번호 가져오기
			String pk_seq = request.getParameter("pk_seq");
			String fk_seq = request.getParameter("fk_seq");
			// 글 수정해야할 글1개 내용 가져오기 


			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("pk_seq", pk_seq);
			paraMap.put("fk_seq", fk_seq);
			paraMap.put("fk_emp_no", fk_emp_no);
			///////////////////////////////
			paraMap.put("searchType", "");
			paraMap.put("searchWord", "");
	        ///////////////////////////////
			
			BoardVO boardvo = service.getViewWithNoAddCount2(paraMap);
			// 글조회수(readCount) 증가 없이 단순히 글1개만 조회해주는 것이다.
			
			
			mav.addObject("gobackURL", gobackURL);
			mav.addObject("boardvo", boardvo);
			mav.setViewName("board/tmp_write.board");
		
			
			return mav;
		}
	
		
		// === 임시저장글 완료하기 === //
				@RequestMapping(value="/board/tmp_end.bts", method= {RequestMethod.POST})
				public ModelAndView tmp_end(Map<String,String> paraMap, ModelAndView mav, BoardVO boardvo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기 및 파일 첨부하기 	
					MultipartFile attach = boardvo.getAttach();
					
					if( !attach.isEmpty() ) {
						mrequest.getSession();
			//			String root = session.getServletContext().getRealPath("/");

		//				String path = root+"resources"+File.separator+"files";
						
						String newFileName = "";
						// WAS(톰캣)의 디스크에 저장될 파일명 
						
		//				byte[] bytes = null;
						// 첨부파일의 내용물을 담는 것 
						
						long file_size = 0;
						// 첨부파일의 크기 
						
						try {
			//				bytes = attach.getBytes();
							
							String originalFilename = attach.getOriginalFilename();

							boardvo.setFilename(newFileName);
							
							boardvo.setOrg_filename(originalFilename);
							
							file_size = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
							boardvo.setFile_size(String.valueOf(file_size));
							
						} catch (Exception e) {
							e.printStackTrace();
						}
						
					}

					int n = 0;
					
					if( attach.isEmpty() ) {
						n = service.tmp_write(boardvo);
					}
					else {
						n = service.add_withFile(boardvo);
					}
					
					if(n==1) {
						mav.setViewName("redirect:/board/list.bts");
					}
					else {
						mav.setViewName("board/error/add_error.tiles1");
					}
					
					
				
					return mav;
				}
		
	// === #72. 글수정 페이지 완료하기 === //
	@RequestMapping(value="/board/editEnd.bts", method= {RequestMethod.POST})
	public ModelAndView editEnd(ModelAndView mav, BoardVO boardvo, HttpServletRequest request) {
		
		int n = service.edit(boardvo);

		
		if(n==0) {
			mav.addObject("message", "암호가 일치하지 않아 글 수정이 불가합니다.");
			mav.addObject("loc", "javascript:history.back()");
		}
		else {
			mav.addObject("message", "글 수정 성공!!");
			mav.addObject("loc", request.getContextPath()+"/board/view.bts?pk_seq="+boardvo.getPk_seq());
		}
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	// ==== #163. 첨부파일 다운로드 받기 ==== //
		@RequestMapping(value="/file/download_board.bts")
		public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
			
			String pk_seq = request.getParameter("pk_seq");
			// 첨부파일이 있는 글번호 
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("searchType", "");
			paraMap.put("searchWord", "");
			paraMap.put("pk_seq", pk_seq);
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = null;
			
			try {
				Integer.parseInt(pk_seq);
				BoardVO boardvo = service.getViewWithNoAddCount(paraMap);
				
				if(boardvo == null || (boardvo != null && boardvo.getFilename() == null ) ) {
					out = response.getWriter();

					out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
					return; // 종료
				}
				else {
					String fileName = boardvo.getFilename();
					
					String orgFilename = boardvo.getOrg_filename();

					HttpSession session = request.getSession();
					String root = session.getServletContext().getRealPath("/");
					
					String path = root+"resources"+File.separator+"files";

					// **** file 다운로드 하기 **** //
					boolean flag = false; // file 다운로드 성공, 실패를 알려주는 용도
					flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
					
					if(!flag) {
						out = response.getWriter();
						
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
	
		
		@RequestMapping(value="/file/download_fileboard.bts")
		public void requiredLogin_download_fileboard(HttpServletRequest request, HttpServletResponse response) {
			
			String pk_seq = request.getParameter("pk_seq");
			// 첨부파일이 있는 글번호 
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("searchType", "");
			paraMap.put("searchWord", "");
			paraMap.put("pk_seq", pk_seq);
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = null;
			
			try {
				Integer.parseInt(pk_seq);
				FileboardVO fileboardvo = service.getViewWithNoAddCount_fileboard(paraMap);
				
				if(fileboardvo == null || (fileboardvo != null && fileboardvo.getFilename() == null ) ) {
					out = response.getWriter();

					out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
					return; // 종료
				}
				else {
					String fileName = fileboardvo.getFilename();
					
					String orgFilename = fileboardvo.getOrg_filename();

					HttpSession session = request.getSession();
					String root = session.getServletContext().getRealPath("/");
					
					String path = root+"resources"+File.separator+"files";

					// **** file 다운로드 하기 **** //
					boolean flag = false; // file 다운로드 성공, 실패를 알려주는 용도
					flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
					
					if(!flag) {
						out = response.getWriter();
						
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
		
		@RequestMapping(value="/file/download_notice.bts")
		public void requiredLogin_download_notice(HttpServletRequest request, HttpServletResponse response) {
			
			String pk_seq = request.getParameter("pk_seq");
			// 첨부파일이 있는 글번호 
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("searchType", "");
			paraMap.put("searchWord", "");
			paraMap.put("pk_seq", pk_seq);
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = null;
			
			try {
				Integer.parseInt(pk_seq);
				NoticeVO noticevo = service.getViewWithNoAddCount_notice(paraMap);
				
				if(noticevo == null || (noticevo != null && noticevo.getFilename() == null ) ) {
					out = response.getWriter();

					out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
					return; // 종료
				}
				else {
					String fileName = noticevo.getFilename();
					
					String orgFilename = noticevo.getOrg_filename();

					HttpSession session = request.getSession();
					String root = session.getServletContext().getRealPath("/");
					
					String path = root+"resources"+File.separator+"files";

					// **** file 다운로드 하기 **** //
					boolean flag = false; // file 다운로드 성공, 실패를 알려주는 용도
					flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
					
					if(!flag) {
						out = response.getWriter();
						
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
		
		// === #168. 스마트에디터. 드래그앤드롭을 사용한 다중사진 파일 업로드 === //
		@RequestMapping(value="/image/multiplePhotoUpload.action", method= {RequestMethod.POST})
		public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
			/*
		      1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
		      >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
		           우리는 WAS 의 webapp/resources/photo_upload 라는 폴더로 지정해준다.
		    */
			
			 // WAS 의 webapp 의 절대경로를 알아와야 한다.
			HttpSession session = request.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root+"resources" + File.separator+"photo_upload";
			// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다.
			
			
//			System.out.println("~~~~ 확인용  webapp 의 절대경로 => " + root);
			// ~~~~ 확인용  webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\photo_upload
			
			File dir = new File(path);
			if(dir.exists()) {
				dir.mkdirs();
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
				
		//		System.out.println(">>> 확인용 filename ==> " + filename);
				// >>> 확인용 filename ==> %EC%89%90%EB%B3%B4%EB%A0%88%EC%A0%84%EB%A9%B4.jpg
				
				InputStream is = request.getInputStream(); //is 는 네이버 스마트 에디터를 사용하여 사진첨부하기된  이미지 팡리임.
			
				String newFilename = fileManager.doFileUpload(is, filename, path);
				
				String ctxPath = request.getContextPath(); // /board
				
				String strURL = "";
				
				strURL += "&bNewLine=true&sFileName="+newFilename; 
				strURL += "&sWidth=";
				strURL += "&sFileURL="+ctxPath+"/resources/photo_upload/"+newFilename;
				
				// === 웹브라우저 상에 사진 이미지를 쓰기 === //
				PrintWriter out = response.getWriter();
				out.print(strURL);
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		
	// --- 게시판 끝 --- -------------------

		// --- 공지 게시판 시작 ---  -----------------
		@RequestMapping(value = "/notice/list.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
		public ModelAndView list_fileboard(ModelAndView mav, HttpServletRequest request, NoticeVO noticevo) {
			
			///////////////////////////////////
			
			HttpSession session = request.getSession();
			
			getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
			
			List<NoticeVO> noticeList = null;
		
			 
			session.setAttribute("readCountPermission", "yes");

			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");
			String headerCategory = request.getParameter("headerCategory");
					
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
			if(headerCategory == null ) {
				headerCategory = "";
			}
			
			if(searchType == null || (!"subject".equals(searchType) && !"user_name".equals(searchType)) ) {
				searchType = "subject";
			}
			
			if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
				searchWord = "";
			}
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			paraMap.put("headerCategory", headerCategory);
			
			int totalCount = 0;        // 총 게시물 건수
			int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
			int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
			int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
			
			int startRno = 0; // 시작 행번호
			int endRno = 0;   // 끝 행번호
			 
			// 총 게시물 건수(totalCount)
			totalCount = service.getTotalCount_notice(paraMap);
		
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
			
			noticeList = service.noticeListSearchWithPaging(paraMap);
			// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
			
			// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
			if( !"".equals(searchType) && !"".equals(searchWord)) {
				mav.addObject("paraMap", paraMap);
			}
			// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임. 
			if( !"".equals(headerCategory) ) {
			  mav.addObject("paraMap", paraMap); 
			  }
			
			
			
			// === 페이지바 만들기 === //
			int blockSize = 10;
			
			int loop = 1;
			
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			
			String pageBar = "<ul style='list-style: none;'>";
			String url = "list.bts";
			
			// === [맨처음][이전] 만들기 === //
			if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?headerCategory="+headerCategory+"searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?headerCategory="+headerCategory+"searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
				}
				else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a style='color: black;' href='"+url+"?headerCategory="+headerCategory+"searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
				}
				
				loop++;
				pageNo++;
				
			}// end of while-----------------------
			
			
			// === [다음][마지막] 만들기 === //
			if( pageNo <= totalPage ) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?headerCategory="+headerCategory+"searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?headerCategory="+headerCategory+"searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
			}
			
			pageBar += "</ul>";
			
			mav.addObject("pageBar", pageBar);
			
			String gobackURL = MyUtil.getCurrentURL(request);

			mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
			

			
			mav.addObject("noticeList", noticeList);
			
			/////////////////////////////////////
			
			
			mav.setViewName("notice/list.board");
			//  /WEB-INF/views/tiles1/board/list.jsp 파일을 생성한다.
			
			return mav;
		
		}
		
		
		
		// === 글쓰기 ====
			@RequestMapping(value="/notice/write.bts")
			public ModelAndView requiredLogin_add_notice(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
			
				getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
				
				// === #142. 답변글쓰기가 추가된 경우 시작 === //
				String fk_seq = request.getParameter("fk_seq");
				String groupno = request.getParameter("groupno");
				String depthno = request.getParameter("depthno");
				String subject = "[답글] "+request.getParameter("subject");
				String header = request.getParameter("header");
				
				if(fk_seq == null) {
					fk_seq = "";
					
					List<NoticeVO> noticedList = null;
					
					String pk_seq = request.getParameter("pk_seq");		 			 	
					String fk_emp_no = request.getParameter("fk_emp_no");
					
					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("pk_seq", pk_seq);
					paraMap.put("fk_emp_no", fk_emp_no);
					noticedList = service.temp_list_notice(paraMap);
					
					mav.addObject("noticedList", noticedList);
					
				}
				mav.addObject("header", header);
				mav.addObject("fk_seq", fk_seq);
				mav.addObject("groupno", groupno);
				mav.addObject("depthno", depthno);
				mav.addObject("subject", subject);
				// === 답변글쓰기가 추가된 경우 끝               === //

				mav.setViewName("notice/write.board");
				//  /WEB-INF/views/tiles1/board/add.jsp 파일을 생성한다.
			
			    return mav;
			}
		
			
			// === #54. 게시판 글쓰기 완료 요청 === //
			@RequestMapping(value="/notice/write_end.bts", method= {RequestMethod.POST})
			public ModelAndView write_end_notice(Map<String,String> paraMap, ModelAndView mav, NoticeVO noticevo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기 및 파일 첨부하기 	
				MultipartFile attach = noticevo.getAttach();
				
				if( !attach.isEmpty() ) {
					HttpSession session = mrequest.getSession();
					String root = session.getServletContext().getRealPath("/");

					String path = root+"resources"+File.separator+"files";
					
					String newFileName = "";
					// WAS(톰캣)의 디스크에 저장될 파일명 
					
					byte[] bytes = null;
					// 첨부파일의 내용물을 담는 것 
					
					long fileSize = 0;
					// 첨부파일의 크기 
					
					try {
						bytes = attach.getBytes();

						String originalFilename = attach.getOriginalFilename();

						newFileName = fileManager.doFileUpload(bytes, originalFilename, path);

						noticevo.setFilename(newFileName);

						noticevo.setOrg_filename(originalFilename);

						fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
						noticevo.setFile_size(String.valueOf(fileSize));
						
					} catch (Exception e) {
						e.printStackTrace();
					}
					
				}

				int n = 0;
				
				if( attach.isEmpty() ) {
					n = service.add_notice(noticevo);
				}
				else {
					// 파일첨부가 있는 경우라면 
					n = service.add_withFile_notice(noticevo);
				}
				
				
				
				if(n==1) {
					mav.setViewName("redirect:/notice/list.bts");
				}
				else {
					mav.setViewName("board/error/add_error.tiles1");
					//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
				}
				
				
			
				return mav;
			}
		
			@RequestMapping(value="/notice/view.bts")
			public ModelAndView view_notice(ModelAndView mav, HttpServletRequest request) {
				
				getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
				
				// 조회하고자 하는 글번호 받아오기 
			 	String pk_seq = request.getParameter("pk_seq");
			 	
			 	// 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다. 
			 	String searchType = request.getParameter("searchType");
			 	String searchWord = request.getParameter("searchWord");
			 	String headerCategory = request.getParameter("headerCategory");
			 	
			 	if(headerCategory == null ) {
					headerCategory = "";
				}
				
				if(searchType == null || (!"subject".equals(searchType) && !"user_name".equals(searchType)) ) {
					searchType = "subject";
				}

			 	
			 	if(searchWord == null) {
			 		searchWord = "";
			 	}
			 	
			 	
			 	String gobackURL = request.getParameter("gobackURL");  

			 	if( gobackURL != null && gobackURL.contains(" ") ) {
			 		gobackURL = gobackURL.replaceAll(" ", "&");
			 	}

			 	mav.addObject("gobackURL", gobackURL);
			 	

			 	try {
				 	Integer.parseInt(pk_seq);
				 	
				 	Map<String, String> paraMap = new HashMap<>();
				 	paraMap.put("pk_seq", pk_seq);
				 	paraMap.put("headerCategory", headerCategory);
				 	paraMap.put("searchType", searchType);
				 	paraMap.put("searchWord", searchWord);
				 	
				 	mav.addObject("paraMap", paraMap); // view.jsp 에서 이전글제목 및 다음글제목 클릭시 사용하기 위해서 임.
					
				 	HttpSession session = request.getSession();
				 	EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

				 	
				 	
				 	int login_userid1 = 0;
				 	if(loginuser != null) {
				 	   login_userid1 = loginuser.getPk_emp_no();

				 	   
				 	}

				 	String login_userid = Integer.toString(login_userid1);
				 	
				 	paraMap.put("login_userid", login_userid);

				 	NoticeVO noticevo = null;
				 	if( "yes".equals(session.getAttribute("readCountPermission")) ) {
				 		// 글목록보기를 클릭한 다음에 특정글을 조회해온 경우이다.
				 	 
				 		noticevo = service.getView_notice(paraMap);
					 	// 글조회수 증가와 함께 글1개를 조회를 해주는 것 
				 		
				 		session.removeAttribute("readCountPermission");
				 	}
				 	else {
				 		// 웹브라우저에서 새로고침(F5)을 클릭한 경우이다. 
				 		
				 		noticevo = service.getViewWithNoAddCount_notice(paraMap);
					 	// 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것이다.  
				 	}
				 
				 	
				 	
				 	mav.addObject("noticevo", noticevo);
			 	} catch(NumberFormatException e) {
			 		
			 	}
			 	
			 	mav.setViewName("/notice/view.board");
			 	
				return mav; 
			}		
		
			@RequestMapping(value="/notice/view_2.bts")
			public ModelAndView view_2_notice(ModelAndView mav, HttpServletRequest request) {
				
				getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
				
				// 조회하고자 하는 글번호 받아오기 
			 	String pk_seq = request.getParameter("pk_seq");
			 	
			 	String headerCategory = request.getParameter("headerCategory");
			 	String searchType = request.getParameter("searchType");
			 	String searchWord = request.getParameter("searchWord");
			 	String gobackURL = request.getParameter("gobackURL");

			 	
			 	HttpSession session = request.getSession();
				session.setAttribute("readCountPermission", "yes");
			 	
				try {
			         searchWord = URLEncoder.encode(searchWord, "UTF-8"); // 한글이 웹브라우저 주소창에서 사용되어질때 한글이 ? 처럼 안깨지게 하려고 하는 것임.  
			         gobackURL = URLEncoder.encode(gobackURL, "UTF-8");   // 한글이 웹브라우저 주소창에서 사용되어질때 한글이 ? 처럼 안깨지게 하려고 하는 것임.

			      } catch (UnsupportedEncodingException e) {
			         e.printStackTrace();
			      } 
				
			 	mav.setViewName("redirect:/notice/view.bts?pk_seq="+pk_seq+"&headerCategory="+headerCategory+"&searchType="+searchType+"&searchWord="+searchWord+"&gobackURL="+gobackURL);
			 	
				return mav;
			}		
			
		
			
			// === #71. 글 수정페이지 요청 === //
			@RequestMapping(value="/notice/edit.bts")
			public ModelAndView requiredLogin_edit_notice(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
				
				request.getSession();
				
				// 조회하고자 하는 글번호 받아오기 
				String fk_emp_no = request.getParameter("fk_emp_no");
				
				// 글 수정해야 할 글번호 가져오기
				String pk_seq = request.getParameter("pk_seq");
				
				// 글 수정해야할 글1개 내용 가져오기 
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("pk_seq", pk_seq);
				paraMap.put("fk_emp_no", fk_emp_no);
				///////////////////////////////
				paraMap.put("searchType", "");
				paraMap.put("searchWord", "");
		        ///////////////////////////////
				
				NoticeVO noticevo = service.getViewWithNoAddCount_notice(paraMap);
				// 글조회수(readCount) 증가 없이 단순히 글1개만 조회해주는 것이다.
				
				HttpSession session = request.getSession();
				EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
				
				int getFk_emp_no1 = Integer.parseInt(noticevo.getFk_emp_no());
				
				
				if( loginuser.getPk_emp_no()!=getFk_emp_no1 ) {
					String message = "다른 사용자의 글은 수정이 불가합니다.";
					String loc = "javascript:history.back()";
					
					mav.addObject("message", message);
					mav.addObject("loc", loc);
					mav.setViewName("msg");
				}
				else {
					// 자신의 글을 수정할 경우
					// 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
					mav.addObject("noticevo", noticevo);
					mav.setViewName("notice/edit.board");
				}
				
				return mav;
			}	
		
			
		@RequestMapping(value="/notice/editEnd.bts", method= {RequestMethod.POST})
		public ModelAndView editEnd_notice(ModelAndView mav, NoticeVO noticevo, HttpServletRequest request) {
			
			int n = service.edit_notice(noticevo);

			
			if(n==0) {
				mav.addObject("message", "암호가 일치하지 않아 글 수정이 불가합니다.");
				mav.addObject("loc", "javascript:history.back()");
			}
			else {
				mav.addObject("message", "글 수정 성공!!");
				mav.addObject("loc", request.getContextPath()+"/notice/view.bts?pk_seq="+noticevo.getPk_seq());
			}
			
			mav.setViewName("msg");
			
			return mav;
		}	
	
		// === #76. 글삭제 페이지 요청 === //
		@RequestMapping(value="/notice/del.bts")
		public ModelAndView requiredLogin_del_notice(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
			
					// 삭제해야 할 글번호 가져오기
					String pk_seq = request.getParameter("pk_seq");
					
					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("pk_seq", pk_seq);
					
					///////////////////////////////
					paraMap.put("searchType", "");
					paraMap.put("searchWord", "");
					///////////////////////////////
					
					NoticeVO noticevo = service.getViewWithNoAddCount_notice(paraMap);
					// 글조회수(readCount) 증가 없이 단순히 글1개만 조회해주는 것이다.
					
					HttpSession session = request.getSession();
					EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

				 	int login_userid1 = 0;
				 	if(loginuser != null) {
				 	   login_userid1 = loginuser.getPk_emp_no();
				 	   // login_userid 는 로그인 되어진 사용자의 userid 이다.
				 	}

				 	String login_userid = Integer.toString(login_userid1);

				 	
					if( !login_userid.equals(noticevo.getFk_emp_no()) ) {
						String message = "다른 사용자의 글은 삭제가 불가합니다.";
						String loc = "javascript:history.back()";
						
						mav.addObject("message", message);
						mav.addObject("loc", loc);
						mav.setViewName("msg");
					}
					else {
						// 자신의 글을 삭제할 경우
						// 글작성시 입력해준 글암호와 일치하는지 여부를 알아오도록 암호를 입력받아주는 del.jsp 페이지를 띄우도록 한다. 
						mav.addObject("pw", noticevo.getPw());
						mav.addObject("pk_seq", pk_seq);
						mav.setViewName("notice/del.board");
					}
			
			return mav;
		}	
		
		
		// === #77. 글삭제 페이지 완료하기 === //
		@RequestMapping(value="/notice/delEnd.bts", method= {RequestMethod.POST})
		public ModelAndView delEnd_notice(ModelAndView mav, HttpServletRequest request) {
			
			String pk_seq = request.getParameter("pk_seq");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("pk_seq", pk_seq);
			
			////////////////////////////////////////////////////
			// === #164. 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파이을 삭제해주어야 한다. === //
			paraMap.put("searchType", "");
			paraMap.put("searchWord", "");
			
			NoticeVO noticevo = service.getViewWithNoAddCount_notice(paraMap);
			String filename = noticevo.getFilename();
			
			if( filename != null && !"".equals(filename)) {
				
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");
				String path = root+"resources"+File.separator+"files";

				paraMap.put("path", path); // 삭제해야 할 파일이 저장된 경로
				paraMap.put("filename", filename);// 삭제해야할 파일명
				
			}
			// === 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파이을 삭제해주어야 한다. 끝 === //
			////////////////////////////////////////////////////////////
			
			int n = service.del_notice(paraMap);
			
			if(n==1) {
				mav.addObject("message", "글 삭제 성공!!");
				mav.addObject("loc", request.getContextPath()+"/notice/list.bts");
			}
			else {
				mav.addObject("message", "글 삭제 실패!!");
				mav.addObject("loc", "javascript:history.back()");
			}
			
			mav.setViewName("msg");
			
			return mav;
		}
		
		// --- 공지 게시판 끝 ---  -----------------	
		
		
		
		
	// --- 자료 게시판 시작 ---  -----------------
	@RequestMapping(value = "/fileboard/list.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
	public ModelAndView list_fileboard(ModelAndView mav, HttpServletRequest request, FileboardVO fileboardvo) {
		
		///////////////////////////////////
		
		HttpSession session = request.getSession();
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
		
		List<FileboardVO> fileboardlist = null;
	
		 
		session.setAttribute("readCountPermission", "yes");

		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String ko_depname = request.getParameter("ko_depname");
				
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(ko_depname == null ) {
			ko_depname = "";
		}
		
		if(searchType == null || (!"subject".equals(searchType) && !"user_name".equals(searchType)) ) {
			searchType = "subject";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("ko_depname", ko_depname);
		
		int totalCount = 0;        // 총 게시물 건수
		int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0; // 시작 행번호
		int endRno = 0;   // 끝 행번호
		 
		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalCount_fileboard(paraMap);
	
	//	System.out.println("totalCount =" + totalCount );
		
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
		
		fileboardlist = service.ListSearchWithPaging_fileboard(paraMap);
		// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
		
		// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		if( !"".equals(searchType) && !"".equals(searchWord)) {
			mav.addObject("paraMap", paraMap);
		}
		// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임. 
		if( !"".equals(ko_depname) ) {
		  mav.addObject("paraMap", paraMap); 
		  }
		
		
		
		// === 페이지바 만들기 === //
		int blockSize = 10;
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "list.bts";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?ko_depname="+ko_depname+"searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?ko_depname="+ko_depname+"searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a style='color: black;' href='"+url+"?ko_depname="+ko_depname+"searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}

			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?ko_depname="+ko_depname+"searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?ko_depname="+ko_depname+"searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		String gobackURL = MyUtil.getCurrentURL(request);

		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
		

		
		mav.addObject("fileboardlist", fileboardlist);
		
		/////////////////////////////////////
		
		
		mav.setViewName("fileboard/list.board");
		//  /WEB-INF/views/tiles1/board/list.jsp 파일을 생성한다.
		
		return mav;
	
	}
	
	
	
	// === 글쓰기 ====
		@RequestMapping(value="/fileboard/write.bts")
		public ModelAndView requiredLogin_add_fileboard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
			getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
			
			// === #142. 답변글쓰기가 추가된 경우 시작 === //
			String fk_seq = request.getParameter("fk_seq");
			String groupno = request.getParameter("groupno");
			String depthno = request.getParameter("depthno");
			String subject = "[답글] "+request.getParameter("subject");
			String ko_depname = request.getParameter("ko_depname");
			
			if(fk_seq == null) {
				fk_seq = "";
				
				List<FileboardVO> fileboardlist = null;
				
				String pk_seq = request.getParameter("pk_seq");		 			 	
				String fk_emp_no = request.getParameter("fk_emp_no");
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("pk_seq", pk_seq);
				paraMap.put("fk_emp_no", fk_emp_no);
				
				mav.addObject("fileboardlist", fileboardlist);
				
			}
			mav.addObject("ko_depname", ko_depname);
			mav.addObject("fk_seq", fk_seq);
			mav.addObject("groupno", groupno);
			mav.addObject("depthno", depthno);
			mav.addObject("subject", subject);
			// === 답변글쓰기가 추가된 경우 끝               === //

			mav.setViewName("fileboard/write.board");
			//  /WEB-INF/views/tiles1/board/add.jsp 파일을 생성한다.
		
		    return mav;
		}
	
		
		// === #54. 게시판 글쓰기 완료 요청 === //
		@RequestMapping(value="/fileboard/write_end.bts", method= {RequestMethod.POST})
		public ModelAndView write_end_fileboard(Map<String,String> paraMap, ModelAndView mav, FileboardVO fileboardvo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기 및 파일 첨부하기 	
			MultipartFile attach = fileboardvo.getAttach();
			
			if( !attach.isEmpty() ) {
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");

				String path = root+"resources"+File.separator+"files";
				
				String newFileName = "";
				// WAS(톰캣)의 디스크에 저장될 파일명 
				
				byte[] bytes = null;
				// 첨부파일의 내용물을 담는 것 
				
				long fileSize = 0;
				// 첨부파일의 크기 
				
				try {
					bytes = attach.getBytes();

					String originalFilename = attach.getOriginalFilename();

					newFileName = fileManager.doFileUpload(bytes, originalFilename, path);

					fileboardvo.setFilename(newFileName);

					fileboardvo.setOrg_filename(originalFilename);

					fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
					fileboardvo.setFile_size(String.valueOf(fileSize));
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}

			int n = 0;
			
			if( attach.isEmpty() ) {
				n = service.add_fileboard(fileboardvo);
			}
			else {
				// 파일첨부가 있는 경우라면 
				n = service.add_withFile_fileboard(fileboardvo);
			}
			
			
			
			if(n==1) {
				mav.setViewName("redirect:/fileboard/list.bts");
			}
			else {
				mav.setViewName("board/error/add_error.tiles1");
				//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
			}
			
			
		
			return mav;
		}
	
		
		@RequestMapping(value="/fileboard/view.bts")
		public ModelAndView view_fileboard(ModelAndView mav, HttpServletRequest request) {
			
			getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
			
			// 조회하고자 하는 글번호 받아오기 
		 	String pk_seq = request.getParameter("pk_seq");
		 	
		 	// 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다. 
		 	String searchType = request.getParameter("searchType");
		 	String searchWord = request.getParameter("searchWord");
		 	String ko_depname = request.getParameter("ko_depname");
		 	
		 	if(ko_depname == null ) {
		 		ko_depname = "";
			}
			
			if(searchType == null || (!"subject".equals(searchType) && !"user_name".equals(searchType)) ) {
				searchType = "subject";
			}

		 	
		 	if(searchWord == null) {
		 		searchWord = "";
		 	}
		 	
		 	
		 	String gobackURL = request.getParameter("gobackURL");  

		 	if( gobackURL != null && gobackURL.contains(" ") ) {
		 		gobackURL = gobackURL.replaceAll(" ", "&");
		 	}

		 	mav.addObject("gobackURL", gobackURL);
		 	

		 	try {
			 	Integer.parseInt(pk_seq);
			 	
			 	Map<String, String> paraMap = new HashMap<>();
			 	paraMap.put("pk_seq", pk_seq);
			 	paraMap.put("ko_depname", ko_depname);
			 	paraMap.put("searchType", searchType);
			 	paraMap.put("searchWord", searchWord);
			 	
			 	mav.addObject("paraMap", paraMap); // view.jsp 에서 이전글제목 및 다음글제목 클릭시 사용하기 위해서 임.
				
			 	HttpSession session = request.getSession();
			 	EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

			 	
			 	
			 	int login_userid1 = 0;
			 	if(loginuser != null) {
			 	   login_userid1 = loginuser.getPk_emp_no();

			 	   
			 	}

			 	String login_userid = Integer.toString(login_userid1);
			 	
			 	paraMap.put("login_userid", login_userid);

			 	FileboardVO fileboardvo = null;
			 	if( "yes".equals(session.getAttribute("readCountPermission")) ) {
			 		// 글목록보기를 클릭한 다음에 특정글을 조회해온 경우이다.
			 	 
			 		fileboardvo = service.getView_fileboard(paraMap);
				 	// 글조회수 증가와 함께 글1개를 조회를 해주는 것 
			 		
			 		session.removeAttribute("readCountPermission");
			 	}
			 	else {
			 		// 웹브라우저에서 새로고침(F5)을 클릭한 경우이다. 
			 		
			 		fileboardvo = service.getViewWithNoAddCount_fileboard(paraMap);
				 	// 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것이다.  
			 	}
			 
			 	
			 	
			 	mav.addObject("fileboardvo", fileboardvo);
		 	} catch(NumberFormatException e) {
		 		
		 	}
		 	
		 	mav.setViewName("/fileboard/view.board");
		 	
			return mav; 
		}		
	
		@RequestMapping(value="/fileboard/view_2.bts")
		public ModelAndView view_2_fileboard(ModelAndView mav, HttpServletRequest request) {
			
			getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
			
			// 조회하고자 하는 글번호 받아오기 
		 	String pk_seq = request.getParameter("pk_seq");
		 	
		 	String ko_depname = request.getParameter("ko_depname");
		 	String searchType = request.getParameter("searchType");
		 	String searchWord = request.getParameter("searchWord");
		 	String gobackURL = request.getParameter("gobackURL");

		 	
		 	HttpSession session = request.getSession();
			session.setAttribute("readCountPermission", "yes");
		 	
			try {
		         searchWord = URLEncoder.encode(searchWord, "UTF-8"); // 한글이 웹브라우저 주소창에서 사용되어질때 한글이 ? 처럼 안깨지게 하려고 하는 것임.  
		         gobackURL = URLEncoder.encode(gobackURL, "UTF-8");   // 한글이 웹브라우저 주소창에서 사용되어질때 한글이 ? 처럼 안깨지게 하려고 하는 것임.

		      } catch (UnsupportedEncodingException e) {
		         e.printStackTrace();
		      } 
			
		 	mav.setViewName("redirect:/notice/view.bts?pk_seq="+pk_seq+"&ko_depname="+ko_depname+"&searchType="+searchType+"&searchWord="+searchWord+"&gobackURL="+gobackURL);
		 	
			return mav;
		}	
	
		
		// === #71. 글 수정페이지 요청 === //
		@RequestMapping(value="/fileboard/edit.bts")
		public ModelAndView requiredLogin_edit_fileboard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
			
			request.getSession();
			
			// 조회하고자 하는 글번호 받아오기 
			String fk_emp_no = request.getParameter("fk_emp_no");
			
			// 글 수정해야 할 글번호 가져오기
			String pk_seq = request.getParameter("pk_seq");
			
			// 글 수정해야할 글1개 내용 가져오기 
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("pk_seq", pk_seq);
			paraMap.put("fk_emp_no", fk_emp_no);
			///////////////////////////////
			paraMap.put("searchType", "");
			paraMap.put("searchWord", "");
	        ///////////////////////////////
			
			FileboardVO fileboardvo = service.getViewWithNoAddCount_fileboard(paraMap);
			// 글조회수(readCount) 증가 없이 단순히 글1개만 조회해주는 것이다.
			
			HttpSession session = request.getSession();
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			int getFk_emp_no1 = Integer.parseInt(fileboardvo.getFk_emp_no());
			
			
			if( loginuser.getPk_emp_no()!=getFk_emp_no1 ) {
				String message = "다른 사용자의 글은 수정이 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			else {
				// 자신의 글을 수정할 경우
				// 가져온 1개글을 글수정할 폼이 있는 view 단으로 보내준다.
				mav.addObject("fileboardvo", fileboardvo);
				mav.setViewName("fileboard/edit.board");
			}
			
			return mav;
		}	
	
		@RequestMapping(value="/fileboard/editEnd.bts", method= {RequestMethod.POST})
		public ModelAndView editEnd_fileboard(ModelAndView mav, FileboardVO fileboardvo, HttpServletRequest request) {
			
			int n = service.edit_fileboard(fileboardvo);

			
			if(n==0) {
				mav.addObject("message", "암호가 일치하지 않아 글 수정이 불가합니다.");
				mav.addObject("loc", "javascript:history.back()");
			}
			else {
				mav.addObject("message", "글 수정 성공!!");
				mav.addObject("loc", request.getContextPath()+"/fileboard/view.bts?pk_seq="+fileboardvo.getPk_seq());
			}
			
			mav.setViewName("msg");
			
			return mav;
		}		
	
		// === #76. 글삭제 페이지 요청 === //
			@RequestMapping(value="/fileboard/del.bts")
			public ModelAndView requiredLogin_del_fileboard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
				
					// 삭제해야 할 글번호 가져오기
					String pk_seq = request.getParameter("pk_seq");
					
					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("pk_seq", pk_seq);
					
					///////////////////////////////
					paraMap.put("searchType", "");
					paraMap.put("searchWord", "");
					///////////////////////////////
					
					FileboardVO fileboardvo = service.getViewWithNoAddCount_fileboard(paraMap);
					// 글조회수(readCount) 증가 없이 단순히 글1개만 조회해주는 것이다.
					
					HttpSession session = request.getSession();
					EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

				 	int login_userid1 = 0;
				 	if(loginuser != null) {
				 	   login_userid1 = loginuser.getPk_emp_no();
				 	   // login_userid 는 로그인 되어진 사용자의 userid 이다.
				 	}

				 	String login_userid = Integer.toString(login_userid1);

				 	
					if( !login_userid.equals(fileboardvo.getFk_emp_no()) ) {
						String message = "다른 사용자의 글은 삭제가 불가합니다.";
						String loc = "javascript:history.back()";
						
						mav.addObject("message", message);
						mav.addObject("loc", loc);
						mav.setViewName("msg");
					}
					else {
						// 자신의 글을 삭제할 경우
						// 글작성시 입력해준 글암호와 일치하는지 여부를 알아오도록 암호를 입력받아주는 del.jsp 페이지를 띄우도록 한다. 
						mav.addObject("pw", fileboardvo.getPw());
						mav.addObject("pk_seq", pk_seq);
						mav.setViewName("fileboard/del.board");
					}
			
				return mav;
			}	
			
			
			// === #77. 글삭제 페이지 완료하기 === //
			@RequestMapping(value="/fileboard/delEnd.bts", method= {RequestMethod.POST})
			public ModelAndView delEnd_fileboard(ModelAndView mav, HttpServletRequest request) {
				
				String pk_seq = request.getParameter("pk_seq");
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("pk_seq", pk_seq);
				
				////////////////////////////////////////////////////
				// === #164. 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파이을 삭제해주어야 한다. === //
				paraMap.put("searchType", "");
				paraMap.put("searchWord", "");
				
				FileboardVO fileboardvo = service.getViewWithNoAddCount_fileboard(paraMap);
				String filename = fileboardvo.getFilename();
				
				if( filename != null && !"".equals(filename)) {
					
					HttpSession session = request.getSession();
					String root = session.getServletContext().getRealPath("/");
					String path = root+"resources"+File.separator+"files";

					paraMap.put("path", path); // 삭제해야 할 파일이 저장된 경로
					paraMap.put("filename", filename);// 삭제해야할 파일명
					
				}
				// === 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파이을 삭제해주어야 한다. 끝 === //
				////////////////////////////////////////////////////////////
				
				int n = service.del_fileboard(paraMap);
				
				if(n==1) {
					mav.addObject("message", "글 삭제 성공!!");
					mav.addObject("loc", request.getContextPath()+"/fileboard/list.bts");
				}
				else {
					mav.addObject("message", "글 삭제 실패!!");
					mav.addObject("loc", "javascript:history.back()");
				}
				
				mav.setViewName("msg");
				
				return mav;
			}	
		
	// --- 자료 게시판 끝 --- -------------------
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	/*
	// 오류발생시
	@ExceptionHandler(java.lang.Throwable.class)
	public void handleThrowable(Throwable e, HttpServletRequest request, HttpServletResponse response) {

	e.printStackTrace(); // 콘솔에 에러메시지 나타내기

	try {
	   // *** 웹브라우저에 출력하기 시작 *** //
	   
	   // HttpServletResponse response 객체는 넘어온 데이터를 조작해서 결과물을 나타내고자 할때 쓰인다. 
	   response.setContentType("text/html; charset=UTF-8");
	   
	   PrintWriter out = response.getWriter();   // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
	   
	   out.println("<html>");
	   out.println("<head><title>오류메시지 출력하기</title></head>");
	   out.println("<body>");
	   out.println("<h1>오류발생</h1>");
	   
	 //  out.printf("<div><span style='font-weight: bold;'>오류메시지</span><br><span style='color: red;'>%s</span></div>", e.getMessage());
	   
	   String ctxPath = request.getContextPath();
	   
	   out.println("<div><img src='"+ctxPath+"/resources/images/error.gif'/></div>");
	   out.printf("<div style='margin: 20px; color: blue; font-weight: bold; font-size: 26pt;'>%s</div>", "장난금지");
	   out.println("<a href='"+ctxPath+"/index.action'>홈페이지로 가기</a>");
	   out.println("</body>");
	   out.println("</html>");
	   
	   // *** 웹브라우저에 출력하기 끝 *** //
	} catch (IOException e1) {
	   e1.printStackTrace();
	}

	}
	
	*/
	
	// === 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 생성 === //
		public void getCurrentURL(HttpServletRequest request) {
			HttpSession session = request.getSession();
			session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
		}
	
	
}
