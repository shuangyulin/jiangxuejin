package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class TermInfo {
    /*学期id*/
    private Integer termId;
    public Integer getTermId(){
        return termId;
    }
    public void setTermId(Integer termId){
        this.termId = termId;
    }

    /*学期名称*/
    @NotEmpty(message="学期名称不能为空")
    private String termName;
    public String getTermName() {
        return termName;
    }
    public void setTermName(String termName) {
        this.termName = termName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTermInfo=new JSONObject(); 
		jsonTermInfo.accumulate("termId", this.getTermId());
		jsonTermInfo.accumulate("termName", this.getTermName());
		return jsonTermInfo;
    }}