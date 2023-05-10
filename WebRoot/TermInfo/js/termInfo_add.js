$(function () {
	$("#termInfo_termName").validatebox({
		required : true, 
		missingMessage : '请输入学期名称',
	});

	//单击添加按钮
	$("#termInfoAddButton").click(function () {
		//验证表单 
		if(!$("#termInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#termInfoAddForm").form({
			    url:"TermInfo/add",
			    onSubmit: function(){
					if($("#termInfoAddForm").form("validate"))  { 
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
                        $("#termInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#termInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#termInfoClearButton").click(function () { 
		$("#termInfoAddForm").form("clear"); 
	});
});
