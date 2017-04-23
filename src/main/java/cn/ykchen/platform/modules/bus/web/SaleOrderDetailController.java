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
import cn.ykchen.platform.modules.bus.entity.SaleOrderDetail;
import cn.ykchen.platform.modules.bus.service.SaleOrderDetailService;

/**
 * 销售订单详情Controller
 * @author yk.chen
 * @version 2017-04-22
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/saleOrderDetail")
public class SaleOrderDetailController extends BaseController {

	@Autowired
	private SaleOrderDetailService saleOrderDetailService;
	
	@ModelAttribute
	public SaleOrderDetail get(@RequestParam(required=false) String id) {
		SaleOrderDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = saleOrderDetailService.get(id);
		}
		if (entity == null){
			entity = new SaleOrderDetail();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:saleOrderDetail:view")
	@RequestMapping(value = {"list", ""})
	public String list(SaleOrderDetail saleOrderDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SaleOrderDetail> page = saleOrderDetailService.findPage(new Page<SaleOrderDetail>(request, response), saleOrderDetail); 
		model.addAttribute("page", page);
		return "modules/bus/saleOrderDetailList";
	}

	@RequiresPermissions("bus:saleOrderDetail:view")
	@RequestMapping(value = "form")
	public String form(SaleOrderDetail saleOrderDetail, Model model) {
		model.addAttribute("saleOrderDetail", saleOrderDetail);
		return "modules/bus/saleOrderDetailForm";
	}

	@RequiresPermissions("bus:saleOrderDetail:edit")
	@RequestMapping(value = "save")
	public String save(SaleOrderDetail saleOrderDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, saleOrderDetail)){
			return form(saleOrderDetail, model);
		}
		saleOrderDetailService.save(saleOrderDetail);
		addMessage(redirectAttributes, "保存销售订单详情成功");
		return "redirect:"+Global.getAdminPath()+"/bus/saleOrderDetail/?repage";
	}

	@RequiresPermissions("bus:saleOrderDetail:edit")
	@RequestMapping(value = "goOnSave")
	public String goOnSave(SaleOrderDetail saleOrderDetail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, saleOrderDetail)){
			return form(saleOrderDetail, model);
		}
		saleOrderDetailService.save(saleOrderDetail);
		addMessage(redirectAttributes, "保存销售订单详情成功");
		return "redirect:"+Global.getAdminPath()+"/bus/saleOrderDetail/form";
	}
	
	@RequiresPermissions("bus:saleOrderDetail:edit")
	@RequestMapping(value = "delete")
	public String delete(SaleOrderDetail saleOrderDetail, RedirectAttributes redirectAttributes) {
		saleOrderDetailService.delete(saleOrderDetail);
		addMessage(redirectAttributes, "删除销售订单详情成功");
		return "redirect:"+Global.getAdminPath()+"/bus/saleOrderDetail/?repage";
	}

}