var score_manage_tool = null; 
$(function () { 
	initScoreManageTool(); //建立Score管理对象
	score_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#score_manage").datagrid({
		url : 'Score/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "scoreId",
		sortOrder : "desc",
		toolbar : "#score_manage_tool",
		columns : [[
			{
				field : "scoreId",
				title : "成绩id",
				width : 70,
			},
			{
				field : "termObj",
				title : "所在学期",
				width : 140,
			},
			{
				field : "userObj",
				title : "学生",
				width : 140,
			},
			{
				field : "colleageObj",
				title : "所在学院",
				width : 140,
			},
			{
				field : "zhcj",
				title : "综合成绩",
				width : 70,
			},
		]],
	});

	$("#scoreEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#scoreEditForm").form("validate")) {
					//验证表单 
					if(!$("#scoreEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#scoreEditForm").form({
						    url:"Score/" + $("#score_scoreId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#scoreEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#scoreEditDiv").dialog("close");
			                        score_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#scoreEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#scoreEditDiv").dialog("close");
				$("#scoreEditForm").form("reset"); 
			},
		}],
	});
});

function initScoreManageTool() {
	score_manage_tool = {
		init: function() {
			$.ajax({
				url : "TermInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#termObj_termId_query").combobox({ 
					    valueField:"termId",
					    textField:"termName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{termId:0,termName:"不限制"});
					$("#termObj_termId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "Colleage/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#colleageObj_collleageId_query").combobox({ 
					    valueField:"collleageId",
					    textField:"colleageName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{collleageId:0,colleageName:"不限制"});
					$("#colleageObj_collleageId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#score_manage").datagrid("reload");
		},
		redo : function () {
			$("#score_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#score_manage").datagrid("options").queryParams;
			queryParams["termObj.termId"] = $("#termObj_termId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["colleageObj.collleageId"] = $("#colleageObj_collleageId_query").combobox("getValue");
			$("#score_manage").datagrid("options").queryParams=queryParams; 
			$("#score_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#scoreQueryForm").form({
			    url:"Score/OutToExcel",
			});
			//提交表单
			$("#scoreQueryForm").submit();
		},
		remove : function () {
			var rows = $("#score_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var scoreIds = [];
						for (var i = 0; i < rows.length; i ++) {
							scoreIds.push(rows[i].scoreId);
						}
						$.ajax({
							type : "POST",
							url : "Score/deletes",
							data : {
								scoreIds : scoreIds.join(","),
							},
							beforeSend : function () {
								$("#score_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#score_manage").datagrid("loaded");
									$("#score_manage").datagrid("load");
									$("#score_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#score_manage").datagrid("loaded");
									$("#score_manage").datagrid("load");
									$("#score_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#score_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Score/" + rows[0].scoreId +  "/update",
					type : "get",
					data : {
						//scoreId : rows[0].scoreId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (score, response, status) {
						$.messager.progress("close");
						if (score) { 
							$("#scoreEditDiv").dialog("open");
							$("#score_scoreId_edit").val(score.scoreId);
							$("#score_scoreId_edit").validatebox({
								required : true,
								missingMessage : "请输入成绩id",
								editable: false
							});
							$("#score_termObj_termId_edit").combobox({
								url:"TermInfo/listAll",
							    valueField:"termId",
							    textField:"termName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#score_termObj_termId_edit").combobox("select", score.termObjPri);
									//var data = $("#score_termObj_termId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#score_termObj_termId_edit").combobox("select", data[0].termId);
						            //}
								}
							});
							$("#score_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#score_userObj_user_name_edit").combobox("select", score.userObjPri);
									//var data = $("#score_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#score_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#score_colleageObj_collleageId_edit").combobox({
								url:"Colleage/listAll",
							    valueField:"collleageId",
							    textField:"colleageName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#score_colleageObj_collleageId_edit").combobox("select", score.colleageObjPri);
									//var data = $("#score_colleageObj_collleageId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#score_colleageObj_collleageId_edit").combobox("select", data[0].collleageId);
						            //}
								}
							});
							$("#score_zhcj_edit").val(score.zhcj);
							$("#score_zhcj_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入综合成绩",
								invalidMessage : "综合成绩输入不对",
							});
							score_scoreDesc_editor.setContent(score.scoreDesc, false);
							$("#score_scoreMemo_edit").val(score.scoreMemo);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
