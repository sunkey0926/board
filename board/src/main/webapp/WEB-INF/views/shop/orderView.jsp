<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<title>Board</title>

<link rel="stylesheet" type="text/css" href="/resources/css/shop/orderView.css">

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

					<div class="orderInfo">
						<c:forEach items="${orderView}" var="orderView" varStatus="status">

							<c:if test="${status.first}">
								<p>
									<span>수령인</span>${orderView.orderRec}</p>
								<p>
									<span>주소</span>(${orderView.userAddr1}) ${orderView.userAddr2} ${orderView.userAddr3}
								</p>
								<p>
									<span>가격</span>
									<fmt:formatNumber pattern="###,###,###" value="${orderView.amount}" />
									원
								</p>
							</c:if>

						</c:forEach>
					</div>

					<ul class="orderView">
						<c:forEach items="${orderView}" var="orderView">
							<li>
								<div class="thumb">
									<img src="${orderView.gdsThumbImg}" />
								</div>
								<div class="gdsInfo">
									<p>
										<span>상품명</span>${orderView.gdsName}<br /> <span>개당 가격</span>
										<fmt:formatNumber pattern="###,###,###" value="${orderView.gdsPrice}" />
										원<br /> <span>구입 수량</span>${orderView.cartStock} 개<br /> <span>최종 가격</span>
										<fmt:formatNumber pattern="###,###,###" value="${orderView.gdsPrice * orderView.cartStock}" />
										원                 
									</p>
								</div>
							</li>
						</c:forEach>
					</ul>
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
