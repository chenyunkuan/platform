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
import cn.ykchen.platform.modules.bus.entity.Material;
import cn.ykchen.platform.modules.bus.service.MaterialService;

/**
 * 原料Controller
 * @author yk.chen
 * @version 2017-04-20
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/material")
public class MaterialController extends BaseController {

	@Autowired
	private MaterialService materialService;
	
	@ModelAttribute
	public Material get(@RequestParam(required=false) String id) {
		Material entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = materialService.get(id);
		}
		if (entity == null){
			entity = new Material();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:material:view")
	@RequestMapping(value = {"list", ""})
	public String list(Material material, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Material> page = materialService.findPage(new Page<Material>(request, response), material); 
		model.addAttribute("page", page);
		return "modules/bus/materialList";
	}

	@RequiresPermissions("bus:material:view")
	@RequestMapping(value = "form")
	public String form(Material material, Model model) {
		model.addAttribute("material", material);
		return "modules/bus/materialForm";
	}

	@RequiresPermissions("bus:material:edit")
	@RequestMapping(value = "save")
	public String save(Material material, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, material)){
			return form(material, model);
		}
		materialService.save(material);
		addMessage(redirectAttributes, "保存原料成功");
		return "redirect:"+Global.getAdminPath()+"/bus/material/?repage";
	}

	@RequiresPermissions("bus:material:edit")
	@RequestMapping(value = "goOnSave")
	public String goOnSave(Material material, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, material)){
			return form(material, model);
		}
		materialService.save(material);
		addMessage(redirectAttributes, "保存原料成功");
		return "redirect:"+Global.getAdminPath()+"/bus/material/form";
	}
	
	@RequiresPermissions("bus:material:edit")
	@RequestMapping(value = "delete")
	public String delete(Material material, RedirectAttributes redirectAttributes) {
		materialService.delete(material);
		addMessage(redirectAttributes, "删除原料成功");
		return "redirect:"+Global.getAdminPath()+"/bus/material/?repage";
	}

}