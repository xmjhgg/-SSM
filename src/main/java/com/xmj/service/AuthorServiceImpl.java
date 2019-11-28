package com.xmj.service;


import com.xmj.dao.AuthorDao;
import com.xmj.pojo.Author;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Service("authorService")
public class AuthorServiceImpl implements AuthorService {

    @Autowired
    AuthorDao authorDao;

    @Override
    public int addAuthor(Author author) {
        return authorDao.addAuthor(author);
    }



    @Override
    public Author selectAuthorrByUsernameAndPassword(String username, String password) {
        return authorDao.selectAuthorByUsernameAndPassword(username,password);
    }

    @Override
    public int updateAuthorIntroduceOrHeadImg(Author author, String introduce, MultipartFile headImg) throws IOException {

        if (!headImg.isEmpty()){
            StringBuilder sb=new StringBuilder("D:\\Study\\java3\\matest\\src\\main\\webapp\\userimg\\");
            String contentType=headImg.getContentType();
            String suffixName=contentType.substring(contentType.indexOf("/")+1);
            String filename=author.getUsername()+"_headImg"+"."+suffixName;
            sb.append(filename);
            headImg.transferTo(new File(sb.toString()));
            String savaPath="userimg/"+filename;

            return authorDao.updateAuthorIntroduceAndHeadImgById(introduce,savaPath,author.getId());
        }else {
            return authorDao.updateAuthorIntroduceById(author.getId(),introduce);
        }

    }

    @Override
    public Author selectAuthorById(Integer id) {
        return authorDao.selectAuthorById(id);
    }

    @Override
    public int updateAuthorPasswordById(String password, Integer id) {
        return authorDao.updateAuthorPasswordById(password,id);
    }

    @Override
    public Author selectAuthorBlogsById(Integer id) {
        return authorDao.selectAuthorBlogsById(id);
    }


    public String selectAuthorUsername(String username) {
        return authorDao.selectUsername(username);
    }



}
