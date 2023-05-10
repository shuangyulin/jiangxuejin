var family_manage_tool = null; 
$(function () { 
	initFamilyManageTool(); //建立Family管理对象
	family_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#family_manage").datagrid({
		url : 'Family/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "familyId",
		sortOrder : "desc",
		toolbar : "#family_manage_tool",
		columns : [[
			{
				field : "familyId",
				title : "记录id",
				width : 70,
			},
			{
				field : "userObj",
				title : "学生",
				width : 140,
			},
			{
				field : "updateTime",
				title : "更新时间",
				width : 140,
			},
		]],
	});

	$("#familyEditDiv").dialog({
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
				if ($("#familyEditForm").form("validate")) {
					//验证表单 
					if(!$("#familyEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#familyEditForm").form({
						    url:"Family/" + $("#family_familyId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#familyEditForm").form("validate"))  {
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
			                        $("#familyEditDiv").dialog("close");
			                        family_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#familyEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#familyEditDiv").dialog("close");
				$("#familyEditForm").form("reset"); 
			},
		}],
	});
});

function initFamilyManageTool() {
	family_manage_tool = {
		init: function() {
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
			$("#family_manage").datagrid("reload");
		},
		redo : function () {
			$("#family_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#family_manage").datagrid("options").queryParams;
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["updateTime"] = $("#updateTime").datebox("getValue"); 
			$("#family_manage").datagrid("options").queryParams=queryParams; 
			$("#family_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#familyQueryForm").form({
			    url:"Family/OutToExcel",
			});
			//提交表单
			$("#familyQueryForm").submit();
		},
		remove : function () {
			var rows = $("#family_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var familyIds = [];
						for (var i = 0; i < rows.length; i ++) {
							familyIds.push(rows[i].familyId);
						}
						$.ajax({
							type : "POST",
							url : "Family/deletes",
							data : {
								familyIds : familyIds.join(","),
							},
							beforeSend : function () {
								$("#family_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#family_manage").datagrid("loaded");
									$("#family_manage").datagrid("load");
									$("#family_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#family_manage").datagrid("loaded");
									$("#family_manage").datagrid("load");
									$("#family_manage").datagrid("unselectAll");
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
			var rows = $("#family_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Family/" + rows[0].familyId +  "/update",
					type : "get",
					data : {
						//familyId : rows[0].familyId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (family, response, status) {
						$.messager.progress("close");
						if (family) { 
							$("#familyEditDiv").dialog("open");
							$("#family_familyId_edit").val(family.familyId);
							$("#family_familyId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录id",
								editable: false
							});
							$("#family_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#family_userObj_user_name_edit").combobox("select", family.userObjPri);
									//var data = $("#family_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#family_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							family_familyDesc_editor.setContent(family.familyDesc, false);
							$("#family_updateTime_edit").datebox({
								value: family.updateTime,
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
