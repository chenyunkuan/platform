/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cn.ykchen.platform.modules.bus.entity;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 销售订单Entity
 * @author yk.chen
 * @version 2017-04-22
 */
public class SaleOrderDetail extends DataEntity<SaleOrderDetail> {
	
	private static final long serialVersionUID = 1L;
	private SaleOrder saleOrder;		// 销售订单 父类
	private Long productId;
	private String productName;
	private String fillMaterial;		// 填充材料
	private Double width;		// 宽
	private Double height;		// 高
	private Double square;		// 平方
	private Long quantity;		// 数量
	private Double price;		// 单价
	private Double amount;		// 金额
	
	public SaleOrderDetail() {
		super();
	}

	public SaleOrderDetail(String id){
		super(id);
	}

	public SaleOrderDetail(SaleOrder saleOrder){
		this.saleOrder = saleOrder;
	}

	@NotNull(message="销售订单不能为空")
	public SaleOrder getSaleOrder() {
		return saleOrder;
	}

	public void setSaleOrder(SaleOrder saleOrder) {
		this.saleOrder = saleOrder;
	}

	@Length(min=1, max=64, message="填充材料长度必须介于 1 和 64 之间")
	public String getFillMaterial() {
		return fillMaterial;
	}

	public void setFillMaterial(String fillMaterial) {
		this.fillMaterial = fillMaterial;
	}
	
	@NotNull(message="宽不能为空")
	public Double getWidth() {
		return width;
	}

	public void setWidth(Double width) {
		this.width = width;
	}
	
	@NotNull(message="高不能为空")
	public Double getHeight() {
		return height;
	}

	public void setHeight(Double height) {
		this.height = height;
	}
	
	@NotNull(message="平方不能为空")
	public Double getSquare() {
		return square;
	}

	public void setSquare(Double square) {
		this.square = square;
	}
	
	public Long getQuantity() {
		return quantity;
	}

	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}
	
	@NotNull(message="单价不能为空")
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	
	@NotNull(message="金额不能为空")
	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
}