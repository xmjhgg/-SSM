package com.xmj.controller;

import com.xmj.pojo.WebNumber;
import com.xmj.service.CommentService;
import com.xmj.service.WebNumberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class CommentIssueCommentContrller {

    @Autowired
    CommentService commentService;

    @Autowired
    WebNumberService webNumberService;

    @RequestMapping("/issueComent")
    @ResponseBody
    public Map commentIssue(Integer blogId,String commentName,String commentContext){
        Date currentDate=new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String commentTime=sdf.format(currentDate).substring(0,19);
        Map result=new HashMap();
        int row=commentService.addComment(commentName,commentContext,commentTime,blogId);
        if (row>0){
            result.put("msg","OK");
        }else {
            result.put("msg","FAIL");
            return  result;
        }
        webNumberService.updateCommentNumberAdd();
        result.put("commentName",commentName);
        result.put("commentContext",commentContext);
        result.put("commentTime",commentTime);
        return result;
    }

}
