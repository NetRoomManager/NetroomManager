<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!-- 상품관리 페이지 -->
<%--${productList.get(0).productCategoryName}--%>
<style>
	#product_update table>tbody>tr>th {
		padding-top: 15px;
	}

</style>

<div id="headerContent"></div>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav me-auto mb-2 mb-lg-0 pt-1">
			<li class="nav-item"><a class="nav-link active navbar-brand"
									aria-current="page" href="${cpath}/">NetRoom</a></li>
			<li class="nav-item pe-3 hover_element"><a class="nav-link"
													   data-bs-toggle="modal" data-bs-target="#productUpdate">상품등록</a>
			</li>
			<li class="nav-item pe-3 hover_element"><a class="nav-link"
													   data-bs-toggle="modal" data-bs-target="#categoryUpdate">카테고리등록</a>
			</li>
		</ul>
		<ul class="navbar-nav">
			<li class="nav-item pe-2">
				<button type="button" class="btn btn-light" data-bs-container="body"
						data-bs-toggle="popover" data-bs-placement="bottom"
						data-bs-content="test"
						style="-bs-btn-padding-y: .25rem; - -bs-btn-padding-x: .75em; - -bs-btn-font-size: 1.15rem;">
					<svg width="20" height="20" viewBox="0 0 20 20" fill="none"
						 xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 relative"
						 preserveAspectRatio="none">
						<path fill-rule="evenodd"
							  clip-rule="evenodd"
							  d="M5.46335 6.82247C5.17954 6.82247 4.95008 6.58557 4.98808 6.30431C5.28388 4.11461 6.91244 2.5 9.78004 2.5C12.5925 2.5 14.4888 4.20082 14.4888 6.51914C14.4888 8.19829 13.6579 9.37912 12.2516 10.2349C10.8773 11.0583 10.4832 11.6324 10.4832 12.7483V12.9091C10.4832 13.1852 10.2593 13.4091 9.98316 13.4091H8.7718C8.49805 13.4091 8.2752 13.189 8.27184 12.9152L8.26725 12.5424C8.21399 11.0149 8.86385 10.0399 10.3234 9.15162C11.6124 8.36079 12.0705 7.73246 12.0705 6.61664C12.0705 5.39248 11.1224 4.49332 9.66285 4.49332C8.35848 4.49332 7.46502 5.20111 7.21313 6.35946C7.15721 6.61661 6.94421 6.82247 6.68105 6.82247H5.46335ZM9.37002 17.5C10.1478 17.5 10.7388 16.908 10.7388 16.1364C10.7388 15.3647 10.1478 14.7727 9.37002 14.7727C8.61302 14.7727 8.01157 15.3647 8.01157 16.1364C8.01157 16.908 8.61302 17.5 9.37002 17.5Z"
							  fill="black"></path>
					</svg>
				</button>
			</li>
			<li class="nav-item pe-2">
				<button type="button" class="btn btn-light" onclick="location.reload();"
						style="-bs-btn-padding-y: .25rem; - -bs-btn-padding-x: .75rem; - -bs-btn-font-size: 1.15rem;">
					<svg width="20" height="20" viewBox="0 0 20 20" fill="none"
						 xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 relative"
						 preserveAspectRatio="none">
						<path fill-rule="evenodd"
							  clip-rule="evenodd"
							  d="M10 3.74999C6.54822 3.74999 3.75 6.54821 3.75 9.99999C3.75 13.4518 6.54822 16.25 10 16.25C13.4518 16.25 16.25 13.4518 16.25 9.99999C16.25 9.0682 16.0465 8.18565 15.6821 7.39291C15.538 7.07928 15.6753 6.70817 15.989 6.564C16.3026 6.41984 16.6737 6.55723 16.8179 6.87086C17.256 7.82403 17.5 8.88437 17.5 9.99999C17.5 14.1421 14.1421 17.5 10 17.5C5.85786 17.5 2.5 14.1421 2.5 9.99999C2.5 5.85786 5.85786 2.49999 10 2.49999V3.74999Z"
							  fill="black"></path>
						<path
								d="M10 5.58279V0.667193C10 0.402244 10.309 0.257507 10.5126 0.427123L13.4619 2.88492C13.6118 3.00986 13.6118 3.24013 13.4619 3.36506L10.5126 5.82286C10.309 5.99248 10 5.84774 10 5.58279Z"
								fill="black"></path>
					</svg>
				</button>
			</li>
		</ul>
	</div>
	<div class="modal fade" id="productUpdate" data-bs-backdrop="static"
		 data-bs-keyboard="false" tabindex="-1"
		 aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<form action="${cpath}/admin/addProduct" method="POST" enctype="multipart/form-data">
					<div class="modal-header">
						<h3 class="modal-title">상품등록</h3>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
					</div>
					<div class="modal-body container">
						<div class="row justify-content-center align-items-center mb-3">
							<div class="col-6 text-center">
								<img id="preview" class="img-thumbnail mb-2"
									 src="../img/nuguri.webp" alt="예시 이미지"
									 style="max-width: 200px; max-height: 200px;">
								<input class="form-control form-control-sm" id="image" name="upload" accept="image/*" type="file" required>
							</div>
						</div>
						<table class="table table-borderless">
							<tbody>
							<tr>
								<th>상품명</th>
								<td>
									<input class="form-control" type="text" name="name" placeholder="Default input" aria-label="default input example" required>
								</td>
								<th>상품분류</th>
								<td>
									<select class="form-select"
											aria-label="Default select example" name="productCategoryId" required>
										<option selected>분류에 없는 것은 등록해서 사용</option>
										<c:forEach var="categoryDTO" items="${productCategoryList}">
											<option value="${categoryDTO.id}">${categoryDTO.name}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>상품가격</th>
								<td>
									<input class="form-control" type="number" name="price" placeholder="1,000" aria-label="default input example" required>
								</td>
								<th>상품수량</th>
								<td>
									<input class="form-control" type="number" name="count" placeholder="1" aria-label="default input example" required>
								</td>
							</tr>
							<tr>
								<th colspan="2">제품설명</th>
								<th>할인율</th>
								<td>
									<input class="form-control" type="number" name="dcRate" placeholder="%" aria-label="default input example" required>
								</td>
							</tr>
							<tr>
								<td colspan="4" rowspan="4" class="form-floating">
									<textarea class="form-control" name="detail" placeholder="Leave a comment here" id="floatingTextarea" style="height: 90px;" required></textarea>
									<label for="floatingTextarea">Comments</label>
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary"  data-bs-dismiss="modal">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="modal fade" id="categoryUpdate" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<form action="${cpath}/admin/addProductCategory" method="POST" enctype="multipart/form-data">
					<div class="modal-header">
						<h3 class="modal-title">카테고리등록</h3>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body container">
						<table class="table table-borderless">
							<tbody>
							<tr>
								<th>카테고리이름</th>
								<td>
									<input class="form-control" type="text" name="name" placeholder="카테고리 이름" required aria-label="default input example">
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary" data-bs-dismiss="modal">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</nav>
<div class="container pt-4">
	<form class="d-flex" action="${cpath}/admin/product" method="get">
		<div class="mb-3 pe-2" style="width: 150px;">
			<select class="form-select" name="category" aria-label="Default select example">
				<option selected value="all">전체</option>
				<option value="id">상품번호</option>
				<option value="name">상품명</option>
				<option value="productCategoryName">상품분류</option>
			</select>
		</div>
		<div class="mb-3 pe-2">
			<input type="text" class="form-control" name="keyword" id="searchName">
		</div>
		<div>
			<button type="submit" class="btn btn-secondary">검색</button>
		</div>
	</form>
</div>
<div class="container">
	<table class="table table-hover">
		<thead>
		<tr class="table-dark text-center">
<%--			<th scope="col">#</th>--%>
			<th scope="col">상품번호</th>
			<th scope="col">상품명</th>
			<th scope="col">상품분류</th>
			<th scope="col">가격</th>
			<th scope="col">현재재고</th>
			<th scope="col">금일 판매갯수</th>
			<th scope="col">상세보기</th>
			<th scope="col">삭제</th>
		</tr>
		</thead>
		<script>
			let products = [];
		</script>
		<tbody>
		<c:forEach var="dto" items="${productList}" varStatus="status">
			<tr class="text-center">
				<td class="pt-3">${dto.id}</td>
				<td class="pt-3">${dto.name}</td>
				<td class="pt-3">${dto.productCategoryName}</td>
				<td class="pt-3">${dto.price}원</td>
				<td class="pt-3">${dto.count}</td>
				<td class="pt-3">금일 판매갯수</td>
				<td>
					<button id="view_product_${status.index}" type="button" name="${dto.id}" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#detail_check_modal">조회</button>
				</td>
				<td>
					<a href="${cpath}/admin/deleteProduct/${dto.id}">
						<button type="button" class="btn btn-outline-danger">삭제</button>
					</a>
				</td>
			</tr>
			<script>
				products.push(${dto.id});
			</script>
		</c:forEach>
		</tbody>
	</table>

	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<li class="page-item">
				<a class="page-link" href="#" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				</a>
			</li>

			<li class="page-item">
				<a class="page-link" href="#" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		</ul>
	</nav>

	<div class="modal fade" id="detail_check_modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">상세조회</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
                <form id="product_update" method="POST" enctype="multipart/form-data">
				<div class="modal-body">
					<div class="row">
						<div class="col-6 text-center">
							<img id="productImg" class="img-thumbnail mb-2"
								 src="" alt="예시 이미지"
								 style="max-width: 200px; max-height: 200px;">
							<input class="form-control form-control-sm" id="updateImg" name="upload" accept="image/*" type="file" required>
						</div>
						<div class="col-6">
							<table class="table table-borderless">
								<tbody>
								<tr>
									<th>상품번호</th>
									<td><input id="productId" class="form-control form-control-sm"
											   type="text" placeholder="" name="id"
											   aria-label="default input example" readonly></td>
								</tr>
								<tr>
									<th>상품명</th>
									<td><input id="productName" class="form-control form-control-sm"
											   type="text" name="name"
											   aria-label="default input example"></td>
								</tr>
								<tr>
									<th>상품분류</th>
									<td><input id="productCategory" class="form-control form-control-sm"
											   type="text" placeholder="Default input"
											   aria-label="default input example" readonly></td>
								</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-6">
							<table class="table table-borderless">
								<tbody>
								<tr>
									<th>가격</th>
									<td><input id="productPrice" class="form-control form-control-sm"
											   type="text" name="price"
											   aria-label="default input example"></td>
								</tr>
								<tr>
									<th>할인율</th>
									<td><input id="productDcrate" class="form-control form-control-sm"
											   type="text" name="dcRate"
											   aria-label="default input example"></td>
								</tr>
								</tbody>
							</table>
						</div>
						<div class="col-6">
							<table class="table table-borderless">
								<tbody>
								<tr>
									<th>현재재고</th>
									<td><input id="productCount" class="form-control form-control-sm"
											   type="text" name="count"
											   aria-label="default input example"></td>
								</tr>
								<tr>
									<th>금일 판매갯수</th>
									<td><input id="productSales" class="form-control form-control-sm"
											   type="text" placeholder="Default input"
											   aria-label="default input example"></td>
								</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row px-2">
						<table class="table table-borderless">
							<tbody>
							<tr>
								<th>제품상세</th>
								<th></th>
							</tr>
							<tr>
								<td colspan="2" rowspan="2" class="form-floating">
									<textarea class="form-control" placeholder="Leave a comment here" id="productDetail" name="detail" style="height: 90px;"></textarea>
									<label for="floatingTextarea">Comments</label>
								</td>
							</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-danger"
                            data-bs-dismiss="modal">수정</button>
				</div>
                </form>
			</div>
		</div>
	</div>
</div>
<script>
	var popoverTriggerList = [].slice.call(document
			.querySelectorAll('[data-bs-toggle="popover"]'))
	var popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
		return new bootstrap.Popover(popoverTriggerEl)
	})


	var imageInput = document.getElementById('image');
	imageInput.addEventListener('change', previewImage);

	function previewImage(event) {
		var input = event.target;
		var preview = document.getElementById('preview');

		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function() {
				preview.src = reader.result;
			};

			reader.readAsDataURL(input.files[0]);
		}
	}
</script>
<script>

	async function openView(id) {
		let url = '/admin/viewProduct/' + id;
		console.log(`Fetching: ` + url); // 요청을 보내는 URL 로그
		return await fetch(url)
				.then(response => {
					console.log(`Received response: ` + JSON.stringify(response)); // 받아온 응답 로그
					return response.json();
				})
				.then(productData => {
					console.log(`Received data: ` + JSON.stringify(productData)); // 받아온 데이터 로그
					return productData;
				});
	}

	products.forEach((product, index) => {
		const viewProduct = document.getElementById('view_product_' + index);
		viewProduct.addEventListener('click', async e => {
			let id = e.target.name;

			// dto가 담겨있는 객체
			const productData = await openView(id);

            const updateForm = document.getElementById('product_update');
            updateForm.action = '${cpath}/admin/updateProduct/' + productData.id;

			console.log(productData.name);
			const productImg = document.getElementById('productImg');
			productImg.src = '/upload/' + productData.img;
			const productId = document.getElementById('productId');
			productId.value = productData.id;
			const productName = document.getElementById('productName');
			productName.value = productData.name;
			const productCategory = document.getElementById('productCategory');
			productCategory.value = productData.productCategoryName;
			const productPrice = document.getElementById('productPrice');
			productPrice.value = productData.price;
			const productDcrate = document.getElementById('productDcrate');
			productDcrate.value = productData.dcRate;
			const productCount = document.getElementById('productCount');
			productCount.value = productData.count;
			const productSales = document.getElementById('productSales');
			productSales.value = 1;
			const productDetail = document.getElementById('productDetail');
			productDetail.value = productData.detail;
		});
	});

</script>
</body>
</html>