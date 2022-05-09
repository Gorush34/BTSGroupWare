package com.spring.bts.moongil.model;

public class LikeVO {

	private int pk_seq;
	private int fk_seq;
	private int fk_emp_no;
	private int like_check;

	public LikeVO() {}
	
	public LikeVO(int pk_seq, int fk_seq, int fk_emp_no, int like_check) {
		
		this.pk_seq = pk_seq;
		this.fk_seq = fk_seq;
		this.fk_emp_no = fk_emp_no;
		this.like_check = like_check;
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

	public int getLike_check() {
		return like_check;
	}

	public void setLike_check(int like_check) {
		this.like_check = like_check;
	}
	
	
	
}
