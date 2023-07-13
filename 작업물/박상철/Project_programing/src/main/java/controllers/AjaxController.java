package controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AjaxController {

	@GetMapping("/ajax1")
	public void ajaxStep1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String param = (String) request.getParameter("param");
		System.out.println("[AjaxTest1] param: " + param);
		
		PrintWriter writer = response.getWriter();
		writer.print("Hello. This is Server!!!");
	}
	
	@PostMapping("/ajax2")
	public void ajaxStep2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("[bookInfo]");
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String result = "";
		PrintWriter writer = response.getWriter();
		result="<main><book>"+
		         "<title><![CDATA[자바 개발자 프로그래밍]]></title>" +
		         "<writer><![CDATA[SOLBOOK | Solero]]></writer>" +                             
		         "<image><![CDATA[http://localhost:8584/SMFAjax23SP/images/book1.jpg]]></image>"+
		      "</book>"+
		      "<book>"+
		         "<title><![CDATA[모두를 위한 자바]]></title>" +
		         "<writer><![CDATA[SOLBOOK | Solero]]></writer>" +                             
		        "<image><![CDATA[http://localhost:8584/SMFAjax23SP/images/book2.jpg]]></image>"+
		      "</book></main>";
		System.out.println(result);
		writer.print(result);
	}	

}
