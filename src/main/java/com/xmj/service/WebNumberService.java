package com.xmj.service;

import com.xmj.pojo.WebNumber;
import org.springframework.transaction.annotation.Transactional;

public interface WebNumberService {

    @Transactional
    public WebNumber selectReadNumber();

    @Transactional
    public int updateReadNumberAdd();

    @Transactional
    public int updateCommentNumberAdd();

}
