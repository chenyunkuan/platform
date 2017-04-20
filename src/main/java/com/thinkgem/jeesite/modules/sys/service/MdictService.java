/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.Mdict;
import com.thinkgem.jeesite.modules.sys.dao.MdictDao;

/**
 * 多级字典Service
 * @author yk.chen
 * @version 2017-04-20
 */
@Service
@Transactional(readOnly = true)
public class MdictService extends TreeService<MdictDao, Mdict> {

	public Mdict get(String id) {
		return super.get(id);
	}
	
	public List<Mdict> findList(Mdict mdict) {
		if (StringUtils.isNotBlank(mdict.getParentIds())){
			mdict.setParentIds(","+mdict.getParentIds()+",");
		}
		return super.findList(mdict);
	}
	
	@Transactional(readOnly = false)
	public void save(Mdict mdict) {
		super.save(mdict);
	}
	
	@Transactional(readOnly = false)
	public void delete(Mdict mdict) {
		super.delete(mdict);
	}
	
}