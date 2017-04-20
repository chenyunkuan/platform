/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.Mdict;

/**
 * 多级字典DAO接口
 * @author yk.chen
 * @version 2017-04-20
 */
@MyBatisDao
public interface MdictDao extends TreeDao<Mdict> {
	
}