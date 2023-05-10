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
import com.chengxusheji.service.FdyService;
import com.chengxusheji.po.Fdy;

//Fdy管理控制层
@Controller
@RequestMapping("/Fdy")
public class FdyController extends BaseController {

    /*业务层对象*/
    @Resource FdyService fdyService;

	@InitBinder("fdy")
	public void initBinderFdy(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("fdy.");
	}
	/*跳转到添加Fdy视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Fdy());
		return "Fdy_add";
	}

	/*客户端ajax方式提交添加辅导员信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Fdy fdy, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(fdyService.getFdy(fdy.getFdyUserName()) != null) {
			message = "辅导员账号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
        fdyService.addFdy(fdy);
        message = "辅导员添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询辅导员信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String fdyUserName,String name,String birthDate,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (fdyUserName == null) fdyUserName = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		if(rows != 0)fdyService.setRows(rows);
		List<Fdy> fdyList = fdyService.queryFdy(fdyUserName, name, birthDate, telephone, page);
	    /*计算总的页数和总的记录数*/
	    fdyService.queryTotalPageAndRecordNumber(fdyUserName, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = fdyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = fdyService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Fdy fdy:fdyList) {
			JSONObject jsonFdy = fdy.getJsonObject();
			jsonArray.put(jsonFdy);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询辅导员信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Fdy> fdyList = fdyService.queryAllFdy();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Fdy fdy:fdyList) {
			JSONObject jsonFdy = new JSONObject();
			jsonFdy.accumulate("fdyUserName", fdy.getFdyUserName());
			jsonFdy.accumulate("name", fdy.getName());
			jsonArray.put(jsonFdy);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询辅导员信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String fdyUserName,String name,String birthDate,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (fdyUserName == null) fdyUserName = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		List<Fdy> fdyList = fdyService.queryFdy(fdyUserName, name, birthDate, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    fdyService.queryTotalPageAndRecordNumber(fdyUserName, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = fdyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = fdyService.getRecordNumber();
	    request.setAttribute("fdyList",  fdyList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("fdyUserName", fdyUserName);
	    request.setAttribute("name", name);
	    request.setAttribute("birthDate", birthDate);
	    request.setAttribute("telephone", telephone);
		return "Fdy/fdy_frontquery_result"; 
	}

     /*前台查询Fdy信息*/
	@RequestMapping(value="/{fdyUserName}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String fdyUserName,Model model,HttpServletRequest request) throws Exception {
		/*根据主键fdyUserName获取Fdy对象*/
        Fdy fdy = fdyService.getFdy(fdyUserName);

        request.setAttribute("fdy",  fdy);
        return "Fdy/fdy_frontshow";
	}

	/*ajax方式显示辅导员修改jsp视图页*/
	@RequestMapping(value="/{fdyUserName}/update",method=RequestMethod.GET)
	public void update(@PathVariable String fdyUserName,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键fdyUserName获取Fdy对象*/
        Fdy fdy = fdyService.getFdy(fdyUserName);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonFdy = fdy.getJsonObject();
		out.println(jsonFdy.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新辅导员信息*/
	@RequestMapping(value = "/{fdyUserName}/update", method = RequestMethod.POST)
	public void update(@Validated Fdy fdy, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			fdyService.updateFdy(fdy);
			message = "辅导员更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "辅导员更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除辅导员信息*/
	@RequestMapping(value="/{fdyUserName}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String fdyUserName,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  fdyService.deleteFdy(fdyUserName);
	            request.setAttribute("message", "辅导员删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "辅导员删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条辅导员记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String fdyUserNames,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = fdyService.deleteFdys(fdyUserNames);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出辅导员信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String fdyUserName,String name,String birthDate,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(fdyUserName == null) fdyUserName = "";
        if(name == null) name = "";
        if(birthDate == null) birthDate = "";
        if(telephone == null) telephone = "";
        List<Fdy> fdyList = fdyService.queryFdy(fdyUserName,name,birthDate,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Fdy信息记录"; 
        String[] headers = { "辅导员账号","姓名","性别","出生日期","联系电话","邮箱"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<fdyList.size();i++) {
        	Fdy fdy = fdyList.get(i); 
        	dataset.add(new String[]{fdy.getFdyUserName(),fdy.getName(),fdy.getGender(),fdy.getBirthDate(),fdy.getTelephone(),fdy.getEmail()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Fdy.xls");//filename是下载的xls的名，建议最好用英文 
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
