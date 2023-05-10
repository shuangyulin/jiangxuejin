package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.FamilyService;
import com.chengxusheji.po.Family;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Family管理控制层
@Controller
@RequestMapping("/Family")
public class FamilyController extends BaseController {

    /*业务层对象*/
    @Resource FamilyService familyService;

    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("family")
	public void initBinderFamily(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("family.");
	}
	/*跳转到添加Family视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Family());
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Family_add";
	}

	/*客户端ajax方式提交添加家庭情况信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Family family, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        familyService.addFamily(family);
        message = "家庭情况添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询家庭情况信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("userObj") UserInfo userObj,String updateTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (updateTime == null) updateTime = "";
		if(rows != 0)familyService.setRows(rows);
		List<Family> familyList = familyService.queryFamily(userObj, updateTime, page);
	    /*计算总的页数和总的记录数*/
	    familyService.queryTotalPageAndRecordNumber(userObj, updateTime);
	    /*获取到总的页码数目*/
	    int totalPage = familyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = familyService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Family family:familyList) {
			JSONObject jsonFamily = family.getJsonObject();
			jsonArray.put(jsonFamily);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询家庭情况信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Family> familyList = familyService.queryAllFamily();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Family family:familyList) {
			JSONObject jsonFamily = new JSONObject();
			jsonFamily.accumulate("familyId", family.getFamilyId());
			jsonFamily.accumulate("familyDesc", family.getFamilyDesc());
			jsonArray.put(jsonFamily);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询家庭情况信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("userObj") UserInfo userObj,String updateTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (updateTime == null) updateTime = "";
		List<Family> familyList = familyService.queryFamily(userObj, updateTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    familyService.queryTotalPageAndRecordNumber(userObj, updateTime);
	    /*获取到总的页码数目*/
	    int totalPage = familyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = familyService.getRecordNumber();
	    request.setAttribute("familyList",  familyList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("updateTime", updateTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Family/family_frontquery_result"; 
	}

     /*前台查询Family信息*/
	@RequestMapping(value="/{familyId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer familyId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键familyId获取Family对象*/
        Family family = familyService.getFamily(familyId);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("family",  family);
        return "Family/family_frontshow";
	}

	/*ajax方式显示家庭情况修改jsp视图页*/
	@RequestMapping(value="/{familyId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer familyId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键familyId获取Family对象*/
        Family family = familyService.getFamily(familyId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonFamily = family.getJsonObject();
		out.println(jsonFamily.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新家庭情况信息*/
	@RequestMapping(value = "/{familyId}/update", method = RequestMethod.POST)
	public void update(@Validated Family family, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			familyService.updateFamily(family);
			message = "家庭情况更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "家庭情况更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除家庭情况信息*/
	@RequestMapping(value="/{familyId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer familyId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  familyService.deleteFamily(familyId);
	            request.setAttribute("message", "家庭情况删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "家庭情况删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条家庭情况记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String familyIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = familyService.deleteFamilys(familyIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出家庭情况信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("userObj") UserInfo userObj,String updateTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(updateTime == null) updateTime = "";
        List<Family> familyList = familyService.queryFamily(userObj,updateTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Family信息记录"; 
        String[] headers = { "记录id","学生","更新时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<familyList.size();i++) {
        	Family family = familyList.get(i); 
        	dataset.add(new String[]{family.getFamilyId() + "",family.getUserObj().getName(),family.getUpdateTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Family.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
