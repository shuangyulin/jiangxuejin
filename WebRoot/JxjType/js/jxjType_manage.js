var jxjType_manage_tool = null; 
$(function () { 
	initJxjTypeManageTool(); //建立JxjType管理对象
	jxjType_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#jxjType_manage").datagrid({
		url : 'JxjType/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "typeId",
		sortOrder : "desc",
		toolbar : "#jxjType_manage_tool",
		columns : [[
			{
				field : "typeId",
				title : "类别id",
				width : 70,
			},
			{
				field : "typeName",
				title : "类别名称",
				width : 140,
			},
			{
				field : "jxjMoney",
				title : "奖学金金额",
				width : 70,
			},
			{
				field : "pdbz",
				title : "评定标准",
				width : 140,
			},
			{
				field : "addTime",
				title : "添加时间",
				width : 140,
			},
		]],
	});

	$("#jxjTypeEditDiv").dialog({
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
				if ($("#jxjTypeEditForm").form("validate")) {
					//验证表单 
					if(!$("#jxjTypeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#jxjTypeEditForm").form({
						    url:"JxjType/" + $("#jxjType_typeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#jxjTypeEditForm").form("validate"))  {
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
			                        $("#jxjTypeEditDiv").dialog("close");
			                        jxjType_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#jxjTypeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#jxjTypeEditDiv").dialog("close");
				$("#jxjTypeEditForm").form("reset"); 
			},
		}],
	});
});

function initJxjTypeManageTool() {
	jxjType_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#jxjType_manage").datagrid("reload");
		},
		redo : function () {
			$("#jxjType_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#jxjType_manage").datagrid("options").queryParams;
			queryParams["addTime"] = $("#addTime").datebox("getValue"); 
			$("#jxjType_manage").datagrid("options").queryParams=queryParams; 
			$("#jxjType_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#jxjTypeQueryForm").form({
			    url:"JxjType/OutToExcel",
			});
			//提交表单
			$("#jxjTypeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#jxjType_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var typeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							typeIds.push(rows[i].typeId);
						}
						$.ajax({
							type : "POST",
							url : "JxjType/deletes",
							data : {
								typeIds : typeIds.join(","),
							},
							beforeSend : function () {
								$("#jxjType_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#jxjType_manage").datagrid("loaded");
									$("#jxjType_manage").datagrid("load");
									$("#jxjType_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#jxjType_manage").datagrid("loaded");
									$("#jxjType_manage").datagrid("load");
									$("#jxjType_manage").datagrid("unselectAll");
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
			var rows = $("#jxjType_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "JxjType/" + rows[0].typeId +  "/update",
					type : "get",
					data : {
						//typeId : rows[0].typeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (jxjType, response, status) {
						$.messager.progress("close");
						if (jxjType) { 
							$("#jxjTypeEditDiv").dialog("open");
							$("#jxjType_typeId_edit").val(jxjType.typeId);
							$("#jxjType_typeId_edit").validatebox({
								required : true,
								missingMessage : "请输入类别id",
								editable: false
							});
							$("#jxjType_typeName_edit").val(jxjType.typeName);
							$("#jxjType_typeName_edit").validatebox({
								required : true,
								missingMessage : "请输入类别名称",
							});
							$("#jxjType_jxjMoney_edit").val(jxjType.jxjMoney);
							$("#jxjType_jxjMoney_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入奖学金金额",
								invalidMessage : "奖学金金额输入不对",
							});
							$("#jxjType_pdbz_edit").val(jxjType.pdbz);
							$("#jxjType_pdbz_edit").validatebox({
								required : true,
								missingMessage : "请输入评定标准",
							});
							$("#jxjType_addTime_edit").datetimebox({
								value: jxjType.addTime,
							    required: true,
							    showSeconds: true,
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
