package com.xmj.service;

import com.xmj.dao.BlogDao;
import com.xmj.pojo.Blog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service("blogService")
public class BlogServiceImpl implements BlogService {

    @Autowired
    BlogDao blogDao;

    @Override
    public Integer addBlog(String blogTitle, String blogNote,String blogContext2, String blogContext, String blogClass,String issueTime,MultipartFile blogImg,Integer authorId) throws IOException {

        String blogImgSavaPath="";
        if (blogImg.isEmpty()){
            blogImgSavaPath="img/2.jpg";
        }else {
            StringBuilder sb=new StringBuilder("D:\\Study\\java3\\matest\\src\\main\\webapp\\blogimg\\");
            String contentType=blogImg.getContentType();
            String suffixName=contentType.substring(contentType.indexOf("/")+1);
            String filename=authorId+"_"+UUID.randomUUID()+"_blogimg."+suffixName;
            sb.append(filename);
            blogImg.transferTo(new File(sb.toString()));
            blogImgSavaPath="blogimg/"+filename;
        }
        return blogDao.addBlog(blogTitle,blogNote,blogContext2,blogContext,blogClass,blogImgSavaPath,issueTime,authorId);
    }

    @Override
    public Blog selectBolgByBlogId(Integer id) {
        return blogDao.selectBlogByBlogId(id);
    }

    @Override
    public int updateBlogByBlogId(Integer blogId, String blogTitle, String blogNote,String blogContext2,  String blogContext, String blogClass) {
        return blogDao.updateBlogByBlogId(blogId,blogTitle,blogNote,blogContext2,blogContext,blogClass);
    }

    @Override
    public int deleteBlogByBlogId(Integer blogId) {
        return blogDao.deleteBlogByBlogId(blogId);
    }

    @Override
    public List<Blog> selectBlogByBlogClass(String blogClass) {
        return blogDao.selectBlogByBlogClass(blogClass);
    }

    @Override
    public List<Blog> selectAllBlogs() {
        return blogDao.selectAllBlogs();
    }

    public List<Blog> selectFiveHotBlogs(){
        return  blogDao.selectFiveHotBlogs();
    }

    @Override
    public int updateBlogReadNumberAddOne(Integer blogId) {
        return blogDao.updateBlogReadNumberAddOne(blogId);
    }

    @Override
    public List<Blog> selectBlogByKey(String key) {
        return blogDao.selectBlogsByKey(key);
    }


}
