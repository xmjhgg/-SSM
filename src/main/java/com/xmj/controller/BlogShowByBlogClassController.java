package com.xmj.controller;


import com.xmj.dao.BlogDao;
import com.xmj.pojo.Blog;
import com.xmj.service.BlogService;
import com.xmj.until.BlogListSort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class BlogShowByBlogClassController {

    @Autowired
    BlogService blogService;

    @RequestMapping("/blogShowByBlogClass")
    public String BlogShowByBlogClassController(@RequestBody Map data, HttpSession session){
        String blogClass= (String) data.get("blogClass");
        List<Blog> allBlogs;
        if (blogClass.equals("所有博客")){
            allBlogs=blogService.selectAllBlogs();
        }else {
            allBlogs=blogService.selectBlogByBlogClass(blogClass);
        }
        for (Blog b:allBlogs) {
            if (b.getBlogContext2().length()<50){
                b.setBlogContext2(b.getBlogContext2().substring(0,b.getBlogContext2().length())+".....");
                }
            else {
                b.setBlogContext2(b.getBlogContext2().substring(0,50)+".....");
                }
            b.setIssueTime(b.getIssueTime().substring(0,16));
        }
        BlogListSort blogListSort=BlogListSort.getInstance();
        blogListSort.blogsSortByTime(allBlogs);


        List<Blog> blogs=new ArrayList<>();
        String pageIndex2=(String) data.get("pageIndex");
        int pageIndex=Integer.parseInt(pageIndex2);
        int pageStart=0;
        int isBack= (int) data.get("isBack"); //0第一页，1前进，2后退
        int pageIsEnd=0;
        switch (isBack){
            case 0:
                pageStart=0;break;
            case 1:
                pageStart=pageIndex*5;
                pageIndex++;
                break;

            case 2:
                pageIndex--;
                pageStart=(pageIndex-1)*5;
                break;
        }
        int pageSize;
        if (pageStart+5<allBlogs.size()){
            pageSize=5;
            pageIsEnd=0;
        }else {
            pageSize=allBlogs.size()-pageStart;
            pageIsEnd=1;
        }
        for (int i=pageStart,j=0;j<pageSize;j++,i++){
            blogs.add(allBlogs.get(i));
        }

        for (Blog b:blogs){
            b.setBlogCommentNumber(b.getComments().size());
            System.out.println(b.getBlogCommentNumber());
        }

        session.setAttribute("allBlogsNumber",allBlogs.size());
        session.setAttribute("blogs",blogs);
        session.setAttribute("pageIndex",pageIndex);
        session.setAttribute("pageIsEnd",pageIsEnd);
        session.setAttribute("blogClass",blogClass);
        return "blog";
    }


}
