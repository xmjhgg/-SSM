package com.xmj.service;

import com.xmj.pojo.Blog;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface BlogService {

    @Transactional
    public Integer addBlog(String blogTitle,String blogNote,String blogContext2,String blogContext,String blogClass,String issueTime,MultipartFile blogImg,Integer authorId) throws IOException;

    @Transactional
    public Blog selectBolgByBlogId(Integer id);

    @Transactional
    public int updateBlogByBlogId(Integer blogId,String blogTitle, String blogNote, String blogContext2,String blogContext, String blogClass);

    @Transactional
    public int deleteBlogByBlogId(Integer blogId);

    @Transactional
    public List<Blog> selectBlogByBlogClass(String  blogClass);

    @Transactional
    public List<Blog> selectAllBlogs();

    @Transactional
    public List<Blog> selectFiveHotBlogs();


    @Transactional
    public int updateBlogReadNumberAddOne(Integer blogId);

    @Transactional
    public List<Blog> selectBlogByKey(String key);

}
