package com.xmj.controller;


import com.xmj.pojo.Author;
import com.xmj.service.AuthorService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    AuthorService authorService;
    @RequestMapping("/login")
    @ResponseBody
    public Map login(@RequestBody Author author,HttpSession session) {
        String username = author.getUsername().trim();
        String password = author.getPassword().trim();
        Map result=new HashMap();
        if (username == null && username.length() == 0 || password == null && password.length() == 0) {
            result.put("msg","NONE");
            return  result;
        }

        Author author1 = authorService.selectAuthorrByUsernameAndPassword(username,password);
        if (author1 != null) {
            session.setAttribute("user",author1);
            result.put("authorUsername",author1.getName());
            result.put("authorHeadImg",author1.getHeadImg());
            result.put("authorIntroduce",author1.getIntroduce());
            result.put("msg","OK");
            return result;
            }
            else {
            result.put("msg","FAIL");
            return result;
            }
    }
}
