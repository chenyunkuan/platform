/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package cn.ykchen.platform.modules.bus.entity;

import com.thinkgem.jeesite.modules.sys.entity.Area;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 客户Entity
 * @author yk.chen
 * @version 2017-04-20
 */
public class Customer extends DataEntity<Customer> {
	
	private static final long serialVersionUID = 1L;
	private Area area;		// 地区
	private String companyName;		// 公司名称
	private String contactPerson;		// 联系人
	private String telephone;		// 座机
	private String cellphone;		// 手机
	private String express;		// 发货物流
	
	public Customer() {
		super();
	}

	public Customer(String id){
		super(id);
	}

	@NotNull(message="地区不能为空")
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}
	
	@Length(min=1, max=32, message="公司名称长度必须介于 1 和 32 之间")
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	@Length(min=1, max=32, message="联系人长度必须介于 1 和 32 之间")
	public String getContactPerson() {
		return contactPerson;
	}

	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}
	
	@Length(min=0, max=20, message="座机长度必须介于 0 和 20 之间")
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
	@Length(min=1, max=20, message="手机长度必须介于 1 和 20 之间")
	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	
	@Length(min=0, max=32, message="发货物流长度必须介于 0 和 32 之间")
	public String getExpress() {
		return express;
	}

	public void setExpress(String express) {
		this.express = express;
	}
	
}