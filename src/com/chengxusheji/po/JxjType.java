package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class JxjType {
    /*类别id*/
    private Integer typeId;
    public Integer getTypeId(){
        return typeId;
    }
    public void setTypeId(Integer typeId){
        this.typeId = typeId;
    }

    /*类别名称*/
    @NotEmpty(message="类别名称不能为空")
    private String typeName;
    public String getTypeName() {
        return typeName;
    }
    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    /*奖学金金额*/
    @NotNull(message="必须输入奖学金金额")
    private Float jxjMoney;
    public Float getJxjMoney() {
        return jxjMoney;
    }
    public void setJxjMoney(Float jxjMoney) {
        this.jxjMoney = jxjMoney;
    }

    /*评定标准*/
    @NotEmpty(message="评定标准不能为空")
    private String pdbz;
    public String getPdbz() {
        return pdbz;
    }
    public void setPdbz(String pdbz) {
        this.pdbz = pdbz;
    }

    /*添加时间*/
    @NotEmpty(message="添加时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonJxjType=new JSONObject(); 
		jsonJxjType.accumulate("typeId", this.getTypeId());
		jsonJxjType.accumulate("typeName", this.getTypeName());
		jsonJxjType.accumulate("jxjMoney", this.getJxjMoney());
		jsonJxjType.accumulate("pdbz", this.getPdbz());
		jsonJxjType.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonJxjType;
    }}