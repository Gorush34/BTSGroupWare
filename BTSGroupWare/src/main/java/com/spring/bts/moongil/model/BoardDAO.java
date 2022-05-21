package com.spring.bts.moongil.model;

import java.util.HashMap;
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


	// 자유게시판 게시물 건수(totalCount)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("moongil.getTotalCount", paraMap);
		return n;
	}

	// 자유게시판 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<BoardVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("moongil.boardListSearchWithPaging", paraMap);
		return boardList;
	}

	// 자유게시판 글1개를 조회를 해주는 것 
	@Override
	public BoardVO getView(Map<String, String> paraMap) {
		BoardVO boardvo = sqlsession.selectOne("moongil.getView", paraMap);
		return boardvo;
	}

	// 자유게시판 글1개의 조회수를 증가
	@Override
	public void setAddReadCount(String pk_seq) {
		sqlsession.update("moongil.setAddReadCount", pk_seq);
		
	}

	// tbl_board 테이블에서  groupno 컬럼의 최대값 알아오기
	@Override
	public int getGroupnoMax() {
		int maxgroupno = sqlsession.selectOne("moongil.getGroupnoMax");
		return maxgroupno;
	}

	// 파일첨부가 있는 경우 자유게시판 글쓰기
	@Override
	public int add_withFile(BoardVO boardvo) {
		int n = sqlsession.insert("moongil.add_withFile", boardvo);
		return n;
	}

	// 파일첨부가 없는 경우 자유게시판 글쓰기
	@Override
	public int add(BoardVO boardvo) {
		int n = sqlsession.insert("moongil.add", boardvo);
		return n;
	}

	// === 자유게시판 1개글 삭제하기 ===
	@Override
	public int del(Map<String, String> paraMap) {
		int n = sqlsession.delete("moongil.del", paraMap);
		return n;
	}

	// === 자유게시판 글수정 페이지 완료하기 === //
	@Override
	public int edit(BoardVO boardvo) {
		int n = sqlsession.update("moongil.edit", boardvo);
		return n;
	}

	// 자유게시판 첨부파일이 있는 임시저장
	@Override
	public int save_withFile(BoardVO boardvo) {
		int n = sqlsession.insert("moongil.save_withFile", boardvo);
		return n;
	}

	// 자유게시판  임시저장
	@Override
	public int save(BoardVO boardvo) {
		int n = sqlsession.insert("moongil.save", boardvo);
		return n;
	}

	// ===  댓글쓰기(Ajax 로 처리) === //
	@Override
	public int addComment(CommentVO commentvo) {
		int n = sqlsession.insert("moongil.addComment", commentvo);
		return n;
	}

	// tbl_board 테이블에 commentCount 컬럼이 1증가(update)
	@Override
	public int updateCommentCount(String fk_seq) {
		int n = sqlsession.update("moongil.updateCommentCount", fk_seq);
		return n;
	}

	// 임시저장 글목록 가져오기
	@Override
	public List<BoardVO> temp_list(Map<String, String> paraMap) {
		List<BoardVO> temp_list = sqlsession.selectList("moongil.temp_list", paraMap);
		return temp_list;
	}

	// === 임시저장글 완료하기 === //
	@Override
	public int tmp_write(BoardVO boardvo) {
		int n = sqlsession.update("moongil.tmp_write", boardvo);
		return n;
	}

	// 임시저장글 조회수 안올라가게
	@Override
	public BoardVO getView2(Map<String, String> paraMap) {
		BoardVO boardvo = sqlsession.selectOne("moongil.getView2", paraMap);
		return boardvo;
	}

	// 원글 글번호(parentSeq)에 해당하는 댓글의 totalPage 수 알아오기 
	@Override
	public int getCommentTotalPage(Map<String, String> paraMap) {
		int totalPage = sqlsession.selectOne("moongil.getCommentTotalPage", paraMap);
		return totalPage;
	}

	// === 원게시물에 딸린 댓글들을 페이징 처리해서 조회해오기(Ajax 로 처리) === //
	@Override
	public List<CommentVO> getCommentListPaging(Map<String, String> paraMap) {
		List<CommentVO> commentList = sqlsession.selectList("moongil.getCommentListPaging", paraMap);
		return commentList;
	}

	// 댓글 삭제하기
	@Override
	public int delComment(String pk_seq) {
		int n = sqlsession.update("moongil.delComment", pk_seq);
		return n;
	}

	// 댓글이 삭제되면 해당 글의 댓글수 감소시켜주기
	@Override
	public int minusCommentCount(String fk_seq) {
		int m = sqlsession.update("moongil.minusCommentCount", fk_seq);
		return m;
	}

	// 공지사항 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<NoticeVO> noticeListSearchWithPaging(Map<String, String> paraMap) {
		List<NoticeVO> noticeList = sqlsession.selectList("moongil.noticeListSearchWithPaging", paraMap);
		return noticeList;
	}

	// 공지사항 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount_notice(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("moongil.getTotalCount_notice", paraMap);
		return n;
	}

	// 파일첨부가 없는 경우 공지사항 글쓰기
	@Override
	public int add_notice(NoticeVO noticevo) {
		int n = sqlsession.insert("moongil.add_notice", noticevo);
		return n;
	}

	// 파일첨부가 있는 경우 공지사항 글쓰기
	@Override
	public int add_withFile_notice(NoticeVO noticevo) {
		int n = sqlsession.insert("moongil.add_withFile_notice", noticevo);
		return n;
	}

	// 공지사항 글조회수 증가와 함께 글1개를 조회를 해주는 것 
	@Override
	public NoticeVO getView_notice(Map<String, String> paraMap) {
		NoticeVO noticevo = sqlsession.selectOne("moongil.getView_notice", paraMap);
		return noticevo;
	}

	 // 공지사항 글 조회수 1증가
	@Override
	public void setAddReadCount_notice(String pk_seq) {
		sqlsession.update("moongil.setAddReadCount_notice", pk_seq);
	}

	// 좋아요를 눌렀는지 확인
	@Override
	public int likeCheck(int fk_seq, int fk_emp_no) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("fk_emp_no", fk_emp_no);
		map.put("fk_seq", fk_seq);
		return sqlsession.selectOne("moongil.likeCheck", map);
	}

	//like테이블 삽입
	@Override
	public void insertLike(int fk_seq, int fk_emp_no) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("fk_emp_no", fk_emp_no);
		map.put("fk_seq", fk_seq);
		sqlsession.insert("moongil.insertLike", map);
	}

	//게시판테이블 +1
	@Override
	public void updateLike(int fk_seq) {
		sqlsession.update("moongil.updateLike", fk_seq);
		
	}

	//like테이블 삭제
	@Override
	public void deleteLike(int fk_seq, int fk_emp_no) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("fk_emp_no", fk_emp_no);
		map.put("fk_seq", fk_seq);
		sqlsession.delete("moongil.deleteLike", map);
	}

	//게시판테이블 - 1
	@Override
	public void updateLikeCancel(int fk_seq) {
		sqlsession.update("moongil.updateLikeCancel", fk_seq);
		
	}

	// 좋아요 불러오기
	@Override
	public List<LikeVO> get_heart(Map<String, String> paraMap) {
		List<LikeVO> likeList = sqlsession.selectList("moongil.get_heart", paraMap);
		return likeList;
	}

	// 전체글의 게시물 건수(totalCount)
	@Override
	public int getTotalCount_total(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("moongil.getTotalCount_total", paraMap);
		return n;
	}

	// 전체글 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<BoardVO> boardListSearchWithPaging_total(Map<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("moongil.boardListSearchWithPaging_total", paraMap);
		return boardList;
	}

	// 오늘의 인기글
	@Override
	public List<Map<String, String>> getBestboard() {
		List<Map<String, String>> boardMap = sqlsession.selectList("moongil.getBestboard");
		return boardMap;
	}

	// 공지사항 글 수정
	@Override
	public int edit_notice(NoticeVO noticevo) {
		int n = sqlsession.update("moongil.edit_notice", noticevo);
		return n;
	}
	
	// 공지사항 글 삭제
	@Override
	public int del_notice(Map<String, String> paraMap) {
		int n = sqlsession.delete("moongil.del_notice", paraMap);
		return n;
	}

	// 자료실 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount_fileboard(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("moongil.getTotalCount_fileboard", paraMap);
		return n;
	}

	// 자료실 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<FileboardVO> ListSearchWithPaging_fileboard(Map<String, String> paraMap) {
		List<FileboardVO> fileboardlist = sqlsession.selectList("moongil.ListSearchWithPaging_fileboard", paraMap);
		return fileboardlist;
	}

	// 자료실 파일 있는 글쓰기
	@Override
	public int add_withFile_fileboard(FileboardVO fileboardvo) {
		int n = sqlsession.insert("moongil.add_withFile_fileboard", fileboardvo);
		return n;
	}

	// 자료실 파일 없는 글쓰기
	@Override
	public int add_fileboard(FileboardVO fileboardvo) {
		int n = sqlsession.insert("moongil.add_fileboard", fileboardvo);
		return n;
	}

	// 자료실 글1개를 조회를 해주는 것 
	@Override
	public FileboardVO getView_fileboard(Map<String, String> paraMap) {
		FileboardVO fileboardvo = sqlsession.selectOne("moongil.getView_fileboard", paraMap);
		return fileboardvo;
	}

	// 자료실 글조회수 1증가 하기 
	@Override
	public void setAddReadCount_fileboard(String pk_seq) {
		sqlsession.update("moongil.setAddReadCount_fileboard", pk_seq);
	}

	// 자료실 글수정
	@Override
	public int edit_fileboard(FileboardVO fileboardvo) {
		int n = sqlsession.update("moongil.edit_fileboard", fileboardvo);
		return n;
	}

	// 자료실 글 삭제
	@Override
	public int del_fileboard(Map<String, String> paraMap) {
		int n = sqlsession.delete("moongil.del_fileboard", paraMap);
		return n;
	}
	
	// 메인페이지에서 공지 글 ajax로 불러오기
	@Override
	public List<Map<String, String>> getNoticeboard() {
		List<Map<String, String>> boardMap = sqlsession.selectList("moongil.getNoticeboard");
		return boardMap;
	}

	// 메인페이지에서 자유게시판 글 ajax로 불러오기
	@Override
	public List<Map<String, String>> getBoard() {
		List<Map<String, String>> boardMap = sqlsession.selectList("moongil.getBoard");
		return boardMap;
	}

	// 메인페이지에서 자료실 글 ajax로 불러오기
	@Override
	public List<Map<String, String>> getFileboard() {
		List<Map<String, String>> boardMap = sqlsession.selectList("moongil.getFileboard");
		return boardMap;
	}

	// 메인페이지 전체게시판 글 ajax 로 불러오기
	@Override
	public List<Map<String, String>> getAll() {
		List<Map<String, String>> boardMap = sqlsession.selectList("moongil.getAll");
		return boardMap;
	}

	// 로그인한 유저가 좋아요를 눌렀는지 안눌렀는지 조회
	@Override
	public LikeVO getlikeuser(Map<String, String> paraMap) {
		LikeVO likevo = sqlsession.selectOne("moongil.getlikeuser", paraMap);
		return likevo;
	}

	// 내가 쓴 글 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<BoardVO> boardListSearchWithPaging_my(Map<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("moongil.boardListSearchWithPaging_my", paraMap);
		return boardList;
	}

	// 내가 쓴 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount_my(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("moongil.getTotalCount_my", paraMap);
		return n;
	}

	// 내가 작성한 글 수 알아오기
	@Override
	public int my_cnt(int pk_emp_no) {
		int n = sqlsession.selectOne("moongil.my_cnt", pk_emp_no);
		return n;
	}

	// 내 댓글이 있는 총 게시물 건수
	@Override
	public int getTotalCount_comment(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("moongil.getTotalCount_comment", paraMap);
		return n;
	}

	// 댓글 쓴 글 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<BoardVO> boardListSearchWithPaging_comment(Map<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("moongil.boardListSearchWithPaging_comment", paraMap);
		return boardList;
	}

	// 댓글 보기
	@Override
	public List<CommentVO> view_comment(Map<String, String> paraMap) {
		List<CommentVO> commentList = sqlsession.selectList("moongil.view_comment", paraMap);
		return commentList;
	}

	// 글삭제를 하면 댓글들도 삭제
	@Override
	public int update_comment_status(Map<String, String> paraMap) {
		int m = sqlsession.update("moongil.update_comment_status", paraMap);
		return m;
	}

	@Override
	public int selectDel(Map<String, String> paraMap) {
		int n = sqlsession.update("moongil.selectDel", paraMap);
		return n;
	}



	
}
