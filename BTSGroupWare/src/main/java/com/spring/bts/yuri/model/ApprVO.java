package com.spring.bts.yuri.model;

import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

@Repository
public class ApprVO {
	
	private String pk_appr_no;		/* 결재번호 */
	private String fk_appr_sortno;	/* 결재구분번호 */
	private int fk_emp_no;			/* 사원번호 */
	private int fk_mid_empno;		/* 중간승인자 */
	private int fk_fin_empno;		/* 최종승인자 */
	private String emergency;		/* 긴급여부 - DEFAULT 0 */
	private String title;			/* 제목 */
	private String contents;		/* 내용 */
	private String filename;		/* 서버파일명 */
	private String orgfilename;		/* 실제파일명 */
	private String fileSize;		/* 파일사이즈 */
	private String status;			/* 결재진행상태 - DEFAULT 0 */
	private String mid_accept;		/* 중간승인여부 - DEFAULT 0 */
	private String fin_accept;		/* 최종승인여부 - DEFAULT 0*/
	private String mid_opinion;		/* 중간승인자의견 */
	private String fin_opinion;		/* 최종승인자의견 */
	private String writeday;		/* 결재작성일자 */
	private String viewcnt;			/* 파일읽음여부 - DEFAULT 0*/
	
	private String previousseq;		/* 이전글번호 */ 
	private String previoussubject;	/* 이전글제목 */
	private String nextseq;			/* 다음글번호 */
	private String nextsubject;		/* 다음글제목 */ 	
	
	
	
	//////////////////////////////////////////////////////////
	
	private String emp_name; 			/* 이름 */
	private String ko_rankname;			/* 직급이름 */
	private String ko_depname;			/* 부서명 */
	private String manager;				/* 부서장번호 */
	private String pk_rank_no;			/* 직급번호 */
	
	private MultipartFile attach;
	/*
	 * form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다.
	 * 진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
	 * 조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.
	 * /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서
	 * input type="file" 인 name 의 이름(attach)과 동일해야만 파일첨부가 가능해진다.!!!!
	 */
	
	// 기본생성자
	public ApprVO() {}

	// 생성자 1
	public ApprVO(String pk_appr_no, String fk_appr_sortno, int fk_emp_no, int fk_mid_empno,
			int fk_fin_empno, String emergency, String title, String contents, String filename,
			String orgfilename, String fileSize, String status, String mid_accept, String fin_accept,
			String mid_opinion, String fin_opinion, String writeday, String viewcnt,
			String emp_name, String ko_rankname, String ko_depname, String manager, String pk_rank_no) {
		
		this.pk_appr_no = pk_appr_no;
		this.fk_appr_sortno = fk_appr_sortno;
		this.fk_emp_no = fk_emp_no;
		this.fk_mid_empno = fk_mid_empno;
		this.fk_fin_empno = fk_fin_empno;
		this.emergency = emergency;
		this.title = title;
		this.contents = contents;
		this.filename = filename;
		this.orgfilename = orgfilename;
		this.fileSize = fileSize;
		this.status = status;
		this.mid_accept = mid_accept;
		this.fin_accept = fin_accept;
		this.mid_opinion = mid_opinion;
		this.fin_opinion = fin_opinion;
		this.writeday = writeday;
		this.viewcnt = viewcnt;
		this.emp_name = emp_name;
		this.ko_rankname = ko_rankname;
		this.ko_depname = ko_depname;
		this.manager = manager;
		this.pk_rank_no = pk_rank_no;
	}

	
	// Getter Setter
	public String getPk_appr_no() {
		return pk_appr_no;
	}

	public void setPk_appr_no(String pk_appr_no) {
		this.pk_appr_no = pk_appr_no;
	}

	public String getFk_appr_sortno() {
		return fk_appr_sortno;
	}

	public void setFk_appr_sortno(String fk_appr_sortno) {
		this.fk_appr_sortno = fk_appr_sortno;
	}

	public int getFk_emp_no() {
		return fk_emp_no;
	}

	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}

	public int getFk_mid_empno() {
		return fk_mid_empno;
	}

	public void setFk_mid_empno(int fk_mid_empno) {
		this.fk_mid_empno = fk_mid_empno;
	}

	public int getFk_fin_empno() {
		return fk_fin_empno;
	}

	public void setFk_fin_empno(int fk_fin_empno) {
		this.fk_fin_empno = fk_fin_empno;
	}

	public String getEmergency() {
		return emergency;
	}

	public void setEmergency(String emergency) {
		this.emergency = emergency;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
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
	
	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMid_accept() {
		return mid_accept;
	}

	public void setMid_accept(String mid_accept) {
		this.mid_accept = mid_accept;
	}

	public String getFin_accept() {
		return fin_accept;
	}

	public void setFin_accept(String fin_accept) {
		this.fin_accept = fin_accept;
	}

	public String getMid_opinion() {
		return mid_opinion;
	}

	public void setMid_opinion(String mid_opinion) {
		this.mid_opinion = mid_opinion;
	}

	public String getFin_opinion() {
		return fin_opinion;
	}

	public void setFin_opinion(String fin_opinion) {
		this.fin_opinion = fin_opinion;
	}

	public String getWriteday() {
		return writeday;
	}

	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}

	public String getViewcnt() {
		return viewcnt;
	}

	public void setViewcnt(String viewcnt) {
		this.viewcnt = viewcnt;
	}

	
	
	
	////////////////////////////////////////////////////////////
	
	
	
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

	
	///////////////////////////////
	
	
	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public String getKo_rankname() {
		return ko_rankname;
	}

	public void setKo_rankname(String ko_rankname) {
		this.ko_rankname = ko_rankname;
	}

	public String getKo_depname() {
		return ko_depname;
	}

	public void setKo_depname(String ko_depname) {
		this.ko_depname = ko_depname;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}
	
	public String getPk_rank_no() {
		return pk_rank_no;
	}

	public void setPk_rank_no(String pk_rank_no) {
		this.pk_rank_no = pk_rank_no;
	}

	@Override
	public String toString() {
		return "ApprVO [pk_appr_no=" + pk_appr_no + ", fk_appr_sortno=" + fk_appr_sortno + ", fk_emp_no=" + fk_emp_no
				+ ", fk_mid_empno=" + fk_mid_empno + ", fk_fin_empno=" + fk_fin_empno + ", emergency=" + emergency
				+ ", title=" + title + ", contents=" + contents + ", filename=" + filename + ", orgfilename="
				+ orgfilename + ", fileSize=" + fileSize + ", status=" + status + ", mid_accept=" + mid_accept
				+ ", fin_accept=" + fin_accept + ", mid_opinion=" + mid_opinion + ", fin_opinion=" + fin_opinion
				+ ", writeday=" + writeday + ", viewcnt=" + viewcnt + ", previousseq=" + previousseq
				+ ", previoussubject=" + previoussubject + ", nextseq=" + nextseq + ", nextsubject=" + nextsubject
				+ ", emp_name=" + emp_name + ", ko_rankname=" + ko_rankname + ", ko_depname=" + ko_depname
				+ ", manager=" + manager + ", pk_rank_no" + pk_rank_no + ", attach=" + attach + "]";
	}
	
}