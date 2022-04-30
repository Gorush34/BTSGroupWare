package com.spring.bts.moongil.model;

import java.util.Calendar;

public class MemberVO {

	private String userid;             // 회원아이디
	private String pwd;                // 비밀번호 (SHA-256 암호화 대상)  
	private String name;               // 회원명
	private String email;              // 이메일 (AES-256 암호화/복호화 대상)  
	private String mobile;             // 연락처 (AES-256 암호화/복호화 대상) 
	private String postcode;           // 우편번호
	private String address;            // 주소
	private String detailaddress;      // 상세주소
	private String extraaddress;       // 참고항목
	private String gender;             // 성별   남자:1  / 여자:2
	private String birthday;           // 생년월일   
	private int coin;                  // 코인액
	private int point;                 // 포인트 
	private String registerday;        // 가입일자 
	private String lastpwdchangedate;  // 마지막으로 암호를 변경한 날짜  
	private int status;                // 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
	private int idle;                  // 휴면유무      0 : 활동중  /  1 : 휴면중 
	                                   // 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 초과(지났으면)하면 휴면으로 지정
	
	private int pwdchangegap;          // select 용. 지금으로 부터 마지막으로 암호를 변경한지가 몇개월인지 알려주는 개월수(3개월 동안 암호를 변경 안 했을시 암호를 변경하라는 메시지를 보여주기 위함)  
	private int lastlogingap;          // select 용. 지금으로 부터 마지막으로 로그인한지가 몇개월인지 알려주는 개월수(12개월 동안 로그인을 안 했을 경우 해당 로그인 계정을 비활성화 시키려고 함) 
	
	/////////////////////////////////////////////////////////////////////
		
	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
	
    /////////////////////////////////////////////////////////////////////
	
	// #138. 먼저 답변글쓰기는 일반회원은 불가하고 직원(관리파트)들만 답변글쓰기가 가능하도록 하기 위해서 
	//       먼저 오라클에서 tbl_member 테이블에  gradelevel 이라는 컬럼을 추가해야 한다.
	private int gradelevel;            // 등급레벨 
	
	public MemberVO() {}
	
	public MemberVO(String userid, String pwd, String name, String email, String mobile,
			String postcode, String address, String detailaddress, String extraaddress,
			String gender, String birthday) {
		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.postcode = postcode;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.gender = gender;
		this.birthday = birthday;
	}
	
	public MemberVO(String userid, String pwd, String name, String email, String mobile, 
			        String postcode, String address, String detailaddress, String extraaddress) {
		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.postcode = postcode;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
	}
	

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
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

	public String getExtraaddress() {
		return extraaddress;
	}

	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public int getCoin() {
		return coin;
	}

	public void setCoin(int coin) {
		this.coin = coin;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getRegisterday() {
		return registerday;
	}

	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}

	public String getLastpwdchangedate() {
		return lastpwdchangedate;
	}

	public void setLastpwdchangedate(String lastpwdchangedate) {
		this.lastpwdchangedate = lastpwdchangedate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getIdle() {
		return idle;
	}

	public void setIdle(int idle) {
		this.idle = idle;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}
	
	// ==== select 용. 지금으로 부터 마지막으로 암호를 변경하지가 몇개월인지 알려주는 개월수 ==== //
	public int getPwdchangegap() {
		return pwdchangegap;
	}
	
	public void setPwdchangegap(int pwdchangegap) {
		this.pwdchangegap = pwdchangegap;
	}
	
	// ==== select 용. 지금으로 부터 마지막으로 로그인한지가 몇개월인지 알려주는 개월수 ==== //
	public int getLastlogingap() {
		return lastlogingap;
	}
	
	public void setLastlogingap(int lastlogingap) {
		this.lastlogingap = lastlogingap;
	}
	
	public int getGradelevel() {
	      return gradelevel;
	}

    public void setGradelevel(int gradelevel) {
      this.gradelevel = gradelevel;
    }
	
	public int getAge() {
		int age = 0;
		
		Calendar currentDate = Calendar.getInstance(); 
		// 현재날짜와 시간을 얻어온다.
		
		int currentYear = currentDate.get(Calendar.YEAR);
		
	 	age = currentYear - Integer.parseInt(birthday.substring(0, 4)) + 1;
		
		return age;
	}
	
	
}
