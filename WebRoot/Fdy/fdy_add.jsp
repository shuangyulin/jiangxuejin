<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/fdy.css" />
<div id="fdyAddDiv">
	<form id="fdyAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">辅导员账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_fdyUserName" name="fdy.fdyUserName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_password" name="fdy.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_name" name="fdy.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_gender" name="fdy.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_birthDate" name="fdy.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_telephone" name="fdy.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">邮箱:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_email" name="fdy.email" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">辅导员备注:</span>
			<span class="inputControl">
				<textarea id="fdy_fdyMemo" name="fdy.fdyMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="fdyAddButton" class="easyui-linkbutton">添加</a>
			<a id="fdyClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Fdy/js/fdy_add.js"></script> 
