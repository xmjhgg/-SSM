package com.xmj.controller;

import com.xmj.dao.BlogDao;
import com.xmj.pojo.Blog;
import com.xmj.service.BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BlogSearchController {

    @Autowired
    BlogService blogService;

    @RequestMapping("/searchBlogs")
    @ResponseBody
    public Map searchBlog(@RequestBody Map data, HttpSession session){
        String searchKey= (String) data.get("key");
        List<Blog> blogs=blogService.selectBlogByKey(searchKey);
        Map result=new HashMap();
        if (blogs.size()==0){
            result.put("msg","NONE");
            return result;
        }else {
            result.put("msg","OK");
        }
        for (Blog b:blogs) {
            if (b.getBlogContext2().length()<50){
                b.setBlogContext2(b.getBlogContext2().substring(0,b.getBlogContext2().length())+".....");
            }else {
                b.setBlogContext2(b.getBlogContext2().substring(0,50)+".....");
            }
            b.setIssueTime(b.getIssueTime().substring(0,16));
        }
        session.setAttribute("blogs",blogs);
        return result;
    }


}
