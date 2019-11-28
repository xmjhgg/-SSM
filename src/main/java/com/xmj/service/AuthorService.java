package com.xmj.service;


import com.xmj.pojo.Author;
import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface AuthorService {
    @Transactional
    public int addAuthor(Author author);

    @Transactional
    public String selectAuthorUsername(String username);

    @Transactional
    public Author selectAuthorrByUsernameAndPassword(String String,String password);

    @Transactional
    public int updateAuthorIntroduceOrHeadImg(Author author,String introduce,MultipartFile headImg) throws IOException;

    @Transactional
    public Author selectAuthorById(Integer id);

    @Transactional
    public int updateAuthorPasswordById(String password,Integer id);

    @Transactional
    public Author selectAuthorBlogsById(Integer id);

}
