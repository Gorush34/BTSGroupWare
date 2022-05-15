package com.spring.bts.moongil.model;

import org.springframework.web.multipart.MultipartFile;

//=== #52. vo 생성하기
//  먼저, 오라클에서 tbl_board 테이블을 생성해야 한다.
public class BoardVO {


	private String pk_seq;
	private String fk_emp_no;
	private String subject;
	private String content;
	private String user_name;
	private String write_day;
	private String ip;
	private String read_count;
	private String pw;
	private String status;
	private String comment_count;
	private String org_filename;
	private String filename;
	private String file_size;
	private String groupno;
	private String fk_seq;
	private String depthno;
	private String ko_rankname;
	private String like_cnt;
	private String tblname;
	
	private String previousseq;      // 이전글번호
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목	
	
	
	private MultipartFile attach;
	
	public BoardVO() {}


	public BoardVO(String pk_seq, String like_cnt, String fk_emp_no, String subject, String content, String user_name, String write_day,
			String ip, String read_count, String pw, String status, String comment_count, String org_filename,
			String filename, String file_size, String groupno, String fk_seq, String depthno, String previousseq,
			String previoussubject, String nextseq, String nextsubject, MultipartFile attach, String ko_rankname, String tblname) {
		this.pk_seq = pk_seq;
		this.like_cnt = like_cnt;
		this.fk_emp_no = fk_emp_no;
		this.subject = subject;
		this.content = content;
		this.user_name = user_name;
		this.write_day = write_day;
		this.ip = ip;
		this.read_count = read_count;
		this.pw = pw;
		this.status = status;
		this.comment_count = comment_count;
		this.org_filename = org_filename;
		this.filename = filename;
		this.file_size = file_size;
		this.groupno = groupno;
		this.fk_seq = fk_seq;
		this.depthno = depthno;
		this.previousseq = previousseq;
		this.previoussubject = previoussubject;
		this.nextseq = nextseq;
		this.nextsubject = nextsubject;
		this.attach = attach;
		this.ko_rankname = ko_rankname;
		this.tblname = tblname;
	}





	public String getTblname() {
		return tblname;
	}


	public void setTblname(String tblname) {
		this.tblname = tblname;
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


	public String getSubject() {
		return subject;
	}


	public void setSubject(String subject) {
		this.subject = subject;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getUser_name() {
		return user_name;
	}


	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}


	public String getWrite_day() {
		return write_day;
	}


	public void setWrite_day(String write_day) {
		this.write_day = write_day;
	}


	public String getIp() {
		return ip;
	}


	public void setIp(String ip) {
		this.ip = ip;
	}


	public String getRead_count() {
		return read_count;
	}


	public void setRead_count(String read_count) {
		this.read_count = read_count;
	}


	public String getPw() {
		return pw;
	}


	public void setPw(String pw) {
		this.pw = pw;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getComment_count() {
		return comment_count;
	}


	public void setComment_count(String comment_count) {
		this.comment_count = comment_count;
	}


	public String getOrg_filename() {
		return org_filename;
	}


	public void setOrg_filename(String org_filename) {
		this.org_filename = org_filename;
	}


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}


	public String getFile_size() {
		return file_size;
	}


	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}


	public String getGroupno() {
		return groupno;
	}


	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}


	public String getFk_seq() {
		return fk_seq;
	}


	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}


	public String getDepthno() {
		return depthno;
	}


	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}


	public String getPreviousseq() {
		return previousseq;
	}


	public void setPreviousseq(String previousseq) {
		this.previousseq = previousseq;
	}


	public String getPrevioussubject() {
		return previoussubject;
	}


	public void setPrevioussubject(String previoussubject) {
		this.previoussubject = previoussubject;
	}


	public String getNextseq() {
		return nextseq;
	}


	public void setNextseq(String nextseq) {
		this.nextseq = nextseq;
	}


	public String getNextsubject() {
		return nextsubject;
	}


	public void setNextsubject(String nextsubject) {
		this.nextsubject = nextsubject;
	}


	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}


	public String getKo_rankname() {
		return ko_rankname;
	}


	public void setKo_rankname(String ko_rankname) {
		this.ko_rankname = ko_rankname;
	}


	public String getLike_cnt() {
		return like_cnt;
	}


	public void setLike_cnt(String like_cnt) {
		this.like_cnt = like_cnt;
	}
	
	
	
	
	
}