package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.JxjType;

public interface JxjTypeMapper {
	/*添加奖学金类型信息*/
	public void addJxjType(JxjType jxjType) throws Exception;

	/*按照查询条件分页查询奖学金类型记录*/
	public ArrayList<JxjType> queryJxjType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有奖学金类型记录*/
	public ArrayList<JxjType> queryJxjTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的奖学金类型记录数*/
	public int queryJxjTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条奖学金类型记录*/
	public JxjType getJxjType(int typeId) throws Exception;

	/*更新奖学金类型记录*/
	public void updateJxjType(JxjType jxjType) throws Exception;

	/*删除奖学金类型记录*/
	public void deleteJxjType(int typeId) throws Exception;

}
