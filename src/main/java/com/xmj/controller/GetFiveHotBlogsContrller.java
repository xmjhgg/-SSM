package com.xmj.controller;

import com.xmj.pojo.Blog;
import com.xmj.service.BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class GetFiveHotBlogsContrller {

    @Autowired
    BlogService blogService;

    @RequestMapping("/getFiveHotBlogs")
    @ResponseBody
    public Map getFiveHotBlogs(){
        List<Blog> blogs=blogService.selectFiveHotBlogs();
        Map result=new HashMap(); //这个作为json数据返回给前端
        result.put("blogs",blogs);//把查询到的5条热门博客放入
        return result;//返回给前端页面
    }


}
