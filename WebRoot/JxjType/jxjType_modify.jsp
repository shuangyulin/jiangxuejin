<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jxjType.css" />
<div id="jxjType_editDiv">
	<form id="jxjTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxjType_typeId_edit" name="jxjType.typeId" value="<%=request.getParameter("typeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxjType_typeName_edit" name="jxjType.typeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">奖学金金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxjType_jxjMoney_edit" name="jxjType.jxjMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">评定标准:</span>
			<span class="inputControl">
				<textarea id="jxjType_pdbz_edit" name="jxjType.pdbz" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">添加时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxjType_addTime_edit" name="jxjType.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="jxjTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/JxjType/js/jxjType_modify.js"></script> 
