package controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class JsonController {
	
	@PostMapping("/json1")
	public void doJson1(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String jsonInfo = request.getParameter("jsonInfo");
		
		try {
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonInfo);
			System.out.println("* 회원 정보*");
			System.out.println(jsonObject.get("name"));
			System.out.println(jsonObject.get("age"));
			System.out.println(jsonObject.get("gender"));
			System.out.println(jsonObject.get("nickname"));
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping("/json2")
	public void doJson2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();

		JSONObject totalObject = new JSONObject();
		JSONArray membersArray = new JSONArray();
		JSONObject memberInfo = new JSONObject();

		memberInfo.put("name", "박지성");
		memberInfo.put("age", "25");
		memberInfo.put("gender", "남자");
		memberInfo.put("nickname", "날센돌이");
        //  배열에 입력
		membersArray.add(memberInfo);

		memberInfo = new JSONObject();
		memberInfo.put("name", "김연아");
		memberInfo.put("age", "21");
		memberInfo.put("gender", "여자");
		memberInfo.put("nickname", "칼치");
		membersArray.add(memberInfo);

		totalObject.put("members", membersArray);

		String jsonInfo = totalObject.toJSONString();
		System.out.print(jsonInfo);
		writer.print(jsonInfo);
	}
	
	@PostMapping("/json3")
	private void doJson3(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();

		JSONObject totaObject = new JSONObject();
		JSONArray membersArray = new JSONArray();
		JSONObject memberInfo = new JSONObject();
		memberInfo.put("name", "박지성");
		memberInfo.put("age", "25");
		memberInfo.put("gender", "남자");
		memberInfo.put("nickname", "날센돌이");
		membersArray.add(memberInfo);

		memberInfo = new JSONObject();
		memberInfo.put("name", "김연아");
		memberInfo.put("age", "21");
		memberInfo.put("gender", "여자");
		memberInfo.put("nickname", "칼치");
		membersArray.add(memberInfo);
		totaObject.put("members", membersArray);

		JSONArray bookArray = new JSONArray();
		JSONObject bookInfo = new JSONObject();
		bookInfo.put("title", "자바 프로그래밍 입문");
		bookInfo.put("writer", "아무개");
		bookInfo.put("price", "30000");
		bookInfo.put("genre", "BOOKS");
		bookInfo.put("image", "http://localhost:8584/SMFAjax23SP/images/book1.jpg");
		bookArray.add(bookInfo);

		bookInfo = new JSONObject();
		bookInfo.put("title", "자바 마스터북");
		bookInfo.put("writer", "아무개");
		bookInfo.put("price", "30000");
		bookInfo.put("genre", "BOOKS");
		bookInfo.put("image", "http://localhost:8584/SMFAjax23SP/images/book2.jpg");
		bookArray.add(bookInfo);

		totaObject.put("books", bookArray);

		String jsonInfo = totaObject.toJSONString();
		System.out.print(jsonInfo);
		writer.print(jsonInfo);
	}
	

}
