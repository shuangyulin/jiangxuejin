package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Colleage {
    /*学院id*/
    private Integer collleageId;
    public Integer getCollleageId(){
        return collleageId;
    }
    public void setCollleageId(Integer collleageId){
        this.collleageId = collleageId;
    }

    /*学院名称*/
    @NotEmpty(message="学院名称不能为空")
    private String colleageName;
    public String getColleageName() {
        return colleageName;
    }
    public void setColleageName(String colleageName) {
        this.colleageName = colleageName;
    }

    /*学院备注*/
    private String colleageMemo;
    public String getColleageMemo() {
        return colleageMemo;
    }
    public void setColleageMemo(String colleageMemo) {
        this.colleageMemo = colleageMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonColleage=new JSONObject(); 
		jsonColleage.accumulate("collleageId", this.getCollleageId());
		jsonColleage.accumulate("colleageName", this.getColleageName());
		jsonColleage.accumulate("colleageMemo", this.getColleageMemo());
		return jsonColleage;
    }}