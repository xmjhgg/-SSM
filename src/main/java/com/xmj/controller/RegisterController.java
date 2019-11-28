package com.xmj.controller;

import com.xmj.pojo.Author;
import com.xmj.service.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RegisterController {
    @Autowired
    AuthorService authorService;

    @RequestMapping("/register")
    @ResponseBody
    public String  register(@RequestBody Author author){
        int row=authorService.addAuthor(author);
        if (row>0){
            return "OK";
        }else {
            return "FAIL";
        }
    }
}
