<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/family.css" /> 

<div id="family_manage"></div>
<div id="family_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="family_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="family_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="family_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="family_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="family_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="familyQueryForm" method="post">
			学生：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			更新时间：<input type="text" id="updateTime" name="updateTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="family_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="familyEditDiv">
	<form id="familyEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="family_familyId_edit" name="family.familyId" style="width:200px" />
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
				<script name="family.familyDesc" id="family_familyDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">更新时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="family_updateTime_edit" name="family.updateTime" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var family_familyDesc_editor = UE.getEditor('family_familyDesc_edit'); //家庭情况编辑器
</script>
<script type="text/javascript" src="Family/js/family_manage.js"></script> 
