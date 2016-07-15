package com.jy1.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
 
/*
 * 
 */
 
@Controller
public class ControllerMain {
 
	@RequestMapping("/welcome")
	public ModelAndView helloWorld() {
 
		String message = "<br><div style='text-align:center;'>"
				+ "<h3> Controller, RequestMapping 구조 참고 </h3>"
				+ "This message is coming from src/com/jy1/controller/ControllerMain.java </div><br><br>";
		return new ModelAndView("welcome", "message", message);
	}
	
	@RequestMapping("/resource_check")
	public ModelAndView linuxResource() {
 
		String message = "<br><div style='text-align:center;'>"
				+ "<h3>resource_check message</h3></div><br><br>";
		return new ModelAndView("resource_check", "message", message);
	}

	@RequestMapping("/mysql_test")
	public ModelAndView mysqlTest() {
 
		String message = "<br><div style='text-align:center;'>"
				+ "<h3>mysql test message</h3></div><br><br>";
		return new ModelAndView("mysql_test", "message", message);
	}

}