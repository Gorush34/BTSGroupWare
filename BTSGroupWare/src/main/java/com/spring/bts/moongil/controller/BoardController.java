package com.spring.bts.moongil.controller;
import java.io.File;
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
import com.spring.bts.moongil.model.BoardVO;
import com.spring.bts.moongil.model.CommentVO;
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
	
	
	
	@RequestMapping(value = "/board/main.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
    public String board_main(HttpServletRequest request) {

		      
	       return "board_main.board";
	}

	
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
		
		if(searchType == null || (!"subject".equals(searchType) && !"name".equals(searchType)) ) {
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
	 	/*
	 	System.out.println("~~~~ view2 의 searchType : " + searchType);
	    System.out.println("~~~~ view2 의 searchWord : " + searchWord);
	    System.out.println("~~~~ view2 의 gobackURL : " + gobackURL);
	 	*/
	 	
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

	//			String path = root+"resources"+File.separator+"files";
				
				String newFileName = "";

				
	//			byte[] bytes = null;

				
	//			long file_size = 0;
				
				try {
		//			bytes = attach.getBytes();

					
					String originalFilename = attach.getOriginalFilename();

					boardvo.setFilename(newFileName);
				
					boardvo.setOrg_filename(originalFilename);

					
	//				file_size = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
	//				boardvo.setFile_size(String.valueOf(file_size));
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}

			int n = 0;
			
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
	public ModelAndView view(ModelAndView mav, HttpServletRequest request) {
		
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

		 	
		 	
		 	int login_userid1 = 0;
		 	if(loginuser != null) {
		 	   login_userid1 = loginuser.getPk_emp_no();

		 	   
		 	}

		 	String login_userid = Integer.toString(login_userid1);
		 	
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
			// 댓글쓰기에 첨부파일이 없는 경우 
			
			int n = 0;
			
			try {
				n = service.addComment(commentvo);
			} catch (Throwable e) {
				e.printStackTrace();
			}
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			jsonObj.put("user_name", commentvo.getUser_name());
			
			return jsonObj.toString();  
		}
		
		
		// === 원게시물에 딸린 댓글들을 조회해오기(Ajax 로 처리) === //
		@ResponseBody
		@RequestMapping(value="/board/readComment.bts", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
		public String readComment(HttpServletRequest request) {
		
			String fk_seq = request.getParameter("fk_seq");
			
			List<CommentVO> commentList = service.getCommentList(fk_seq);
			
			JSONArray jsonArr = new JSONArray();  // []
			
			if( commentList != null ) {
				for(CommentVO cmtvo : commentList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("user_name", cmtvo.getUser_name());
					jsonObj.put("content", cmtvo.getContent());
					jsonObj.put("write_day", cmtvo.getWrite_day());
					
					jsonArr.put(jsonObj);
				}// end of for---------------------
			}
			
			return jsonArr.toString();
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
			
			JSONArray jsonArr = new JSONArray(); // []
			
			if(commentList != null) {
				for(CommentVO cmtvo : commentList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("content", cmtvo.getContent());
					jsonObj.put("name", cmtvo.getUser_name());
					jsonObj.put("regDate", cmtvo.getWrite_day());
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
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_seq", fk_seq);
			paraMap.put("sizePerPage", sizePerPage);
			
			// 원글 글번호(parentSeq)에 해당하는 댓글의 totalPage 수 알아오기 
			int totalPage = service.getCommentTotalPage(paraMap);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("totalPage", totalPage);   // {"totalPage":5}
			
			return jsonObj.toString();
		}
		
		
		

		
	// === #108. 검색어 입력시 자동글 완성하기 3 === //
	@ResponseBody
	@RequestMapping(value="/wordSearchShow.bts", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String wordSearchShow(HttpServletRequest request) {
		
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
	
	// == 게시판 글보기 끝  == //
	
	
	
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
						HttpSession session = mrequest.getSession();
						String root = session.getServletContext().getRealPath("/");

		//				String path = root+"resources"+File.separator+"files";
						
						String newFileName = "";
						// WAS(톰캣)의 디스크에 저장될 파일명 
						
						byte[] bytes = null;
						// 첨부파일의 내용물을 담는 것 
						
						long file_size = 0;
						// 첨부파일의 크기 
						
						try {
							bytes = attach.getBytes();
							
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
	@RequestMapping(value="/bts/editEnd.bts", method= {RequestMethod.POST})
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
	
	
	// --- 게시판 끝 --- -------------------
	
	// --- 자료 게시판 시작 ---  -----------------
	@RequestMapping(value = "/fileboard/list.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
    public String fileboard_list(HttpServletRequest request) {

		      
	       return "/fileboard/list.board";
	}
	// --- 자료 게시판 끝 --- -------------------
	
	
	// --- 공지 게시판 시작 ---  -----------------
	@RequestMapping(value = "/notice/list.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
    public String notice_test(HttpServletRequest request) {

		      
	       return "/notice/list.board";
	}
	// --- 공지 게시판 끝 ---  -----------------
	
	
	
	// === 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 생성 === //
		public void getCurrentURL(HttpServletRequest request) {
			HttpSession session = request.getSession();
			session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
		}
	
	
}
