package com.spring.bts.hwanmo.model;

import org.springframework.web.multipart.MultipartFile;

public class EmployeeVO {
	/* 사원테이블(정환모) */
	private int	pk_emp_no; 				/* 사원번호 */
	private int	fk_department_id; 		/* 부서명구분번호 */
	private int	fk_rank_id; 			/* 직급구분번호 */
	private int	fk_board_authority_no; 	/* 게시판권한번호 */
	private int	fk_site_authority_no; 	/* 사이트권한번호 */
	private String emp_name; 			/* 이름 */
	private String emp_pwd; 			/* 비밀번호 */
	private String com_tel; 			/* 회사전화번호 */
	private String postal; 				/* 우편번호 */
	private String address; 			/* 주소 */
	private String detailaddress; 		/* 상세주소 */
	private String extraaddress; 		/* 주소참고항목 */
	private String uq_phone; 			/* 휴대폰번호 */
	private String uq_email; 			/* 이메일 */
	private String hire_date; 			/* 입사일 */
	private String img_path; 			/* 사진파일경로 */
	private String img_name; 			/* 사진파일명 */
	private String birthday;			/* 생년월일 */
	private int ishired; 				/* 입퇴사상태  1:재직중(기본값) / 0:퇴사상태 */ 
	private int gradelevel; 			/* 등급 */
	private String gender;              // 성별   남자:1  / 여자:2
	private String lastpwdchangedate; // 마지막으로 암호를 변경한 날짜  
	
    private String ko_rankname;         // 직급
    private String ko_depname;         // 부서
	
	private int pwdchangegap;		 // select 용. 지금으로 부터 마지막으로 암호를 변경한지가 몇개월인지 알려주는 개월수(3개월 동안 암호를 변경 안 했을시 암호를 변경하라는 메시지를 보여주기 위함)
	
	private MultipartFile attach;
	
	// 정보수정용 회사번호, 휴대전화번호
	private String num1;
	private String num2;
	private String num3;
	
	private String hp2;
	private String hp3;
	
	/////////////////////////////////////////////////////////////////////
	
	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false

	/////////////////////////////////////////////////////////////////////
	
	public EmployeeVO() {};
	
	public EmployeeVO(int pk_emp_no, int fk_department_id, int fk_rank_id, String emp_name, String emp_pwd
			, String com_tel, String postal, String address, String detailaddress
			, String extraaddress, String uq_phone, String uq_email, String birthday, String gender, String img_name, String img_path, int gradelevel) {
		super();
		this.pk_emp_no = pk_emp_no;
		this.fk_department_id = fk_department_id;
		this.fk_rank_id = fk_rank_id;
		this.emp_name = emp_name;
		this.emp_pwd = emp_pwd;
		this.com_tel = com_tel;
		this.postal = postal;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.uq_phone = uq_phone;
		this.uq_email = uq_email;
		this.img_path = img_path;
		this.img_name = img_name;
		this.birthday = birthday;
		this.gradelevel = gradelevel;
		this.gender = gender;
		// this.lastpwdchangedate = lastpwdchangedate;
		// this.pwdchangegap = pwdchangegap;
		// this.requirePwdChange = requirePwdChange;
	}

	public EmployeeVO(int pk_emp_no, int fk_department_id, int fk_rank_id, int fk_board_authority_no,
			int fk_site_authority_no, String emp_name, String emp_pwd, String com_tel, String postal, String address,
			String detailaddress, String extraaddress, String uq_phone, String uq_email, String hire_date,
			String img_path, String img_name, String birthday, int ishired, int gradelevel, String gender,
			String lastpwdchangedate, int pwdchangegap, boolean requirePwdChange) {
		super();
		this.pk_emp_no = pk_emp_no;
		this.fk_department_id = fk_department_id;
		this.fk_rank_id = fk_rank_id;
		this.fk_board_authority_no = fk_board_authority_no;
		this.fk_site_authority_no = fk_site_authority_no;
		this.emp_name = emp_name;
		this.emp_pwd = emp_pwd;
		this.com_tel = com_tel;
		this.postal = postal;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.uq_phone = uq_phone;
		this.uq_email = uq_email;
		this.hire_date = hire_date;
		this.img_path = img_path;
		this.img_name = img_name;
		this.birthday = birthday;
		this.ishired = ishired;
		this.gradelevel = gradelevel;
		this.gender = gender;
		this.lastpwdchangedate = lastpwdchangedate;
		this.pwdchangegap = pwdchangegap;
		this.requirePwdChange = requirePwdChange;
	}

	public int getPk_emp_no() {
		return pk_emp_no;
	}

	public void setPk_emp_no(int pk_emp_no) {
		this.pk_emp_no = pk_emp_no;
	}

	public int getFk_department_id() {
		return fk_department_id;
	}

	public void setFk_department_id(int fk_department_id) {
		this.fk_department_id = fk_department_id;
	}

	public int getFk_rank_id() {
		return fk_rank_id;
	}

	public void setFk_rank_id(int fk_rank_id) {
		this.fk_rank_id = fk_rank_id;
	}

	public int getFk_board_authority_no() {
		return fk_board_authority_no;
	}

	public void setFk_board_authority_no(int fk_board_authority_no) {
		this.fk_board_authority_no = fk_board_authority_no;
	}

	public int getFk_site_authority_no() {
		return fk_site_authority_no;
	}

	public void setFk_site_authority_no(int fk_site_authority_no) {
		this.fk_site_authority_no = fk_site_authority_no;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public String getEmp_pwd() {
		return emp_pwd;
	}

	public void setEmp_pwd(String emp_pwd) {
		this.emp_pwd = emp_pwd;
	}

	public String getCom_tel() {
		return com_tel;
	}

	public void setCom_tel(String com_tel) {
		this.com_tel = com_tel;
	}

	public String getPostal() {
		return postal;
	}

	public void setPostal(String postal) {
		this.postal = postal;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailaddress() {
		return detailaddress;
	}

	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}

	public String getExtraaddress() {
		return extraaddress;
	}

	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}

	public String getUq_phone() {
		return uq_phone;
	}

	public void setUq_phone(String uq_phone) {
		this.uq_phone = uq_phone;
	}

	public String getUq_email() {
		return uq_email;
	}

	public void setUq_email(String uq_email) {
		this.uq_email = uq_email;
	}

	public String getHire_date() {
		return hire_date;
	}

	public void setHire_date(String hire_date) {
		this.hire_date = hire_date;
	}

	public String getImg_path() {
		return img_path;
	}

	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}

	public String getImg_name() {
		return img_name;
	}

	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public int getIshired() {
		return ishired;
	}

	public void setIshired(int ishired) {
		this.ishired = ishired;
	}

	public int getGradelevel() {
		return gradelevel;
	}

	public void setGradelevel(int gradelevel) {
		this.gradelevel = gradelevel;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getLastpwdchangedate() {
		return lastpwdchangedate;
	}

	public void setLastpwdchangedate(String lastpwdchangedate) {
		this.lastpwdchangedate = lastpwdchangedate;
	}

	public int getPwdchangegap() {
		return pwdchangegap;
	}

	public void setPwdchangegap(int pwdchangegap) {
		this.pwdchangegap = pwdchangegap;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}

	public String getKo_rankname() {
		return ko_rankname;
	}

	public void setKo_rankname(String ko_rankname) {
		this.ko_rankname = ko_rankname;
	}

	public String getKo_depname() {
		return ko_depname;
	}

	public void setKo_depname(String ko_depname) {
		this.ko_depname = ko_depname;
	}

	public String getNum1() {
		return num1;
	}

	public void setNum1(String num1) {
		this.num1 = num1;
	}

	public String getNum2() {
		return num2;
	}

	public void setNum2(String num2) {
		this.num2 = num2;
	}

	public String getNum3() {
		return num3;
	}

	public void setNum3(String num3) {
		this.num3 = num3;
	}

	public String getHp2() {
		return hp2;
	}

	public void setHp2(String hp2) {
		this.hp2 = hp2;
	}

	public String getHp3() {
		return hp3;
	}

	public void setHp3(String hp3) {
		this.hp3 = hp3;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
	
	
	
	
	
}
