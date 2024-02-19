<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="box-header">
	<h4 class="box-title">시설 이용 목록/예약</h4>  
</div>
    
 <div class="container-full">
   <section class="content">   
    <!-- 시설목록/ 건물/시설 -->

<div class="row">
	<div class="card h-p100 col-5">
		<img style="padding-top: 10px;" class="card-img-top" src="${pageContext.request.contextPath }/resources/images/gallery/thumb/4.jpg" alt="card image cap">
		<div class="card-body">
		  <h4 class="card-title b-0 px-0">건물/시설 목록</h4>
		</div>

	</div>


<div class="col-6">
	<div class="box-body">
		<h4 class="box-title">건물/시설 목록</h4>
		<div id="productorder_filter col-6" class="dataTables_filter">
			<label>
				<input type="search" class="form-control form-control-sm" placeholder="Search">
				
			</label>
		</div>
		<h6 class="box-subtitle mb-20"></h6>
		<div class="table-responsive">
			<table class="table">
				<!-- 
				<thead class="bg-inverse">
					<tr>
						<th>#</th>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Username</th>
					</tr>
				</thead> 
				-->
				<tbody>
					<tr>
						<td>A건물</td>
						<td>B건물</td>
						<td>C건물</td>
						<td>D건물</td>
					</tr>
					<tr>
						<td>공과대건물</td>
						<td>미대건물</td>
						<td>경영학건물</td>
						<td>아...</td>
					</tr>
					<tr>
						<td>BBQ</td>
						<td>굽네</td>
						<td>교촌</td>
						<td>BHC</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					
				</tbody>
				
			</table>
			
<div class="box">
	<div class="box-body">
		<h4 class="box-title">선택 목록</h4>
		<h6 class="box-subtitle mb-20"> </h6>
		<div class="table-responsive">
			<table class="table">
				
			<thead class="bg-primary">
					<tr>
						<th>건물</th>
						<th>시설</th>
						<th>날짜/시간</th>
						<th>신청</th>
					</tr>
				</thead> 
	
				<tbody>
					<tr>
						<td>A건물</td>
						<td>시설</td>
						<td>Eichmann</td>
						<td>
							 <button type="submit" class="btn btn-success pull-right">신청</button>
						</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
	
				</tbody>
			</table>
			<div class="box-footer">
				<button type="submit" class="btn btn-danger">목록</button>
			</div>
		</div>
	</div>
</div>			
		</div>
	</div>
</div>	
	
</div>    
</section>
</div>
    
    
   
    
    
    
