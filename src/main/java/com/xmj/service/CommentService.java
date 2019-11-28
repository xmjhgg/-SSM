package com.xmj.service;

import com.xmj.pojo.Comment;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface CommentService {

    @Transactional
    public int addComment(String comentName,String commentContext,String commentTime,Integer blogId);

    @Transactional
    public List<Comment> selectComtentByBlogId(Integer blogId);


}
