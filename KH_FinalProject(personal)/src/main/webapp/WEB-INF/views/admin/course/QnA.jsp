<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="generator" content="Hugo 0.88.1">
<script src="https://kit.fontawesome.com/2c1bc70929.js"
	crossorigin="anonymous"></script>
<c:url var="css" value="/static/css" />
<c:url var="bs5" value="/static/bs5" />
<c:url var="jQuery" value="/static/js" />
<c:url var="img" value="/static/img" />
<link rel="stylesheet" type="text/css" href="${css}/default.css">
<link rel="stylesheet" type="text/css" href="${css}/navigation.css">
<link rel="stylesheet" type="text/css" href="${css}/footer.css">
<link rel="stylesheet" type="text/css"	href="${bs5}/css/bootstrap.min.css">

<script type="text/javascript" src="${jQuery}/jquery-3.6.0.min.js"></script>

<title>QnA</title>

<style>
	.bd-placeholder-img {
		font-size: 1.125rem;
		text-anchor: middle;
		-webkit-user-select: none;
		-moz-user-select: none;
		user-select: none;
	}
	
	@media ( min-width : 768px) {
		.bd-placeholder-img-lg {
			font-size: 3.5rem;
		}
	}
	
	.imgSize {
		width: 440px;
		height: 286px;
	}
	
	.card-name {
		width: 100%;
		height: 100%;
	}
	
	.card-title {
		height: 5rem;
	}
	
	.btn-sale {
		width: 100%;
	}
	
	.active {
		border-bottom: solid 2px black;
		font-weight: 900;
	}
	
	.shadow-bottom {
		box-shadow: 0 5px 15px -10px;
	}
	
	.shadow-top {
		box-shadow: 0 -5px 15px -10px;
	}
	
	.sticky-bottom {
		position: -webkit-sticky;
		position: sticky;
		top: 0;
		background-color: white;
	}
	
	.fs-7 {
		font-size: 14px;
	}
	
	.QnA-content {
		width: 95%;
	}
	
	.QnA-content:focus {
		outline: none;
	}
	
	.cardHeader {
		height: 60px;
	}
	
	.QnA-answer {
		background-color: rgba(232, 235, 239, 0.994);
	}
	
	.answer-QnA:hover,
	.pointerBtn:hover {
		color: rgb(147, 197, 75);
		cursor: pointer;
	}
	.title{
		width: 95%;
		border-color: #dfd7ca;
	}
	.title:focus{
		outline: none;
		box-shadow: 0 0 0 0;
		border-color: #dfd7ca;
	}
	.answerBtn{
		min-width: 74px;
	}
	.questionBox{
		max-width: 445px;
	}
	.box{
		min-height: 500px;
	}
</style>
</head>

<body>
	<header>
		<%@ include file="../module/navigation.jsp"%>
	</header>
	
	<c:url var="courseUrl" value="/course"/>
	<c:url var="courseDetailUrl" value="/course/detail">
		<c:param name="id">${lessonData.l_id}</c:param>
	</c:url>
	<c:url var="courseQnAUrl" value="/course/detail/QnA"/>
	<c:url var="wishlistUrl" value="/mypage/wishlist"/>
	
	<main>
		<!-- ??? ?????? ?????? ????????? -->
		<div class="container-fluid bg-dark">
			<div class="container">
				<div class="row p-5 mx-auto">
					<!-- ?????? ????????? -->
					<div class="col-12 col-md-9 col-lg-5 p-2 d-flex flex-column justify-content-center">
						<div class="ratio ratio-4x3 align-self-center">
						<img class="rounded bannerImg" src="${lessonData.l_thumbnail}"
							alt="?????? ?????????">
						</div>
					</div>
					<!-- ?????? ?????? -->
					<div class="col-12 col-md-9 col-lg-7 mt-4">
						<nav class="text-dark" style="-bs-breadcrumb-divider: '&gt;';"
							aria-label="breadcrumb">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="/home/course">Course</a></li>
								<li class="breadcrumb-item" aria-current="page">${lessonData.l_lesson_category}</li>
							</ol>
						</nav>
						<div class="card-body mt-3 text-light">
							<div class="card-title card-name">
								<div class="fs-4 fw-bolder lh-base cardBox">${lessonData.l_title}
								</div>
							</div>
							<div class="card-detail">
								<br>
								<p class="card-text fs-6 mt-2">${lessonData.l_wid}</p>
								<p class="text-success">
	
									<c:set var="avg" value="${reviewInfo.AVG}" />
									<fmt:formatNumber var="avgFloor" value="${avg - (avg % 1)}"
										type="number" />
									<fmt:formatNumber var="avgCeil"
										value="${avg + (1 - (avg % 1)) % 1}" type="number" />
									<!-- ?????? ?????? ?????? ?????? -->
									<c:choose>
										<c:when test="${avg != 0.0}">
											<c:forEach begin="1" end="${avgFloor}">
												<i class="fa-solid fa-star"></i>
											</c:forEach>
											<c:if test="${avgCeil != avgFloor}">
												<i class="fa-solid fa-star-half-stroke"></i>
											</c:if>
											<c:forEach begin="1" end="${5 - avgCeil}">
												<i class="fa-regular fa-star"></i>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:forEach begin="1" end="5">
												<i class="fa-regular fa-star"></i>
											</c:forEach>
										</c:otherwise>
									</c:choose>
									(${reviewInfo.AVG})
								</p>
								<p class="text-muted">${reviewInfo.AMOUNT}???????????????</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<section id="QnA">
			<!-- ?????? nav -->
			<div class="border-light border-bottom my-2 ps-3 pt-1 sticky-top bg-white shadow-bottom">
				<div class="container">
					<nav class="nav nav-course">
						<a class="description nav-link text-dark"
							href="${courseDetailUrl}#description">????????????</a>
						<a class="curriculum nav-link text-dark"
							href="${courseDetailUrl}#curriculum">????????????</a> 
						<a class="review nav-link text-dark"
							href="${courseDetailUrl}#review">?????????(${reviewInfo.AMOUNT})</a>
						<a class="QnA nav-link text-dark active" href="#QnA">QnA</a>
					</nav>
				</div>
			</div>
			<div class="container box">
				<div class="row">
					<!-- QnA board -->
					<div class="col-md-12 col-lg-8 pt-3 px-4 pb-3 b">
						<div class="QnA-write row justify-content-between">
							<div class="col-3 fs-4 fw-bold mb-3">QnA</div>
							<div class="col-3">
								<button type="button" class="btn btn-primary float-end QnAbtn"
										data-bs-toggle="modal" data-bs-target="#QnAModal">
									????????????</button>
							</div>

							<!-- ?????? Modal -->
							<div class="modal fade" id="QnAModal" tabindex="-1"
								aria-labelledby="QnAModalLabel" aria-hidden="true">
								<div
									class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
									<div class="modal-content">
										<div class="modal-header border-0 d-block">
											<div>
												<h5 class="modal-title d-inline fw-bold" id="QnAModalLabel">????????????</h5>
												<button type="button" class="btn-close float-end"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="bg-secondary text-white rounded py-2 pe-2 mt-2">
												<ul class="mb-0 fs-7">
													<li>?????? ??? ????????? ?????? ??? ?????? ????????? ?????? ?????? ???????????? ??????????????? ??????????????????.</li>
													<li>?????? ?????????????????? ????????????, ?????? ?????? ??? ????????? ??????????????? ????????? ???????????????.</li>
													<li>????????? ?????? ??? ?????????, ??????, ??????, ?????? ??? ????????? ?????? ?????? ?????? ?????? ?????? ??????
														??????, ?????? ??? ??? ????????????.</li>
												</ul>
											</div>
										</div>

										<div class="modal-body">
											<form action="${courseQnAUrl}/add" method="post">
												<input type="hidden" name="qb_wid"
													value="${sessionScope.loginData.AC_ID}"> 
												<input type="hidden" name="qb_lid" value="${lessonData.l_id}">
												<div class="form-floating mb-3 d-flex justify-content-center">
												  <input type="text" id="floatingInput" name="qb_title"
												  		 class="form-control title"
												  		 placeholder="?????? ?????? ?????? ??????????" value="">
												  <label for="floatingInput" class="text-muted ms-3">QnA ??????</label>
												</div>
												<textarea name="qb_content" rows="10"
													class="QnA-content border rounded m-2 p-3"
													placeholder="????????? ????????? ???????????????"></textarea>
												<div class="modal-footer border-0">
													<button type="button" class="btn btn-secondary"
														data-bs-dismiss="modal">????????????</button>
													<button type="button" class="btn btn-primary"
														onclick="formCheck(this.form);">????????????</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<c:choose>
			                <c:when test="${foundNothing eq 0}">
								<div class="bg-light text-center mx-auto my-4 py-4 rounded">
									<div class="fs-1">???</div>
									<br>
									<div class="fs-4">?????? ????????? ?????? ????????? ???????????????!</div>
								</div>	                
			                </c:when>
			                <c:otherwise>
								<!-- QnA ????????? -->
								<c:forEach items="${QnA}" var="QnA" varStatus="modalNum">
									<div class="card mb-3">
										<!-- ????????? ?????? ??? ?????? ??????-->
										<div class="card-header row mx-0 cardHeader">
											<div class="col-1 px-0 text-center">
												<img src="https://t4.ftcdn.net/jpg/03/73/50/09/360_F_373500999_wAWkzJZRb2XHm9KeHEDcCJBkx4wR67us.jpg"
													alt="user-image" class="rounded-circle"
													style="width: 40px; height: 40px;">
											</div>
											<div class="col-3 flex-fill">
												<div style="font-size: 17px;">${QnA.qb_title}</div>
												<div class="nickname small text-muted">
													<span class="me-1"> ${QnA.qb_wid}</span>
													<div class="vr"></div>
													<fmt:formatDate value="${QnA.qb_date}" var="createDate"
																	dateStyle="short" pattern="yy-MM-dd"/>
													<span class="ms-1"> ${createDate}</span>
												</div>
											</div>
											<c:if test="${lessonData.l_wid eq sessionScope.loginData.AC_ID}">
												<c:if test="${empty QnA.qaa_content}">
													<div class="col-2 px-0 mt-1 text-end pe-1">
														<button data-bs-toggle="modal" data-bs-target="#AnswerModal"
															 	type="button" class="btn btn-outline-primary answerBtn"
															 	onclick="getQnAcontent(this)">
															 	????????????</button>
													</div>
												</c:if>
											</c:if>
										</div>
										<!-- QnA ?????? -->
										<div class="card-body">
											<p class="card-text">
												<c:set var="newLine" value="<%=\"\n\" %>"/>
												${fn:replace(QnA.qb_content, newLine, '<br>')}
											</p>
											<br>
											<!-- ??????/?????? ?????? -->
											<div> <!-- ?????? div??? ????????? class ?????? ???????????? ??? ??? -->
												<c:if test="${QnA.qb_wid eq sessionScope.loginData.AC_ID}">
													<input type="hidden" value="${QnA.qb_bid}"> 
													<span class="me-2 pointerBtn" onclick="commentEdit(this);">??????</span>
													<div class="vr"></div>
													<span class="ms-2 pointerBtn">
														<a data-bs-toggle="modal" class="text-decoration-none"
															href="#QnADelete${modalNum.count}Modal">??????</a>
													</span>
												</c:if>
											</div>
										</div>
										
										<!-- ???????????? Modal -->
										<div class="modal fade" id="AnswerModal" tabindex="-1"
										aria-labelledby="AnswerModalLabel" aria-hidden="true">
										<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
											<div class="modal-content">
												<div class="modal-header border-0 d-block pb-0">
													<div>
														<h5 class="modal-title d-inline fw-bold" id="AnswerModalLabel">????????????</h5>
														<button type="button" class="btn-close float-end"
															data-bs-dismiss="modal" aria-label="Close"></button>
													</div>
													<div class="bg-secondary text-white rounded py-2 pe-2 mt-4 ms-2 questionBox">
														<p class="ps-4 mb-1">QnA</p>
														<hr class="bg-white">
														<p class="ps-3 question"></p>
													</div>
												</div>
		
												<div class="modal-body">
													<form action="${courseUrl}/detail/QnA/answer/add" method="post">
														<input type="hidden" name="qaa_lid" value="${lessonData.l_id}">
														<input type="hidden" name="qaa_wid" value="${sessionScope.loginData.AC_ID}">
														<input type="hidden" name="qaa_bid" value="${QnA.qb_bid}">
														
														<textarea name="qaa_content" rows="10"
															class="QnA-content border rounded m-2 p-3"
															placeholder="????????? ????????? ???????????????"></textarea>
														<div class="modal-footer border-0">
															<button type="button" class="btn btn-secondary"
																data-bs-dismiss="modal">????????????</button>
															<button type="button" class="btn btn-primary"
																onclick="formCheck(this.form);">????????????</button>
														</div>
													</form>
												</div>
											</div>
										</div>
									</div>
										
										<!-- QnA ?????? Modal -->
										<div class="modal fade" id="QnADelete${modalNum.count}Modal" aria-hidden="true"
											aria-labelledby="exampleModalToggleLabel" tabindex="-1">
											<div class="modal-dialog modal-dialog-centered">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="exampleModalToggleLabel">????????????</h5>
														<button type="button" class="btn-close" data-bs-dismiss="modal"
															aria-label="Close"></button>
													</div>
													<div class="modal-body">???????????? ?????????????????????????</div>
													<div class="modal-footer">
														<input type="hidden" value="${QnA.qb_bid}">
														<button type="button" class="btn btn-secondary"
															data-bs-dismiss="modal">??????</button>
														<button class="btn btn-primary"
															data-bs-target="#QnADelete${modalNum.count}Modal2" data-bs-toggle="modal"
															onclick="commentDelete(this,'QnADelete${modalNum.count}Modal2');">??????</button>
													</div>
												</div>
											</div>
										</div>
										<div class="modal fade" id="QnADelete${modalNum.count}Modal2" aria-hidden="true"
											aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
											<div class="modal-dialog modal-dialog-centered">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="exampleModalToggleLabel2">
															?????? ??????</h5>
														<button type="button" class="btn-close" data-bs-dismiss="modal"
															aria-label="Close"></button>
													</div>
													<div class="modal-body"></div>
													<div class="modal-footer">
														<button class="check-btn btn btn-primary"
															data-bs-toggle="modal">??????</button>
													</div>
												</div>
											</div>
										</div>
										
										<!-- ???????????? QnA?????? -->
										<c:if test="${!empty QnA.qaa_wid}">
											<div class="card-body QnA-answer row mx-0">
												<div class="col-1 p-0 text-center">
													<i class="fa-solid fa-arrow-up fa-rotate-90"></i>
												</div>
												<div class="col ps-0">
													<!-- ?????? ????????? ?????? -->
													<div>
														<img src="https://t4.ftcdn.net/jpg/03/73/50/09/360_F_373500999_wAWkzJZRb2XHm9KeHEDcCJBkx4wR67us.jpg"
															alt="teacher-img" class="rounded-circle" style="width: 30px; height: 30px;">
														<span class="me-1">${QnA.qaa_wid}</span>
														<div class="vr"></div>
														<fmt:formatDate value="${QnA.qaa_date}" var="createDate"
																		dateStyle="short" pattern="yy-MM-dd"/>
														<span class="ms-1 small">
															${createDate}
														</span>
													</div>
													<!-- ?????? ?????? -->
													<div class="content mt-2">
														<c:set var="newLine" value="<%=\"\n\" %>"></c:set>
														${fn:replace(QnA.qaa_content, newLine, '<br>')}
													</div>
													<br>
													<!-- ?????? ??? ?????? ?????? -->
													<c:if test="${QnA.qaa_wid eq sessionScope.loginData.AC_ID}">
														<div class="mt-2">
															<input type="hidden" value="${QnA.qb_bid}"> 
															<span class="me-2 pointerBtn"" onclick="commentEdit(this);">??????</span>
															<div class="vr"></div>
															<span class="ms-2">
																<a data-bs-toggle="modal" class="text-decoration-none"
																   href="#QnAanswerDelete${modalNum.count}Modal">??????</a>
															</span>
														</div>
													</c:if>
												</div>
												<!-- Answer Modal -->
												<div class="modal fade" id="QnAanswerDelete${modalNum.count}Modal"
													aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
													tabindex="-1">
													<div class="modal-dialog modal-dialog-centered">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title" id="exampleModalToggleLabel">????????????</h5>
																<button type="button" class="btn-close"
																	data-bs-dismiss="modal" aria-label="Close"></button>
															</div>
															<div class="modal-body">QnA ????????? ?????????????????????????</div>
															<div class="modal-footer">
																<input type="hidden" value="${QnA.qb_bid}">
																<button type="button" class="btn btn-secondary"
																	data-bs-dismiss="modal">??????</button>
																<button class="btn btn-primary" data-bs-toggle="modal" 
																		data-bs-target="#QnAanswerDelete${modalNum.count}Modal2"
																		onclick="commentDelete(this,'QnAanswerDelete${modalNum.count}Modal2');">??????</button>
															</div>
														</div>
													</div>
												</div>
												<div class="modal fade" id="QnAanswerDelete${modalNum.count}Modal2"
													aria-hidden="true" aria-labelledby="exampleModalToggleLabel2"
													tabindex="-1">
													<div class="modal-dialog modal-dialog-centered">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title" id="exampleModalToggleLabel2">
																	?????? ??????</h5>
																<button type="button" class="btn-close"
																	data-bs-dismiss="modal" aria-label="Close"></button>
															</div>
															<div class="modal-body"></div>
															<div class="modal-footer">
																<button class="check-btn btn btn-primary"
																	data-bs-toggle="modal">??????</button>
															</div>
														</div>
													</div>
												</div>
											</div>
										</c:if>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
					
					
					<!-- sale ??????/ md ????????? ??? show -->
					<fmt:formatNumber value="${lessonData.l_price}" type="currency" 
                    				  var="price" currencySymbol="???"/>
					<div class="col-lg-4 p-4">
						<div class="position-sticky d-none d-lg-block" style="top: 2rem;">
							<div class="p-4 mb-3 bg-light rounded">
								<p class="small mt-2 mb-0">${lessonData.l_wid}</p>
								<p class="fs-5 fw-bolder">${lessonData.l_title}</p>
								<br>
								<br>
								<c:if test="${!historyExist}">
									<fmt:formatNumber var="installmentPrice" type="number" 
													  value="${lessonData.l_price / 5}" />
									<c:choose>
										<c:when test="${lessonData.l_price >= 70000}">
											<p class="small fw-bold text-primary m-0">???${price}</p>
											<p class="fs-5 fw-bolder text-warning m-0">??? ${installmentPrice}???</p>
											<p class="small text-muted mt-0">5?????? ?????????</p>
										</c:when>
										<c:otherwise>
											<p class="fs-5 fw-bolder text-warning ps-1">${price}???</p>
										</c:otherwise>
									</c:choose>
								</c:if>
								<div>
									<c:choose>
										<c:when test="${!historyExist and !isExistInCart}">
											<button class="btn btn-success d-block btn-sale mb-1" 
													id="goToCart" type="button">
												???????????? ??????</button>
											<button class="btn btn-outline-success btn-sale d-block"
													id="addCart" type="button">??????????????? ??????</button>
										</c:when>
										<c:when test="${!historyExist and isExistInCart}">
											<button class="btn btn-success d-block btn-sale mb-1" type="button" 
													onclick="location.href='${wishlistUrl}/${sessionScope.loginData.AC_ID}'">
												??????????????? ??????</button>
										</c:when>
										<c:otherwise>
											<button class="btn btn-success d-block btn-sale mb-1"
												type="button">?????? ????????????</button>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- sale ??????/ md ????????? ??? show -->
			<div class="col-md-12 d-lg-none py-2 shadow-top sticky-bottom">
				<div class="container-fluid">
					<div class="row btn-sale justify-content-center">
						<c:choose>
							<c:when test="${!historyExist and !isExistInCart}">
								<div class="col-2 align-self-center">
									<p class="fw-bold text-black text-center m-0">${price}</p>
								</div>
								<div class="col-5 p-1">
									<button class="btn btn-success btn-sale" type="button" id="goToCart">
										???????????? ??????</button>
								</div>
								<div class="col-5 p-1">
									<button class="btn btn-outline-success btn-sale" id="addCart" type="button">
										???????????????	??????</button>
								</div>
							</c:when>
							<c:when test="${!historyExist and isExistInCart}">
								<div class="col-5 p-1">
									<button class="btn btn-outline-success btn-sale" type="button"
											onclick="location.href='${wishlistUrl}/${sessionScope.loginData.AC_ID}'">
										??????????????? ??????</button>
								</div>
							</c:when>
							<c:otherwise>
								<div class="col-5 p-1">
									<button class="btn btn-success btn-sale" type="button">
										?????? ????????????</button>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</section>
	</main>
	<footer>
		<%@ include file="../module/footer.jsp"%>
	</footer>
	<!-- QnA ?????? -->
	<script>
		function commentEdit(element) {
			element.innerText = '??????';
			element.nextElementSibling.remove();
			element.nextElementSibling.remove();
			
			// QnA ??????
			const QnA = element.parentElement.previousElementSibling.previousElementSibling;
			var value = QnA.innerText; 
			
			var textarea = document.createElement("textarea");
			textarea.setAttribute("class", "form-control");
			textarea.setAttribute("rows", "5");
			textarea.value = value;

			QnA.innerText = "";
			QnA.append(textarea);

			//???????????? ??????
			element.setAttribute("onclick", "commentUpdate(this);");
		}
		function commentUpdate(element) {
			var bid = element.previousElementSibling.value;//QnA id
			const textarea = element.parentElement.previousElementSibling
										.previousElementSibling.children[0];
			var value = textarea.value;//textarea??? ?????? ??????

			// changeText(element);
			if(element.parentElement.classList.length === 0){
				modifyAjax('${courseUrl}/QnA/modify', bid, value, textarea, element);
			}else{
				modifyAjax('${courseUrl}/QnA/answer/modify', bid, value, textarea, element);
			}
		}
		function modifyAjax(address, bid, value, textarea, element){
			$.ajax({
				url : address,
				type : "post",
				data : {
					bid : bid,
					content : value
				},
				success : function(data) {
					textarea.value = data.value;
					changeText(element);
				}
			});
		}
		function changeText(element) {
			element.innerText = '??????';

			// <textarea> ??????
			const textarea = element.parentElement.previousElementSibling
										.previousElementSibling.children[0];
			var value = textarea.value;
			textarea.remove();
			
			//QnA??? ????????? ??? ??????
			var content = element.parentElement.previousElementSibling.previousElementSibling;
			content.innerText = value; 
			
			//?????? ?????? id
			if(element.parentElement.classList.length === 0){
				//?????? ?????? ?????? id
				var modalName = element.parentElement.parentElement.nextElementSibling
																	.nextElementSibling.id;
			}else{
				//?????? ?????? ?????? ?????? id
				var modalName = element.parentElement.parentElement.nextElementSibling.id;
			}
			modifyAndDelete_btn(element, modalName);
			
			element.setAttribute("onclick", "commentEdit(this);");
		}
		
		function modifyAndDelete_btn(element, modalName) {
			var vr = document.createElement('div');
			vr.setAttribute('class', 'vr');
			
			var span = document.createElement('span');
			span.setAttribute('class', 'ms-2 pointerBtn')
			
			var a = document.createElement('a');
			a.setAttribute('data-bs-toggle', 'modal');
			a.setAttribute('class', 'text-decoration-none');
			a.setAttribute('href', '#' + modalName);
			a.innerText = '??????';
			span.append(a);

			element.after(span);
			element.after(vr);
		}
	</script>
	<!-- QnA ?????? -->
	<script>
		function commentDelete(element, modalName) {
			console.log(modalName);
			const bid = element.previousElementSibling.previousElementSibling.value;
			console.log(element);
			console.log(bid);
			const modal = document.getElementById(modalName);
			const checkMessage = modal.children[0].children[0].children[1];
			const boss = element.parentElement.parentElement.parentElement.parentElement.parentElement;
			
			var address = '';
			if(!modalName.includes('answer', 3)){
				address = '${courseUrl}/QnA/delete';
			}else{
				address = '${courseUrl}/QnA/answer/delete';
			}
			deleteAjax(address, bid, checkMessage, boss);
		}
		function deleteAjax(address, bid, checkMessage, boss){
			$.ajax({
				url : `\${address}`,
				type : "post",
				data : {
					bid : bid
				},
				success : function(data) {
					if (data.type === "success") {
						checkMessage.innerText = data.message;
						boss.remove();
					}else if(data.type === "fail"){
	                	checkMessage.innerText = data.message;
	                }else{ //notExist
	                	checkMessage.innerText = data.message;
	                }
				}
			});
		}
	</script>
	<!-- QnA ??? ?????? ?????? -->
	<c:url value="/login" var="login" />
	<script>
		//????????? ??????
		$('button.QnAbtn').on('click', e=>{
			var client = '${sessionScope.loginData.AC_ID}';
			
			if(client === '' || client.trim() === ''){
				location.href = '${login}';
			}
		});
		
		function getQnAcontent(btn){
			//QnA ?????? ????????????
			var QnAcontent = btn.parentElement.parentElement.
							nextElementSibling.children[0].innerText;
			var questionBox = document.querySelector('.question');
			questionBox.innerText = QnAcontent;
		}
	
		function formCheck(form) {
			//??????, ?????? textarea ????????? ?????? ?????????
			if(form.qb_content !== undefined){
				if (form.qb_content.value.trim() === "" || form.qb_title.value.trim() === "") {
					alert("QnA ????????? ????????? ????????? ??? ????????????.");
				} else {
					form.submit();
				}
			}else{
				if (form.qaa_content.value.trim() === "") {
					alert("????????? ?????? ??? ????????? ?????????.");
				} else {
					form.submit();
				}
			}
		}
	</script>
	<!-- ???????????? ?????? ?????? -->
    <script>
   		var addCartBtn = document.querySelector('button#addCart');
	    addCartBtn.addEventListener('click', ()=>{
	    	let login = checkLogin();
	    	
	    	if(login){
	    		$.ajax({
					url: "${wishlistUrl}/add",
					type: "post",
					dataType: "JSON",
					data: {
						l_id: ${lessonData.l_id}
					},
					success: function(data){
						if(data.result === 'goToCart'){
							location.href = "${wishlistUrl}/${sessionScope.loginData.AC_ID}";
						}else {
							alert(data.msg);
							location.reload();
						}
					},
					error: function(data){
						alert("error");
					}
				});
	    	}
	    	
	    });
	    
	    var goToCartBtn = document.querySelector('button#goToCart');
	    goToCartBtn.addEventListener('click', ()=>{
	    	let login = checkLogin();
	    	
	    	if(login){
		    	$.ajax({
					url: "${wishlistUrl}/add?direct=3",
					type: "post",
					dataType: "JSON",
					data: {
						l_id: ${lessonData.l_id}
					},
					success: function(data){
						if(data.result === 'goToCart'){
							location.href = "${wishlistUrl}/${sessionScope.loginData.AC_ID}";
						}else {
							alert(data.msg);
						}
					},
					error: function(data){
						alert("error");
					}
				});
	    	}
	    });
		
	    function checkLogin(){
	    	var loginData = "";
	    	loginData += "${sessionScope.loginData.AC_ID}";
	    	
	    	if(loginData.trim() === ""){
	    		alert("???????????? ?????????.");
	    		return false;
	    	}
	    	return true;
	    }
    </script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa"
		crossorigin="anonymous"></script>
</body>

</html>