package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.TermInfo;

import com.chengxusheji.mapper.TermInfoMapper;
@Service
public class TermInfoService {

	@Resource TermInfoMapper termInfoMapper;
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

    /*添加学期记录*/
    public void addTermInfo(TermInfo termInfo) throws Exception {
    	termInfoMapper.addTermInfo(termInfo);
    }

    /*按照查询条件分页查询学期记录*/
    public ArrayList<TermInfo> queryTermInfo(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return termInfoMapper.queryTermInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<TermInfo> queryTermInfo() throws Exception  { 
     	String where = "where 1=1";
    	return termInfoMapper.queryTermInfoList(where);
    }

    /*查询所有学期记录*/
    public ArrayList<TermInfo> queryAllTermInfo()  throws Exception {
        return termInfoMapper.queryTermInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = termInfoMapper.queryTermInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取学期记录*/
    public TermInfo getTermInfo(int termId) throws Exception  {
        TermInfo termInfo = termInfoMapper.getTermInfo(termId);
        return termInfo;
    }

    /*更新学期记录*/
    public void updateTermInfo(TermInfo termInfo) throws Exception {
        termInfoMapper.updateTermInfo(termInfo);
    }

    /*删除一条学期记录*/
    public void deleteTermInfo (int termId) throws Exception {
        termInfoMapper.deleteTermInfo(termId);
    }

    /*删除多条学期信息*/
    public int deleteTermInfos (String termIds) throws Exception {
    	String _termIds[] = termIds.split(",");
    	for(String _termId: _termIds) {
    		termInfoMapper.deleteTermInfo(Integer.parseInt(_termId));
    	}
    	return _termIds.length;
    }
}
