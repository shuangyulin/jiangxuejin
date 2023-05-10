var termInfo_manage_tool = null; 
$(function () { 
	initTermInfoManageTool(); //建立TermInfo管理对象
	termInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#termInfo_manage").datagrid({
		url : 'TermInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "termId",
		sortOrder : "desc",
		toolbar : "#termInfo_manage_tool",
		columns : [[
			{
				field : "termId",
				title : "学期id",
				width : 70,
			},
			{
				field : "termName",
				title : "学期名称",
				width : 140,
			},
		]],
	});

	$("#termInfoEditDiv").dialog({
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
				if ($("#termInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#termInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#termInfoEditForm").form({
						    url:"TermInfo/" + $("#termInfo_termId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#termInfoEditForm").form("validate"))  {
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
			                        $("#termInfoEditDiv").dialog("close");
			                        termInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#termInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#termInfoEditDiv").dialog("close");
				$("#termInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initTermInfoManageTool() {
	termInfo_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#termInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#termInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#termInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#termInfoQueryForm").form({
			    url:"TermInfo/OutToExcel",
			});
			//提交表单
			$("#termInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#termInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var termIds = [];
						for (var i = 0; i < rows.length; i ++) {
							termIds.push(rows[i].termId);
						}
						$.ajax({
							type : "POST",
							url : "TermInfo/deletes",
							data : {
								termIds : termIds.join(","),
							},
							beforeSend : function () {
								$("#termInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#termInfo_manage").datagrid("loaded");
									$("#termInfo_manage").datagrid("load");
									$("#termInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#termInfo_manage").datagrid("loaded");
									$("#termInfo_manage").datagrid("load");
									$("#termInfo_manage").datagrid("unselectAll");
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
			var rows = $("#termInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "TermInfo/" + rows[0].termId +  "/update",
					type : "get",
					data : {
						//termId : rows[0].termId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (termInfo, response, status) {
						$.messager.progress("close");
						if (termInfo) { 
							$("#termInfoEditDiv").dialog("open");
							$("#termInfo_termId_edit").val(termInfo.termId);
							$("#termInfo_termId_edit").validatebox({
								required : true,
								missingMessage : "请输入学期id",
								editable: false
							});
							$("#termInfo_termName_edit").val(termInfo.termName);
							$("#termInfo_termName_edit").validatebox({
								required : true,
								missingMessage : "请输入学期名称",
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
