package com.xmj.authorController;

import com.xmj.pojo.Author;
import com.xmj.service.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class AuthorNumberGetController {

    @Autowired
    AuthorService authorService;

    @RequestMapping("/author/authorNumberGet")
    @ResponseBody
    public String authorNumberGet(HttpSession session){

        Author author= (Author) session.getAttribute("user");
        String username=authorService.selectAuthorById(author.getId()).getUsername();

        return username;


    }

}
