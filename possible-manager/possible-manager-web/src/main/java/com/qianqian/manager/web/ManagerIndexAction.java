package com.qianqian.manager.web;

import com.qianqian.common.pojo.dto.ProductResult;
import com.qianqian.common.pojo.dto.PageInfo;
import com.qianqian.manager.pojo.po.Category;
import com.qianqian.manager.pojo.po.Product;
import com.qianqian.manager.pojo.vo.ProductCustom;
import com.qianqian.manager.pojo.vo.ProductQuery;
import com.qianqian.manager.service.CategoryService;
import com.qianqian.manager.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

/**
 * User: DHC
 * Date: 2018/10/25
 * Time: 15:28
 * Version:V1.0
 */
@Controller
public class ManagerIndexAction {
    @Autowired
    private ProductService productService;
    @Autowired
    private CategoryService categoryService;
    @GetMapping("/{path}")
    public String index1(@PathVariable String path) {
        return path;
    }

    @GetMapping("/pages/{path}")
    public String index2(@PathVariable String path) {
        return "pages/" + path;
    }

    @GetMapping("/pages/{path1}/{path2}")
    public String index3(@PathVariable String path1, @PathVariable String path2) {
        return "pages/" + path1 + "/" + path2;
    }

    //显示页面数据回显
    @ResponseBody
    @GetMapping("/products")
    public ProductResult<ProductCustom> listProductsByPage(PageInfo pageInfo, ProductQuery productQuery){
        return productService.listProductsByPage(pageInfo, productQuery);
    }

    //查询分类信息并回显
    @ResponseBody
    @GetMapping("/showcategory")
    public List<Category> findcategory(){
        List<Category> categorys = categoryService.findCategory();
        return categorys;
    }

    //新增数据
    @ResponseBody
    @GetMapping("/addproduct")
    public int doAddProduct(Product product){
        product.setPdate(new Date());
        product.setPimage("aaa");
        product.setIs_hot(1);
        int message = productService.save(product);
        return message;
    }

    //批量删除数据(包含删除数据)
    @ResponseBody
    @PostMapping("/products/batch")
    public int doDeleteMoreProduct(@RequestParam("ids[]") List<Integer> ids){
        int message = 0;
        for (Integer pid:ids){
            message += productService.remove(pid);
        }
        return message;
    }

    //修改商品的是否热门信息
    @ResponseBody
    @PostMapping("/products/ishot")
    public int doEditIshotProduct(@RequestParam("is_hot") Integer is_hot,@RequestParam("pid") Integer pid){
        System.out.println(is_hot);
        System.out.println(pid);
        return productService.modifyByIshot(is_hot,pid);
    }

    //修改数据
    @ResponseBody
    @GetMapping("/editproduct")
    public int doEditProduct(Product product){
        product.setPdate(new Date());
        int message = productService.modify(product);
        return message;
    }


}
