package com.spring.bts.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {
	
	// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
	public static String getCurrentURL(HttpServletRequest request) {
		
		// 만약에 웹브라우저 주소입력란에 아래와 같이 입력되었더라면..
		// http://localhost:9090/MyMVC/member/memberList.up?currentShowPageNo=5&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0
		
		
		String currentURL = request.getRequestURL().toString();
		// http://localhost:9090/MyMVC/member/memberList.up
		
		String queryString = request.getQueryString();
		// currentShowPageNo=5&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0 (GET 방식일 경우)
		
		if(queryString != null) { // GET 방식일 경우
			currentURL += "?" + queryString;
			// http://localhost:9090/MyMVC/member/memberList.up?currentShowPageNo=5&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0
			// 검색조건을 달아준다!
		}
		
		String ctxPath = request.getContextPath();
		//   /MyMVC
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		// currentURL 에서 ctxPath 가 처음으로 나타나는 시작값 + ctxPath의 길이 => beginIndex
		// ctxPath 이후의 값을 받아오기 위해 시작점을 받아오는 변수 beginIndex 생성
		
		currentURL = currentURL.substring(beginIndex);
		// /member/memberList.up?currentShowPageNo=5&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0
		// beginIndex를 이용하여 currentURL에 ctxPath 이후의 주소를 다시 저장해준다.
		
		return currentURL;
	}
	
}
