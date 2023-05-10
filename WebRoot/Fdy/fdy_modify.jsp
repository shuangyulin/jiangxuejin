<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/fdy.css" />
<div id="fdy_editDiv">
	<form id="fdyEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">辅导员账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_fdyUserName_edit" name="fdy.fdyUserName" value="<%=request.getParameter("fdyUserName") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_password_edit" name="fdy.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_name_edit" name="fdy.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_gender_edit" name="fdy.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_birthDate_edit" name="fdy.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_telephone_edit" name="fdy.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">邮箱:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fdy_email_edit" name="fdy.email" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">辅导员备注:</span>
			<span class="inputControl">
				<textarea id="fdy_fdyMemo_edit" name="fdy.fdyMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="fdyModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Fdy/js/fdy_modify.js"></script> 
