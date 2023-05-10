$(function () {
	$.ajax({
		url : "Fdy/" + $("#fdy_fdyUserName_edit").val() + "/update",
		type : "get",
		data : {
			//fdyUserName : $("#fdy_fdyUserName_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (fdy, response, status) {
			$.messager.progress("close");
			if (fdy) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#fdyModifyButton").click(function(){ 
		if ($("#fdyEditForm").form("validate")) {
			$("#fdyEditForm").form({
			    url:"Fdy/" +  $("#fdy_fdyUserName_edit").val() + "/update",
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
			$("#fdyEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
