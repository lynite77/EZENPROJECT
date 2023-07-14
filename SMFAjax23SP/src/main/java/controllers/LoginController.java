package controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

	@GetMapping("/loginform")
	public String doLogin() {
		System.out.println("[LoginController] : /login.do");
		return "loginform";
	}
	
	
	@PostMapping("/login.post")
	public String doLogin(Model model,
			@RequestParam(value = "id", required = true) String id,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "email", required = false) String email) {
		
		model.addAttribute("id", id);
		model.addAttribute("name", name);
		model.addAttribute("email", email);
		return "login";
	}


} 
