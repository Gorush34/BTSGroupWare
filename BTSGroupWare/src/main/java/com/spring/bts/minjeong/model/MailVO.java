package com.spring.bts.minjeong.model;

import org.springframework.web.multipart.MultipartFile;

public class MailVO {

	// 메일 VO 
	private String pk_mail_num;             // NOT NULL NUMBER(14)  메일번호    
	private String fk_senduser_num;         // NUMBER(8)     		보낸사람 사원번호
	private String fk_receiveuser_num;     	// NUMBER(8)     		받는사람 사원번호
	private String recemail;				// VARCHAR2(100)		이메일
	private String sendemail;				// VARCHAR2(100)		이메일
	private String recempname;        		// VARCHAR2(10)  		받는사람 이름
	private String sendempname;        		// VARCHAR2(10)  		받는사람 이름
	private String subject;                 // VARCHAR2(100) 		메일 제목
	private String content;                 // VARCHAR2(256) 		메일 내용
	private String filename;                // VARCHAR2(100) 		파일 저장되는 이름(disk)
	private String orgfilename;             // VARCHAR2(100) 		파일 원래이름(저장시)
	private String filesize;                // NUMBER        		파일크기
	private String reg_date;                // DATE          		메일쓰기 일자
	private String importance;              // NUMBER(2)     		파일 중요! 표시 여부		(0 : 중요표시안함X , 1:중요표시선택O)
	private String read_status;             // NUMBER(2)     		받는사람 읽음 여부 		(0 : 안읽음X , 1:읽음O)
	private String reservation_date;        // DATE          		발송예약 날짜
	private String reservation_status;      // NUMBER(2)     		발송예약여부 			(0: 발송예약X , 1: 발송예약O)
	private String del_status;				// NUMBER(2)  			삭제여부				(0: 삭제X , 1:삭제)
	private String temp_status;				// NUMBER(2) 			임시보관함 저장여부 		(0:저장 X , 1:저장O)
	private String importance_star;			// NUMBER(2) 			중요보관함(★) 저장여부 	(0:저장 X , 1:저장O) 
	
	// 메일 상세내용 보기
	private String prev_seq;		// 이전글번호
	private String prev_subject;	// 이전글제목
	private String next_seq;		// 다음글번호
	private String next_subject;	// 다음글제목
	
	// 파일첨부
	private MultipartFile attach;
	// form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
    // 진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
	
	public MailVO() {}
	
	
	// 생성자
	public MailVO(String pk_mail_num, String fk_senduser_num, String fk_receiveuser_num, String recemail,
			String sendemail, String recempname, String sendempname, String subject, String content, String filename,
			String orgfilename, String filesize, String reg_date, String importance, String read_status,
			String reservation_date, String reservation_status, String del_status, String temp_status,
			String importance_star, String prev_seq, String prev_subject, String next_seq, String next_subject,
			MultipartFile attach) {
		
			super();
			
			this.pk_mail_num = pk_mail_num;
			this.fk_senduser_num = fk_senduser_num;
			this.fk_receiveuser_num = fk_receiveuser_num;
			this.recemail = recemail;
			this.sendemail = sendemail;
			this.recempname = recempname;
			this.sendempname = sendempname;
			this.subject = subject;
			this.content = content;
			this.filename = filename;
			this.orgfilename = orgfilename;
			this.filesize = filesize;
			this.reg_date = reg_date;
			this.importance = importance;
			this.read_status = read_status;
			this.reservation_date = reservation_date;
			this.reservation_status = reservation_status;
			this.del_status = del_status;
			this.temp_status = temp_status;
			this.importance_star = importance_star;
			this.prev_seq = prev_seq;
			this.prev_subject = prev_subject;
			this.next_seq = next_seq;
			this.next_subject = next_subject;
			this.attach = attach;
	}
	
	
	// getter 및 setter	
	public String getRecemail() {
		return recemail;
	}


	public void setRecemail(String recemail) {
		this.recemail = recemail;
	}


	public String getSendemail() {
		return sendemail;
	}


	public void setSendemail(String sendemail) {
		this.sendemail = sendemail;
	}


	public String getRecempname() {
		return recempname;
	}


	public void setRecempname(String recempname) {
		this.recempname = recempname;
	}


	public String getSendempname() {
		return sendempname;
	}


	public void setSendempname(String sendempname) {
		this.sendempname = sendempname;
	}


	public String getPk_mail_num() {
		return pk_mail_num;
	}



	public void setPk_mail_num(String pk_mail_num) {
		this.pk_mail_num = pk_mail_num;
	}

	public String getFk_senduser_num() {
		return fk_senduser_num;
	}

	public void setFk_senduser_num(String fk_senduser_num) {
		this.fk_senduser_num = fk_senduser_num;
	}

	public String getFk_receiveuser_num() {
		return fk_receiveuser_num;
	}

	public void setFk_receiveuser_num(String fk_receiveuser_num) {
		this.fk_receiveuser_num = fk_receiveuser_num;
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

	public String getImportance() {
		return importance;
	}

	public void setImportance(String importance) {
		this.importance = importance;
	}

	public String getReservation_status() {
		return reservation_status;
	}

	public void setReservation_status(String reservation_status) {
		this.reservation_status = reservation_status;
	}

	public String getRead_status() {
		return read_status;
	}

	public void setRead_status(String read_status) {
		this.read_status = read_status;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getReservation_date() {
		return reservation_date;
	}

	public void setReservation_date(String reservation_date) {
		this.reservation_date = reservation_date;
	}


	public String getPrev_seq() {
		return prev_seq;
	}

	public void setPrev_seq(String prev_seq) {
		this.prev_seq = prev_seq;
	}

	public String getPrev_subject() {
		return prev_subject;
	}

	public void setPrev_subject(String prev_subject) {
		this.prev_subject = prev_subject;
	}

	public String getNext_seq() {
		return next_seq;
	}

	public void setNext_seq(String next_seq) {
		this.next_seq = next_seq;
	}

	public String getNext_subject() {
		return next_subject;
	}

	public void setNext_subject(String next_subject) {
		this.next_subject = next_subject;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}


	public String getDel_status() {
		return del_status;
	}


	public void setDel_status(String del_status) {
		this.del_status = del_status;
	}


	public String getTemp_status() {
		return temp_status;
	}


	public void setTemp_status(String temp_status) {
		this.temp_status = temp_status;
	}


	public String getImportance_star() {
		return importance_star;
	}


	public void setImportance_star(String importance_star) {
		this.importance_star = importance_star;
	}

		
	
	
}
