package com.spring.bts.yuri.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.common.FileManager;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.yuri.model.ApprVO;
import com.spring.bts.yuri.model.InterEdmsDAO;

// === Service 선언 === //
// 트랜잭션 처리를 담당하는 곳 , 업무를 처리하는 곳, 비지니스(Business)단
/* 자동적으로 @Component 가 올라와 있다! */
@Service
public class EdmsService implements InterEdmsService {

	// === 의존객체 주입하기(DI: Dependency Injection) === //
	@Autowired
	private InterEdmsDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO 의 bean 을  dao 에 주입시켜준다. 
    // 그러므로 dao 는 null 이 아니다.
	
	
	// === 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) === #yuly
//	@Autowired
//	private AES256 aes;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.common.AES256 의 bean 을  aes 에 주입시켜준다. 
	// 그러므로 aes 는 null 이 아니다.
	// com.spring.board.common.AES256 의 bean 은 /webapp/WEB-INF/spring/appServlet/servlet-context.xml 파일에서 bean 으로 등록시켜주었음.  
	
	// 서비스에서 쓰기 위해 끼워넣어 준 것이다.
	
	@Autowired	// Type에 따라 알아서 Bean을 주입해준다. 의존객체주입
	private FileManager fileManager;
	
	
	
	
	
	// === 로그인된 사원 정보 가져오기 === //
	@Override
	public EmployeeVO getLoginMember(Map<String, String> paraMap) {
		EmployeeVO loginuser = dao.getLoginMember(paraMap);
		return loginuser;
	}	

	
	// === 전자결재 양식선택(업무기안서, 휴가신청서 등..)을 위한 것 === // #yuly
/*
	@Override
	public List<String> getApprsortList() {
		List<String> apprsortList = dao.getApprsortList();
		return apprsortList;
	}
*/
	
	
	// === 글쓰기(파일 첨부가 없는 글쓰기) === //
	@Override
	public int edmsAdd(ApprVO apprvo) {
		int n = dao.edmsAdd(apprvo);
		return n;
	}
	
	// === 글쓰기(파일 첨부가 있는 글쓰기) === //
	@Override
	public int edmsAdd_withFile(ApprVO apprvo) {
		int n = dao.edmsAdd_withFile(apprvo);
		return n;
	}

	// 글 조회수 증가와 함께 글1개를 조회하기
	// (먼저, 로그인을 한 상태에서 다른 사람의 글을 조회할 경우에는, 글조회수 컬럼의 값을 1 증가해준다)
	@Override
	public ApprVO getView(Map<String, String> paraMap) {
		
		ApprVO apprvo = dao.getView(paraMap);
		
		String loginuser_empno = paraMap.get("loginuser_empno");
		
		if(loginuser_empno != null &&
			apprvo != null &&
			!loginuser_empno.equals( apprvo.getPk_appr_no() )) {
			// 글조회수 증가는 로그인을 한 상태에서 다른 사람의 글을 읽을 때만 증가하도록 한다.
			
			// 글조회수 1 증가하기 메소드
			dao.setAddViewcnt(apprvo.getPk_appr_no());
			apprvo = dao.getView(paraMap);
		}
		return apprvo;
			
	}

	// 조회수 증가없이 대기문서 1개 조회하기
	@Override
	public ApprVO getViewWithNoAddCount(Map<String, String> paraMap) {
		ApprVO apprvo = dao.getView(paraMap);
		return apprvo;
	}

	// 1개글 수정하기
	@Override
	public int edit(ApprVO apprvo) {
		int n = dao.edit(apprvo);
		return n;
	}

	// 1개글 삭제하기
	@Override
	public int del(Map<String, String> paraMap) {
		int n = dao.del(paraMap);
		
		// ==== 파일첨부가 된 글이라면 글 삭제 시 먼저 첨부파일을 삭제해주어야 한다. ==== //
		if(n==1) {
			String path = paraMap.get("path"); // 컨트롤러에서 받아온 key값
			String fileName = paraMap.get("fileName"); // 컨트롤러에서 받아온 key값
			
			if( fileName != null && "".equals(fileName) ) {
				try {
					fileManager.doFileDelete(fileName, path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return n;
	}

	// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	@Override
	public List<ApprVO> edmsListSearchWithPaging(Map<String, String> paraMap) {
		List<ApprVO> edmsList = dao.edmsListSearchWithPaging(paraMap);
		return edmsList;
	}
	
	// 검색어 입력시 자동글 완성 searchAutoComplete
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = dao.wordSearchShow(paraMap);
		return wordList;
	}
	
	// 총 게시물 건수(totalCount) 구하기 - 검색이 있을 때와 검색이 없을 때로 나뉜다.
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}


	
	/////////////////////////////////////////////////////////////////////////////////
	
	
	// 상세부서정보 페이지 사원목록 불러오기
	@Override
	public List<EmployeeVO> addBook_depInfo_select() {
		List<EmployeeVO> empList = dao.addBook_depInfo_select();
		return empList;
	}

	// 승인하기
	@Override
	public int accept(ApprVO apprvo) {
		int n = dao.accept(apprvo);
		return n;
	}

	// 반려하기
	@Override
	public int reject(ApprVO apprvo) {
		int n = dao.reject(apprvo);
		return n;
	}
	
	
	// 페이징 처리한 대기문서 목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	@Override
	public List<ApprVO> edmsListSearchWithPaging_wait(Map<String, String> paraMap) {
		List<ApprVO> edmsList = dao.edmsListSearchWithPaging_wait(paraMap);
		return edmsList;
	}

	// 페이징 처리한 승인문서 목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	@Override
	public List<ApprVO> edmsListSearchWithPaging_accept(Map<String, String> paraMap) {
		List<ApprVO> edmsList = dao.edmsListSearchWithPaging_accept(paraMap);
		return edmsList;
	}

	// 페이징 처리한 반려문서 목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	@Override
	public List<ApprVO> edmsListSearchWithPaging_reject(Map<String, String> paraMap) {
		List<ApprVO> edmsList = dao.edmsListSearchWithPaging_reject(paraMap);
		return edmsList;
	}
	
	
	
	
	
	
	
}