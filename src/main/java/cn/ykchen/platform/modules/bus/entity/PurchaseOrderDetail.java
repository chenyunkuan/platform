/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cn.ykchen.platform.modules.bus.entity;

import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 采购订单Entity
 * @author yk.chen
 * @version 2017-04-22
 */
public class PurchaseOrderDetail extends DataEntity<PurchaseOrderDetail> {
	
	private static final long serialVersionUID = 1L;
	private PurchaseOrder purchaseOrder;		// order_id 父类
	private Long materialId;		// 原料
	private Long factoryId;		// 厂商
	private Long quantity;		// 数量
	private Double amount;		// 金额
	
	public PurchaseOrderDetail() {
		super();
	}

	public PurchaseOrderDetail(String id){
		super(id);
	}

	public PurchaseOrderDetail(PurchaseOrder order){
		this.purchaseOrder = order;
	}

	public PurchaseOrder getPurchaseOrder() {
		return purchaseOrder;
	}

	public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
		this.purchaseOrder = purchaseOrder;
	}

	@NotNull(message="原料不能为空")
	public Long getMaterialId() {
		return materialId;
	}

	public void setMaterialId(Long materialId) {
		this.materialId = materialId;
	}
	
	@NotNull(message="厂商不能为空")
	public Long getFactoryId() {
		return factoryId;
	}

	public void setFactoryId(Long factoryId) {
		this.factoryId = factoryId;
	}
	
	@NotNull(message="数量不能为空")
	public Long getQuantity() {
		return quantity;
	}

	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}
	
	@NotNull(message="金额不能为空")
	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}
	
}