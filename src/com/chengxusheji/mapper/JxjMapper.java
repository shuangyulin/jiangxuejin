package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Jxj;

public interface JxjMapper {
	/*添加奖学金申请信息*/
	public void addJxj(Jxj jxj) throws Exception;

	/*按照查询条件分页查询奖学金申请记录*/
	public ArrayList<Jxj> queryJxj(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有奖学金申请记录*/
	public ArrayList<Jxj> queryJxjList(@Param("where") String where) throws Exception;

	/*按照查询条件的奖学金申请记录数*/
	public int queryJxjCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条奖学金申请记录*/
	public Jxj getJxj(int jxjId) throws Exception;

	/*更新奖学金申请记录*/
	public void updateJxj(Jxj jxj) throws Exception;

	/*删除奖学金申请记录*/
	public void deleteJxj(int jxjId) throws Exception;

}
