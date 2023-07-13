package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import charts.ChartController;
import controllers.AjaxController;
import controllers.JsonController;
import controllers.LoginController;
import controllers.MemberController;
import members.MemberDao;


@Configuration
public class ControllerConfig {
	
	@Autowired
	private MemberDao memberDao;

	@Bean
	public LoginController loginController() {
		return new LoginController();
	}

	
	@Bean
	public JsonController jsonController() {
		return new JsonController();
	}
	
	@Bean
	public AjaxController ajaxController() {
		return new AjaxController();
	}
	
	@Bean
	public MemberController memberController() {
		return new MemberController(memberDao);
	}

	@Bean
	public ChartController chartController() {
		return new ChartController(memberDao);
	}
	
}
