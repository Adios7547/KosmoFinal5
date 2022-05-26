package com.example.service.agency;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.dao.AbandonedRepository;
import com.example.dao.AgencyRepository;
import com.example.domain.AbandonedVO;
import com.example.domain.AgencyVO;

@Service
public class AgencyServiceImpl implements AgencyService{
	
	@Autowired
	private AbandonedRepository abandonedRepo;
	
	@Autowired
	private AgencyRepository agencyRepo;

	
	
	public List<AbandonedVO> getPaging(Pageable paging){
		return abandonedRepo.findAll(paging);
	}
	
	public int countRecord() {
		return abandonedRepo.countRecord();
	}
	
	
	@Override
	public List<AgencyVO> getHotelPaging(Pageable paging) {		
		return agencyRepo.findByAgencyCategoryNum(paging, 1);
	}
	
	@Override
	public int countHotelRecord() {		
		return agencyRepo.countHotelRecord();
	}

	//보호소 상세정보 띄우기 
	@Override
	public AbandonedVO getagencyShelter(AbandonedVO vo) {
		AbandonedVO avo = abandonedRepo.findById(vo.getAbNo()).get();
		return abandonedRepo.save(avo);
	}
	
	
	//호텔정보 상세정보 띄우기 
		@Override
		public AgencyVO getagencyHotel(AgencyVO vo) {
			AgencyVO avo = agencyRepo.findById(vo.getAgencyNum()).get();
			return agencyRepo.save(avo);
		}
	
}
