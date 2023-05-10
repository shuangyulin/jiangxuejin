package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.TermInfo;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Colleage;
import com.chengxusheji.po.Score;

import com.chengxusheji.mapper.ScoreMapper;
@Service
public class ScoreService {

	@Resource ScoreMapper scoreMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加学生成绩记录*/
    public void addScore(Score score) throws Exception {
    	scoreMapper.addScore(score);
    }

    /*按照查询条件分页查询学生成绩记录*/
    public ArrayList<Score> queryScore(TermInfo termObj,UserInfo userObj,Colleage colleageObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != termObj && termObj.getTermId()!= null && termObj.getTermId()!= 0)  where += " and t_score.termObj=" + termObj.getTermId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_score.userObj='" + userObj.getUser_name() + "'";
    	if(null != colleageObj && colleageObj.getCollleageId()!= null && colleageObj.getCollleageId()!= 0)  where += " and t_score.colleageObj=" + colleageObj.getCollleageId();
    	int startIndex = (currentPage-1) * this.rows;
    	return scoreMapper.queryScore(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Score> queryScore(TermInfo termObj,UserInfo userObj,Colleage colleageObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != termObj && termObj.getTermId()!= null && termObj.getTermId()!= 0)  where += " and t_score.termObj=" + termObj.getTermId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_score.userObj='" + userObj.getUser_name() + "'";
    	if(null != colleageObj && colleageObj.getCollleageId()!= null && colleageObj.getCollleageId()!= 0)  where += " and t_score.colleageObj=" + colleageObj.getCollleageId();
    	return scoreMapper.queryScoreList(where);
    }

    /*查询所有学生成绩记录*/
    public ArrayList<Score> queryAllScore()  throws Exception {
        return scoreMapper.queryScoreList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(TermInfo termObj,UserInfo userObj,Colleage colleageObj) throws Exception {
     	String where = "where 1=1";
    	if(null != termObj && termObj.getTermId()!= null && termObj.getTermId()!= 0)  where += " and t_score.termObj=" + termObj.getTermId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_score.userObj='" + userObj.getUser_name() + "'";
    	if(null != colleageObj && colleageObj.getCollleageId()!= null && colleageObj.getCollleageId()!= 0)  where += " and t_score.colleageObj=" + colleageObj.getCollleageId();
        recordNumber = scoreMapper.queryScoreCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取学生成绩记录*/
    public Score getScore(int scoreId) throws Exception  {
        Score score = scoreMapper.getScore(scoreId);
        return score;
    }

    /*更新学生成绩记录*/
    public void updateScore(Score score) throws Exception {
        scoreMapper.updateScore(score);
    }

    /*删除一条学生成绩记录*/
    public void deleteScore (int scoreId) throws Exception {
        scoreMapper.deleteScore(scoreId);
    }

    /*删除多条学生成绩信息*/
    public int deleteScores (String scoreIds) throws Exception {
    	String _scoreIds[] = scoreIds.split(",");
    	for(String _scoreId: _scoreIds) {
    		scoreMapper.deleteScore(Integer.parseInt(_scoreId));
    	}
    	return _scoreIds.length;
    }
}
