package com.spring.bts.jieun.controller;


import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.jieun.service.InterResourceService;



//=== #30. 컨트롤러 선언 ===
@Component

@Controller
public class ResourceController {
		

	@Autowired    // Type에 따라 알아서 Bean 을 주입해준다.
    private InterResourceService service;
	

	
	// === 예약 메인 페이지 === //	
	@RequestMapping(value="/reservation/reservationMain.bts")
	public ModelAndView reservationMain(ModelAndView mav) {
		
		mav.setViewName("reservationMain.calendar");
		
		return mav;
	}

	// === 예약 및 자원 관리자 페이지 === //	
	@RequestMapping(value="/reservation/reservationAdmin.bts")
	public ModelAndView reservationAdmin(ModelAndView mav) {
		
		mav.setViewName("reservationAdmin.calendar");
		
		return mav;
	}
	
	// === 자원등록 페이지 === //	
	@RequestMapping(value="/reservation/resourceRegister.bts")
	public ModelAndView resourceRegister(ModelAndView mav) {
		
		mav.setViewName("resourceRegister.calendar");
		
		return mav;
	}
	
	
		
		
}
