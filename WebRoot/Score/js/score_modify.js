$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('score_scoreDesc_edit');
	var score_scoreDesc_edit = UE.getEditor('score_scoreDesc_edit'); //详细成绩编辑器
	score_scoreDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Score/" + $("#score_scoreId_edit").val() + "/update",
		type : "get",
		data : {
			//scoreId : $("#score_scoreId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (score, response, status) {
			$.messager.progress("close");
			if (score) { 
				$("#score_scoreId_edit").val(score.scoreId);
				$("#score_scoreId_edit").validatebox({
					required : true,
					missingMessage : "请输入成绩id",
					editable: false
				});
				$("#score_termObj_termId_edit").combobox({
					url:"TermInfo/listAll",
					valueField:"termId",
					textField:"termName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#score_termObj_termId_edit").combobox("select", score.termObjPri);
						//var data = $("#score_termObj_termId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#score_termObj_termId_edit").combobox("select", data[0].termId);
						//}
					}
				});
				$("#score_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#score_userObj_user_name_edit").combobox("select", score.userObjPri);
						//var data = $("#score_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#score_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#score_colleageObj_collleageId_edit").combobox({
					url:"Colleage/listAll",
					valueField:"collleageId",
					textField:"colleageName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#score_colleageObj_collleageId_edit").combobox("select", score.colleageObjPri);
						//var data = $("#score_colleageObj_collleageId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#score_colleageObj_collleageId_edit").combobox("select", data[0].collleageId);
						//}
					}
				});
				$("#score_zhcj_edit").val(score.zhcj);
				$("#score_zhcj_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入综合成绩",
					invalidMessage : "综合成绩输入不对",
				});
				score_scoreDesc_edit.setContent(score.scoreDesc);
				$("#score_scoreMemo_edit").val(score.scoreMemo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#scoreModifyButton").click(function(){ 
		if ($("#scoreEditForm").form("validate")) {
			$("#scoreEditForm").form({
			    url:"Score/" +  $("#score_scoreId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#scoreEditForm").form("validate"))  {
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
			$("#scoreEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
