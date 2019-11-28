package com.xmj.authorController;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.xmj.dao.BlogDao;
import com.xmj.pojo.Blog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;



@Controller
public class BlogMangerLookBlogController {

    @Autowired
    BlogDao blogDao;

    @RequestMapping("/author/blogMangerBlogLook")
    @ResponseBody
    public Map blogMangerBlogLook(@RequestBody Map map){
        Integer id= (Integer) map.get("blogId");
        Map result=new HashMap();
        Blog blog=blogDao.selectBlogByBlogId(id);
        result.put("blogId",blog.getBlogId());
        result.put("blogTitle",blog.getBlogTitle());
        result.put("blogNote",blog.getBlogNote());
        result.put("blogClass",blog.getBlogClass());
        result.put("blogContext",blog.getBlogContext());
        result.put("blogContext2",blog.getBlogContext2());
        return  result;
    };
}
