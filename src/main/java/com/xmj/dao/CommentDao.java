package com.xmj.dao;

import com.xmj.pojo.Comment;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;

import java.util.List;

public interface CommentDao {


    @Insert("insert into t_comment (comment_name,comment_context,comment_time,comment_blog) " +
            "values (#{commentName},#{commentContext},#{commentTime},#{blogId})")
    public int addComment(@Param("commentName") String comentName,@Param("commentContext") String commentContext,
                          @Param("commentTime")String commentTime, @Param("blogId")Integer blogId);


    @Results({
            @Result(id = true,property = "commentId",column = "comment_id"),
            @Result(property = "commentName",column = "comment_name"),
            @Result(property = "commentContext",column = "comment_context"),
            @Result(property = "commentTime",column = "comment_time"),
            @Result(property = "blog",column = "comment_blog"),
    })
    @Select("select * from t_comment where comment_blog = #{blogId}")
    public List<Comment> selectComtentByBlogId(Integer blogId);

}
