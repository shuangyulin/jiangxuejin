$(function () {
	$("#jxj_jxjTypeObj_typeId").combobox({
	    url:'JxjType/listAll',
	    valueField: "typeId",
	    textField: "typeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#jxj_jxjTypeObj_typeId").combobox("getData"); 
            if (data.length > 0) {
                $("#jxj_jxjTypeObj_typeId").combobox("select", data[0].typeId);
            }
        }
	});
	$("#jxj_title").validatebox({
		required : true, 
		missingMessage : '请输入申请标题',
	});

	$("#jxj_content").validatebox({
		required : true, 
		missingMessage : '请输入申请描述',
	});

	$("#jxj_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#jxj_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#jxj_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#jxj_fdyState").validatebox({
		required : true, 
		missingMessage : '请输入辅导员审核状态',
	});

	$("#jxj_fdyUserName").validatebox({
		required : true, 
		missingMessage : '请输入审核的辅导员',
	});

	$("#jxj_glState").validatebox({
		required : true, 
		missingMessage : '请输入管理员审核状态',
	});

	$("#jxj_glResult").validatebox({
		required : true, 
		missingMessage : '请输入管理员审核结果',
	});

	//单击添加按钮
	$("#jxjAddButton").click(function () {
		//验证表单 
		if(!$("#jxjAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#jxjAddForm").form({
			    url:"Jxj/add",
			    onSubmit: function(){
					if($("#jxjAddForm").form("validate"))  { 
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
                        $("#jxjAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#jxjAddForm").submit();
		}
	});

	//单击清空按钮
	$("#jxjClearButton").click(function () { 
		$("#jxjAddForm").form("clear"); 
	});
});
