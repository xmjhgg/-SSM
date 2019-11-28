package com.xmj.authorController;

import com.xmj.dao.BlogDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BogMangerUpdateBlogContrller {

    @Autowired
    BlogDao blogDao;

    @RequestMapping("/author/blogMangerUpdateBlog")
    @ResponseBody
    public String blogMangerUpdateBlog(Integer blogId,String blogTitle, String blogNote,String blogContext2, String blogContext, String blogClass){
        int row=blogDao.updateBlogByBlogId(blogId,blogTitle,blogNote,blogContext2,blogContext,blogClass);
        if (row>0){
            return "OK";
        }
        else {
            return "FAIL";
        }
    }
}
