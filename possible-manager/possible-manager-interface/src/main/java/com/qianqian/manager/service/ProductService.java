package com.qianqian.manager.service;

import com.qianqian.common.pojo.dto.ProductResult;
import com.qianqian.common.pojo.dto.PageInfo;
import com.qianqian.manager.pojo.po.Product;
import com.qianqian.manager.pojo.vo.ProductCustom;
import com.qianqian.manager.pojo.vo.ProductQuery;

import java.util.List;

/**
 * 用于处理商品的业务逻辑层接口
 * User: DHC
 * Date: 2018/10/29
 * Time: 14:27
 * Version:V1.0
 */
public interface ProductService {
    /**
     * 带分页查询的商品查询
     * @param pageInfo
     * @param productQuery
     * @return
     */
    ProductResult<ProductCustom> listProductsByPage(PageInfo pageInfo, ProductQuery productQuery);

    /**
     * 增
     * @param product
     */
    int save(Product product);

    /**
     * 删
     * @param pid
     */
    int remove(int pid);

    /**
     * 改
     * @param product
     */
   int  modify(Product product);

    /**
     * 修改是否热门信息
     * @param is_hot,pid
     * @return
     */
    int modifyByIshot(Integer is_hot,Integer pid);
}
