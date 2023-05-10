package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Fdy;

import com.chengxusheji.mapper.FdyMapper;
@Service
public class FdyService {

	@Resource FdyMapper fdyMapper;
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

    /*添加辅导员记录*/
    public void addFdy(Fdy fdy) throws Exception {
    	fdyMapper.addFdy(fdy);
    }

    /*按照查询条件分页查询辅导员记录*/
    public ArrayList<Fdy> queryFdy(String fdyUserName,String name,String birthDate,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!fdyUserName.equals("")) where = where + " and t_fdy.fdyUserName like '%" + fdyUserName + "%'";
    	if(!name.equals("")) where = where + " and t_fdy.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_fdy.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_fdy.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return fdyMapper.queryFdy(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Fdy> queryFdy(String fdyUserName,String name,String birthDate,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!fdyUserName.equals("")) where = where + " and t_fdy.fdyUserName like '%" + fdyUserName + "%'";
    	if(!name.equals("")) where = where + " and t_fdy.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_fdy.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_fdy.telephone like '%" + telephone + "%'";
    	return fdyMapper.queryFdyList(where);
    }

    /*查询所有辅导员记录*/
    public ArrayList<Fdy> queryAllFdy()  throws Exception {
        return fdyMapper.queryFdyList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String fdyUserName,String name,String birthDate,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(!fdyUserName.equals("")) where = where + " and t_fdy.fdyUserName like '%" + fdyUserName + "%'";
    	if(!name.equals("")) where = where + " and t_fdy.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_fdy.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_fdy.telephone like '%" + telephone + "%'";
        recordNumber = fdyMapper.queryFdyCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取辅导员记录*/
    public Fdy getFdy(String fdyUserName) throws Exception  {
        Fdy fdy = fdyMapper.getFdy(fdyUserName);
        return fdy;
    }

    /*更新辅导员记录*/
    public void updateFdy(Fdy fdy) throws Exception {
        fdyMapper.updateFdy(fdy);
    }

    /*删除一条辅导员记录*/
    public void deleteFdy (String fdyUserName) throws Exception {
        fdyMapper.deleteFdy(fdyUserName);
    }

    /*删除多条辅导员信息*/
    public int deleteFdys (String fdyUserNames) throws Exception {
    	String _fdyUserNames[] = fdyUserNames.split(",");
    	for(String _fdyUserName: _fdyUserNames) {
    		fdyMapper.deleteFdy(_fdyUserName);
    	}
    	return _fdyUserNames.length;
    }
}
