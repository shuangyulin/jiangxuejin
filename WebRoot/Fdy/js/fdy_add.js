$(function () {
	$("#fdy_fdyUserName").validatebox({
		required : true, 
		missingMessage : '请输入辅导员账号',
	});

	$("#fdy_password").validatebox({
		required : true, 
		missingMessage : '请输入登录密码',
	});

	$("#fdy_name").validatebox({
		required : true, 
		missingMessage : '请输入姓名',
	});

	$("#fdy_gender").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#fdy_birthDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#fdy_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	$("#fdy_email").validatebox({
		required : true, 
		missingMessage : '请输入邮箱',
	});

	//单击添加按钮
	$("#fdyAddButton").click(function () {
		//验证表单 
		if(!$("#fdyAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#fdyAddForm").form({
			    url:"Fdy/add",
			    onSubmit: function(){
					if($("#fdyAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#fdyAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#fdyAddForm").submit();
		}
	});

	//单击清空按钮
	$("#fdyClearButton").click(function () { 
		$("#fdyAddForm").form("clear"); 
	});
});
