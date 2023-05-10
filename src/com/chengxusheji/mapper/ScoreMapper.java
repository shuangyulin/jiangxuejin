package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Score;

public interface ScoreMapper {
	/*添加学生成绩信息*/
	public void addScore(Score score) throws Exception;

	/*按照查询条件分页查询学生成绩记录*/
	public ArrayList<Score> queryScore(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有学生成绩记录*/
	public ArrayList<Score> queryScoreList(@Param("where") String where) throws Exception;

	/*按照查询条件的学生成绩记录数*/
	public int queryScoreCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条学生成绩记录*/
	public Score getScore(int scoreId) throws Exception;

	/*更新学生成绩记录*/
	public void updateScore(Score score) throws Exception;

	/*删除学生成绩记录*/
	public void deleteScore(int scoreId) throws Exception;

}
