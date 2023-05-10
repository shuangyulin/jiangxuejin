package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.TermInfo;

public interface TermInfoMapper {
	/*添加学期信息*/
	public void addTermInfo(TermInfo termInfo) throws Exception;

	/*按照查询条件分页查询学期记录*/
	public ArrayList<TermInfo> queryTermInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有学期记录*/
	public ArrayList<TermInfo> queryTermInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的学期记录数*/
	public int queryTermInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条学期记录*/
	public TermInfo getTermInfo(int termId) throws Exception;

	/*更新学期记录*/
	public void updateTermInfo(TermInfo termInfo) throws Exception;

	/*删除学期记录*/
	public void deleteTermInfo(int termId) throws Exception;

}
