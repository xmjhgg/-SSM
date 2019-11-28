package com.xmj.service;

import com.xmj.dao.WebNumberDao;
import com.xmj.pojo.WebNumber;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("webService")
public class WebServiceImpl implements WebNumberService {

    @Autowired
    WebNumberDao webNumberDao;

    @Override
    public WebNumber selectReadNumber() {
        return webNumberDao.selectReadNumber();
    }

    @Override
    public int updateReadNumberAdd() {
        return webNumberDao.updateReadNumberAdd();
    }

    @Override
    public int updateCommentNumberAdd() {
        return webNumberDao.updateCommentNumberAdd();
    }
}
