<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jxj.css" />
<div id="jxj_editDiv">
	<form id="jxjEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxj_jxjId_edit" name="jxj.jxjId" value="<%=request.getParameter("jxjId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="jxjModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Jxj/js/jxj_modify.js"></script> 
