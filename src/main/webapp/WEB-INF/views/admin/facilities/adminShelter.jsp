<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | Contacts</title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="/admin/plugins/fontawesome-free/css/all.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Tempusdominus Bootstrap 4 -->
<link rel="stylesheet"
	href="/admin/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- iCheck -->
<link rel="stylesheet"
	href="/admin/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- JQVMap -->
<link rel="stylesheet" href="/admin/plugins/jqvmap/jqvmap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/admin/dist/css/adminlte.min.css">
<!-- overlayScrollbars -->
<link rel="stylesheet"
	href="/admin/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Daterange picker -->
<link rel="stylesheet"
	href="/admin/plugins/daterangepicker/daterangepicker.css">
<!-- summernote -->
<link rel="stylesheet"
	href="/admin/plugins/summernote/summernote-bs4.min.css">
<script src="https://kit.fontawesome.com/23b331c6f8.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../dist/css/adminlte.min.css">

<style type="text/css">
.lead {
	margin-top: 10px;
}

.agencyImg{
	border-radius:20px;
	margin-top: 20px;
}

.agencyCon{
	margin-top: 30px;

}

.small{
	text-align: left;
	margin-left:-25px;
}

</style>

</head>
<body class="hold-transition sidebar-mini">
	<!-- Site wrapper -->
	<div class="wrapper">

		<%@ include file="../../admin/common/adminNavbar.jsp"%>

		<%@ include file="../../admin/common/adminSidebar.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>보호소</h1>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- Main content -->
			<section class="content">

				<!-- Default box -->
				<div class="card card-solid">
					<div class="card-body pb-0">

						<div class="row">
							<c:forEach items="${paging}" var="shelter">
								<div
									class="col-12 col-sm-6 col-md-4 d-flex align-items-stretch flex-column">
									<div class="card bg-light d-flex flex-fill">
										<div class="card-body pt-0">
											<div class="row">
												<div class="col-7 agencyCon">
													<h2 class="lead">
														<b>${shelter.abName}</b>
													</h2>
													<p class="text-muted text-sm">
														<b>견종 : </b> ${shelter.abKind}
													</p>
													<ul class="ml-4 mb-0 fa-ul text-muted">
														<li class="small"><span class="fa-li"></span>
															나이 : ${shelter.abAge}</li>
														<li class="small"><span class="fa-li"></span>
															성별 : ${shelter.abGender}</li>
													</ul>
												</div>
												<div class="col-5 text-center">
													<img src="${shelter.abImage}" alt="user-avatar"
														class="img-square img-fluid agencyImg">
												</div>
											</div>
										</div>
										<div class="card-footer">
											<div class="text-right">
												<a class="btn btn-sm btn-warning" data-toggle="modal"
													data-target="#shelterModal${shelter.abNo}">수정 </a> <a
													href="#" class="btn btn-sm btn-danger"> 삭제 </a>
											</div>
										</div>
									</div>
								</div>
								<!-- Modal -->
								<div class="modal fade" id="shelterModal${shelter.abNo}"
									tabindex="-1"
									aria-labelledby="shelterModal${shelter.abNo}Label"
									aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title"
													id="shelterModal${shelter.abNo}Label">${shelter.abName}
												</h5>
												<button type="button" class="close" data-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<!-- form start -->
											<div class="modal-body">
												<div class="container-fluid">
													<div class="row">
														<form action="/admin/update2" method="post">
														  <input type="hidden" name="agencyNum" value="${shelter.abNo}">
															<div class="row">

																<div class="mb-3 col-md-6">
																	<label for="exampleFormControlInput1"
																		class="form-label">이름</label> <input type="text"
																		class="form-control" id="exampleFormControlInput1"
																		name="facility" value="${shelter.abName}">
																</div>

																<div class="mb-3 col-md-12">
																	<label for="exampleFormControlTextarea1"
																		class="form-label">나이</label>
																	<input type="text"
																		   class="form-control" id="exampleFormControlInput1"
																		   name="facility" value="${shelter.abAge}">
																</div>

																<div class="mb-3 col-md-12">
																	<label for="exampleInputPassword1" class="form-label">이미지
																		첨부</label>
																	<div class="custom-file">
																		<input type="file" class="custom-file-input"
																			id="customFile"> <label
																			class="custom-file-label" for="customFile">Choose
																			file</label>
																	</div>
																</div>

																<div class="modal-footer">
																	<button type="submit" class="btn btn-secondary m-2 btn-success"
																		id="btnQnAWrite">수정</button>
																	<button type="button" class="btn btn-secondary m-2 btn-danger"
																		id="btnCancle" data-dismiss="modal">취소</button>
																</div>

															</div>
														</form>
													</div>
												</div>
											</div>
										</div>

									</div>
								</div>
							</c:forEach>
						</div>

					</div>

				</div>

				<!-- /.card-body -->
				<div class="card-footer">
					<nav aria-label="Contacts Page Navigation">
						<ul class="pagination justify-content-center m-0">
							<c:set var="recordsCnt" value="${count}" />
							<c:set var="jspFile" value="adminShelter?" />
							<c:set var="perpage" value="9" />
						</ul>
						<%@include file="paging.jsp"%>
					</nav>
				</div>
				<!-- /.card-footer -->
		</div>
		<!-- /.card -->
		<%@ include file="../../admin/common/adminFooter.jsp"%>
		</section>
		<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->

	<!-- Control Sidebar -->
	<aside class="control-sidebar control-sidebar-dark">
		<!-- Control sidebar content goes here -->
	</aside>
	<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->

	<!-- jQuery -->
	<script src="../../plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE App -->
	<script src="../../dist/js/adminlte.min.js"></script>

	<!-- jQuery -->
	<script src="/admin/plugins/jquery/jquery.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="/admin/plugins/jquery-ui/jquery-ui.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button)
	</script>
	<!-- Bootstrap 4 -->
	<script src="/admin/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- ChartJS -->
	<script src="/admin/plugins/chart.js/Chart.min.js"></script>
	<!-- Sparkline -->
	<script src="/admin/plugins/sparklines/sparkline.js"></script>
	<!-- JQVMap -->
	<script src="/admin/plugins/jqvmap/jquery.vmap.min.js"></script>
	<script src="/admin/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
	<!-- jQuery Knob Chart -->
	<script src="/admin/plugins/jquery-knob/jquery.knob.min.js"></script>
	<!-- daterangepicker -->
	<script src="/admin/plugins/moment/moment.min.js"></script>
	<script src="/admin/plugins/daterangepicker/daterangepicker.js"></script>
	<!-- Tempusdominus Bootstrap 4 -->
	<script
		src="/admin/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
	<!-- Summernote -->
	<script src="/admin/plugins/summernote/summernote-bs4.min.js"></script>
	<!-- overlayScrollbars -->
	<script
		src="/admin/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
	<!-- AdminLTE App -->
	<script src="/admin/dist/js/adminlte.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script src="/admin/dist/js/pages/dashboard.js"></script>
	<script type="text/javascript">
		$('#facilities').addClass('menu-is-opening')
		$('#facilities').addClass('menu-open')
		$('#shelter').addClass('active')
	</script>
	<script type="text/javascript">
		/*
			* each : 하나씩 뽑음
			* <a class="page-link" href="adminHotel?P=2&amp;page=13">13</a>
			* a태그 사이에 있는 숫자13을 찾아야 합니다
			* a태그안에 있는 text를 찾고 page랑 같으면
			* active클래스 추가
			* */
		$(function(){
			var page = '${param.page}'
			$('.pagination').find('li').each(function(){
				if(page == $(this).find('a').text()){
					$(this).addClass('active')
				}
				//console.log(e.text())
			})
		})

	</script>
		<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		function sample6_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								document.getElementById("sample6_extraAddress").value = extraAddr;

							} else {
								document.getElementById("sample6_extraAddress").value = '';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('sample6_postcode').value = data.zonecode;
							document.getElementById("sample6_address").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("sample6_detailAddress")
									.focus();
						}
					}).open();
		}
	</script>
</body>
</html>

