package cn.ykchen.platform.modules.bus.utils;

import cn.ykchen.platform.modules.bus.entity.Customer;
import cn.ykchen.platform.modules.bus.entity.Factory;
import cn.ykchen.platform.modules.bus.entity.Material;
import cn.ykchen.platform.modules.bus.entity.Product;
import cn.ykchen.platform.modules.bus.service.CustomerService;
import cn.ykchen.platform.modules.bus.service.FactoryService;
import cn.ykchen.platform.modules.bus.service.MaterialService;
import cn.ykchen.platform.modules.bus.service.ProductService;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by cheny on 2017/4/21.
 */
public class SelectUtils {
    private static MaterialService materialService = SpringContextHolder.getBean(MaterialService.class);

    private static FactoryService factoryService = SpringContextHolder.getBean(FactoryService.class);

    private static ProductService productService = SpringContextHolder.getBean(ProductService.class);

    private static CustomerService customerService = SpringContextHolder.getBean(CustomerService.class);

    public static List<Material> listMaterial(){
        Material material = new Material();
        material.setDelFlag(BaseEntity.DEL_FLAG_NORMAL);
        return materialService.findList(material);
    }

    public static List<Factory> listFactory(){
        Factory factory = new Factory();
        factory.setDelFlag(BaseEntity.DEL_FLAG_NORMAL);
        return factoryService.findList(factory);
    }

    public static List<Product> listProduct(){
        Product product = new Product();
        product.setDelFlag(BaseEntity.DEL_FLAG_NORMAL);
        return productService.findList(product);
    }

    public static List<Customer> listCustomer(){
        Customer customer = new Customer();
        customer.setDelFlag(BaseEntity.DEL_FLAG_NORMAL);
        return customerService.findList(customer);
    }
}
