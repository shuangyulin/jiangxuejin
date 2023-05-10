<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/termInfo.css" />
<div id="termInfoAddDiv">
	<form id="termInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学期名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="termInfo_termName" name="termInfo.termName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="termInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="termInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/TermInfo/js/termInfo_add.js"></script> 
