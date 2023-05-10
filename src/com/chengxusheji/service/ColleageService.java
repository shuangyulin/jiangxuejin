package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Colleage;

import com.chengxusheji.mapper.ColleageMapper;
@Service
public class ColleageService {

	@Resource ColleageMapper colleageMapper;
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

    /*添加学院记录*/
    public void addColleage(Colleage colleage) throws Exception {
    	colleageMapper.addColleage(colleage);
    }

    /*按照查询条件分页查询学院记录*/
    public ArrayList<Colleage> queryColleage(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return colleageMapper.queryColleage(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Colleage> queryColleage() throws Exception  { 
     	String where = "where 1=1";
    	return colleageMapper.queryColleageList(where);
    }

    /*查询所有学院记录*/
    public ArrayList<Colleage> queryAllColleage()  throws Exception {
        return colleageMapper.queryColleageList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = colleageMapper.queryColleageCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取学院记录*/
    public Colleage getColleage(int collleageId) throws Exception  {
        Colleage colleage = colleageMapper.getColleage(collleageId);
        return colleage;
    }

    /*更新学院记录*/
    public void updateColleage(Colleage colleage) throws Exception {
        colleageMapper.updateColleage(colleage);
    }

    /*删除一条学院记录*/
    public void deleteColleage (int collleageId) throws Exception {
        colleageMapper.deleteColleage(collleageId);
    }

    /*删除多条学院信息*/
    public int deleteColleages (String collleageIds) throws Exception {
    	String _collleageIds[] = collleageIds.split(",");
    	for(String _collleageId: _collleageIds) {
    		colleageMapper.deleteColleage(Integer.parseInt(_collleageId));
    	}
    	return _collleageIds.length;
    }
}
