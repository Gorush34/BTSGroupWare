package com.spring.bts.hwanmo.model;

public class LeaveVO {
	
	private int pk_vacation_no; /* 연차관리번호 */
	private String total_vacation_days; /* 올해연차개수 */
	private String use_vacation_days; /* 사용연차개수 */
	private String rest_vacation_days; /* 남은연차개수 */
	private int fk_emp_no; /* 사원번호 */
	
	public LeaveVO() {}
	public LeaveVO(int pk_vacation_no, String total_vacation_days, String use_vacation_days,
			String rest_vacation_days, int fk_emp_no) {
		super();
		this.pk_vacation_no = pk_vacation_no;
		this.total_vacation_days = total_vacation_days;
		this.use_vacation_days = use_vacation_days;
		this.rest_vacation_days = rest_vacation_days;
		this.fk_emp_no = fk_emp_no;
	}
	
	public int getPk_vacation_no() {
		return pk_vacation_no;
	}
	public void setPk_vacation_no(int pk_vacation_no) {
		this.pk_vacation_no = pk_vacation_no;
	}
	public String getTotal_vacation_days() {
		return total_vacation_days;
	}
	public void setTotal_vacation_days(String total_vacation_days) {
		this.total_vacation_days = total_vacation_days;
	}
	public String getUse_vacation_days() {
		return use_vacation_days;
	}
	public void setUse_vacation_days(String use_vacation_days) {
		this.use_vacation_days = use_vacation_days;
	}
	public String getRest_vacation_days() {
		return rest_vacation_days;
	}
	public void setRest_vacation_days(String rest_vacation_days) {
		this.rest_vacation_days = rest_vacation_days;
	}
	public int getFk_emp_no() {
		return fk_emp_no;
	}
	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}
	
	
	
}
