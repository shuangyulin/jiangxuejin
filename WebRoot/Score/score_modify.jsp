<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/score.css" />
<div id="score_editDiv">
	<form id="scoreEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">成绩id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_scoreId_edit" name="score.scoreId" value="<%=request.getParameter("scoreId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">所在学期:</span>
			<span class="inputControl">
				<input class="textbox"  id="score_termObj_termId_edit" name="score.termObj.termId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="score_userObj_user_name_edit" name="score.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">所在学院:</span>
			<span class="inputControl">
				<input class="textbox"  id="score_colleageObj_collleageId_edit" name="score.colleageObj.collleageId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">综合成绩:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="score_zhcj_edit" name="score.zhcj" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">详细成绩:</span>
			<span class="inputControl">
				<script id="score_scoreDesc_edit" name="score.scoreDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">成绩备注:</span>
			<span class="inputControl">
				<textarea id="score_scoreMemo_edit" name="score.scoreMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="scoreModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Score/js/score_modify.js"></script> 
