/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cn.ykchen.platform.modules.bus.entity;

import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.modules.sys.entity.Mdict;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 原料Entity
 * @author yk.chen
 * @version 2017-04-20
 */
public class Material extends DataEntity<Material> {
	
	private static final long serialVersionUID = 1L;
	private Mdict type;		// 原料类型
	private String name;		// 原料名称
	private String color;		// 原料颜色
	private String specification;		// 规格
	private String unit;		// 单位
	private String quantity;		// 库存数量
	private String price;		// 单价
	private String attribute;		// 原料属性
	
	public Material() {
		super();
	}

	public Material(String id){
		super(id);
	}

	@NotNull(message="原料类型不能为空")
	public Mdict getType() {
		return type;
	}

	public void setType(Mdict type) {
		this.type = type;
	}
	
	@Length(min=1, max=32, message="原料名称长度必须介于 1 和 32 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=32, message="原料颜色长度必须介于 0 和 32 之间")
	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
	
	@Length(min=0, max=64, message="规格长度必须介于 0 和 64 之间")
	public String getSpecification() {
		return specification;
	}

	public void setSpecification(String specification) {
		this.specification = specification;
	}
	
	@Length(min=0, max=10, message="单位长度必须介于 0 和 10 之间")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	@Length(min=1, max=11, message="库存数量长度必须介于 1 和 11 之间")
	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	
	@Length(min=0, max=64, message="原料属性长度必须介于 0 和 64 之间")
	public String getAttribute() {
		return attribute;
	}

	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}
	
}