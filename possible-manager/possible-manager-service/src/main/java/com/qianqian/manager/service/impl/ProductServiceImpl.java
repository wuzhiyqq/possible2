package com.qianqian.manager.service.impl;

import com.qianqian.common.pojo.dto.ProductResult;
import com.qianqian.common.pojo.dto.PageInfo;
import com.qianqian.manager.dao.ProductMapper;
import com.qianqian.manager.pojo.po.Product;
import com.qianqian.manager.pojo.vo.ProductCustom;
import com.qianqian.manager.pojo.vo.ProductQuery;
import com.qianqian.manager.service.ProductService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * User: WZ
 * Date: 2018/10/29
 * Time: 14:30
 * Version:V1.0
 */
@Service
public class ProductServiceImpl implements ProductService {
    //要使用接口，不需要使用具体实现（log4j logback）
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private ProductMapper productDao;

    @Override
    public ProductResult<ProductCustom> listProductsByPage(PageInfo pageInfo, ProductQuery productQuery) {
        ProductResult<ProductCustom> result = new ProductResult<ProductCustom>();
        //查询成功的情况
        result.setCode(0);
        result.setMsg("success");
        try {
            long count = productDao.countProducts(productQuery);
            result.setCount(count);
            List<ProductCustom> data = productDao.listProductsByPage(pageInfo,productQuery);
            result.setData(data);
        } catch (Exception e) {
            //查询发生异常时的情况
            result.setCode(1);
            result.setMsg("failed");
            //查询发生异常时将进行日志输出(输出到控制台还是到日志文件,由logback.xml决定)
            logger.error(e.getMessage(), e);
        }
        return result;
    }

    @Override
    public int save(Product product) {

        return productDao.insert(product);
    }

    @Override
    public int remove(int pid) {
        return productDao.delete(pid);

    }

    @Override
    public int  modify(Product product) {

        return productDao.update(product);
    }

    @Override
    public int modifyByIshot(Integer is_hot,Integer pid) {
        return productDao.updateByIshot(is_hot,pid);
    }
}
