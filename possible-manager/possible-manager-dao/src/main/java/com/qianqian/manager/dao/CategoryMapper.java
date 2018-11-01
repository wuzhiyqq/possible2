package com.qianqian.manager.dao;

import com.qianqian.manager.pojo.po.Category;

import java.util.List;


public interface CategoryMapper {

    /**
     *
     * @return
     */
    long countCategorys();

    /**
     *
     * @return
     */
    List<Category> findCategory();

}