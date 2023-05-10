package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Jxj {
    /*记录id*/
    private Integer jxjId;
    public Integer getJxjId(){
        return jxjId;
    }
    public void setJxjId(Integer jxjId){
        this.jxjId = jxjId;
    }

    /*奖学金类型*/
    private JxjType jxjTypeObj;
    public JxjType getJxjTypeObj() {
        return jxjTypeObj;
    }
    public void setJxjTypeObj(JxjType jxjTypeObj) {
        this.jxjTypeObj = jxjTypeObj;
    }

    /*申请标题*/
    @NotEmpty(message="申请标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*申请描述*/
    @NotEmpty(message="申请描述不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*申请材料*/
    private String sqcl;
    public String getSqcl() {
        return sqcl;
    }
    public void setSqcl(String sqcl) {
        this.sqcl = sqcl;
    }

    /*申请学生*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*辅导员审核状态*/
    @NotEmpty(message="辅导员审核状态不能为空")
    private String fdyState;
    public String getFdyState() {
        return fdyState;
    }
    public void setFdyState(String fdyState) {
        this.fdyState = fdyState;
    }

    /*审核的辅导员*/
    @NotEmpty(message="审核的辅导员不能为空")
    private String fdyUserName;
    public String getFdyUserName() {
        return fdyUserName;
    }
    public void setFdyUserName(String fdyUserName) {
        this.fdyUserName = fdyUserName;
    }

    /*管理员审核状态*/
    @NotEmpty(message="管理员审核状态不能为空")
    private String glState;
    public String getGlState() {
        return glState;
    }
    public void setGlState(String glState) {
        this.glState = glState;
    }

    /*管理员审核结果*/
    @NotEmpty(message="管理员审核结果不能为空")
    private String glResult;
    public String getGlResult() {
        return glResult;
    }
    public void setGlResult(String glResult) {
        this.glResult = glResult;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonJxj=new JSONObject(); 
		jsonJxj.accumulate("jxjId", this.getJxjId());
		jsonJxj.accumulate("jxjTypeObj", this.getJxjTypeObj().getTypeName());
		jsonJxj.accumulate("jxjTypeObjPri", this.getJxjTypeObj().getTypeId());
		jsonJxj.accumulate("title", this.getTitle());
		jsonJxj.accumulate("content", this.getContent());
		jsonJxj.accumulate("sqcl", this.getSqcl());
		jsonJxj.accumulate("userObj", this.getUserObj().getName());
		jsonJxj.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonJxj.accumulate("fdyState", this.getFdyState());
		jsonJxj.accumulate("fdyUserName", this.getFdyUserName());
		jsonJxj.accumulate("glState", this.getGlState());
		jsonJxj.accumulate("glResult", this.getGlResult());
		return jsonJxj;
    }}