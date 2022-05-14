package com.spring.bts.hwanmo.model;

public class AttendanceSortVO {

	private int pk_att_sort_no;		// 근태신청구분번호 
	private String att_sort_ename; 		// 영어 근태구분명
	private String att_sort_korname; 		// 한국 근태구분명
	private float minus_cnt;		// 연차차감개수
	
	// 기본생성자
	public AttendanceSortVO() {}
	public AttendanceSortVO(int pk_att_sort_no, String att_sort_ename, String att_sort_korname, float minus_cnt) {
		super();
		this.pk_att_sort_no = pk_att_sort_no;
		this.att_sort_ename = att_sort_ename;
		this.att_sort_korname = att_sort_korname;
		this.minus_cnt = minus_cnt;
	}
	public int getPk_att_sort_no() {
		return pk_att_sort_no;
	}
	public void setPk_att_sort_no(int pk_att_sort_no) {
		this.pk_att_sort_no = pk_att_sort_no;
	}
	public String getAtt_sort_ename() {
		return att_sort_ename;
	}
	public void setAtt_sort_ename(String att_sort_ename) {
		this.att_sort_ename = att_sort_ename;
	}
	public String getAtt_sort_korname() {
		return att_sort_korname;
	}
	public void setAtt_sort_korname(String att_sort_korname) {
		this.att_sort_korname = att_sort_korname;
	}
	public float getMinus_cnt() {
		return minus_cnt;
	}
	public void setMinus_cnt(float minus_cnt) {
		this.minus_cnt = minus_cnt;
	}
	
	
	
}
