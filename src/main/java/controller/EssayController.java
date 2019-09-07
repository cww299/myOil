package controller;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pojo.Essay;
import service.EssayService;
import util.Page;

@Controller
@RequestMapping("")
public class EssayController {
	final String ECONOMICS="economics";
	final String TECHNOLOGY="technology";
	final String DECISION="decision";
	final String NEWS="news";
	
	@Autowired
	EssayService essayService;
	
	@RequestMapping("/getEssayList")
	public @ResponseBody Object getEssayList(HttpServletRequest req){
		Essay essay=new Essay();
		Page page=new Page();
		page.setGetSelect(Integer.parseInt(req.getParameter("num")));
		essay.setPage(page);
		essay.setViews(1);
		return essayService.selectEssay(essay);
	}
	
	
	
	@RequestMapping("/getEssayListByCategory")
	public ModelAndView getEssayListByCategory(HttpServletRequest req) {
		ModelAndView mav=new ModelAndView("essayList");
		Essay essay=new Essay();
		Page page=new Page();
		if(req.getParameter("nowPage")!=null) {
			page.setNowPage(Integer.parseInt(req.getParameter("nowPage")));
			page.toSumStart();
		}
		essay.setPage(page);
		essay.setCategory(req.getParameter("category"));
		List<Essay> list=essayService.selectEssay(essay);
		//List<Essay> list=essayService.getEssayListByCategory(10, req.getParameter("category"));
		req.setAttribute("essayList", list);
		return mav;
	}
	
	@RequestMapping("/getNumOfCategory")
	public @ResponseBody Object getNumOfCategory(HttpServletRequest req) {
		return essayService.getNumOfCategory(req.getParameter("category"));
	}
	
	@RequestMapping("/getByCategory")
	public @ResponseBody Object getEssayListByCategory1(HttpServletRequest req) {
		Essay essay=new Essay();
		Page page=new Page();
		if(req.getParameter("num")!=null)
			page.setGetSelect(Integer.parseInt(req.getParameter("num")));
		if(req.getParameter("isHot")!=null)
			essay.setIsHot(1);
		if(req.getParameter("views")!=null)
			essay.setViews(1);
		if(req.getParameter("time")!=null)
			essay.setTime(new Timestamp(132));
		essay.setPage(page);
		essay.setCategory(req.getParameter("category"));
		List<Essay> list=essayService.selectEssay(essay);
		return list;
	}
	
	@RequestMapping("/getNext")
	public @ResponseBody Object getNext(HttpServletRequest req) {
		Essay essay=new Essay();
		essay.setId(Integer.parseInt(req.getParameter("id")));
		essay.setCategory(req.getParameter("category"));
		return essayService.getNext(essay);
	}
	
	@RequestMapping("/getBefore")
	public @ResponseBody Object getBefore(HttpServletRequest req) {
		Essay essay=new Essay();
		essay.setId(Integer.parseInt(req.getParameter("id")));
		essay.setCategory(req.getParameter("category"));
		return essayService.getBefore(essay);
	}
	
	
	
	/*
	 * 通过不同的数据要求查找相应的文章
	 * 
	 */
	@RequestMapping("/getEssayBySomeData")
	public @ResponseBody Object getEssayById(Essay essay){
		return essayService.selectEssay(essay);
	}
	
	/*
	 * 删除文章
	 */
	@RequestMapping("/deleteEssay")
	public @ResponseBody Object deleteEssay(int id){
		return essayService.deleteEssay(id);
	}
	
	
	
	//初始化index
	@RequestMapping("/index")
	public ModelAndView index(HttpServletRequest req) {
		ModelAndView mav=new ModelAndView("index");
		Essay essay;
		Page page;
		//设置热点新闻
		List<Essay> newsEssays;
		page=new Page();
		page.setGetSelect(9);
		essay=new Essay();
		essay.setPage(page);
		essay.setIsHot(1);
		essay.setCategory(NEWS);
		newsEssays=essayService.selectEssay(essay);
		req.getSession().setAttribute("newsEssays", newsEssays);
		//设置最新财经、推荐财经
		req.setAttribute("economicsTime", getList(ECONOMICS,"time"));
		req.getSession().setAttribute("economicsEssays", getList(ECONOMICS,"isHot"));
		req.setAttribute("technologyTime", getList(TECHNOLOGY,"time"));
		req.getSession().setAttribute("technologyEssays", getList(TECHNOLOGY,"isHot"));
		req.setAttribute("decisionTime", getList(DECISION,"time"));
		req.getSession().setAttribute("decisionEssays", getList(DECISION,"isHot"));
		return mav;
	}
	
	public List<Essay> getList(String category,String req){
		Essay essay=new Essay();
		Page page=new Page();
		if(req.equals("isHot")) {
			essay.setIsHot(1);
		}
		else if(req.equals("time")) {
			essay.setTime(new Timestamp(31));
			page.setGetSelect(5);
		}
		essay.setCategory(category);
		essay.setPage(page);
		return essayService.selectEssay(essay);
	}
	
	@RequestMapping("/getEssay")
	public ModelAndView getEssay(HttpServletRequest req) {
		ModelAndView mav=new ModelAndView("essay");
		Essay essay=essayService.getEssayById(Integer.parseInt(req.getParameter("id")));
		Essay e=new Essay();
		e.setId(Integer.parseInt(req.getParameter("id")));
		e.setCategory(essay.getCategory());
		req.setAttribute("essay", essay);
		req.setAttribute("beforeEssay", essayService.getBefore(e));
		req.setAttribute("nextEssay", essayService.getNext(e));
		req.setAttribute("aboutEssays", getList(essay.getCategory(),"isHot"));
		essayService.addEssayViews(Integer.parseInt(req.getParameter("id")));
		return mav;
	}
	
	
	
	
	
	
}
