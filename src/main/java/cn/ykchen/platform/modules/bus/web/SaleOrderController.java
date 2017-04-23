/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cn.ykchen.platform.modules.bus.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import cn.ykchen.platform.modules.bus.entity.SaleOrder;
import cn.ykchen.platform.modules.bus.service.SaleOrderService;

/**
 * 销售订单Controller
 * @author yk.chen
 * @version 2017-04-22
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/saleOrder")
public class SaleOrderController extends BaseController {

	@Autowired
	private SaleOrderService saleOrderService;
	
	@ModelAttribute
	public SaleOrder get(@RequestParam(required=false) String id) {
		SaleOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = saleOrderService.get(id);
		}
		if (entity == null){
			entity = new SaleOrder();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:saleOrder:view")
	@RequestMapping(value = {"list", ""})
	public String list(SaleOrder saleOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SaleOrder> page = saleOrderService.findPage(new Page<SaleOrder>(request, response), saleOrder); 
		model.addAttribute("page", page);
		return "modules/bus/saleOrderList";
	}

	@RequiresPermissions("bus:saleOrder:view")
	@RequestMapping(value = "form")
	public String form(SaleOrder saleOrder, Model model) {
		model.addAttribute("saleOrder", saleOrder);
		return "modules/bus/saleOrderForm";
	}

	@RequiresPermissions("bus:saleOrder:edit")
	@RequestMapping(value = "save")
	public String save(SaleOrder saleOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, saleOrder)){
			return form(saleOrder, model);
		}
		saleOrderService.save(saleOrder);
		addMessage(redirectAttributes, "保存销售订单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/saleOrder/?repage";
	}

	@RequiresPermissions("bus:saleOrder:edit")
	@RequestMapping(value = "goOnSave")
	public String goOnSave(SaleOrder saleOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, saleOrder)){
			return form(saleOrder, model);
		}
		saleOrderService.save(saleOrder);
		addMessage(redirectAttributes, "保存销售订单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/saleOrder/form";
	}
	
	@RequiresPermissions("bus:saleOrder:edit")
	@RequestMapping(value = "delete")
	public String delete(SaleOrder saleOrder, RedirectAttributes redirectAttributes) {
		saleOrderService.delete(saleOrder);
		addMessage(redirectAttributes, "删除销售订单成功");
		return "redirect:"+Global.getAdminPath()+"/bus/saleOrder/?repage";
	}

}