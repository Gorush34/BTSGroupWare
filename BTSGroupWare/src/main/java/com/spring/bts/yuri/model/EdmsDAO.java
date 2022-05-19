package com.spring.bts.yuri.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.spring.bts.hwanmo.model.EmployeeVO;

// === DAO 선언 === //
@Repository
public class EdmsDAO implements InterEdmsDAO {
	private final Logger LOGGER = LoggerFactory.getLogger(EdmsDAO.class);
	// === 의존객체 주입하기(DI: Dependency Injection) === //
	/* 
		>>> 의존 객체 자동 주입(Automatic Dependency Injection)은
		스프링 컨테이너가 자동적으로 의존 대상 객체를 찾아서 해당 객체에 필요한 의존객체를 주입하는 것을 말한다.
		단, 의존객체는 스프링 컨테이너속에 bean 으로 등록되어 있어야 한다.
		
		의존 객체 자동 주입(Automatic Dependency Injection)방법 3가지
		
		1. @Autowired ==> Spring Framework에서 지원하는 어노테이션이다.
						스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
		2. @Resource  ==> Java 에서 지원하는 어노테이션이다.	
						스프링 컨테이너에 담겨진 의존객체를 주입할때 필드명(이름)을 찾아서 연결(의존객체주입)한다.
		3. @Inject    ==> Java 에서 지원하는 어노테이션이다.
						스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
		
	 */
/*
	@Autowired
	private SqlSessionTemplate abc; // abc는 DB이다(mybatis), sqlsession 에 있고 sql 파일은 ?
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된
	// org.mybatis.spring.SqlSessionTemplate 의 bean 을  abc 에 주입시켜준다. 
    // 그러므로 abc 는 null 이 아니다.
*/
	
	@Resource
	private SqlSessionTemplate sqlsession; // 로컬DB mymvc_user에 연결
	/* @Resource 를 쓸 때는 sqlsession에 abc를 넣으면 안 된다. */
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된
	// org.mybatis.spring.SqlSessionTemplate 의  sqlsession bean 을  sqlsession 에 주입시켜준다. 
    // 그러므로 sqlsession 는 null 이 아니다.
	
	
	
	// 로그인 멤버 정보 가져오기
	@Override
	public EmployeeVO getLoginMember(Map<String, String> paraMap) {
		EmployeeVO loginuser = sqlsession.selectOne("yuri.getLoginMember", paraMap);
		return loginuser;
	}
		
	// 파일첨부가 없는 전자결재 문서작성
	@Override
	public int edmsAdd(ApprVO apprvo) {
		int n = sqlsession.insert("yuri.edmsAdd", apprvo);
		return n;
	}
	
	// 파일첨부가 있는 전자결재 문서작성
	@Override
	public int edmsAdd_withFile(ApprVO apprvo) {
		int n = sqlsession.insert("yuri.edmsAdd_withFile", apprvo);
		return n;
	}

	// 1개 조회하기
	@Override
	public ApprVO getView(Map<String, String> paraMap) {
		ApprVO apprvo = sqlsession.selectOne("yuri.getView", paraMap);
		return apprvo;
	}	
	
	// 대기문서 글조회수 1 증가하기 메소드
	@Override
	public void setAddViewcnt(String pk_appr_no) {
		sqlsession.update("yuri.setAddReadCount", pk_appr_no);
	}
	
	// 1개글 수정하기
	@Override
	public int edit(ApprVO apprvo) {
		int n = sqlsession.update("yuri.edit", apprvo);
		return n;
	}

	// 1개글 삭제하기
	@Override
	public int del(Map<String, String> paraMap) {
		int n = sqlsession.delete("yuri.del", paraMap);
		return n;
	}

	// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	@Override
	public List<ApprVO> edmsListSearchWithPaging(Map<String, String> paraMap) {
		List<ApprVO> edmsList = sqlsession.selectList("yuri.edmsListSearchWithPaging", paraMap);
		return edmsList;
	}
	
	// 검색어 입력시 자동글 완성하기
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = sqlsession.selectList("yuri.wordSearchShow", paraMap);
		return wordList;
	}

	// 총 게시물 건수(totalCount) 구하기 - 검색이 있을 때와 검색이 없을 때로 나뉜다.
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("yuri.getTotalCount", paraMap);
		return n;
	}

	// 상세부서정보 페이지 사원목록 불러오기 
	@Override
	public List<EmployeeVO> addBook_depInfo_select() {
		List<EmployeeVO> empList = sqlsession.selectList("yuri.addBook_depInfo_select");
		return empList;
	}
	
	// 승인하기
	@Override
	public int accept(ApprVO apprvo) {
		System.out.println("accept(ApprVO apprvo)");
		System.out.println(apprvo.toString());
		int n = sqlsession.update("yuri.accept", apprvo);
		return n;
	}

	// 반력하기
	@Override
	public int reject(ApprVO apprvo) {
		int n = sqlsession.update("yuri.reject", apprvo);
		return n;
	}

	// 대기문서 목록 페이징 처리
	@Override
	public List<ApprVO> edmsListSearchWithPaging_wait(Map<String, String> paraMap) {
		
		List<ApprVO> edmsList = sqlsession.selectList("yuri.edmsListSearchWithPaging_wait", paraMap);
		return edmsList;
	}
	
	// 승인문서 목록 페이징 처리
	@Override
	public List<ApprVO> edmsListSearchWithPaging_accept(Map<String, String> paraMap) {
		List<ApprVO> edmsList = sqlsession.selectList("yuri.edmsListSearchWithPaging_accept", paraMap);
		return edmsList;
	}
	
	// 반려문서 목록 페이징 처리
	@Override
	public List<ApprVO> edmsListSearchWithPaging_reject(Map<String, String> paraMap) {
		List<ApprVO> edmsList = sqlsession.selectList("yuri.edmsListSearchWithPaging_reject", paraMap);
		return edmsList;
	}

	// 상태 상관없이 전체 리스트 불러오기
	@Override
	public List<Map<String, Object>> getAllList(Map<String, String> paraMap) {
		List<Map<String, Object>> allList = sqlsession.selectList("yuri.getAllList", paraMap);
		return allList;
	}

	// 상태가 승인됨인 리스트 불러오기
	@Override
	public List<Map<String, Object>> getAcceptList(Map<String, String> paraMap) {
		List<Map<String, Object>> acceptList = sqlsession.selectList("yuri.getAcceptList", paraMap);
		return acceptList;
	}

	// 상태가 반려됨인 리스트 불러오기
	@Override
	public List<Map<String, Object>> getRejectList(Map<String, String> paraMap) {
		List<Map<String, Object>> rejectList = sqlsession.selectList("yuri.getRejectList", paraMap);
		return rejectList;
	}

	// 로그인유저의 결재대기문서 가져오기
	@Override
	public int getTotalCountWaitingSign(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("yuri.getTotalCountWaitingSign", paraMap);
		return totalCount;
	}

	// 페이징 처리한 로그인유저의 결재대기목록 가져오기
	@Override
	public List<Map<String, Object>> waitingSignListWithPaging(Map<String, String> paraMap) {
		List<Map<String, Object>> waitingList = sqlsession.selectList("yuri.waitingSignListWithPaging", paraMap);
		return waitingList;
	}

	// 문서번호 통해 문서정보 가져오기
	@Override
	public ApprVO getApprInfo(String pk_appr_no) {
		ApprVO apprvo = sqlsession.selectOne("yuri.getApprInfo", pk_appr_no);
		return apprvo;
	}

	// 승인 처리하기
	@Override
	public int updateAppr(ApprVO apprvo) {
		int n = sqlsession.update("yuri.updateAppr", apprvo);
		return n;
	}

	// 문서번호로 결재자 이름 알아오기
	@Override
	public Map<String, String> getApprSignInfo(String pk_appr_no) {
		Map<String, String> signMap = sqlsession.selectOne("yuri.getApprSignInfo", pk_appr_no);
		return signMap;
	}

	// 내문서함 - 대기문서함 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount_wait(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("yuri.getTotalCount_wait", paraMap);
		return totalCount;
	}

	// 상태가 대기중인 모든 결재문서 불러오기
	@Override
	public List<ApprVO> getEdmsListWithPaging_wait(Map<String, String> paraMap) {

		System.out.println(paraMap.get("fk_emp_no"));
		
		List<ApprVO> edmsList = sqlsession.selectList("yuri.getEdmsListWithPaging_wait", paraMap);
		return edmsList;
	}

	// 내문서함 - 승인문서함 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount_accept(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("yuri.getTotalCount_accept", paraMap);
		return totalCount;
	}

	// 내문서함 - 반려문서함 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount_reject(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("yuri.getTotalCount_reject", paraMap);
		return totalCount;
	}
}