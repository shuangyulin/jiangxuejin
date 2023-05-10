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
import com.chengxusheji.service.JxjService;
import com.chengxusheji.po.Jxj;
import com.chengxusheji.service.JxjTypeService;
import com.chengxusheji.po.JxjType;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Jxj管理控制层
@Controller
@RequestMapping("/Jxj")
public class JxjController extends BaseController {

    /*业务层对象*/
    @Resource JxjService jxjService;

    @Resource JxjTypeService jxjTypeService;
    @Resource UserInfoService userInfoService;
	@InitBinder("jxjTypeObj")
	public void initBinderjxjTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("jxjTypeObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("jxj")
	public void initBinderJxj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("jxj.");
	}
	/*跳转到添加Jxj视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Jxj());
		/*查询所有的JxjType信息*/
		List<JxjType> jxjTypeList = jxjTypeService.queryAllJxjType();
		request.setAttribute("jxjTypeList", jxjTypeList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Jxj_add";
	}

	/*客户端ajax方式提交添加奖学金申请信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Jxj jxj, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		jxj.setSqcl(this.handleFileUpload(request, "sqclFile"));
        jxjService.addJxj(jxj);
        message = "奖学金申请添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询奖学金申请信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("jxjTypeObj") JxjType jxjTypeObj,String title,@ModelAttribute("userObj") UserInfo userObj,String fdyState,String fdyUserName,String glState,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if (fdyState == null) fdyState = "";
		if (fdyUserName == null) fdyUserName = "";
		if (glState == null) glState = "";
		if(rows != 0)jxjService.setRows(rows);
		List<Jxj> jxjList = jxjService.queryJxj(jxjTypeObj, title, userObj, fdyState, fdyUserName, glState, page);
	    /*计算总的页数和总的记录数*/
	    jxjService.queryTotalPageAndRecordNumber(jxjTypeObj, title, userObj, fdyState, fdyUserName, glState);
	    /*获取到总的页码数目*/
	    int totalPage = jxjService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = jxjService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Jxj jxj:jxjList) {
			JSONObject jsonJxj = jxj.getJsonObject();
			jsonArray.put(jsonJxj);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询奖学金申请信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Jxj> jxjList = jxjService.queryAllJxj();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Jxj jxj:jxjList) {
			JSONObject jsonJxj = new JSONObject();
			jsonJxj.accumulate("jxjId", jxj.getJxjId());
			jsonJxj.accumulate("title", jxj.getTitle());
			jsonArray.put(jsonJxj);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询奖学金申请信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("jxjTypeObj") JxjType jxjTypeObj,String title,@ModelAttribute("userObj") UserInfo userObj,String fdyState,String fdyUserName,String glState,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (title == null) title = "";
		if (fdyState == null) fdyState = "";
		if (fdyUserName == null) fdyUserName = "";
		if (glState == null) glState = "";
		List<Jxj> jxjList = jxjService.queryJxj(jxjTypeObj, title, userObj, fdyState, fdyUserName, glState, currentPage);
	    /*计算总的页数和总的记录数*/
	    jxjService.queryTotalPageAndRecordNumber(jxjTypeObj, title, userObj, fdyState, fdyUserName, glState);
	    /*获取到总的页码数目*/
	    int totalPage = jxjService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = jxjService.getRecordNumber();
	    request.setAttribute("jxjList",  jxjList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("jxjTypeObj", jxjTypeObj);
	    request.setAttribute("title", title);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("fdyState", fdyState);
	    request.setAttribute("fdyUserName", fdyUserName);
	    request.setAttribute("glState", glState);
	    List<JxjType> jxjTypeList = jxjTypeService.queryAllJxjType();
	    request.setAttribute("jxjTypeList", jxjTypeList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Jxj/jxj_frontquery_result"; 
	}

     /*前台查询Jxj信息*/
	@RequestMapping(value="/{jxjId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer jxjId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键jxjId获取Jxj对象*/
        Jxj jxj = jxjService.getJxj(jxjId);

        List<JxjType> jxjTypeList = jxjTypeService.queryAllJxjType();
        request.setAttribute("jxjTypeList", jxjTypeList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("jxj",  jxj);
        return "Jxj/jxj_frontshow";
	}

	/*ajax方式显示奖学金申请修改jsp视图页*/
	@RequestMapping(value="/{jxjId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer jxjId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键jxjId获取Jxj对象*/
        Jxj jxj = jxjService.getJxj(jxjId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonJxj = jxj.getJsonObject();
		out.println(jsonJxj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新奖学金申请信息*/
	@RequestMapping(value = "/{jxjId}/update", method = RequestMethod.POST)
	public void update(@Validated Jxj jxj, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String sqclFileName = this.handleFileUpload(request, "sqclFile");
		if(!sqclFileName.equals(""))jxj.setSqcl(sqclFileName);
		try {
			jxjService.updateJxj(jxj);
			message = "奖学金申请更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "奖学金申请更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除奖学金申请信息*/
	@RequestMapping(value="/{jxjId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer jxjId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  jxjService.deleteJxj(jxjId);
	            request.setAttribute("message", "奖学金申请删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "奖学金申请删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条奖学金申请记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String jxjIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = jxjService.deleteJxjs(jxjIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出奖学金申请信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("jxjTypeObj") JxjType jxjTypeObj,String title,@ModelAttribute("userObj") UserInfo userObj,String fdyState,String fdyUserName,String glState, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(title == null) title = "";
        if(fdyState == null) fdyState = "";
        if(fdyUserName == null) fdyUserName = "";
        if(glState == null) glState = "";
        List<Jxj> jxjList = jxjService.queryJxj(jxjTypeObj,title,userObj,fdyState,fdyUserName,glState);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Jxj信息记录"; 
        String[] headers = { "记录id","奖学金类型","申请标题","申请描述","申请学生","辅导员审核状态","审核的辅导员","管理员审核状态","管理员审核结果"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<jxjList.size();i++) {
        	Jxj jxj = jxjList.get(i); 
        	dataset.add(new String[]{jxj.getJxjId() + "",jxj.getJxjTypeObj().getTypeName(),jxj.getTitle(),jxj.getContent(),jxj.getUserObj().getName(),jxj.getFdyState(),jxj.getFdyUserName(),jxj.getGlState(),jxj.getGlResult()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Jxj.xls");//filename是下载的xls的名，建议最好用英文 
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
