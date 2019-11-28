package com.xmj.controller;

import com.xmj.pojo.Blog;
import com.xmj.pojo.Comment;
import com.xmj.service.BlogService;
import com.xmj.service.CommentService;
import com.xmj.until.CommentListSort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class GetBlogInfoShowController {

    @Autowired
    BlogService blogService;


    @RequestMapping("/getBlogInfoShow")
    @ResponseBody
    public Map getBlogInfoShow(@RequestBody Map data){

        Integer blogId= (Integer) data.get("blogId");
        Blog blog=blogService.selectBolgByBlogId(blogId); //查询数据库
        blogService.updateBlogReadNumberAddOne(blogId); //阅读数加一

        CommentListSort commentListSort=CommentListSort.getInstance();
        commentListSort.commentSortByTime(blog.getComments());//根据发表时间排序评论

        for (Comment c:blog.getComments()){
            c.setCommentTime(c.getCommentTime().substring(0,19)); //获取评论的时间（去掉末尾的0）
        }

        blog.setIssueTime(blog.getIssueTime().substring(0,19));

        Map result=new HashMap();
        result.put("blog",blog); //将博客放入result中，并返回resutl给前端处理
        return result;


    }

}
