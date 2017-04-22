/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cn.ykchen.platform.modules.bus.entity;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 商品Entity
 * @author yk.chen
 * @version 2017-04-22
 */
public class Product extends DataEntity<Product> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 商品名称
	private String image;		// 图片
	private Double price;		// 单价
	private String color;		// 颜色
	
	public Product() {
		super();
	}

	public Product(String id){
		super(id);
	}

	@Length(min=1, max=64, message="商品名称长度必须介于 1 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=512, message="图片长度必须介于 0 和 512 之间")
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	@NotNull(message="单价不能为空")
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	
	@Length(min=1, max=64, message="颜色长度必须介于 1 和 64 之间")
	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
	
}