package com.example.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import community.CommunityVO;
import lombok.Data;

@Data
@Entity
@Table(name="report")
public class ReportVO {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer r_num;
	
	@ManyToOne
	@JoinColumn(name="user_email")
	private UserVO user;
	
	@ManyToOne
	@JoinColumn(name="c_num")
	private CommunityVO community;
	
	@ManyToOne
	@JoinColumn(name="comment_num")
	private CommentVO comment;
	
	@ManyToOne
	@JoinColumn(name="review_num")
	private ReviewVO review;
	
	@Column(length = 100)
	private String r_reason;

	@Column(insertable = false, updatable = false, columnDefinition = "date default (current_date)")
	@Temporal(TemporalType.DATE)
	private Date r_date;
	

}
