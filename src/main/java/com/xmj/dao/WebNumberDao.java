package com.xmj.dao;

import com.xmj.pojo.WebNumber;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface WebNumberDao {


    @Select("select * from t_web where id=1")
    public WebNumber selectReadNumber();

    @Update("update t_web set readNumber=readNumber+1 where id=1")
    public int updateReadNumberAdd();

    @Update("update t_web set commentNumber=commentNumber+1 where id=1")
    public int updateCommentNumberAdd();

}
