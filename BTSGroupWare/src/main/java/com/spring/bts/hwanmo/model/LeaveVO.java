package com.spring.bts.hwanmo.model;

public class LeaveVO {
	
	private int pk_vac_no; /* 연차관리번호 */
	private String total_vac_days; /* 올해연차개수 */
	private String use_vac_days; /* 사용연차개수 */
	private String rest_vac_days; /* 남은연차개수 */
	private String instead_vac_days; /* 대체연차개수 */
	private String regdate; /* 등록일자 */
	private int fk_emp_no; /* 사원번호 */
	
	public LeaveVO() {}
	public LeaveVO(int pk_vac_no, String total_vac_days, String use_vac_days, String rest_vac_days,
			String instead_vac_days, String regdate, int fk_emp_no) {
		super();
		this.pk_vac_no = pk_vac_no;
		this.total_vac_days = total_vac_days;
		this.use_vac_days = use_vac_days;
		this.rest_vac_days = rest_vac_days;
		this.instead_vac_days = instead_vac_days;
		this.regdate = regdate;
		this.fk_emp_no = fk_emp_no;
	}
	
	public int getPk_vac_no() {
		return pk_vac_no;
	}
	public void setPk_vac_no(int pk_vac_no) {
		this.pk_vac_no = pk_vac_no;
	}
	public String getTotal_vac_days() {
		return total_vac_days;
	}
	public void setTotal_vac_days(String total_vac_days) {
		this.total_vac_days = total_vac_days;
	}
	public String getUse_vac_days() {
		return use_vac_days;
	}
	public void setUse_vac_days(String use_vac_days) {
		this.use_vac_days = use_vac_days;
	}
	public String getRest_vac_days() {
		return rest_vac_days;
	}
	public void setRest_vac_days(String rest_vac_days) {
		this.rest_vac_days = rest_vac_days;
	}
	public String getInstead_vac_days() {
		return instead_vac_days;
	}
	public void setInstead_vac_days(String instead_vac_days) {
		this.instead_vac_days = instead_vac_days;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getFk_emp_no() {
		return fk_emp_no;
	}
	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}
	
	
	
	
	
}
