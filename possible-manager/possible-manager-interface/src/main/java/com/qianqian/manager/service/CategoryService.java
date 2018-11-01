package com.qianqian.manager.service;

import com.qianqian.common.pojo.dto.ProductResult;
import com.qianqian.manager.pojo.po.Category;

import java.util.List;

public interface CategoryService {
    List<Category> findCategory();
}
