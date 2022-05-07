package com.spring.bts.jieun.model;

public class ScheduleVO {
	private int pk_schno;  
	private int fk_emp_no;  
	private int fk_calno;      
	private String subject;   
	private String startdate;           
	private String enddate;           
	private String content; 
	private String color;   
	private String place;   
	private String joinuser;   
	private int fk_lgcatgono;
	
	public int getPk_schno() {
		return pk_schno;
	}
	public void setPk_schno(int pk_schno) {
		this.pk_schno = pk_schno;
	}
	public int getFk_emp_no() {
		return fk_emp_no;
	}
	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}
	public int getFk_calno() {
		return fk_calno;
	}
	public void setFk_calno(int fk_calno) {
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
	public int getFk_lgcatgono() {
		return fk_lgcatgono;
	}
	public void setFk_lgcatgono(int fk_lgcatgono) {
		this.fk_lgcatgono = fk_lgcatgono;
	}
	
	
}
