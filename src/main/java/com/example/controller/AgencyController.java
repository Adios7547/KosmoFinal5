package com.example.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.domain.AbandonedVO;
import com.example.domain.AgencyVO;
import com.example.service.agency.AgencyService;

@Controller
@RequestMapping("/include")
public class AgencyController {
	
	@Autowired
	private AgencyService agencyservice; 
	
	////agencyhotel 보기
	@RequestMapping(value ="/agencyHotel", method=RequestMethod.GET)
public String agencyHotel(Model m, AgencyVO vo) {
		
		int page = 1;
		if(vo.getPage()!=0) {
			page = vo.getPage();
		}
		Pageable paging = PageRequest.of(page-1, 16,Sort.Direction.ASC,"agencyNum");

		m.addAttribute("paging",agencyservice.getHotelPaging(paging) );
		
		m.addAttribute("count",agencyservice.countHotelRecord() );
		return "/include/agencyHotel";
	}
	
	
	//agencyhotel 상세보기
	@RequestMapping(value ="/agencyHotelDetail", method=RequestMethod.GET)
	public void agencyHotelDetail(Model m,AgencyVO vo) {
		System.out.println(vo.getAgencyNum());
		m.addAttribute("hotel",agencyservice.getagencyHotel(vo));
		
	}
	
	@RequestMapping(value ="/agencytest", method=RequestMethod.GET)
	public String agencytest() {
		return "/include/agencytest";
	}
	
	@RequestMapping(value ="/agencytestDetail", method=RequestMethod.GET)
	public String agencytestDetail() {
		return "/include/agencytestDetail";
	}

	
	//agencyshelter 페이지 ************************************************************************************
	
	//agencyShelter 페이징 처리
	@RequestMapping(value ="/agencyShelter", method=RequestMethod.GET)
	public String agencyShelter(Model m,AbandonedVO vo) {
		
		int page = 1;
		if(vo.getPage()!=0) {
			page = vo.getPage();
		}
		Pageable paging = PageRequest.of(page-1, 9,Sort.Direction.ASC,"abNo");

		m.addAttribute("paging",agencyservice.getPaging(paging) );
		
		m.addAttribute("count",agencyservice.countRecord() );
		return "/include/agencyShelter";
	}
	
	
	//agencyShelterDetail 상세보기 *********************************************************************************
	
	@RequestMapping(value ="/agencyShelterDetail", method=RequestMethod.GET)
	public void agencyShelterDetail(Model m,AbandonedVO vo) {
		System.out.println(vo.getAbNo());
		m.addAttribute("shelter",agencyservice.getagencyShelter(vo));
		
	}
	
	
	@RequestMapping(value ="/yootest", method=RequestMethod.GET)
	public String yootest() {
		return "/include/yootest";
	}
}
