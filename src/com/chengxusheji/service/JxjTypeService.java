package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.JxjType;

import com.chengxusheji.mapper.JxjTypeMapper;
@Service
public class JxjTypeService {

	@Resource JxjTypeMapper jxjTypeMapper;
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

    /*添加奖学金类型记录*/
    public void addJxjType(JxjType jxjType) throws Exception {
    	jxjTypeMapper.addJxjType(jxjType);
    }

    /*按照查询条件分页查询奖学金类型记录*/
    public ArrayList<JxjType> queryJxjType(String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!addTime.equals("")) where = where + " and t_jxjType.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return jxjTypeMapper.queryJxjType(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<JxjType> queryJxjType(String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(!addTime.equals("")) where = where + " and t_jxjType.addTime like '%" + addTime + "%'";
    	return jxjTypeMapper.queryJxjTypeList(where);
    }

    /*查询所有奖学金类型记录*/
    public ArrayList<JxjType> queryAllJxjType()  throws Exception {
        return jxjTypeMapper.queryJxjTypeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String addTime) throws Exception {
     	String where = "where 1=1";
    	if(!addTime.equals("")) where = where + " and t_jxjType.addTime like '%" + addTime + "%'";
        recordNumber = jxjTypeMapper.queryJxjTypeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取奖学金类型记录*/
    public JxjType getJxjType(int typeId) throws Exception  {
        JxjType jxjType = jxjTypeMapper.getJxjType(typeId);
        return jxjType;
    }

    /*更新奖学金类型记录*/
    public void updateJxjType(JxjType jxjType) throws Exception {
        jxjTypeMapper.updateJxjType(jxjType);
    }

    /*删除一条奖学金类型记录*/
    public void deleteJxjType (int typeId) throws Exception {
        jxjTypeMapper.deleteJxjType(typeId);
    }

    /*删除多条奖学金类型信息*/
    public int deleteJxjTypes (String typeIds) throws Exception {
    	String _typeIds[] = typeIds.split(",");
    	for(String _typeId: _typeIds) {
    		jxjTypeMapper.deleteJxjType(Integer.parseInt(_typeId));
    	}
    	return _typeIds.length;
    }
}
