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
import cn.ykchen.platform.modules.bus.entity.Factory;
import cn.ykchen.platform.modules.bus.service.FactoryService;

/**
 * 厂商Controller
 * @author yk.chen
 * @version 2017-04-21
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/factory")
public class FactoryController extends BaseController {

	@Autowired
	private FactoryService factoryService;
	
	@ModelAttribute
	public Factory get(@RequestParam(required=false) String id) {
		Factory entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = factoryService.get(id);
		}
		if (entity == null){
			entity = new Factory();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:factory:view")
	@RequestMapping(value = {"list", ""})
	public String list(Factory factory, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Factory> page = factoryService.findPage(new Page<Factory>(request, response), factory); 
		model.addAttribute("page", page);
		return "modules/bus/factoryList";
	}

	@RequiresPermissions("bus:factory:view")
	@RequestMapping(value = "form")
	public String form(Factory factory, Model model) {
		model.addAttribute("factory", factory);
		return "modules/bus/factoryForm";
	}

	@RequiresPermissions("bus:factory:edit")
	@RequestMapping(value = "save")
	public String save(Factory factory, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, factory)){
			return form(factory, model);
		}
		factoryService.save(factory);
		addMessage(redirectAttributes, "保存厂商成功");
		return "redirect:"+Global.getAdminPath()+"/bus/factory/?repage";
	}

	@RequiresPermissions("bus:factory:edit")
	@RequestMapping(value = "goOnSave")
	public String goOnSave(Factory factory, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, factory)){
			return form(factory, model);
		}
		factoryService.save(factory);
		addMessage(redirectAttributes, "保存厂商成功");
		return "redirect:"+Global.getAdminPath()+"/bus/factory/form";
	}
	
	@RequiresPermissions("bus:factory:edit")
	@RequestMapping(value = "delete")
	public String delete(Factory factory, RedirectAttributes redirectAttributes) {
		factoryService.delete(factory);
		addMessage(redirectAttributes, "删除厂商成功");
		return "redirect:"+Global.getAdminPath()+"/bus/factory/?repage";
	}

}