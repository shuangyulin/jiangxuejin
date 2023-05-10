var fdy_manage_tool = null; 
$(function () { 
	initFdyManageTool(); //建立Fdy管理对象
	fdy_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#fdy_manage").datagrid({
		url : 'Fdy/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "fdyUserName",
		sortOrder : "desc",
		toolbar : "#fdy_manage_tool",
		columns : [[
			{
				field : "fdyUserName",
				title : "辅导员账号",
				width : 140,
			},
			{
				field : "name",
				title : "姓名",
				width : 140,
			},
			{
				field : "gender",
				title : "性别",
				width : 140,
			},
			{
				field : "birthDate",
				title : "出生日期",
				width : 140,
			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
			{
				field : "email",
				title : "邮箱",
				width : 140,
			},
		]],
	});

	$("#fdyEditDiv").dialog({
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
				if ($("#fdyEditForm").form("validate")) {
					//验证表单 
					if(!$("#fdyEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#fdyEditForm").form({
						    url:"Fdy/" + $("#fdy_fdyUserName_edit").val() + "/update",
						    onSubmit: function(){
								if($("#fdyEditForm").form("validate"))  {
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
			                        $("#fdyEditDiv").dialog("close");
			                        fdy_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#fdyEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#fdyEditDiv").dialog("close");
				$("#fdyEditForm").form("reset"); 
			},
		}],
	});
});

function initFdyManageTool() {
	fdy_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#fdy_manage").datagrid("reload");
		},
		redo : function () {
			$("#fdy_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#fdy_manage").datagrid("options").queryParams;
			queryParams["fdyUserName"] = $("#fdyUserName").val();
			queryParams["name"] = $("#name").val();
			queryParams["birthDate"] = $("#birthDate").datebox("getValue"); 
			queryParams["telephone"] = $("#telephone").val();
			$("#fdy_manage").datagrid("options").queryParams=queryParams; 
			$("#fdy_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#fdyQueryForm").form({
			    url:"Fdy/OutToExcel",
			});
			//提交表单
			$("#fdyQueryForm").submit();
		},
		remove : function () {
			var rows = $("#fdy_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var fdyUserNames = [];
						for (var i = 0; i < rows.length; i ++) {
							fdyUserNames.push(rows[i].fdyUserName);
						}
						$.ajax({
							type : "POST",
							url : "Fdy/deletes",
							data : {
								fdyUserNames : fdyUserNames.join(","),
							},
							beforeSend : function () {
								$("#fdy_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#fdy_manage").datagrid("loaded");
									$("#fdy_manage").datagrid("load");
									$("#fdy_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#fdy_manage").datagrid("loaded");
									$("#fdy_manage").datagrid("load");
									$("#fdy_manage").datagrid("unselectAll");
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
			var rows = $("#fdy_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Fdy/" + rows[0].fdyUserName +  "/update",
					type : "get",
					data : {
						//fdyUserName : rows[0].fdyUserName,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (fdy, response, status) {
						$.messager.progress("close");
						if (fdy) { 
							$("#fdyEditDiv").dialog("open");
							$("#fdy_fdyUserName_edit").val(fdy.fdyUserName);
							$("#fdy_fdyUserName_edit").validatebox({
								required : true,
								missingMessage : "请输入辅导员账号",
								editable: false
							});
							$("#fdy_password_edit").val(fdy.password);
							$("#fdy_password_edit").validatebox({
								required : true,
								missingMessage : "请输入登录密码",
							});
							$("#fdy_name_edit").val(fdy.name);
							$("#fdy_name_edit").validatebox({
								required : true,
								missingMessage : "请输入姓名",
							});
							$("#fdy_gender_edit").val(fdy.gender);
							$("#fdy_gender_edit").validatebox({
								required : true,
								missingMessage : "请输入性别",
							});
							$("#fdy_birthDate_edit").datebox({
								value: fdy.birthDate,
							    required: true,
							    showSeconds: true,
							});
							$("#fdy_telephone_edit").val(fdy.telephone);
							$("#fdy_telephone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
							});
							$("#fdy_email_edit").val(fdy.email);
							$("#fdy_email_edit").validatebox({
								required : true,
								missingMessage : "请输入邮箱",
							});
							$("#fdy_fdyMemo_edit").val(fdy.fdyMemo);
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
