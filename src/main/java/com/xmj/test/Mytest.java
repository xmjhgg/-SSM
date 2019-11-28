package com.xmj.test;

import com.xmj.dao.AuthorDao;
import com.xmj.dao.BlogDao;
import com.xmj.pojo.Author;
import com.xmj.pojo.Blog;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class Mytest {

    ApplicationContext context=new ClassPathXmlApplicationContext("spring.xml");


    @Test
    public void mytest(){
        AuthorDao authorDao= (AuthorDao) context.getBean("authorDao");
        Author author=authorDao.selectAuthorBlogsById(9);

        List<Blog> blogs=author.getBlogs();

        for (Blog b:blogs){
            System.out.println(b);
        }

    }



}
