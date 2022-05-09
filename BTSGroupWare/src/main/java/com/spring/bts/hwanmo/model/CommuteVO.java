package com.spring.bts.hwanmo.model;

public class CommuteVO {
	private int pk_worktime_no; 	/* 출퇴근번호 */
	private String regdate; 		/* 날짜 */
	private String in_time; 		/* 출근시간 */
	private String out_time; 		/* 퇴근시간 */
	private String total_worktime; 	/* 총업무시간 */
	private int fk_emp_no; 			/* 사원번호 */
	
	public CommuteVO() {}
	public CommuteVO(int pk_worktime_no, String regdate, String in_time, String out_time, String total_worktime,
			int fk_emp_no) {
		super();
		this.pk_worktime_no = pk_worktime_no;
		this.regdate = regdate;
		this.in_time = in_time;
		this.out_time = out_time;
		this.total_worktime = total_worktime;
		this.fk_emp_no = fk_emp_no;
	}
	
	public int getPk_worktime_no() {
		return pk_worktime_no;
	}
	public void setPk_worktime_no(int pk_worktime_no) {
		this.pk_worktime_no = pk_worktime_no;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getIn_time() {
		return in_time;
	}
	public void setIn_time(String in_time) {
		this.in_time = in_time;
	}
	public String getOut_time() {
		return out_time;
	}
	public void setOut_time(String out_time) {
		this.out_time = out_time;
	}
	public String getTotal_worktime() {
		return total_worktime;
	}
	public void setTotal_worktime(String total_worktime) {
		this.total_worktime = total_worktime;
	}
	public int getFk_emp_no() {
		return fk_emp_no;
	}
	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}
	
}
