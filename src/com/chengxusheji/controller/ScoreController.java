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
import com.chengxusheji.service.ScoreService;
import com.chengxusheji.po.Score;
import com.chengxusheji.service.ColleageService;
import com.chengxusheji.po.Colleage;
import com.chengxusheji.service.TermInfoService;
import com.chengxusheji.po.TermInfo;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Score管理控制层
@Controller
@RequestMapping("/Score")
public class ScoreController extends BaseController {

    /*业务层对象*/
    @Resource ScoreService scoreService;

    @Resource ColleageService colleageService;
    @Resource TermInfoService termInfoService;
    @Resource UserInfoService userInfoService;
	@InitBinder("termObj")
	public void initBindertermObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("termObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("colleageObj")
	public void initBindercolleageObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("colleageObj.");
	}
	@InitBinder("score")
	public void initBinderScore(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("score.");
	}
	/*跳转到添加Score视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Score());
		/*查询所有的Colleage信息*/
		List<Colleage> colleageList = colleageService.queryAllColleage();
		request.setAttribute("colleageList", colleageList);
		/*查询所有的TermInfo信息*/
		List<TermInfo> termInfoList = termInfoService.queryAllTermInfo();
		request.setAttribute("termInfoList", termInfoList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Score_add";
	}

	/*客户端ajax方式提交添加学生成绩信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Score score, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        scoreService.addScore(score);
        message = "学生成绩添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询学生成绩信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("termObj") TermInfo termObj,@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("colleageObj") Colleage colleageObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)scoreService.setRows(rows);
		List<Score> scoreList = scoreService.queryScore(termObj, userObj, colleageObj, page);
	    /*计算总的页数和总的记录数*/
	    scoreService.queryTotalPageAndRecordNumber(termObj, userObj, colleageObj);
	    /*获取到总的页码数目*/
	    int totalPage = scoreService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = scoreService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Score score:scoreList) {
			JSONObject jsonScore = score.getJsonObject();
			jsonArray.put(jsonScore);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询学生成绩信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Score> scoreList = scoreService.queryAllScore();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Score score:scoreList) {
			JSONObject jsonScore = new JSONObject();
			jsonScore.accumulate("scoreId", score.getScoreId());
			jsonArray.put(jsonScore);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询学生成绩信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("termObj") TermInfo termObj,@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("colleageObj") Colleage colleageObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<Score> scoreList = scoreService.queryScore(termObj, userObj, colleageObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    scoreService.queryTotalPageAndRecordNumber(termObj, userObj, colleageObj);
	    /*获取到总的页码数目*/
	    int totalPage = scoreService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = scoreService.getRecordNumber();
	    request.setAttribute("scoreList",  scoreList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("termObj", termObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("colleageObj", colleageObj);
	    List<Colleage> colleageList = colleageService.queryAllColleage();
	    request.setAttribute("colleageList", colleageList);
	    List<TermInfo> termInfoList = termInfoService.queryAllTermInfo();
	    request.setAttribute("termInfoList", termInfoList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Score/score_frontquery_result"; 
	}

     /*前台查询Score信息*/
	@RequestMapping(value="/{scoreId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer scoreId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键scoreId获取Score对象*/
        Score score = scoreService.getScore(scoreId);

        List<Colleage> colleageList = colleageService.queryAllColleage();
        request.setAttribute("colleageList", colleageList);
        List<TermInfo> termInfoList = termInfoService.queryAllTermInfo();
        request.setAttribute("termInfoList", termInfoList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("score",  score);
        return "Score/score_frontshow";
	}

	/*ajax方式显示学生成绩修改jsp视图页*/
	@RequestMapping(value="/{scoreId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer scoreId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键scoreId获取Score对象*/
        Score score = scoreService.getScore(scoreId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonScore = score.getJsonObject();
		out.println(jsonScore.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新学生成绩信息*/
	@RequestMapping(value = "/{scoreId}/update", method = RequestMethod.POST)
	public void update(@Validated Score score, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			scoreService.updateScore(score);
			message = "学生成绩更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "学生成绩更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除学生成绩信息*/
	@RequestMapping(value="/{scoreId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer scoreId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  scoreService.deleteScore(scoreId);
	            request.setAttribute("message", "学生成绩删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "学生成绩删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条学生成绩记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String scoreIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = scoreService.deleteScores(scoreIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出学生成绩信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("termObj") TermInfo termObj,@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("colleageObj") Colleage colleageObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<Score> scoreList = scoreService.queryScore(termObj,userObj,colleageObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Score信息记录"; 
        String[] headers = { "成绩id","所在学期","学生","所在学院","综合成绩"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<scoreList.size();i++) {
        	Score score = scoreList.get(i); 
        	dataset.add(new String[]{score.getScoreId() + "",score.getTermObj().getTermName(),score.getUserObj().getName(),score.getColleageObj().getColleageName(),score.getZhcj() + ""});
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
			response.setHeader("Content-disposition","attachment; filename="+"Score.xls");//filename是下载的xls的名，建议最好用英文 
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
