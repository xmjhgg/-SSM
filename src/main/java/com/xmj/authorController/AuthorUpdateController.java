package com.xmj.authorController;


import com.xmj.pojo.Author;
import com.xmj.service.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
public class AuthorUpdateController {

    @Autowired
    AuthorService authorService;

    //拦截请求，使用这个方法对这个请求进行处理
    @RequestMapping("/author/authorUpdate")

    //返回json数据
    @ResponseBody

    //获取前端传过来的数据，封装到作者实体类中
    public Map authorUpdate(@RequestParam("headImg") MultipartFile headImg, @RequestParam("authorIntroduce") String authorIntroduce, HttpSession session) throws IOException {
        Author author= (Author) session.getAttribute("user");

        //调用service，将作者信息传到数据库中进行修改
        int row = authorService.updateAuthorIntroduceOrHeadImg(author,authorIntroduce,headImg);

        //得到修改后的作者信息
        Author author1=authorService.selectAuthorById(author.getId());

        //这个作为json数据返回给前端
        Map result=new HashMap();
        //将修改后的作者信息返回给前端
        result.put("authorHeadImg",author1.getHeadImg());
        result.put("authorIntroduce",author1.getIntroduce());
        if (row>0){
            result.put("msg","OK");
        }else {
            result.put("msg","FAIL");
        }
        return result;
    }



    }
