package com.spring.bts.hwanmo.model;

import org.springframework.web.multipart.MultipartFile;

public class AttendanceVO {
	
	private int pk_att_num; /* 근태신청번호 */
	private int fk_att_sort_no; /* 근태신청구분번호 */
	private int fk_vacation_no; /* 연차관리번호 */
	private int vacation_days; /* 휴가일수 */
	private String leave_start; /* 근태시작일 */
	private String leave_end; /* 근태종료일 */
	private int fk_emp_no; /* 사원번호 */
	private int fk_mid_app_no; /* 중간승인자 */
	private int fk_fin_app_no; /* 최종승인자 */
	private String att_content; /* 내용 */
	private String filename; /* 서버파일명 */
	private String orgfilename; /* 실제파일명 */
	private String file_path; /* 파일경로 */
	private String filesize;                // NUMBER        		파일크기
	private int mid_approval_ok; /* 중간승인여부 */
	private int fin_approval_ok; /* 최종승인여부 */
	private int approval_status; /* 결재진행상태 */
	private String mid_app_opinion; /* 중간승인자의견 */
	private String fin_app_opinion; /* 최종승인자의견 */
	
	
	// select 용
	private String emp_name;
	private String dept_name;
	
	private EmployeeVO empvo;
	private EmployeeVO midapprvo;
	private EmployeeVO finapprvo;
	
	private MultipartFile attach;
	
	//기본생성자
	public AttendanceVO() {}
	public AttendanceVO(int pk_att_num, int fk_att_sort_no, int fk_vacation_no, int vacation_days, String leave_start,
			String leave_end, int fk_emp_no, int fk_mid_app_no, int fk_fin_app_no, String att_content,
			String filename, String orgfilename, String file_path, int mid_approval_ok, int fin_approval_ok,
			int approval_status, String mid_app_opinion, String fin_app_opinion, String emp_name, String dept_name,
			EmployeeVO empvo, EmployeeVO midapprvo, EmployeeVO finapprvo, MultipartFile attach, String filesize) {
		super();
		this.pk_att_num = pk_att_num;
		this.fk_att_sort_no = fk_att_sort_no;
		this.fk_vacation_no = fk_vacation_no;
		this.vacation_days = vacation_days;
		this.leave_start = leave_start;
		this.leave_end = leave_end;
		this.fk_emp_no = fk_emp_no;
		this.fk_mid_app_no = fk_mid_app_no;
		this.fk_fin_app_no = fk_fin_app_no;
		this.att_content = att_content;
		this.filename = filename;
		this.orgfilename = orgfilename;
		this.file_path = file_path;
		this.mid_approval_ok = mid_approval_ok;
		this.fin_approval_ok = fin_approval_ok;
		this.approval_status = approval_status;
		this.mid_app_opinion = mid_app_opinion;
		this.fin_app_opinion = fin_app_opinion;
		this.emp_name = emp_name;
		this.dept_name = dept_name;
		this.empvo = empvo;
		this.midapprvo = midapprvo;
		this.finapprvo = finapprvo;
		this.attach = attach;
		this.filesize = filesize;
	}
	
	public int getPk_att_num() {
		return pk_att_num;
	}
	public void setPk_att_num(int pk_att_num) {
		this.pk_att_num = pk_att_num;
	}
	public int getFk_att_sort_no() {
		return fk_att_sort_no;
	}
	public void setFk_att_sort_no(int fk_att_sort_no) {
		this.fk_att_sort_no = fk_att_sort_no;
	}
	public int getFk_vacation_no() {
		return fk_vacation_no;
	}
	public void setFk_vacation_no(int fk_vacation_no) {
		this.fk_vacation_no = fk_vacation_no;
	}
	public int getVacation_days() {
		return vacation_days;
	}
	public void setVacation_days(int vacation_days) {
		this.vacation_days = vacation_days;
	}
	public String getLeave_start() {
		return leave_start;
	}
	public void setLeave_start(String leave_start) {
		this.leave_start = leave_start;
	}
	public String getLeave_end() {
		return leave_end;
	}
	public void setLeave_end(String leave_end) {
		this.leave_end = leave_end;
	}
	public int getFk_emp_no() {
		return fk_emp_no;
	}
	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}
	public int getFk_mid_app_no() {
		return fk_mid_app_no;
	}
	public void setFk_mid_app_no(int fk_mid_app_no) {
		this.fk_mid_app_no = fk_mid_app_no;
	}
	public int getFk_fin_app_no() {
		return fk_fin_app_no;
	}
	public void setFk_fin_app_no(int fk_fin_app_no) {
		this.fk_fin_app_no = fk_fin_app_no;
	}
	public String getAtt_content() {
		return att_content;
	}
	public void setAtt_content(String att_content) {
		this.att_content = att_content;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getOrgfilename() {
		return orgfilename;
	}
	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public int getMid_approval_ok() {
		return mid_approval_ok;
	}
	public void setMid_approval_ok(int mid_approval_ok) {
		this.mid_approval_ok = mid_approval_ok;
	}
	public int getFin_approval_ok() {
		return fin_approval_ok;
	}
	public void setFin_approval_ok(int fin_approval_ok) {
		this.fin_approval_ok = fin_approval_ok;
	}
	public int getApproval_status() {
		return approval_status;
	}
	public void setApproval_status(int approval_status) {
		this.approval_status = approval_status;
	}
	public String getMid_app_opinion() {
		return mid_app_opinion;
	}
	public void setMid_app_opinion(String mid_app_opinion) {
		this.mid_app_opinion = mid_app_opinion;
	}
	public String getFin_app_opinion() {
		return fin_app_opinion;
	}
	public void setFin_app_opinion(String fin_app_opinion) {
		this.fin_app_opinion = fin_app_opinion;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public EmployeeVO getEmpvo() {
		return empvo;
	}
	public void setEmpvo(EmployeeVO empvo) {
		this.empvo = empvo;
	}
	public EmployeeVO getMidapprvo() {
		return midapprvo;
	}
	public void setMidapprvo(EmployeeVO midapprvo) {
		this.midapprvo = midapprvo;
	}
	public EmployeeVO getFinapprvo() {
		return finapprvo;
	}
	public void setFinapprvo(EmployeeVO finapprvo) {
		this.finapprvo = finapprvo;
	}
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public String getFilesize() {
		return filesize;
	}
	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	
	
	
}
