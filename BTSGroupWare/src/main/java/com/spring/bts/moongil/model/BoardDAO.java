package com.spring.bts.moongil.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;





@Repository
public class BoardDAO implements InterBoardDAO {

		// === #33. 의존객체 주입하기(DI: Dependency Injection) ===
		   // >>> 의존 객체 자동 주입(Automatic Dependency Injection)은
		   //     스프링 컨테이너가 자동적으로 의존 대상 객체를 찾아서 해당 객체에 필요한 의존객체를 주입하는 것을 말한다. 
		   //     단, 의존객체는 스프링 컨테이너속에 bean 으로 등록되어 있어야 한다. 
	
		   //     의존 객체 자동 주입(Automatic Dependency Injection)방법 3가지 
		   //     1. @Autowired ==> Spring Framework에서 지원하는 어노테이션이다. 
		   //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
		   
		   //     2. @Resource  ==> Java 에서 지원하는 어노테이션이다.
		   //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 필드명(이름)을 찾아서 연결(의존객체주입)한다.
		   
		   //     3. @Inject    ==> Java 에서 지원하는 어노테이션이다.
		    //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.   
		
		/*
		@Resource
		private SqlSessionTemplate sqlsession; // 로컬DB mymvc_user 에 연결
		// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의  sqlsession bean 을  sqlsession 에 주입시켜준다. 
	 // 그러므로 sqlsession 는 null 이 아니다.
		*/
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  sqlsession 에 주입시켜준다. 
	// 그러므로 sqlsession 는 null 이 아니다. 이름 맘대로해도됨


	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("moongil.getTotalCount", paraMap);
		return n;
	}

	@Override
	public List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("moongil.boardListSearchWithPaging", paraMap);
		return boardList;
	}

	@Override
	public BoardVO getView(Map<String, String> paraMap) {
		BoardVO boardvo = sqlsession.selectOne("moongil.getView", paraMap);
		return boardvo;
	}

	@Override
	public void setAddReadCount(String seq) {
		sqlsession.update("moongil.setAddReadCount", seq);
		
	}

	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = sqlsession.selectList("moongil.wordSearchShow", paraMap);
		return wordList;
	}


	


}
