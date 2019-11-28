package com.xmj.authorController;


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
public class AuthorUpdatePasswordController {

    @Autowired
    AuthorService authorService;

    @RequestMapping("/author/authorNumberUpdate")
    @ResponseBody
    public Map updateAuthorPassword(@RequestBody Map data, HttpSession session){

        Map result=new HashMap();
        String password= (String) data.get("password");
        System.out.println(data.get("password"));

        Author author= (Author) session.getAttribute("user");
        int row=authorService.updateAuthorPasswordById(password,author.getId());
        if (row>0){
            result.put("msg","OK");
        }else {
            result.put("msg","FAIL");
        }

        return result;

    }
}
