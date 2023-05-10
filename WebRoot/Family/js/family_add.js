$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('family_familyDesc');
	var family_familyDesc_editor = UE.getEditor('family_familyDesc'); //家庭情况编辑框
	$("#family_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#family_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#family_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#family_updateTime").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#familyAddButton").click(function () {
		if(family_familyDesc_editor.getContent() == "") {
			alert("请输入家庭情况");
			return;
		}
		//验证表单 
		if(!$("#familyAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#familyAddForm").form({
			    url:"Family/add",
			    onSubmit: function(){
					if($("#familyAddForm").form("validate"))  { 
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
                        $("#familyAddForm").form("clear");
                        family_familyDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#familyAddForm").submit();
		}
	});

	//单击清空按钮
	$("#familyClearButton").click(function () { 
		$("#familyAddForm").form("clear"); 
	});
});
