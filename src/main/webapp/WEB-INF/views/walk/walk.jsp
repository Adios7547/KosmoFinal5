<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/walk/stopwatch.css" />
<head>
<meta charset="utf-8" />
<title>산책하기</title>
<link
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet"
	integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
	crossorigin="anonymous" />
<script src="/js/jquery.min.js?ver=3.6.0"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<style>
.mapContainer {
	position: absolute;
	width: 100%;
	height: 100%;
}

#map {
	width: 100%;
	height: 100%;
}

.walkTimer {
	position: fixed;
	z-index: 10;
	bottom: 50px;
	/* left:45%; */
	width: 100%;
}

#box {
	width: 100%;
}

/* #timerBox{
	width:100%
} */
/* #startbtn{
	width:500px;
} */
#stopbtn {
	width: 10%;
	height:60px;
	
}

.walk-container {
	display: none;
	width: 101.5%;
	/* margin-left:0.6%; */
	justify-content: center;
	/* padding-top: 3.55%   */
	position: fixed;
	bottom: 0;
	height: 10%;
	align-items: center;
	
}

.walk-container2 {
	display: flex;
	width: 101.5%;
	justify-content: center;
}

#walk-distance {
  width: 200px;
  background-color: #DDDDDD;
  border: none;
  font-size: 30pt;
  color: #4c4c4c;
  text-align: center;
  font-family: sans-serif;
  border-radius: 7px;

}

p{
	display:inline;
	font-size:15px;
	margin:0;
	white-space:noraml;
	line-height: 1.8;
	font-weight: 400;
	color: black;
}

</style>
 <link rel="stylesheet" href="/walk/button.css" />
</head>
<body>
<div class="mapContainer" id="map"></div>
	<form id="frm" action="walk" method="post">
		<div class="row">
			<div class="walkTimer">
				<div id="box" class="box"> 
				<div class="walk-container2">
					<button type="button" id="startbtn" class="btn-gradient bg-dark block">산책시작</button>
				</div>
					<div id="walk-container" class="walk-container">
						
							<input name="walkDistance" id="walk-distance" value="0"/>						
						
						<button type="submit" id="stopbtn" class="btn-gradient bg-dark block">산책종료</button>
						<div id="timerBox" class="timerBox">
							<div id="time" class="time">00:00:00</div>
						</div>
					</div>
				</div>
			</div>
		</div>
			
		<input name="walkLon" id="walk-path-lon" value="" type="hidden"/> 
		<input name="walkLat" id="walk-path-lat" value="" type="hidden"/> 
		<input name="walkTime" id="walk-time" value="" type="hidden"/> 
		<input name="walkStart" id="walk-start" type="hidden"/>
		<input name="walkEnd" id="walk-end" type="hidden"/> 
		<input name="walkDistance" id="walk-distance" type="hidden"/>
	</form>




	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=38dc5bcb059feb9cd76793722680fa6a"></script>
	<script>
		var mapContainer = document.getElementById("map"), // 지도를 표시할 div
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 5, // 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		var lat;
		var lon;
		var options = {
			enableHighAccuracy : true,
			timeout : 5000,
			maximumAge : 0
		};
		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다
		if (navigator.geolocation) {
			// GeoLocation을 이용해서 접속 위치를 얻어옵니다
			navigator.geolocation.getCurrentPosition(function(position) {
				console.log("포지션" + position);
				(lat = position.coords.latitude), // 위도
				(lon = position.coords.longitude); // 경도

				var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
				message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다
				console.log("loc포지션" + locPosition);
				// 마커와 인포윈도우를 표시합니다
				displayMarker(locPosition, message);
			});
		} else {
			// HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

			var locPosition = new kakao.maps.LatLng(33.450701, 126.570667), message = "geolocation을 사용할수 없어요..";

			displayMarker(locPosition, message);
		}

		// var listLat = [];
		// var listLon = [];
		var polyline;

		function success(position) {
			console.log(position);
			(lat = position.coords.latitude), // 위도
			(lon = position.coords.longitude); // 경도
			// listLat.push(lat);
			// listLon.push(lon);
			// if(){

			// }

			console.log("위도 : " + lat);
			console.log("경도 : " + lon);
			console.log(listLat);
			console.log(listLon);

			mylotation(lat, lon);

			polyline = new kakao.maps.Polyline({
				path : linePath, // 선을 구성하는 좌표배열 입니다
				strokeWeight : 5, // 선의 두께 입니다
				strokeColor : "#FFAE00", // 선의 색깔입니다
				strokeOpacity : 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				strokeStyle : "solid", // 선의 스타일입니다
			});

			// 지도에 선을 표시합니다
			polyline.setMap(map);

			var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
			message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다

			displayMarker(locPosition, message);
		}

		function error(err) {
			console.log(err);
		}
		var navi;
		
		var imageSrc = "/img/walk3.png", // 마커이미지의 주소입니다    
	    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
	    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.


		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		var marker;
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
		var flag = false;
		function displayMarker(locPosition, message) {
			//마커 하나만 생성
			if (flag) {
				marker.setMap(null);
			}
			// 마커를 생성합니다
			marker = new kakao.maps.Marker({
				position : locPosition,
				image: markerImage
			});
			marker.setMap(map);
			flag = true;

			// var iwContent = message, // 인포윈도우에 표시할 내용
			//   iwRemoveable = true;

			// // 인포윈도우를 생성합니다
			// var infowindow = new kakao.maps.InfoWindow({
			//   content: iwContent,
			//   removable: iwRemoveable,
			// });

			// // 인포윈도우를 마커위에 표시합니다
			// infowindow.open(map, marker);

			// // 지도 중심좌표를 접속위치로 변경합니다
			map.setCenter(locPosition);
		}

		// 선을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 선을 표시합니다

		var linePath = [];
		var listLat = [];
		var listLon = [];
		var qwer = 0;
		
		let standardPosition;

		function mylotation(lat, lon) {
			const lotation = new kakao.maps.LatLng(lat, lon);
			console.log("lon" + lotation.La);
			console.log("lat" + lotation.Ma);
			console.log("lat" + lat);
			console.log("lon" + lon);
			if (standardPosition == null) {
				standardPosition = lotation;
				linePath.push(standardPosition);
				listLat.push(standardPosition.Ma);
				listLon.push(standardPosition.La);

				Number($("#walk-distance").val(qwer))
			} else {
				
				const dis = distance(standardPosition.Ma, standardPosition.La,
						lat, lon);
				console.log("거리 " + dis);
				if (dis >= 10) {
					
					linePath.push(lotation);
					standardPosition = lotation;
					listLat.push(standardPosition.Ma);
					listLon.push(standardPosition.La);
					
					qwer+=10
					
					Number($("#walk-distance").val(qwer));
				}
			}
			


			console.log("라인" + linePath);
		}

	

		function distance(lat1, lon1, lat2, lon2) {
			var theta = lon1 - lon2;
			var dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2))
					+ Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2))
					* Math.cos(deg2rad(theta)); 
			dist = Math.acos(dist);
			dist = rad2deg(dist);
			dist = dist * 60 * 1.1515 * 1609.344;
			// dist = dist / 1000; 단위 km
			return dist; // 단위 m
		}

		function deg2rad(deg) {
			return (deg * Math.PI) / 180.0;
		}
		console.log("테스트" + deg2rad(10));

		function rad2deg(rad) {
			return (rad * 180) / Math.PI;
		}

		console.log(distance(37.48439983948313, 127.08369152181689,
				37.48037945455113, 126.88236669761956));

		//radian(라디안)을 10진수로 변환
		// private static double rad2deg(double rad){
		//     return (rad * 180 / Math.PI);
		// }
		
	
		$("#startbtn").click(
				(params) => {
					if (navigator.geolocation) {
						$("#walk-path-lon").val("");
						$("#walk-path-lat").val("");
						$("#walk-time").val("");
						navi = navigator.geolocation.watchPosition(success,
								error, options);
						console.log("tqtqtq"+linePath.length)
						$("#walk-distance").val(0)
						
					}
				   var x = document.getElementById("walk-container");
					
					$("#startbtn").hide()
					x.style.display="flex";
					
				});

		$("#stopbtn").click(function name(params) {
			navigator.geolocation.clearWatch(navi);

			$("#walk-path-lon").val(listLon);
			$("#walk-path-lat").val(listLat);
			console.log("사이즈" + listLat.length);

			polyline.setMap(null);
		});
	</script>
	<script type="text/javascript" src="/walk/stopwatch.js"></script>

</body>
</html>