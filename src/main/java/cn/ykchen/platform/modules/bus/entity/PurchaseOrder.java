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
 * 采购订单Entity
 * @author yk.chen
 * @version 2017-04-22
 */
public class PurchaseOrder extends DataEntity<PurchaseOrder> {
	
	private static final long serialVersionUID = 1L;
	private Long totalQuantity;		// 总数量
	private Double totalAmount;		// 总金额
	private String applyBy;		// 申请人
	private Date applyDate;		// 申请日期
	private String auditBy;		// 审批人
	private Date auditDate;		// 审批日期
	private Double payTotalAmount;		// 付款总金额
	private Date payDate;		// 付款日期
	private String status;		// 状态
	private List<PurchaseOrderDetail> purchaseOrderDetailList = Lists.newArrayList();		// 子表列表
	
	public PurchaseOrder() {
		super();
	}

	public PurchaseOrder(String id){
		super(id);
	}

	@NotNull(message="总数量不能为空")
	public Long getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(Long totalQuantity) {
		this.totalQuantity = totalQuantity;
	}
	
	@NotNull(message="总金额不能为空")
	public Double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	@Length(min=1, max=64, message="申请人长度必须介于 1 和 64 之间")
	public String getApplyBy() {
		return applyBy;
	}

	public void setApplyBy(String applyBy) {
		this.applyBy = applyBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}
	
	@Length(min=0, max=64, message="审批人长度必须介于 0 和 64 之间")
	public String getAuditBy() {
		return auditBy;
	}

	public void setAuditBy(String auditBy) {
		this.auditBy = auditBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAuditDate() {
		return auditDate;
	}

	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}
	
	public Double getPayTotalAmount() {
		return payTotalAmount;
	}

	public void setPayTotalAmount(Double payTotalAmount) {
		this.payTotalAmount = payTotalAmount;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPayDate() {
		return payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	
	@Length(min=1, max=32, message="状态长度必须介于 1 和 32 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public List<PurchaseOrderDetail> getPurchaseOrderDetailList() {
		return purchaseOrderDetailList;
	}

	public void setPurchaseOrderDetailList(List<PurchaseOrderDetail> purchaseOrderDetailList) {
		this.purchaseOrderDetailList = purchaseOrderDetailList;
	}
}