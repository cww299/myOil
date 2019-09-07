package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("")
public class ManagerController {
	
	@RequestMapping("toManager")
	public ModelAndView toManager() {
		ModelAndView mav=new ModelAndView("Manager");
		return mav;
	}
}