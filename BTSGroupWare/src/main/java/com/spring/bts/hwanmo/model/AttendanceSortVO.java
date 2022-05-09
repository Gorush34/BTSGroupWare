package com.spring.bts.hwanmo.model;

public class AttendanceSortVO {

	private int pk_att_sort_no;		// 근태신청구분번호 
	private int att_sort_name; 		// 근태구분명
	private String minus_cnt;		// 연차차감개수
	
	// 기본생성자
	public AttendanceSortVO() {}
	
	public AttendanceSortVO(int pk_att_sort_no, int att_sort_name, String minus_cnt) {
		super();
		this.pk_att_sort_no = pk_att_sort_no;
		this.att_sort_name = att_sort_name;
		this.minus_cnt = minus_cnt;
	}

	public int getPk_att_sort_no() {
		return pk_att_sort_no;
	}

	public void setPk_att_sort_no(int pk_att_sort_no) {
		this.pk_att_sort_no = pk_att_sort_no;
	}

	public int getAtt_sort_name() {
		return att_sort_name;
	}

	public void setAtt_sort_name(int att_sort_name) {
		this.att_sort_name = att_sort_name;
	}

	public String getMinus_cnt() {
		return minus_cnt;
	}

	public void setMinus_cnt(String minus_cnt) {
		this.minus_cnt = minus_cnt;
	}
	
	
	
}
