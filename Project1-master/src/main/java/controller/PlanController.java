package controller;

import java.awt.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import Spring.QualityDAO;
import plans.PlanDao;
import plans.PlanVO;
import product.ProductDao;
import product.ProductVO;

@Controller
@RequestMapping("/plans")
public class PlanController {
	
	@Autowired
	PlanDao planDao;
	
	@GetMapping("/planOrder")
	public String planOrder(@RequestParam String[] productName,
							/*@RequestParam String[] memberName,*/
							@RequestParam String[] orderInfo,
							@RequestParam int[] orderCount)
							 {
		for (int i = 0;i<productName.length;i++) {
		PlanVO vo = new PlanVO();
		//vo.setMemberName(memberName[i]);
		vo.setProductName(productName[i]);
		vo.setOrderCount(orderCount[i]);
		vo.setOrderInfo(orderInfo[i]);
		planDao.saveSelectedValues(vo);
		System.out.printf(vo.getOrderInfo() +vo.getOrderCount() + vo.getProductName() /*+ vo.getMemberName()*/ +"\n");
		}
		// planDao.saveSelectedValues(vo);
		return "planView";
	}
	
	@GetMapping("/planOrder.do")
	public String planOrder2(Model model) {
		model.addAttribute("plist", planDao.productNamelist());
		//model.addAttribute("mlist", planDao.memberNamelist());
		return "planOrder.jsp";
	}
	
	@GetMapping("/planView")
    public String displayPage(Model model) {
		//List<PlanVO> plist = planDao.listAll();
		model.addAttribute("olist", planDao.listAll());
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