package com.qianqian.manager.dao;

import com.qianqian.common.pojo.dto.PageInfo;
import com.qianqian.manager.pojo.po.Product;
import com.qianqian.manager.pojo.vo.ProductCustom;
import com.qianqian.manager.pojo.vo.ProductQuery;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface ProductMapper {

    /**
     *查询商品总条数
     * @return
     * @param productQuery
     */
    long countProducts(@Param("productQuery")ProductQuery productQuery);

    /**
     *分页查询
     * @param pageInfo
     * @param productQuery
     * @return
     */
    List<ProductCustom> listProductsByPage(@Param("pageInfo")PageInfo pageInfo,@Param("productQuery") ProductQuery productQuery);

    /**
     * 增
     * @param product
     */
    int insert(Product product);

    /**
     * 删
     * @param pid
     */
    int delete(int pid);

    /**
     * 改
     * @param product
     */
    int update(Product product);

    /**
     * 修改是否热门信息
     * @param is_hot,pid
     * @return
     */
    int updateByIshot(@Param("is_hot") Integer is_hot,@Param("pid")Integer pid);
}