<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/colleage.css" />
<div id="colleageAddDiv">
	<form id="colleageAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学院名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="colleage_colleageName" name="colleage.colleageName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">学院备注:</span>
			<span class="inputControl">
				<textarea id="colleage_colleageMemo" name="colleage.colleageMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="colleageAddButton" class="easyui-linkbutton">添加</a>
			<a id="colleageClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Colleage/js/colleage_add.js"></script> 
