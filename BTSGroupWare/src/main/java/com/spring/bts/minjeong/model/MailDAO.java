package com.spring.bts.minjeong.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository	// @component 가 포함되어 있는 것이다. 자동적으로 bean 으로 올라간다.
public class MailDAO implements InterMailDAO {

	// === #33. 의존객체 주입하기(DI: Dependency Injection) ===
	   // >>> 의존 객체 자동 주입(Automatic Dependency Injection)은
	   //     스프링 컨테이너가 자동적으로 의존 대상 객체를 찾아서 해당 객체에 필요한 의존객체를 주입하는 것을 말한다. 
	   //     단, 의존객체는 스프링 컨테이너속에 bean 으로 등록되어 있어야 한다. 

	   //     의존 객체 자동 주입(Automatic Dependency Injection)방법 3가지 
	   //     1. @Autowired ==> Spring Framework에서 지원하는 어노테이션이다. 
	   //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
	   
	   //     2. @Resource  ==> Java 에서 지원하는 어노테이션이다. (JDK)
	   //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 필드명(이름)을 찾아서 연결(의존객체주입)한다.
	   
	   //     3. @Inject    ==> Java 에서 지원하는 어노테이션이다. (JDK) @Autowired 와 기능은 똑같지만 JAVA 인 JDK 에 속해있다.
	   //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.   
		
	/*
		// 이제 DAO 에서 Spring 은 Connection 을 얻어올 필요가 없다.
		// root-context.xml 파일을 참조한다.
		@Autowired	// bean 에 올라간것 중 SqlSessionTemplate 에 들어간 것을 넣어준다.
		private SqlSessionTemplate abc;		// @Autowired 로 인해 abc 는 null 이 아니게됨. abc 는  myBatis로  DB 이다.
											// SqlSessionTemplate : DBCP 연결 , abc 에는 sqlsession 이 들어와 있는 것이다.
		// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  abc 에 주입시켜준다. 
	    // 그러므로 abc 는 null 이 아니다.
	*/
	
	@Resource
	private SqlSessionTemplate sqlsession;
	// Type 에 따라 Spring 컨테이너가 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의  sqlsession bean 을  sqlsession 에 주입시켜준다. 
    // 그러므로 sqlsession 는 null 이 아니다.
	
	@Override
	public List<MailVO> getReceiveMailList() {
		List<MailVO> receiveMailList = sqlsession.selectList("minjeong.getReceiveMailList");
		return receiveMailList;
	}

	// 총 받은메일 개수 구해오기
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("minjeong.getTotalCount", paraMap);
		return n;
	}

	// 페이징처리 한 받은 메일목록 (검색 있든, 없든 모두 다 포함)
	@Override
	public List<MailVO> recMailListSearchWithPaging(Map<String, String> paraMap) {
		List<MailVO> receiveMailList = sqlsession.selectList("minjeong.recMailListSearchWithPaging", paraMap);
	//	System.out.println("확인용 dao");
		
		return receiveMailList;
	}

}
