var jxj_manage_tool = null; 
$(function () { 
	initJxjManageTool(); //建立Jxj管理对象
	jxj_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#jxj_manage").datagrid({
		url : 'Jxj/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "jxjId",
		sortOrder : "desc",
		toolbar : "#jxj_manage_tool",
		columns : [[
			{
				field : "jxjId",
				title : "记录id",
				width : 70,
			},
			{
				field : "jxjTypeObj",
				title : "奖学金类型",
				width : 140,
			},
			{
				field : "title",
				title : "申请标题",
				width : 140,
			},
			{
				field : "content",
				title : "申请描述",
				width : 140,
			},
			{
				field : "sqcl",
				title : "申请材料",
				width : "350px",
				formatter: function(val,row) {
 					if(val == "") return "暂无文件";
					return "<a href='" + val + "' target='_blank' style='color:red;'>" + val + "</a>";
				}
 			},
			{
				field : "userObj",
				title : "申请学生",
				width : 140,
			},
			{
				field : "fdyState",
				title : "辅导员审核状态",
				width : 140,
			},
			{
				field : "fdyUserName",
				title : "审核的辅导员",
				width : 140,
			},
			{
				field : "glState",
				title : "管理员审核状态",
				width : 140,
			},
			{
				field : "glResult",
				title : "管理员审核结果",
				width : 140,
			},
		]],
	});

	$("#jxjEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#jxjEditForm").form("validate")) {
					//验证表单 
					if(!$("#jxjEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#jxjEditForm").form({
						    url:"Jxj/" + $("#jxj_jxjId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#jxjEditForm").form("validate"))  {
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
			                        $("#jxjEditDiv").dialog("close");
			                        jxj_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#jxjEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#jxjEditDiv").dialog("close");
				$("#jxjEditForm").form("reset"); 
			},
		}],
	});
});

function initJxjManageTool() {
	jxj_manage_tool = {
		init: function() {
			$.ajax({
				url : "JxjType/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#jxjTypeObj_typeId_query").combobox({ 
					    valueField:"typeId",
					    textField:"typeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{typeId:0,typeName:"不限制"});
					$("#jxjTypeObj_typeId_query").combobox("loadData",data); 
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
		},
		reload : function () {
			$("#jxj_manage").datagrid("reload");
		},
		redo : function () {
			$("#jxj_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#jxj_manage").datagrid("options").queryParams;
			queryParams["jxjTypeObj.typeId"] = $("#jxjTypeObj_typeId_query").combobox("getValue");
			queryParams["title"] = $("#title").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["fdyState"] = $("#fdyState").val();
			queryParams["fdyUserName"] = $("#fdyUserName").val();
			queryParams["glState"] = $("#glState").val();
			$("#jxj_manage").datagrid("options").queryParams=queryParams; 
			$("#jxj_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#jxjQueryForm").form({
			    url:"Jxj/OutToExcel",
			});
			//提交表单
			$("#jxjQueryForm").submit();
		},
		remove : function () {
			var rows = $("#jxj_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var jxjIds = [];
						for (var i = 0; i < rows.length; i ++) {
							jxjIds.push(rows[i].jxjId);
						}
						$.ajax({
							type : "POST",
							url : "Jxj/deletes",
							data : {
								jxjIds : jxjIds.join(","),
							},
							beforeSend : function () {
								$("#jxj_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#jxj_manage").datagrid("loaded");
									$("#jxj_manage").datagrid("load");
									$("#jxj_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#jxj_manage").datagrid("loaded");
									$("#jxj_manage").datagrid("load");
									$("#jxj_manage").datagrid("unselectAll");
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
			var rows = $("#jxj_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Jxj/" + rows[0].jxjId +  "/update",
					type : "get",
					data : {
						//jxjId : rows[0].jxjId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (jxj, response, status) {
						$.messager.progress("close");
						if (jxj) { 
							$("#jxjEditDiv").dialog("open");
							$("#jxj_jxjId_edit").val(jxj.jxjId);
							$("#jxj_jxjId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录id",
								editable: false
							});
							$("#jxj_jxjTypeObj_typeId_edit").combobox({
								url:"JxjType/listAll",
							    valueField:"typeId",
							    textField:"typeName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#jxj_jxjTypeObj_typeId_edit").combobox("select", jxj.jxjTypeObjPri);
									//var data = $("#jxj_jxjTypeObj_typeId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#jxj_jxjTypeObj_typeId_edit").combobox("select", data[0].typeId);
						            //}
								}
							});
							$("#jxj_title_edit").val(jxj.title);
							$("#jxj_title_edit").validatebox({
								required : true,
								missingMessage : "请输入申请标题",
							});
							$("#jxj_content_edit").val(jxj.content);
							$("#jxj_content_edit").validatebox({
								required : true,
								missingMessage : "请输入申请描述",
							});
							$("#jxj_sqcl").val(jxj.sqcl);
							if(jxj.sqcl == "") $("#jxj_sqclA").html("暂无文件");
							else $("#jxj_sqclA").html(jxj.sqcl);
							$("#jxj_sqclA").attr("href", jxj.sqcl);
							$("#jxj_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#jxj_userObj_user_name_edit").combobox("select", jxj.userObjPri);
									//var data = $("#jxj_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#jxj_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#jxj_fdyState_edit").val(jxj.fdyState);
							$("#jxj_fdyState_edit").validatebox({
								required : true,
								missingMessage : "请输入辅导员审核状态",
							});
							$("#jxj_fdyUserName_edit").val(jxj.fdyUserName);
							$("#jxj_fdyUserName_edit").validatebox({
								required : true,
								missingMessage : "请输入审核的辅导员",
							});
							$("#jxj_glState_edit").val(jxj.glState);
							$("#jxj_glState_edit").validatebox({
								required : true,
								missingMessage : "请输入管理员审核状态",
							});
							$("#jxj_glResult_edit").val(jxj.glResult);
							$("#jxj_glResult_edit").validatebox({
								required : true,
								missingMessage : "请输入管理员审核结果",
							});
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
