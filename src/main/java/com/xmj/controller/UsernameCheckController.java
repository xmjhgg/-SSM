package com.xmj.controller;

import com.xmj.pojo.Author;
import com.xmj.service.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsernameCheckController {

    @Autowired
    AuthorService authorService;
    @RequestMapping("/usernameCheck")
    @ResponseBody
    public String usernameCheck(@RequestBody Author author){
        String username=author.getUsername();
        if (username==null||username.length()<=0){
            return "NONE";
        }
        String tempusername=authorService.selectAuthorUsername(username);
        if (tempusername!=null){
            return "EXIST";
        }else {
            return "OK";
        }
    }
}
