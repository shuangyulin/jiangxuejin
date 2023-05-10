package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Family;

import com.chengxusheji.mapper.FamilyMapper;
@Service
public class FamilyService {

	@Resource FamilyMapper familyMapper;
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

    /*添加家庭情况记录*/
    public void addFamily(Family family) throws Exception {
    	familyMapper.addFamily(family);
    }

    /*按照查询条件分页查询家庭情况记录*/
    public ArrayList<Family> queryFamily(UserInfo userObj,String updateTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_family.userObj='" + userObj.getUser_name() + "'";
    	if(!updateTime.equals("")) where = where + " and t_family.updateTime like '%" + updateTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return familyMapper.queryFamily(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Family> queryFamily(UserInfo userObj,String updateTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_family.userObj='" + userObj.getUser_name() + "'";
    	if(!updateTime.equals("")) where = where + " and t_family.updateTime like '%" + updateTime + "%'";
    	return familyMapper.queryFamilyList(where);
    }

    /*查询所有家庭情况记录*/
    public ArrayList<Family> queryAllFamily()  throws Exception {
        return familyMapper.queryFamilyList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(UserInfo userObj,String updateTime) throws Exception {
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_family.userObj='" + userObj.getUser_name() + "'";
    	if(!updateTime.equals("")) where = where + " and t_family.updateTime like '%" + updateTime + "%'";
        recordNumber = familyMapper.queryFamilyCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取家庭情况记录*/
    public Family getFamily(int familyId) throws Exception  {
        Family family = familyMapper.getFamily(familyId);
        return family;
    }

    /*更新家庭情况记录*/
    public void updateFamily(Family family) throws Exception {
        familyMapper.updateFamily(family);
    }

    /*删除一条家庭情况记录*/
    public void deleteFamily (int familyId) throws Exception {
        familyMapper.deleteFamily(familyId);
    }

    /*删除多条家庭情况信息*/
    public int deleteFamilys (String familyIds) throws Exception {
    	String _familyIds[] = familyIds.split(",");
    	for(String _familyId: _familyIds) {
    		familyMapper.deleteFamily(Integer.parseInt(_familyId));
    	}
    	return _familyIds.length;
    }
}
