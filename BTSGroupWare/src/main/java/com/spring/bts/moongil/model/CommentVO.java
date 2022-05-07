package com.spring.bts.moongil.model;

import org.springframework.web.multipart.MultipartFile;

//===== #82. 댓글용 VO 생성하기
//      먼저 오라클에서 tbl_comment 테이블을 생성한다.
//      또한 tbl_board 테이블에 commentCount 컬럼을 추가한다. =====
public class CommentVO {

	private String pk_seq;          // 댓글번호
	private String fk_emp_no;    // 사용자ID
	private String user_name;         // 성명
	private String content;      // 댓글내용
	private String write_day;      // 작성일자
	private String fk_seq;    // 원게시물 글번호
	private String status;       // 글삭제여부
	
	private MultipartFile attach;

	private String filename;    // WAS(톰캣)에 저장될 파일명(2022042911123035243254235235234.png) 
	private String orgfilename; // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String filesize;    // 파일크기 
	
	////////////////////////////////////////////////////////
	
	public CommentVO() {}

	public CommentVO(String pk_seq, String fk_emp_no, String user_name, String content, String write_day, String fk_seq,
			String status, MultipartFile attach, String filename, String orgfilename, String filesize) {
		this.pk_seq = pk_seq;
		this.fk_emp_no = fk_emp_no;
		this.user_name = user_name;
		this.content = content;
		this.write_day = write_day;
		this.fk_seq = fk_seq;
		this.status = status;
		this.attach = attach;
		this.filename = filename;
		this.orgfilename = orgfilename;
		this.filesize = filesize;
	}



	public String getPk_seq() {
		return pk_seq;
	}

	public void setPk_seq(String pk_seq) {
		this.pk_seq = pk_seq;
	}

	public String getFk_emp_no() {
		return fk_emp_no;
	}

	public void setFk_emp_no(String fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWrite_day() {
		return write_day;
	}

	public void setWrite_day(String write_day) {
		this.write_day = write_day;
	}

	public String getFk_seq() {
		return fk_seq;
	}

	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getOrgfilename() {
		return orgfilename;
	}

	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}

	public String getFilesize() {
		return filesize;
	}

	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	
	

	
}
