package com.spring.bts.jieun.model;

public class CalendarVO {
	
	private int pk_calno;
	private String calname;
	private int fk_emp_no;
	private int fk_lgcatgono;
	
	public int getPk_calno() {
		return pk_calno;
	}
	public void setPk_calno(int pk_calno) {
		this.pk_calno = pk_calno;
	}
	public String getCalname() {
		return calname;
	}
	public void setCalname(String calname) {
		this.calname = calname;
	}
	public int getFk_emp_no() {
		return fk_emp_no;
	}
	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}
	public int getFk_lgcatgono() {
		return fk_lgcatgono;
	}
	public void setFk_lgcatgono(int fk_lgcatgono) {
		this.fk_lgcatgono = fk_lgcatgono;
	}
	
	
	
	
}
