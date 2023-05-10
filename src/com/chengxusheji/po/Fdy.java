package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Fdy {
    /*辅导员账号*/
    @NotEmpty(message="辅导员账号不能为空")
    private String fdyUserName;
    public String getFdyUserName(){
        return fdyUserName;
    }
    public void setFdyUserName(String fdyUserName){
        this.fdyUserName = fdyUserName;
    }

    /*登录密码*/
    @NotEmpty(message="登录密码不能为空")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String gender;
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthDate;
    public String getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*邮箱*/
    @NotEmpty(message="邮箱不能为空")
    private String email;
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    /*辅导员备注*/
    private String fdyMemo;
    public String getFdyMemo() {
        return fdyMemo;
    }
    public void setFdyMemo(String fdyMemo) {
        this.fdyMemo = fdyMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonFdy=new JSONObject(); 
		jsonFdy.accumulate("fdyUserName", this.getFdyUserName());
		jsonFdy.accumulate("password", this.getPassword());
		jsonFdy.accumulate("name", this.getName());
		jsonFdy.accumulate("gender", this.getGender());
		jsonFdy.accumulate("birthDate", this.getBirthDate().length()>19?this.getBirthDate().substring(0,19):this.getBirthDate());
		jsonFdy.accumulate("telephone", this.getTelephone());
		jsonFdy.accumulate("email", this.getEmail());
		jsonFdy.accumulate("fdyMemo", this.getFdyMemo());
		return jsonFdy;
    }}