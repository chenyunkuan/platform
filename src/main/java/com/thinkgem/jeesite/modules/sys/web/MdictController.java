/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.Mdict;
import com.thinkgem.jeesite.modules.sys.service.MdictService;

/**
 * 多级字典Controller
 * @author yk.chen
 * @version 2017-04-20
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/mdict")
public class MdictController extends BaseController {

	@Autowired
	private MdictService mdictService;
	
	@ModelAttribute
	public Mdict get(@RequestParam(required=false) String id) {
		Mdict entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = mdictService.get(id);
		}
		if (entity == null){
			entity = new Mdict();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:mdict:view")
	@RequestMapping(value = {"list", ""})
	public String list(Mdict mdict, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Mdict> list = mdictService.findList(mdict); 
		model.addAttribute("list", list);
		return "modules/sys/mdictList";
	}

	@RequiresPermissions("sys:mdict:view")
	@RequestMapping(value = "form")
	public String form(Mdict mdict, Model model) {
		if (mdict.getParent()!=null && StringUtils.isNotBlank(mdict.getParent().getId())){
			mdict.setParent(mdictService.get(mdict.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(mdict.getId())){
				Mdict mdictChild = new Mdict();
				mdictChild.setParent(new Mdict(mdict.getParent().getId()));
				List<Mdict> list = mdictService.findList(mdict); 
				if (list.size() > 0){
					mdict.setSort(list.get(list.size()-1).getSort());
					if (mdict.getSort() != null){
						mdict.setSort(mdict.getSort() + 30);
					}
				}
			}
		}
		if (mdict.getSort() == null){
			mdict.setSort(30);
		}
		model.addAttribute("mdict", mdict);
		return "modules/sys/mdictForm";
	}

	@RequiresPermissions("sys:mdict:edit")
	@RequestMapping(value = "save")
	public String save(Mdict mdict, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, mdict)){
			return form(mdict, model);
		}
		mdictService.save(mdict);
		addMessage(redirectAttributes, "保存多级字典成功");
		return "redirect:"+Global.getAdminPath()+"/sys/mdict/?repage";
	}
	
	@RequiresPermissions("sys:mdict:edit")
	@RequestMapping(value = "delete")
	public String delete(Mdict mdict, RedirectAttributes redirectAttributes) {
		mdictService.delete(mdict);
		addMessage(redirectAttributes, "删除多级字典成功");
		return "redirect:"+Global.getAdminPath()+"/sys/mdict/?repage";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Mdict> list = mdictService.findList(new Mdict());
		for (int i=0; i<list.size(); i++){
			Mdict e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
}