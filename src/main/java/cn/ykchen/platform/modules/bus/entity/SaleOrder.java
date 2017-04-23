/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cn.ykchen.platform.modules.bus.entity;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 销售订单Entity
 * @author yk.chen
 * @version 2017-04-22
 */
public class SaleOrder extends DataEntity<SaleOrder> {
	
	private static final long serialVersionUID = 1L;
	private Customer customer;		// 客户
	private Double totalAmount;		// 总价
	private Long totalQuantity;		// 总数量
	private String status;		// 状态
	private Date orderDate;		// 订单日期
	private Date deliveryDate;		// 发货日期
	private String deliveryCycle;		// 发货周期
	private Boolean hasAfterSale;		// 售后
	private Double afterSaleAmount;		// 售后金额
	private String afterSaleDetail;		// 售后详情
	private List<SaleOrderDetail> saleOrderDetailList = Lists.newArrayList();		// 子表列表
	
	public SaleOrder() {
		super();
	}

	public SaleOrder(String id){
		super(id);
	}

	@NotNull(message="客户不能为空")
	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	
	@NotNull(message="总价不能为空")
	public Double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	@NotNull(message="总数量不能为空")
	public Long getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(Long totalQuantity) {
		this.totalQuantity = totalQuantity;
	}
	
	@Length(min=1, max=64, message="状态长度必须介于 1 和 64 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
	
	@Length(min=1, max=4, message="发货周期长度必须介于 1 和 4 之间")
	public String getDeliveryCycle() {
		return deliveryCycle;
	}

	public void setDeliveryCycle(String deliveryCycle) {
		this.deliveryCycle = deliveryCycle;
	}
	
	@NotNull(message="售后不能为空")
	public Boolean getHasAfterSale() {
		return hasAfterSale;
	}

	public void setHasAfterSale(Boolean hasAfterSale) {
		this.hasAfterSale = hasAfterSale;
	}
	
	public Double getAfterSaleAmount() {
		return afterSaleAmount;
	}

	public void setAfterSaleAmount(Double afterSaleAmount) {
		this.afterSaleAmount = afterSaleAmount;
	}
	
	@Length(min=0, max=256, message="售后详情长度必须介于 0 和 256 之间")
	public String getAfterSaleDetail() {
		return afterSaleDetail;
	}

	public void setAfterSaleDetail(String afterSaleDetail) {
		this.afterSaleDetail = afterSaleDetail;
	}
	
	public List<SaleOrderDetail> getSaleOrderDetailList() {
		return saleOrderDetailList;
	}

	public void setSaleOrderDetailList(List<SaleOrderDetail> saleOrderDetailList) {
		this.saleOrderDetailList = saleOrderDetailList;
	}

	@Override
	public void preInsert() {
		setOrderDate(new Date());
		setStatus("A");
		super.preInsert();
	}

	@Override
	public void preUpdate() {
		super.preUpdate();
	}
}