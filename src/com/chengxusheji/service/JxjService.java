package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.JxjType;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Jxj;

import com.chengxusheji.mapper.JxjMapper;
@Service
public class JxjService {

	@Resource JxjMapper jxjMapper;
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

    /*添加奖学金申请记录*/
    public void addJxj(Jxj jxj) throws Exception {
    	jxjMapper.addJxj(jxj);
    }

    /*按照查询条件分页查询奖学金申请记录*/
    public ArrayList<Jxj> queryJxj(JxjType jxjTypeObj,String title,UserInfo userObj,String fdyState,String fdyUserName,String glState,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != jxjTypeObj && jxjTypeObj.getTypeId()!= null && jxjTypeObj.getTypeId()!= 0)  where += " and t_jxj.jxjTypeObj=" + jxjTypeObj.getTypeId();
    	if(!title.equals("")) where = where + " and t_jxj.title like '%" + title + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_jxj.userObj='" + userObj.getUser_name() + "'";
    	if(!fdyState.equals("")) where = where + " and t_jxj.fdyState like '%" + fdyState + "%'";
    	if(!fdyUserName.equals("")) where = where + " and t_jxj.fdyUserName like '%" + fdyUserName + "%'";
    	if(!glState.equals("")) where = where + " and t_jxj.glState like '%" + glState + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return jxjMapper.queryJxj(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Jxj> queryJxj(JxjType jxjTypeObj,String title,UserInfo userObj,String fdyState,String fdyUserName,String glState) throws Exception  { 
     	String where = "where 1=1";
    	if(null != jxjTypeObj && jxjTypeObj.getTypeId()!= null && jxjTypeObj.getTypeId()!= 0)  where += " and t_jxj.jxjTypeObj=" + jxjTypeObj.getTypeId();
    	if(!title.equals("")) where = where + " and t_jxj.title like '%" + title + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_jxj.userObj='" + userObj.getUser_name() + "'";
    	if(!fdyState.equals("")) where = where + " and t_jxj.fdyState like '%" + fdyState + "%'";
    	if(!fdyUserName.equals("")) where = where + " and t_jxj.fdyUserName like '%" + fdyUserName + "%'";
    	if(!glState.equals("")) where = where + " and t_jxj.glState like '%" + glState + "%'";
    	return jxjMapper.queryJxjList(where);
    }

    /*查询所有奖学金申请记录*/
    public ArrayList<Jxj> queryAllJxj()  throws Exception {
        return jxjMapper.queryJxjList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(JxjType jxjTypeObj,String title,UserInfo userObj,String fdyState,String fdyUserName,String glState) throws Exception {
     	String where = "where 1=1";
    	if(null != jxjTypeObj && jxjTypeObj.getTypeId()!= null && jxjTypeObj.getTypeId()!= 0)  where += " and t_jxj.jxjTypeObj=" + jxjTypeObj.getTypeId();
    	if(!title.equals("")) where = where + " and t_jxj.title like '%" + title + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_jxj.userObj='" + userObj.getUser_name() + "'";
    	if(!fdyState.equals("")) where = where + " and t_jxj.fdyState like '%" + fdyState + "%'";
    	if(!fdyUserName.equals("")) where = where + " and t_jxj.fdyUserName like '%" + fdyUserName + "%'";
    	if(!glState.equals("")) where = where + " and t_jxj.glState like '%" + glState + "%'";
        recordNumber = jxjMapper.queryJxjCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取奖学金申请记录*/
    public Jxj getJxj(int jxjId) throws Exception  {
        Jxj jxj = jxjMapper.getJxj(jxjId);
        return jxj;
    }

    /*更新奖学金申请记录*/
    public void updateJxj(Jxj jxj) throws Exception {
        jxjMapper.updateJxj(jxj);
    }

    /*删除一条奖学金申请记录*/
    public void deleteJxj (int jxjId) throws Exception {
        jxjMapper.deleteJxj(jxjId);
    }

    /*删除多条奖学金申请信息*/
    public int deleteJxjs (String jxjIds) throws Exception {
    	String _jxjIds[] = jxjIds.split(",");
    	for(String _jxjId: _jxjIds) {
    		jxjMapper.deleteJxj(Integer.parseInt(_jxjId));
    	}
    	return _jxjIds.length;
    }
}
