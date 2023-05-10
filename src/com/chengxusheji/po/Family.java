package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Family {
    /*记录id*/
    private Integer familyId;
    public Integer getFamilyId(){
        return familyId;
    }
    public void setFamilyId(Integer familyId){
        this.familyId = familyId;
    }

    /*学生*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*家庭情况*/
    @NotEmpty(message="家庭情况不能为空")
    private String familyDesc;
    public String getFamilyDesc() {
        return familyDesc;
    }
    public void setFamilyDesc(String familyDesc) {
        this.familyDesc = familyDesc;
    }

    /*更新时间*/
    @NotEmpty(message="更新时间不能为空")
    private String updateTime;
    public String getUpdateTime() {
        return updateTime;
    }
    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonFamily=new JSONObject(); 
		jsonFamily.accumulate("familyId", this.getFamilyId());
		jsonFamily.accumulate("userObj", this.getUserObj().getName());
		jsonFamily.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonFamily.accumulate("familyDesc", this.getFamilyDesc());
		jsonFamily.accumulate("updateTime", this.getUpdateTime().length()>19?this.getUpdateTime().substring(0,19):this.getUpdateTime());
		return jsonFamily;
    }}