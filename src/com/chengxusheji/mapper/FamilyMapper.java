package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Family;

public interface FamilyMapper {
	/*添加家庭情况信息*/
	public void addFamily(Family family) throws Exception;

	/*按照查询条件分页查询家庭情况记录*/
	public ArrayList<Family> queryFamily(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有家庭情况记录*/
	public ArrayList<Family> queryFamilyList(@Param("where") String where) throws Exception;

	/*按照查询条件的家庭情况记录数*/
	public int queryFamilyCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条家庭情况记录*/
	public Family getFamily(int familyId) throws Exception;

	/*更新家庭情况记录*/
	public void updateFamily(Family family) throws Exception;

	/*删除家庭情况记录*/
	public void deleteFamily(int familyId) throws Exception;

}
