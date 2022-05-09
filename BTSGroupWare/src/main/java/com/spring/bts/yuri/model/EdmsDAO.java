package com.spring.bts.yuri.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.bts.hwanmo.model.EmployeeVO;

// === DAO 선언 === //
@Repository
public class EdmsDAO implements InterEdmsDAO {

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
	
	// 파일첨부가 없는 전자결재 문서작성
	@Override
	public int edmsAdd_withFile(ApprVO apprvo) {
		int n = sqlsession.insert("yuri.edmsAdd_withFile", apprvo);
		return n;
	}

	// 페이징 처리를 안한 검색어가 없는 전체 대기문서 목록 보여주기
	@Override
	public List<ApprVO> waitListNoSearch() {
		List<ApprVO> waitList = sqlsession.selectList("yuri.waitListNoSearch");
		return waitList;
	}

	// 전자결재 양식선택(업무기안서, 휴가신청서 등..)을 위한 것
/*
	@Override
	public List<String> getApprsortList() {
		sqlsession.selectList("yuri.getApprsortList");
		return null;
	}
*/



	
	
	
	
	
	
	
	
}

