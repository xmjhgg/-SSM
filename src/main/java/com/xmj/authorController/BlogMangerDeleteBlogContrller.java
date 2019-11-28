package com.xmj.authorController;

import com.xmj.service.BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class BlogMangerDeleteBlogContrller {

    @Autowired
    BlogService blogService;

    @RequestMapping("/author/blogMangerDeleteBlog")
    @ResponseBody
    public String blogMangerDeleteBlog(@RequestBody Map data){
        Integer blogId= (Integer) data.get("blogId");
        System.out.println(blogId);
        int row=blogService.deleteBlogByBlogId(blogId);
        System.out.println(row);
        if (row>0){
            return "OK";
        }else {
            return "FAIL";
        }
    }
}
