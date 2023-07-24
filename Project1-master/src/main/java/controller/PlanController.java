package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import plans.PlanDao;
import plans.PlanVO;

@Controller
@RequestMapping("/plans")
public class PlanController {
	
	@Autowired
	PlanDao planDao;
	
	@GetMapping("/planOrder")
	public String planOrder() {
		return "planOrder.jsp";
	}
	
	@PostMapping("/planOrder")
	public String planOrder(@ModelAttribute("plan") PlanVO vo, Model model) {
		System.out.printf("[PlanController] POST: /planOrder \n");
		
		planDao.saveSelectedValues(vo);
		
		return "planView.jsp";
	}
	
	
	/*
	@GetMapping("/update")
	public String update(@RequestParam("code") String code, Model model) {
		ProductVO product = productDao.selectByCode(code);
		model.addAttribute("product", product);
		
		return "updateProduct.jsp";
	}

	@PostMapping("/update")
	public String updatePost(@ModelAttribute("product") ProductVO vo, Model model) {
		System.out.printf("[ProductController] POST: /update \n");
		
		productDao.update(vo);
		
		return "confirmProduct.jsp";
	}
	*/
}
