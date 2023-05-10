<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jxjType.css" />
<div id="jxjTypeAddDiv">
	<form id="jxjTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxjType_typeName" name="jxjType.typeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">奖学金金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxjType_jxjMoney" name="jxjType.jxjMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">评定标准:</span>
			<span class="inputControl">
				<textarea id="jxjType_pdbz" name="jxjType.pdbz" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">添加时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxjType_addTime" name="jxjType.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="jxjTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="jxjTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/JxjType/js/jxjType_add.js"></script> 
