package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import product.ProductDao;
import product.ProductVO;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	ProductDao productDao;
	
	@GetMapping("/register")
	public String register() {
		return "registerProduct.jsp";
	}
	
	@PostMapping("/register")
	public String registerPost(@ModelAttribute("product") ProductVO vo, Model model) {
		System.out.printf("[ProductController] POST: /register \n");
		
		productDao.insert(vo);
		
		return "confirmProduct.jsp";
	}
	
	
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

}
