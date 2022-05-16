package com.spring.bts.byungyoon.model;

import org.springframework.web.multipart.MultipartFile;  

import com.spring.bts.hwanmo.model.EmployeeVO;

//=== #52. VO 생성하기
//    
public class AddBookVO {

	private EmployeeVO evo;
	
	private int registeruser;			// 등록자 번호
	private int pk_addbook_no;			// 주소록 구분번호
	private int fk_emp_no;				// 사원 번호
	private int fk_dept_no;			// 부서 구분번호
	private int fk_rank_no;			// 직급 구분번호
	private String addb_name;			// 이름
	private String com_tel;				// 회사 전화번호
	private String postcode;			// 우편번호
	private String address;				// 주소
	private String detailaddress;		// 상세주소
	private String referenceaddress;	// 주소참고항목
	private String phone;				// 휴대폰번호
	private String email;				// 이메일
	private String photofilepath;		// 사진파일경로
	private String photofilename;		// 사진파일이름
	private String companyname;			// 회사명
	private String memo;				// 메모사항
	private String ko_rankname;			// 직급
	private String ko_depname;			// 부서
	private String company_address;		// 회사주소
	
	
	
	public AddBookVO() {}
	
	public AddBookVO(int registeruser, int pk_addbook_no, int fk_emp_no, int fk_dept_no, int fk_rank_no, String addb_name, String com_tel,
			String postcode, String address, String detailaddress,
			String referenceaddress, String phone, String email,
			String photofilepath, String photofilename, String companyname, String memo, String ko_rankname, String ko_depname, String company_address, EmployeeVO evo) {
		super();
		this.evo = evo;
		
		this.registeruser= registeruser;
		this.pk_addbook_no= pk_addbook_no;
		this.fk_emp_no= fk_emp_no;
		this.fk_dept_no= fk_dept_no;
		this.fk_rank_no= fk_rank_no;
		this.addb_name= addb_name;
		this.com_tel= com_tel;
		this.postcode= postcode;
		this.address= address;
		this.detailaddress= detailaddress;
		this.referenceaddress= referenceaddress;
		this.phone= phone;
		this.email= email;
		this.photofilepath= photofilepath;
		this.photofilename= photofilename;
		this.companyname= companyname;
		this.memo= memo;
		this.ko_rankname = ko_rankname;
		this.ko_depname = ko_depname;
		this.company_address = company_address;
		
	}

	public EmployeeVO getEvo() {
		return evo;
	}

	public void setEvo(EmployeeVO evo) {
		this.evo = evo;
	}
	
	public int getRegisteruser() {
		return registeruser;
	}

	public void setRegisteruser(int registeruser) {
		this.registeruser = registeruser;
	}

	public int getPk_addbook_no() {
		return pk_addbook_no;
	}

	public void setPk_addbook_no(int pk_addbook_no) {
		this.pk_addbook_no = pk_addbook_no;
	}

	public int getFk_emp_no() {
		return fk_emp_no;
	}

	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}

	public int getFk_dept_no() {
		return fk_dept_no;
	}

	public void setFk_dept_no(int fk_dept_no) {
		this.fk_dept_no = fk_dept_no;
	}

	public int getFk_rank_no() {
		return fk_rank_no;
	}

	public void setFk_rank_no(int fk_rank_no) {
		this.fk_rank_no = fk_rank_no;
	}

	public String getAddb_name() {
		return addb_name;
	}

	public void setAddb_name(String addb_name) {
		this.addb_name = addb_name;
	}

	public String getCom_tel() {
		return com_tel;
	}

	public void setCom_tel(String com_tel) {
		this.com_tel = com_tel;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
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

	public String getReferenceaddress() {
		return referenceaddress;
	}

	public void setReferenceaddress(String referenceaddress) {
		this.referenceaddress = referenceaddress;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhotofilepath() {
		return photofilepath;
	}

	public void setPhotofilepath(String photofilepath) {
		this.photofilepath = photofilepath;
	}

	public String getPhotofilename() {
		return photofilename;
	}

	public void setPhotofilename(String photofilename) {
		this.photofilename = photofilename;
	}

	public String getCompanyname() {
		return companyname;
	}

	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getKo_rankname() {
		return ko_rankname;
	}

	public void setKo_rankname(String ko_rankname) {
		this.ko_rankname = ko_rankname;
	}

	public String getCompany_address() {
		return company_address;
	}

	public void setCompany_address(String company_address) {
		this.company_address = company_address;
	}

	public String getKo_depname() {
		return ko_depname;
	}

	public void setKo_depname(String ko_depname) {
		this.ko_depname = ko_depname;
	}


	
	
		
}