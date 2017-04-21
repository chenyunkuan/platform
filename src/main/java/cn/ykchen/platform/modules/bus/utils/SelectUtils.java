package cn.ykchen.platform.modules.bus.utils;

import cn.ykchen.platform.modules.bus.entity.Factory;
import cn.ykchen.platform.modules.bus.entity.Material;
import cn.ykchen.platform.modules.bus.service.FactoryService;
import cn.ykchen.platform.modules.bus.service.MaterialService;
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
}
