package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Fdy;

public interface FdyMapper {
	/*添加辅导员信息*/
	public void addFdy(Fdy fdy) throws Exception;

	/*按照查询条件分页查询辅导员记录*/
	public ArrayList<Fdy> queryFdy(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有辅导员记录*/
	public ArrayList<Fdy> queryFdyList(@Param("where") String where) throws Exception;

	/*按照查询条件的辅导员记录数*/
	public int queryFdyCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条辅导员记录*/
	public Fdy getFdy(String fdyUserName) throws Exception;

	/*更新辅导员记录*/
	public void updateFdy(Fdy fdy) throws Exception;

	/*删除辅导员记录*/
	public void deleteFdy(String fdyUserName) throws Exception;

}
