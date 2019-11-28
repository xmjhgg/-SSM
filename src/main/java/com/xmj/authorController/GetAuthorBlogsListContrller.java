package com.xmj.authorController;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.sun.deploy.net.HttpResponse;
import com.xmj.pojo.Author;
import com.xmj.pojo.Blog;
import com.xmj.service.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@JsonIgnoreProperties
@Controller
public class GetAuthorBlogsListContrller {

    @Autowired
   AuthorService authorService;

    @RequestMapping("/author/getAuthorBlogsList")
    @ResponseBody
    public Map getAuthorBlogsList(HttpSession session){

        Author author = (Author) session.getAttribute("user");
        List<Blog> blogsList = authorService.selectAuthorBlogsById(author.getId()).getBlogs();
        Map result=new HashMap();
        result.put("blogsList",blogsList);
        if (blogsList!=null){
            result.put("msg","OK");
        }else {
            result.put("msg","NONE");
        }
        return result;



    }

}
