package com.spring.bts.jieun.controller;


import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.bts.jieun.model.CalendarVO;
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
		
		List<Map<String, String>> resourceList = service.resourceReservation();
		
		mav.addObject("resourceList",resourceList);
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
	public String resourceReservation(HttpServletRequest request) {
		
		
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
		
		String pk_rno = request.getParameter("pk_rno");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_rno", pk_rno);
		
		List<Map<String, String>> reservationEmployeeList = service.resourceSpecialReservation(paraMap);
		
		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String, String> map : reservationEmployeeList) {
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("EMP_NAME", map.get("EMP_NAME"));
			jsonObj.addProperty("RSERSTARTDATE", map.get("RSERSTARTDATE"));
			jsonObj.addProperty("RSERENDDATE", map.get("RSERENDDATE"));
			jsonObj.addProperty("PK_RSERNO", map.get("PK_RSERNO"));
			
			jsonArr.add(jsonObj);
		}// end of for-------------------------------------------
		
		return gson.toJson(jsonArr);
	}
	
	// 자원 등록 모달에 select 자원 가져오기//
	@ResponseBody
	@RequestMapping(value="/resource/resourceSelect.bts",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String resourceSelect(HttpServletRequest request) {
		
		String pk_classno = request.getParameter("pk_classno");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pk_classno", pk_classno);
		
		List<Map<String, String>> resourceSelctList = service.resourceSelect(paraMap);
		
		JSONArray jsArr = new JSONArray();
		if(resourceSelctList != null) {
			for(Map<String, String> map :resourceSelctList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("pk_rno", map.get("PK_RNO"));
				jsonObj.put("rname", map.get("RNAME"));
				
				jsArr.put(jsonObj);
			}
		}
		
		return jsArr.toString();
	}
	
	// 예약 등록하기 //
	@ResponseBody
	@RequestMapping(value="/reservation/addReservation.bts", method= {RequestMethod.POST})
	public String addReservation(HttpServletRequest request) {
		
		String rserstartdate = request.getParameter("rserstartdate");
		String rserenddate = request.getParameter("rserenddate");
		String fk_emp_no = request.getParameter("fk_emp_no");
		String fk_rno = request.getParameter("pk_rno");
		String fk_classno = request.getParameter("pk_classno");
		String rserusecase = request.getParameter("rserusecase");
		
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("rserstartdate", rserstartdate);
		paraMap.put("rserenddate", rserenddate);
		paraMap.put("fk_emp_no", fk_emp_no);
		paraMap.put("fk_rno", fk_rno);
		paraMap.put("fk_classno", fk_classno);
		paraMap.put("rserusecase", rserusecase);
		
		int n = service.addReservation(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// === 예약상세보기 === //
	@ResponseBody
	@RequestMapping(value="/reservation/reservationDetail.bts", produces = "text/plain;charset=UTF-8")
	public String reservationDetail(HttpServletRequest request) {
		
		String pk_rserno = request.getParameter("pk_rserno");
		
		List<Map<String, String>> reservationDetail = service.reservationDetail(pk_rserno);
		
		Gson gson = new Gson();
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String, String> map : reservationDetail) {
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("EMP_NAME", map.get("EMP_NAME"));
			jsonObj.addProperty("RSERSTARTDATE", map.get("RSERSTARTDATE"));
			jsonObj.addProperty("RSERENDDATE", map.get("RSERENDDATE"));
			jsonObj.addProperty("PK_RSERNO", map.get("PK_RSERNO"));
			jsonObj.addProperty("FK_EMP_NO", map.get("FK_EMP_NO"));
			jsonObj.addProperty("RNAME", map.get("RNAME"));
			jsonObj.addProperty("RSERUSECASE", map.get("RSERUSECASE"));
			jsonObj.addProperty("RINFO", map.get("RINFO"));
			jsonArr.add(jsonObj);
		}// end of for-------------------------------------------
		
		return gson.toJson(jsonArr);
		
	}
	
	// === 예약취소 === //
	@ResponseBody
	@RequestMapping(value="/reservation/cancelReservation.bts")
	public String cancelReservation(HttpServletRequest request) {
		
		String pk_rserno = request.getParameter("pk_rserno");
		
		int n = service.cancelReservation(pk_rserno);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
		
	}
	
	// === 자원 등록 하기 : 관리자 === //
	@RequestMapping(value="/resource/resourceRegister_end.bts", method= {RequestMethod.POST})
	public ModelAndView resourceRegister_end(ModelAndView mav, HttpServletRequest request) throws Throwable {
		
		String rname = request.getParameter("rname");
		String pk_classno = request.getParameter("calpk_classno");
		String rinfo = request.getParameter("rinfo");
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("rname", rname);
		paraMap.put("pk_classno", pk_classno);
		paraMap.put("rinfo", rinfo);
		
		int n = service.resourceRegister_end(paraMap);

		if(n == 0) {
			mav.addObject("message", "자원 등록에 실패하였습니다.");
		}
		else {
			mav.addObject("message", "자원 등록에 성공하였습니다.");
		}
		
		mav.addObject("loc", request.getContextPath()+"/reservation/reservationMain.bts");
		
		mav.setViewName("msg");
		
		return mav;
	}
		
}
