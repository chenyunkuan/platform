/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cn.ykchen.platform.modules.bus.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import cn.ykchen.platform.modules.bus.entity.SaleOrder;
import cn.ykchen.platform.modules.bus.dao.SaleOrderDao;
import cn.ykchen.platform.modules.bus.entity.SaleOrderDetail;
import cn.ykchen.platform.modules.bus.dao.SaleOrderDetailDao;

/**
 * 销售订单Service
 * @author yk.chen
 * @version 2017-04-22
 */
@Service
@Transactional(readOnly = true)
public class SaleOrderService extends CrudService<SaleOrderDao, SaleOrder> {

	@Autowired
	private SaleOrderDetailDao saleOrderDetailDao;
	
	public SaleOrder get(String id) {
		SaleOrder saleOrder = super.get(id);
		saleOrder.setSaleOrderDetailList(saleOrderDetailDao.findList(new SaleOrderDetail(saleOrder)));
		return saleOrder;
	}
	
	public List<SaleOrder> findList(SaleOrder saleOrder) {
		return super.findList(saleOrder);
	}
	
	public Page<SaleOrder> findPage(Page<SaleOrder> page, SaleOrder saleOrder) {
		return super.findPage(page, saleOrder);
	}
	
	@Transactional(readOnly = false)
	public void save(SaleOrder saleOrder) {

		super.save(saleOrder);

		for (SaleOrderDetail saleOrderDetail : saleOrder.getSaleOrderDetailList()){
			if (saleOrderDetail.getId() == null){
				continue;
			}
			if (SaleOrderDetail.DEL_FLAG_NORMAL.equals(saleOrderDetail.getDelFlag())){
				if (StringUtils.isBlank(saleOrderDetail.getId())){
					saleOrderDetail.setSaleOrder(saleOrder);
					saleOrderDetail.preInsert();
					saleOrderDetailDao.insert(saleOrderDetail);
				}else{
					saleOrderDetail.preUpdate();
					saleOrderDetailDao.update(saleOrderDetail);
				}
			}else{
				saleOrderDetailDao.delete(saleOrderDetail);
			}
		}

		super.save(saleOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(SaleOrder saleOrder) {
		super.delete(saleOrder);
		saleOrderDetailDao.delete(new SaleOrderDetail(saleOrder));
	}
	
}