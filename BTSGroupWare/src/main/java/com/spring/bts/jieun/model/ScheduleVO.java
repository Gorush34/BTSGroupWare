package com.spring.bts.jieun.model;

public class ScheduleVO {
	private String pk_schno;  
	private String fk_emp_no;  
	private String fk_calno;      
	private String subject;   
	private String startdate;           
	private String enddate;           
	private String content; 
	private String color;   
	private String place;   
	private String joinuser;   
	private String fk_lgcatgono;
	
	public String getPk_schno() {
		return pk_schno;
	}
	public void setPk_schno(String pk_schno) {
		this.pk_schno = pk_schno;
	}
	public String getFk_emp_no() {
		return fk_emp_no;
	}
	public void setFk_emp_no(String fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}
	public String getFk_calno() {
		return fk_calno;
	}
	public void setFk_calno(String fk_calno) {
		this.fk_calno = fk_calno;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getJoinuser() {
		return joinuser;
	}
	public void setJoinuser(String joinuser) {
		this.joinuser = joinuser;
	}
	public String getFk_lgcatgono() {
		return fk_lgcatgono;
	}
	public void setFk_lgcatgono(String fk_lgcatgono) {
		this.fk_lgcatgono = fk_lgcatgono;
	}
	
	
}
