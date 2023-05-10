<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/termInfo.css" />
<div id="termInfo_editDiv">
	<form id="termInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学期id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="termInfo_termId_edit" name="termInfo.termId" value="<%=request.getParameter("termId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">学期名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="termInfo_termName_edit" name="termInfo.termName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="termInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/TermInfo/js/termInfo_modify.js"></script> 
