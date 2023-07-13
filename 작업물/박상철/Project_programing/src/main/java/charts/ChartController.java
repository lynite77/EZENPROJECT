package charts;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import members.MemberDao;

@Controller
public class ChartController {
	final static int MAX_WEEK = 7;
	
	private MemberDao memberDao;
	
	public ChartController(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	@PostMapping("/chart")
	public void doChart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("[ChartController] /chart");
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();

		JSONArray charts = new JSONArray();
		int[] xvals = new int[] { 120, 200, 150, 80, 70, 110, 130 };
		
		for(Integer x : xvals) {
			charts.add(x);
		}
		
		String jsonInfo = charts.toJSONString();
		System.out.println(jsonInfo);
		writer.print(jsonInfo);
		
	}

	@PostMapping("/chart2")
	public void doChart2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("[ChartController] /chart2");
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();

		String num = (String)request.getParameter("num");
		String max = (String)request.getParameter("max");
		int iNum = Integer.parseInt(num);
		int iMax = Integer.parseInt(max);
		System.out.printf("Parameter: num(%s), max(%d)\n", iNum, iMax);
		
		JSONArray charts = new JSONArray();

		for(int cnt=0; cnt < iNum; cnt++) {
			int x = (int)(Math.random() * iMax);
			charts.add(x);
		}
		
		String jsonInfo = charts.toJSONString();
		System.out.println(jsonInfo);
		writer.print(jsonInfo);
		
	}
	
	
}
