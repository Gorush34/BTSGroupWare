package com.spring.bts.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.model.*;
import com.spring.bts.common.FileManager;
import com.spring.bts.common.AES256;

//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class BtsService implements InterBtsService {
	
}
