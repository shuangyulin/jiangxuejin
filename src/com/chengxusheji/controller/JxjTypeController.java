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
import com.chengxusheji.service.JxjTypeService;
import com.chengxusheji.po.JxjType;

//JxjType管理控制层
@Controller
@RequestMapping("/JxjType")
public class JxjTypeController extends BaseController {

    /*业务层对象*/
    @Resource JxjTypeService jxjTypeService;

	@InitBinder("jxjType")
	public void initBinderJxjType(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("jxjType.");
	}
	/*跳转到添加JxjType视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new JxjType());
		return "JxjType_add";
	}

	/*客户端ajax方式提交添加奖学金类型信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated JxjType jxjType, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        jxjTypeService.addJxjType(jxjType);
        message = "奖学金类型添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询奖学金类型信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (addTime == null) addTime = "";
		if(rows != 0)jxjTypeService.setRows(rows);
		List<JxjType> jxjTypeList = jxjTypeService.queryJxjType(addTime, page);
	    /*计算总的页数和总的记录数*/
	    jxjTypeService.queryTotalPageAndRecordNumber(addTime);
	    /*获取到总的页码数目*/
	    int totalPage = jxjTypeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = jxjTypeService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(JxjType jxjType:jxjTypeList) {
			JSONObject jsonJxjType = jxjType.getJsonObject();
			jsonArray.put(jsonJxjType);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询奖学金类型信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<JxjType> jxjTypeList = jxjTypeService.queryAllJxjType();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(JxjType jxjType:jxjTypeList) {
			JSONObject jsonJxjType = new JSONObject();
			jsonJxjType.accumulate("typeId", jxjType.getTypeId());
			jsonJxjType.accumulate("typeName", jxjType.getTypeName());
			jsonArray.put(jsonJxjType);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询奖学金类型信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (addTime == null) addTime = "";
		List<JxjType> jxjTypeList = jxjTypeService.queryJxjType(addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    jxjTypeService.queryTotalPageAndRecordNumber(addTime);
	    /*获取到总的页码数目*/
	    int totalPage = jxjTypeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = jxjTypeService.getRecordNumber();
	    request.setAttribute("jxjTypeList",  jxjTypeList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("addTime", addTime);
		return "JxjType/jxjType_frontquery_result"; 
	}

     /*前台查询JxjType信息*/
	@RequestMapping(value="/{typeId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer typeId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键typeId获取JxjType对象*/
        JxjType jxjType = jxjTypeService.getJxjType(typeId);

        request.setAttribute("jxjType",  jxjType);
        return "JxjType/jxjType_frontshow";
	}

	/*ajax方式显示奖学金类型修改jsp视图页*/
	@RequestMapping(value="/{typeId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer typeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键typeId获取JxjType对象*/
        JxjType jxjType = jxjTypeService.getJxjType(typeId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonJxjType = jxjType.getJsonObject();
		out.println(jsonJxjType.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新奖学金类型信息*/
	@RequestMapping(value = "/{typeId}/update", method = RequestMethod.POST)
	public void update(@Validated JxjType jxjType, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			jxjTypeService.updateJxjType(jxjType);
			message = "奖学金类型更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "奖学金类型更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除奖学金类型信息*/
	@RequestMapping(value="/{typeId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer typeId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  jxjTypeService.deleteJxjType(typeId);
	            request.setAttribute("message", "奖学金类型删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "奖学金类型删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条奖学金类型记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String typeIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = jxjTypeService.deleteJxjTypes(typeIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出奖学金类型信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(addTime == null) addTime = "";
        List<JxjType> jxjTypeList = jxjTypeService.queryJxjType(addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "JxjType信息记录"; 
        String[] headers = { "类别id","类别名称","奖学金金额","评定标准","添加时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<jxjTypeList.size();i++) {
        	JxjType jxjType = jxjTypeList.get(i); 
        	dataset.add(new String[]{jxjType.getTypeId() + "",jxjType.getTypeName(),jxjType.getJxjMoney() + "",jxjType.getPdbz(),jxjType.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"JxjType.xls");//filename是下载的xls的名，建议最好用英文 
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
