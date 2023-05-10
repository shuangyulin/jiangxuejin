<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jxj.css" />
<div id="jxjAddDiv">
	<form id="jxjAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">奖学金类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxj_jxjTypeObj_typeId" name="jxj.jxjTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">申请标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxj_title" name="jxj.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">申请描述:</span>
			<span class="inputControl">
				<textarea id="jxj_content" name="jxj.content" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">申请材料:</span>
			<span class="inputControl">
				<input id="sqclFile" name="sqclFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">申请学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxj_userObj_user_name" name="jxj.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">辅导员审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxj_fdyState" name="jxj.fdyState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">审核的辅导员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxj_fdyUserName" name="jxj.fdyUserName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">管理员审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jxj_glState" name="jxj.glState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">管理员审核结果:</span>
			<span class="inputControl">
				<textarea id="jxj_glResult" name="jxj.glResult" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="jxjAddButton" class="easyui-linkbutton">添加</a>
			<a id="jxjClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Jxj/js/jxj_add.js"></script> 
