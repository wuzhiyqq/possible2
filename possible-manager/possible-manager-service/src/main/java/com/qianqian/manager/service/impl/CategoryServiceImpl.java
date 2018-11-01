package com.qianqian.manager.service.impl;

import com.qianqian.manager.dao.CategoryMapper;
import com.qianqian.manager.pojo.po.Category;
import com.qianqian.manager.service.CategoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CategoryServiceImpl implements CategoryService {
    //要使用接口，不需要使用具体实现（log4j logback）
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private CategoryMapper categoryDao;
    @Override
    public List<Category> findCategory() {
        List<Category> data = categoryDao.findCategory();
        return data;
    }
}
