<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<title>Board</title>

<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>

<link rel="stylesheet" type="text/css" href="/resources/css/shop/cartList.css">

</head>
<body>

	<div id="root">
		<header id="header">
			<div id="header_box">
				<%@ include file="../include/header.jsp"%>
			</div>
		</header>
		<nav id="nav">
			<div id="nav_box"><%@ include file="../include/nav.jsp"%></div>
		</nav>

		<section id="container">
			<div id="container_box">

				<section id="content">

					<ul>
						<li>
							<div class="allCheck">
								<input type="checkbox" name="allCheck" id="allCheck" />
								<label for="allCheck">모두 선택</label>
								<script>
									$("#allCheck").click(function() {
										var chk = $("#allCheck").prop("checked");
										if (chk) {
											$(".chBox").prop("checked", true);
										} else {
											$(".chBox").prop("checked", false);
										}
									});
								</script>
							</div>

							<div class="delBtn">
								<button type="button" class="selectDelete_btn">선택 삭제</button>

								<script>
									$(".selectDelete_btn").click(function() {
										var confirm_val = confirm("정말 삭제하시겠습니까?");

										if (confirm_val) {
											var checkArr = new Array();

											$("input[class='chBox']:checked").each(function() {
												checkArr.push($(this).attr("data-cartNum"));
											});

											$.ajax({
												url : "/shop/deleteCart",
												type : "post",
												data : {
													chbox : checkArr
												},
												success : function(result) {
													if (result == 1) {
														location.href = "/shop/cartList";
													} else {
														alert("삭제 실패");
													}
												}
											});
										}
									});
								</script>
							</div>

						</li>

						<c:set var="sum" value="0" />

						<c:forEach items="${cartList}" var="cartList">
							<li>
								<div class="checkBox">
									<input type="checkbox" name="chBox" class="chBox" data-cartNum="${cartList.cartNum}" />
									<script>
										$(".chBox").click(function() {
											$("#allCheck").prop("checked", false);
										});
									</script>
								</div>

								<div class="thumb">
									<img src="${cartList.gdsThumbImg}" />
								</div>
								<div class="gdsInfo">
									<p>
										<span>상품명</span>${cartList.gdsName}<br /> <span>개당 가격</span>
										<fmt:formatNumber pattern="###,###,###" value="${cartList.gdsPrice}" />
										원<br /> <span>구입 수량</span>${cartList.cartStock} 개<br /> <span>최종 가격</span>
										<fmt:formatNumber pattern="###,###,###" value="${cartList.gdsPrice * cartList.cartStock}" />
										원
									</p>

									<div class="delete">
										<button type="button" class="delete_${cartList.cartNum}_btn" data-cartNum="${cartList.cartNum}">삭제</button>

										<script>
											$(".delete_${cartList.cartNum}_btn").click(function() {
												var confirm_val = confirm("정말 삭제하시겠습니까?");

												if (confirm_val) {
													var checkArr = new Array();

													checkArr.push($(this).attr("data-cartNum"));

													$.ajax({
														url : "/shop/deleteCart",
														type : "post",
														data : {
															chbox : checkArr
														},
														success : function(result) {
															if (result == 1) {
																location.href = "/shop/cartList";
															} else {
																alert("삭제 실패");
															}
														}
													});
												}
											});
										</script>
									</div>
								</div>
							</li>

							<c:set var="sum" value="${sum + (cartList.gdsPrice * cartList.cartStock)}" />

						</c:forEach>
					</ul>

					<div class="listResult">
						<div class="sum">
							총 합계 :
							<fmt:formatNumber pattern="###,###,###" value="${sum}" />
							원
						</div>
						<div class="orderOpne">
							<button type="button" class="orderOpne_bnt">주문 정보 입력</button>
							<script>
								$(".orderOpne_bnt").click(function() {
									$(".orderInfo").slideDown();
									$(".orderOpne_bnt").slideUp();
								});
							</script>
						</div>
					</div>

					<div class="orderInfo">
						<form role="form" method="post" autocomplete="off">

							<input type="hidden" name="amount" value="${sum}" />

							<div class="inputArea">
								<label for="">수령인</label>
								<input type="text" name="orderRec" id="orderRec" required="required" />
							</div>

							<div class="inputArea">
								<label for="orderPhon">수령인 연락처</label>
								<input type="text" name="orderPhon" id="orderPhon" required="required" />
							</div>


							<div class="inputArea">
								<p>
									<input type="text" id="sample4_postcode" placeholder="우편번호">
									<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
								</p>
								<br>
								<p>
									<input type="text" name="userAddr1" id="sample4_roadAddress" placeholder="도로명주소">
									<input type="text" name="userAddr2" id="sample4_jibunAddress" placeholder="지번주소">
									<span id="guide" style="color: #999; display: none"></span>
									<input type="text" name="userAddr3" id="sample4_detailAddress" placeholder="상세주소">
									<input type="text" id="sample4_extraAddress" placeholder="참고항목">
								</p>

								<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
								<script>
									//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
									function sample4_execDaumPostcode() {
										new daum.Postcode({
											oncomplete : function(data) {
												// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

												// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
												// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
												var roadAddr = data.roadAddress; // 도로명 주소 변수
												var extraRoadAddr = ''; // 참고 항목 변수

												// 법정동명이 있을 경우 추가한다. (법정리는 제외)
												// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
												if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
													extraRoadAddr += data.bname;
												}
												// 건물명이 있고, 공동주택일 경우 추가한다.
												if (data.buildingName !== '' && data.apartment === 'Y') {
													extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
												}
												// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
												if (extraRoadAddr !== '') {
													extraRoadAddr = ' (' + extraRoadAddr + ')';
												}

												// 우편번호와 주소 정보를 해당 필드에 넣는다.
												document.getElementById('sample4_postcode').value = data.zonecode;
												document.getElementById("sample4_roadAddress").value = roadAddr;
												document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

												// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
												if (roadAddr !== '') {
													document.getElementById("sample4_extraAddress").value = extraRoadAddr;
												} else {
													document.getElementById("sample4_extraAddress").value = '';
												}

												var guideTextBox = document.getElementById("guide");
												// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
												if (data.autoRoadAddress) {
													var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
													guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
													guideTextBox.style.display = 'block';

												} else if (data.autoJibunAddress) {
													var expJibunAddr = data.autoJibunAddress;
													guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
													guideTextBox.style.display = 'block';
												} else {
													guideTextBox.innerHTML = '';
													guideTextBox.style.display = 'none';
												}
											}
										}).open();
									}
								</script>
							</div>
							<!-- 
							<div class="inputArea">
								<label for="userAddr1">우편번호</label>
								<input type="text" name="userAddr1" id="userAddr1" required="required" />
							</div>

							<div class="inputArea">
								<label for="userAddr2">1차 주소</label>
								<input type="text" name="userAddr2" id="userAddr2" required="required" />
							</div>

							<div class="inputArea">
								<label for="userAddr3">2차 주소</label>
								<input type="text" name="userAddr3" id="userAddr3" required="required" />
							</div>
							 -->

							<div class="inputArea">
								<button type="submit" class="order_btn">주문</button>
								<button type="button" class="cancel_btn">취소</button>

								<script>
									$(".cancel_btn").click(function() {
										$(".orderInfo").slideUp();
										$(".orderOpne_bnt").slideDown();
									});
								</script>
							</div>

						</form>
					</div>

				</section>

				<aside id="aside">
					<%@ include file="../include/aside.jsp"%>
				</aside>

			</div>
		</section>

		<footer id="footer">
			<div id="footer_box">
				<%@ include file="../include/footer.jsp"%>
			</div>
		</footer>
	</div>
</body>
</html>
