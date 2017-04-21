/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cn.ykchen.platform.modules.bus.service;

import java.util.Date;
import java.util.List;

import cn.ykchen.platform.modules.bus.dao.MaterialDao;
import cn.ykchen.platform.modules.bus.entity.Material;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import cn.ykchen.platform.modules.bus.entity.PurchaseOrder;
import cn.ykchen.platform.modules.bus.dao.PurchaseOrderDao;
import cn.ykchen.platform.modules.bus.entity.PurchaseOrderDetail;
import cn.ykchen.platform.modules.bus.dao.PurchaseOrderDetailDao;

/**
 * 采购订单Service
 * @author yk.chen
 * @version 2017-04-22
 */
@Service
@Transactional(readOnly = true)
public class PurchaseOrderService extends CrudService<PurchaseOrderDao, PurchaseOrder> {

	@Autowired
	private PurchaseOrderDetailDao purchaseOrderDetailDao;

	@Autowired
	private MaterialDao materialDao;
	
	public PurchaseOrder get(String id) {
		PurchaseOrder purchaseOrder = super.get(id);
		purchaseOrder.setPurchaseOrderDetailList(purchaseOrderDetailDao.findList(new PurchaseOrderDetail(purchaseOrder)));
		return purchaseOrder;
	}
	
	public List<PurchaseOrder> findList(PurchaseOrder purchaseOrder) {
		return super.findList(purchaseOrder);
	}
	
	public Page<PurchaseOrder> findPage(Page<PurchaseOrder> page, PurchaseOrder purchaseOrder) {
		return super.findPage(page, purchaseOrder);
	}
	
	@Transactional(readOnly = false)
	public void save(PurchaseOrder purchaseOrder) {
		purchaseOrder.setApplyBy(UserUtils.getUser().getName());
		purchaseOrder.setApplyDate(new Date());
		purchaseOrder.setStatus("APPLY");
		super.save(purchaseOrder);

		long totalQuantity = 0;
		double totalAmount = 0;

		for (PurchaseOrderDetail detail : purchaseOrder.getPurchaseOrderDetailList()){
			if (detail.getId() == null){
				continue;
			}
			if (PurchaseOrderDetail.DEL_FLAG_NORMAL.equals(detail.getDelFlag())){
				Material material = materialDao.get(detail.getMaterialId()+"");

				Double price = material.getPrice();
				Double amount = price * detail.getQuantity();
				detail.setAmount(amount);

				totalQuantity += detail.getQuantity();
				totalAmount += amount;
				if (StringUtils.isBlank(detail.getId())){
					detail.setPurchaseOrder(purchaseOrder);
					detail.preInsert();
					purchaseOrderDetailDao.insert(detail);
				}else{
					detail.preUpdate();
					purchaseOrderDetailDao.update(detail);
				}
			}else{
				purchaseOrderDetailDao.delete(detail);
			}

			purchaseOrder.setTotalAmount(totalAmount);
			purchaseOrder.setTotalQuantity(totalQuantity);
			super.save(purchaseOrder);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(PurchaseOrder purchaseOrder) {
		super.delete(purchaseOrder);
		purchaseOrderDetailDao.delete(new PurchaseOrderDetail(purchaseOrder));
	}
	
}