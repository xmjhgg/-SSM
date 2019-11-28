package com.xmj.controller;

import com.xmj.pojo.WebNumber;
import com.xmj.service.WebNumberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class WebUpdateReadContrller {
    @Autowired
    WebNumberService webNumberService;


    @RequestMapping("/updateReadNumber")
    @ResponseBody
    public Map updateRead(HttpSession session){

        webNumberService.updateReadNumberAdd();
        WebNumber webNumber=webNumberService.selectReadNumber();
        System.out.println(webNumber);
        session.setAttribute("webNumber",webNumber);

        Map result =new HashMap();
        result.put("webNumber",webNumber);
        System.out.println(1);
        return  result;

    }


}
