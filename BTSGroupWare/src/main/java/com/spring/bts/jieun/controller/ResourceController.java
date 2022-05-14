package com.spring.bts.jieun.controller;


import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
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
		
		List<Map<String, String>> classList = service.classSelect();
		List<Map<String, String>> resourceList = service.resourceReservation();
		
		
		mav.addObject("resourceList", resourceList);
		mav.addObject("classList", classList);
		mav.setViewName("reservationMain.resource");
		
		return mav;
	}

	// === 예약 및 자원 관리자 페이지 === //	
	@RequestMapping(value="/reservation/reservationAdmin.bts")
	public ModelAndView reservationAdmin(ModelAndView mav) {
		
		mav.setViewName("reservationAdmin.resource");
		
		return mav;
	}
	
	// === 자원등록 페이지 === //	
	@RequestMapping(value="/reservation/resourceRegister.bts")
	public ModelAndView resourceRegister(ModelAndView mav) {
		
		
		
		mav.setViewName("resourceRegister.resource");
		
		return mav;
	}
	
	// === 예약 페이지에 띄울 자원 리스트 가져오기 === //
	@ResponseBody
	@RequestMapping(value="/resource/reservationView.bts", produces = "text/plain;charset=UTF-8")
	public String resourceReservation(HttpServletRequest reauest) {
		
		List<Map<String, String>> resourceList = service.resourceReservation();
		
		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String, String> map : resourceList) {
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("pk_rno", map.get("PK_RNO"));
			jsonObj.addProperty("rname", map.get("RNAME"));
			
			jsonArr.add(jsonObj);
		}// end of for-------------------------------------------
		
		return gson.toJson(jsonArr);
	}
	
	// === 해당 자원 예약내용 가져오기 === //
	@ResponseBody
	@RequestMapping(value="/reservation/resourceSpecialReservation.bts", produces = "text/plain;charset=UTF-8")
	public String resourceSpecialReservation(HttpServletRequest request) {
		
		String rname = request.getParameter("rname");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("rname", rname);
		
		List<Map<String, String>> reservationEmployeeList = service.resourceSpecialReservation(paraMap);
		
		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String, String> map : reservationEmployeeList) {
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("emp_name", map.get("EMP_NAME"));
			jsonObj.addProperty("rserstartdate", map.get("RSERSTARTDATE"));
			jsonObj.addProperty("rserenddate", map.get("RNARSERENDDATEME"));
			
			jsonArr.add(jsonObj);
		}// end of for-------------------------------------------
		
		return gson.toJson(jsonArr);
	}
		
}
