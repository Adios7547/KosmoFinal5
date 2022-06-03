package com.example.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.domain.FriendVO;
@Repository
public interface FriendRepository extends CrudRepository<FriendVO, Integer> {
	//친구레코드 출력
	@Query("SELECT f FROM FriendVO f WHERE(f.userSign=0 and f.user1.userEmail=:email)  or   "
			+ "(f.userSign=0 and f.user2.userEmail=:email)")
	List<FriendVO> friendList(String email);
	
	//친구번호 얻어오기
	@Query("SELECT f.friendNo FROM FriendVO f WHERE (f.userSign=0 and f.user1.userEmail=:email1 and f.user2.userEmail=:email2)  or     "
			+ " (f.userSign=0 and f.user2.userEmail=:email1 and f.user1.userEmail=:email2)     ")
	long getFriendNo(String email1,String email2);
	
	//1:1채팅 친구 검색
	@Query("SELECT f FROM FriendVO f WHERE(f.userSign=0 and f.user1.userEmail=:email and f.user2.userEmail like :search)  or   "
			+ "(f.userSign=0 and f.user2.userEmail=:email and f.user1.userEmail like :search)")
	List<FriendVO> friendSearch(String search , String email);
	
	
}
