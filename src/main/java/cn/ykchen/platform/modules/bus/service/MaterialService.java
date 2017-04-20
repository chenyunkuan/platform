/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cn.ykchen.platform.modules.bus.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import cn.ykchen.platform.modules.bus.entity.Material;
import cn.ykchen.platform.modules.bus.dao.MaterialDao;

/**
 * 原料Service
 * @author yk.chen
 * @version 2017-04-20
 */
@Service
@Transactional(readOnly = true)
public class MaterialService extends CrudService<MaterialDao, Material> {

	public Material get(String id) {
		return super.get(id);
	}
	
	public List<Material> findList(Material material) {
		return super.findList(material);
	}
	
	public Page<Material> findPage(Page<Material> page, Material material) {
		return super.findPage(page, material);
	}
	
	@Transactional(readOnly = false)
	public void save(Material material) {
		super.save(material);
	}
	
	@Transactional(readOnly = false)
	public void delete(Material material) {
		super.delete(material);
	}
	
}