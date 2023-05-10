$(function () {
	$.ajax({
		url : "Jxj/" + $("#jxj_jxjId_edit").val() + "/update",
		type : "get",
		data : {
			//jxjId : $("#jxj_jxjId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (jxj, response, status) {
			$.messager.progress("close");
			if (jxj) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#jxjModifyButton").click(function(){ 
		if ($("#jxjEditForm").form("validate")) {
			$("#jxjEditForm").form({
			    url:"Jxj/" +  $("#jxj_jxjId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#jxjEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
