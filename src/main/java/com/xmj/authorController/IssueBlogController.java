package com.xmj.authorController;


import com.xmj.pojo.Author;
import com.xmj.service.BlogService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.SimpleFormatter;

@Controller
public class IssueBlogController {

    @Autowired
    BlogService blogService;

    @RequestMapping("/author/issueBlog")
    @ResponseBody
    public Map issueBlog(MultipartFile blogImg,String blogTitle, String blogNote,String blogContext2,
                         String blogContext, String blogClass,HttpSession session) throws IOException {
        Author author= (Author) session.getAttribute("user");
        Date currentDate=new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String issueTime=sdf.format(currentDate);

        int row=blogService.addBlog(blogTitle,blogNote,blogContext2,blogContext,blogClass,issueTime,blogImg,author.getId());

        Map result=new HashMap();
        if (row>0){
            result.put("msg","OK");
        }else {
            result.put("msg","FAIL");
        }
        return result;
    }
}
