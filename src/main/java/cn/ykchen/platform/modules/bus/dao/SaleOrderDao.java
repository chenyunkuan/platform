/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cn.ykchen.platform.modules.bus.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import cn.ykchen.platform.modules.bus.entity.SaleOrder;

/**
 * 销售订单DAO接口
 * @author yk.chen
 * @version 2017-04-22
 */
@MyBatisDao
public interface SaleOrderDao extends CrudDao<SaleOrder> {
	
}