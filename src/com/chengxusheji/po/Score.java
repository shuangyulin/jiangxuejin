package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Score {
    /*成绩id*/
    private Integer scoreId;
    public Integer getScoreId(){
        return scoreId;
    }
    public void setScoreId(Integer scoreId){
        this.scoreId = scoreId;
    }

    /*所在学期*/
    private TermInfo termObj;
    public TermInfo getTermObj() {
        return termObj;
    }
    public void setTermObj(TermInfo termObj) {
        this.termObj = termObj;
    }

    /*学生*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*所在学院*/
    private Colleage colleageObj;
    public Colleage getColleageObj() {
        return colleageObj;
    }
    public void setColleageObj(Colleage colleageObj) {
        this.colleageObj = colleageObj;
    }

    /*综合成绩*/
    @NotNull(message="必须输入综合成绩")
    private Float zhcj;
    public Float getZhcj() {
        return zhcj;
    }
    public void setZhcj(Float zhcj) {
        this.zhcj = zhcj;
    }

    /*详细成绩*/
    @NotEmpty(message="详细成绩不能为空")
    private String scoreDesc;
    public String getScoreDesc() {
        return scoreDesc;
    }
    public void setScoreDesc(String scoreDesc) {
        this.scoreDesc = scoreDesc;
    }

    /*成绩备注*/
    private String scoreMemo;
    public String getScoreMemo() {
        return scoreMemo;
    }
    public void setScoreMemo(String scoreMemo) {
        this.scoreMemo = scoreMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonScore=new JSONObject(); 
		jsonScore.accumulate("scoreId", this.getScoreId());
		jsonScore.accumulate("termObj", this.getTermObj().getTermName());
		jsonScore.accumulate("termObjPri", this.getTermObj().getTermId());
		jsonScore.accumulate("userObj", this.getUserObj().getName());
		jsonScore.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonScore.accumulate("colleageObj", this.getColleageObj().getColleageName());
		jsonScore.accumulate("colleageObjPri", this.getColleageObj().getCollleageId());
		jsonScore.accumulate("zhcj", this.getZhcj());
		jsonScore.accumulate("scoreDesc", this.getScoreDesc());
		jsonScore.accumulate("scoreMemo", this.getScoreMemo());
		return jsonScore;
    }}