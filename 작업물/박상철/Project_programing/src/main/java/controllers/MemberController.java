package controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import members.MemberDao;

@Controller
public class MemberController {
	
	private MemberDao memberDao;
	
	public MemberController(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	@PostMapping("/member")
	public void doMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();

		String id = (String) request.getParameter("id");
		System.out.println("id = " + id);
		
		// boolean overlappedID = id.equals("1000");
		boolean existed = memberDao.isMemberID(id);

		if (existed == true) {
			writer.print("not_usable");
		}
		else {
			writer.print("usable");
		}
	}

}
