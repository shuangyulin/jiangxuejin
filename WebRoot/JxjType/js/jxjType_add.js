$(function () {
	$("#jxjType_typeName").validatebox({
		required : true, 
		missingMessage : '请输入类别名称',
	});

	$("#jxjType_jxjMoney").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入奖学金金额',
		invalidMessage : '奖学金金额输入不对',
	});

	$("#jxjType_pdbz").validatebox({
		required : true, 
		missingMessage : '请输入评定标准',
	});

	$("#jxjType_addTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#jxjTypeAddButton").click(function () {
		//验证表单 
		if(!$("#jxjTypeAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#jxjTypeAddForm").form({
			    url:"JxjType/add",
			    onSubmit: function(){
					if($("#jxjTypeAddForm").form("validate"))  { 
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
                        $("#jxjTypeAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#jxjTypeAddForm").submit();
		}
	});

	//单击清空按钮
	$("#jxjTypeClearButton").click(function () { 
		$("#jxjTypeAddForm").form("clear"); 
	});
});
