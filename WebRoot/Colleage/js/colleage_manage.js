var colleage_manage_tool = null; 
$(function () { 
	initColleageManageTool(); //建立Colleage管理对象
	colleage_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#colleage_manage").datagrid({
		url : 'Colleage/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "collleageId",
		sortOrder : "desc",
		toolbar : "#colleage_manage_tool",
		columns : [[
			{
				field : "collleageId",
				title : "学院id",
				width : 70,
			},
			{
				field : "colleageName",
				title : "学院名称",
				width : 140,
			},
		]],
	});

	$("#colleageEditDiv").dialog({
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
				if ($("#colleageEditForm").form("validate")) {
					//验证表单 
					if(!$("#colleageEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#colleageEditForm").form({
						    url:"Colleage/" + $("#colleage_collleageId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#colleageEditForm").form("validate"))  {
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
			                        $("#colleageEditDiv").dialog("close");
			                        colleage_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#colleageEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#colleageEditDiv").dialog("close");
				$("#colleageEditForm").form("reset"); 
			},
		}],
	});
});

function initColleageManageTool() {
	colleage_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#colleage_manage").datagrid("reload");
		},
		redo : function () {
			$("#colleage_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#colleage_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#colleageQueryForm").form({
			    url:"Colleage/OutToExcel",
			});
			//提交表单
			$("#colleageQueryForm").submit();
		},
		remove : function () {
			var rows = $("#colleage_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var collleageIds = [];
						for (var i = 0; i < rows.length; i ++) {
							collleageIds.push(rows[i].collleageId);
						}
						$.ajax({
							type : "POST",
							url : "Colleage/deletes",
							data : {
								collleageIds : collleageIds.join(","),
							},
							beforeSend : function () {
								$("#colleage_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#colleage_manage").datagrid("loaded");
									$("#colleage_manage").datagrid("load");
									$("#colleage_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#colleage_manage").datagrid("loaded");
									$("#colleage_manage").datagrid("load");
									$("#colleage_manage").datagrid("unselectAll");
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
			var rows = $("#colleage_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Colleage/" + rows[0].collleageId +  "/update",
					type : "get",
					data : {
						//collleageId : rows[0].collleageId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (colleage, response, status) {
						$.messager.progress("close");
						if (colleage) { 
							$("#colleageEditDiv").dialog("open");
							$("#colleage_collleageId_edit").val(colleage.collleageId);
							$("#colleage_collleageId_edit").validatebox({
								required : true,
								missingMessage : "请输入学院id",
								editable: false
							});
							$("#colleage_colleageName_edit").val(colleage.colleageName);
							$("#colleage_colleageName_edit").validatebox({
								required : true,
								missingMessage : "请输入学院名称",
							});
							$("#colleage_colleageMemo_edit").val(colleage.colleageMemo);
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
