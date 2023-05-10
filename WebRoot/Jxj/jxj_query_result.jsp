<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jxj.css" /> 

<div id="jxj_manage"></div>
<div id="jxj_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="jxj_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="jxj_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="jxj_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="jxj_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="jxj_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="jxjQueryForm" method="post">
			奖学金类型：<input class="textbox" type="text" id="jxjTypeObj_typeId_query" name="jxjTypeObj.typeId" style="width: auto"/>
			申请标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			申请学生：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			辅导员审核状态：<input type="text" class="textbox" id="fdyState" name="fdyState" style="width:110px" />
			审核的辅导员：<input type="text" class="textbox" id="fdyUserName" name="fdyUserName" style="width:110px" />
			管理员审核状态：<input type="text" class="textbox" id="glState" name="glState" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="jxj_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="jxjEditDiv">
	<form id="jxjEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxj_jxjId_edit" name="jxj.jxjId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">奖学金类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="jxj_jxjTypeObj_typeId_edit" name="jxj.jxjTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">申请标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxj_title_edit" name="jxj.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">申请描述:</span>
			<span class="inputControl">
				<textarea id="jxj_content_edit" name="jxj.content" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">申请材料:</span>
			<span class="inputControl">
				<a id="jxj_sqclA" style="color:red;margin-bottom:5px;">查看</a>&nbsp;&nbsp;
    			<input type="hidden" id="jxj_sqcl" name="jxj.sqcl"/>
				<input id="sqclFile" name="sqclFile" value="重新选择文件" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">申请学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="jxj_userObj_user_name_edit" name="jxj.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">辅导员审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxj_fdyState_edit" name="jxj.fdyState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">审核的辅导员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxj_fdyUserName_edit" name="jxj.fdyUserName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">管理员审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxj_glState_edit" name="jxj.glState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">管理员审核结果:</span>
			<span class="inputControl">
				<textarea id="jxj_glResult_edit" name="jxj.glResult" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Jxj/js/jxj_manage.js"></script> 
