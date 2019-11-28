package com.xmj.service;


import com.xmj.dao.CommentDao;
import com.xmj.pojo.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("commentService")
public class CommentServiceImpl implements CommentService {

    @Autowired
    CommentDao commentDao;

    @Override
    public int addComment(String comentName, String commentContext, String commentTime, Integer blogId) {
        return commentDao.addComment(comentName,commentContext,commentTime,blogId);
    }

    @Override
    public List<Comment> selectComtentByBlogId(Integer blogId) {
        return commentDao.selectComtentByBlogId(blogId);
    }
}
