<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jxjType.css" /> 

<div id="jxjType_manage"></div>
<div id="jxjType_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="jxjType_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="jxjType_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="jxjType_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="jxjType_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="jxjType_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="jxjTypeQueryForm" method="post">
			添加时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="jxjType_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="jxjTypeEditDiv">
	<form id="jxjTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxjType_typeId_edit" name="jxjType.typeId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="JxjType/js/jxjType_manage.js"></script> 
