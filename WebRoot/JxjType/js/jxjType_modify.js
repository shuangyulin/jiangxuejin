$(function () {
	$.ajax({
		url : "JxjType/" + $("#jxjType_typeId_edit").val() + "/update",
		type : "get",
		data : {
			//typeId : $("#jxjType_typeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (jxjType, response, status) {
			$.messager.progress("close");
			if (jxjType) { 
				$("#jxjType_typeId_edit").val(jxjType.typeId);
				$("#jxjType_typeId_edit").validatebox({
					required : true,
					missingMessage : "请输入类别id",
					editable: false
				});
				$("#jxjType_typeName_edit").val(jxjType.typeName);
				$("#jxjType_typeName_edit").validatebox({
					required : true,
					missingMessage : "请输入类别名称",
				});
				$("#jxjType_jxjMoney_edit").val(jxjType.jxjMoney);
				$("#jxjType_jxjMoney_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入奖学金金额",
					invalidMessage : "奖学金金额输入不对",
				});
				$("#jxjType_pdbz_edit").val(jxjType.pdbz);
				$("#jxjType_pdbz_edit").validatebox({
					required : true,
					missingMessage : "请输入评定标准",
				});
				$("#jxjType_addTime_edit").datetimebox({
					value: jxjType.addTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#jxjTypeModifyButton").click(function(){ 
		if ($("#jxjTypeEditForm").form("validate")) {
			$("#jxjTypeEditForm").form({
			    url:"JxjType/" +  $("#jxjType_typeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#jxjTypeEditForm").form("validate"))  {
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
			$("#jxjTypeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
