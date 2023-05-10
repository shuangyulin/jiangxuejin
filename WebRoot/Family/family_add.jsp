<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/family.css" />
<div id="familyAddDiv">
	<form id="familyAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="family_userObj_user_name" name="family.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">家庭情况:</span>
			<span class="inputControl">
				<script name="family.familyDesc" id="family_familyDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">更新时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="family_updateTime" name="family.updateTime" />

			</span>

		</div>
		<div class="operation">
			<a id="familyAddButton" class="easyui-linkbutton">添加</a>
			<a id="familyClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Family/js/family_add.js"></script> 
