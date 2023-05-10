$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('score_scoreDesc');
	var score_scoreDesc_editor = UE.getEditor('score_scoreDesc'); //详细成绩编辑框
	$("#score_termObj_termId").combobox({
	    url:'TermInfo/listAll',
	    valueField: "termId",
	    textField: "termName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#score_termObj_termId").combobox("getData"); 
            if (data.length > 0) {
                $("#score_termObj_termId").combobox("select", data[0].termId);
            }
        }
	});
	$("#score_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#score_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#score_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#score_colleageObj_collleageId").combobox({
	    url:'Colleage/listAll',
	    valueField: "collleageId",
	    textField: "colleageName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#score_colleageObj_collleageId").combobox("getData"); 
            if (data.length > 0) {
                $("#score_colleageObj_collleageId").combobox("select", data[0].collleageId);
            }
        }
	});
	$("#score_zhcj").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入综合成绩',
		invalidMessage : '综合成绩输入不对',
	});

	//单击添加按钮
	$("#scoreAddButton").click(function () {
		if(score_scoreDesc_editor.getContent() == "") {
			alert("请输入详细成绩");
			return;
		}
		//验证表单 
		if(!$("#scoreAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#scoreAddForm").form({
			    url:"Score/add",
			    onSubmit: function(){
					if($("#scoreAddForm").form("validate"))  { 
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
                        $("#scoreAddForm").form("clear");
                        score_scoreDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#scoreAddForm").submit();
		}
	});

	//单击清空按钮
	$("#scoreClearButton").click(function () { 
		$("#scoreAddForm").form("clear"); 
	});
});
