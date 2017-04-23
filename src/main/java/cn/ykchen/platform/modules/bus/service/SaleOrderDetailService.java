/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cn.ykchen.platform.modules.bus.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import cn.ykchen.platform.modules.bus.entity.SaleOrderDetail;
import cn.ykchen.platform.modules.bus.dao.SaleOrderDetailDao;

/**
 * 销售订单详情Service
 * @author yk.chen
 * @version 2017-04-22
 */
@Service
@Transactional(readOnly = true)
public class SaleOrderDetailService extends CrudService<SaleOrderDetailDao, SaleOrderDetail> {

	public SaleOrderDetail get(String id) {
		return super.get(id);
	}
	
	public List<SaleOrderDetail> findList(SaleOrderDetail saleOrderDetail) {
		return super.findList(saleOrderDetail);
	}
	
	public Page<SaleOrderDetail> findPage(Page<SaleOrderDetail> page, SaleOrderDetail saleOrderDetail) {
		return super.findPage(page, saleOrderDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(SaleOrderDetail saleOrderDetail) {
		super.save(saleOrderDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(SaleOrderDetail saleOrderDetail) {
		super.delete(saleOrderDetail);
	}
	
}