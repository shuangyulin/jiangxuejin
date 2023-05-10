<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/family.css" />
<div id="family_editDiv">
	<form id="familyEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="family_familyId_edit" name="family.familyId" value="<%=request.getParameter("familyId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="family_userObj_user_name_edit" name="family.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">家庭情况:</span>
			<span class="inputControl">
				<script id="family_familyDesc_edit" name="family.familyDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">更新时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="family_updateTime_edit" name="family.updateTime" />

			</span>

		</div>
		<div class="operation">
			<a id="familyModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Family/js/family_modify.js"></script> 
