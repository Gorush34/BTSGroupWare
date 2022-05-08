package com.spring.bts.yuri.model;

import org.springframework.stereotype.Repository;

@Repository
public class ApprSortVO {
	
	private String pk_appr_sortno;		/* 결재문서 구분번호 */
	private String appr_name;			/* 결재문서 구분이름 */
	
	// 기본생성자 <= 이게 없으면 Bean이 생성되지 않는다!
	public ApprSortVO() {}
	
	
	public ApprSortVO(String pk_appr_sortno, String appr_name) {
		this.pk_appr_sortno = pk_appr_sortno;
		this.appr_name = appr_name;
	}
	
	
	
	
	public String getPk_appr_sortno() {
		return pk_appr_sortno;
	}
	public void setPk_appr_sortno(String pk_appr_sortno) {
		this.pk_appr_sortno = pk_appr_sortno;
	}
	public String getAppr_name() {
		return appr_name;
	}
	public void setAppr_name(String appr_name) {
		this.appr_name = appr_name;
	}
	
	
	
	
}
