package com.spring.bts.moongil.model;

public class LikeVO {

	private int pk_seq;
	private int fk_seq;
	private int fk_emp_no;
	private int like_date;
	private String emp_name;
	private String ko_ranknam;
	
	public LikeVO() {}
	
	public LikeVO(int like_date, int pk_seq, int fk_seq, int fk_emp_no, String emp_name, String ko_ranknam) {
		
		this.pk_seq = pk_seq;
		this.fk_seq = fk_seq;
		this.fk_emp_no = fk_emp_no;
		this.like_date = like_date;
		this.emp_name = emp_name;
		this.ko_ranknam = ko_ranknam;
	}

	public int getPk_seq() {
		return pk_seq;
	}

	public void setPk_seq(int pk_seq) {
		this.pk_seq = pk_seq;
	}

	public int getFk_seq() {
		return fk_seq;
	}

	public void setFk_seq(int fk_seq) {
		this.fk_seq = fk_seq;
	}

	public int getFk_emp_no() {
		return fk_emp_no;
	}

	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}

	public int getLike_date() {
		return like_date;
	}

	public void setLike_date(int like_date) {
		this.like_date = like_date;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public String getKo_ranknam() {
		return ko_ranknam;
	}

	public void setKo_ranknam(String ko_ranknam) {
		this.ko_ranknam = ko_ranknam;
	}
	
	
	
}
