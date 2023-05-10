<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/colleage.css" />
<div id="colleage_editDiv">
	<form id="colleageEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学院id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="colleage_collleageId_edit" name="colleage.collleageId" value="<%=request.getParameter("collleageId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">学院名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="colleage_colleageName_edit" name="colleage.colleageName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">学院备注:</span>
			<span class="inputControl">
				<textarea id="colleage_colleageMemo_edit" name="colleage.colleageMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="colleageModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Colleage/js/colleage_modify.js"></script> 
