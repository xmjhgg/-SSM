package com.xmj.dao;

import com.xmj.pojo.Blog;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;

import java.util.List;

public interface BlogDao {


    @Insert("Insert into t_blog (blog_title,blog_note,blog_context2,blog_context,blog_class,blog_issueTime,blog_img,blog_author,blog_readNumber) " +
                                    "values (#{blogTitle},#{blogNote},#{blogContext2},#{blogContext},#{blogClass},#{issueTime}," +
                                             "#{blogImg},#{blog_author},0)")
    public Integer addBlog(@Param("blogTitle") String blogTitle, @Param("blogNote") String blogNote,@Param("blogContext2")String blogContext2,
                           @Param("blogContext") String blogContext,@Param("blogClass") String blogClass, @Param("blogImg") String blogImg,@Param("issueTime") String issueTime,@Param("blog_author")Integer blog_author );


    @Select("select * from t_blog where blog_author=#{authorId}")
    @Results({
            @Result(id = true,property = "blogId",column = "blog_id"),
            @Result(property = "blogTitle",column = "blog_title"),
            @Result(property = "blogNote",column = "blog_note"),
            @Result(property = "blogContext",column = "blog_context"),
            @Result(property = "blogClass",column = "blog_class"),
            @Result(property = "author",column = "blog_author",one = @One(select = "com.xmj.dao.AuthorDao.selectAuthorById",fetchType = FetchType.LAZY))
    })
    public List<Blog> selectBlogByAuthorId(Integer authorId);

    @Select("select * from t_blog where blog_id = #{blogId}")
    @Results({
            @Result(id = true,property = "blogId",column = "blog_id"),
            @Result(property = "blogTitle",column = "blog_title"),
            @Result(property = "blogNote",column = "blog_note"),
            @Result(property = "blogImg",column = "blog_img"),
            @Result(property = "blogContext2",column = "blog_context2"),
            @Result(property = "blogContext",column = "blog_context"),
            @Result(property = "issueTime",column = "blog_issueTime"),
            @Result(property = "blogClass",column = "blog_class"),
            @Result(property = "readNumber",column = "blog_readNumber"),
            @Result(property = "author",column = "blog_author",one = @One(select = "com.xmj.dao.AuthorDao.selectAuthorById",fetchType = FetchType.LAZY)),
            @Result(property = "comments",column = "blog_id",many = @Many(select = "com.xmj.dao.CommentDao.selectComtentByBlogId",fetchType = FetchType.LAZY))
    })
    public Blog selectBlogByBlogId(Integer blogId);

    @Update("update t_blog set blog_title=#{blogTitle},blog_Note=#{blogNote}," +
            "blog_context2=#{blogContext2},blog_context=#{blogContext},blog_class=#{blogClass} where blog_id=#{blogId}")
    public int updateBlogByBlogId(@Param("blogId") Integer blogId,@Param("blogTitle")String blogTitle,
                                  @Param("blogNote") String blogNote,@Param("blogContext2") String blogContext2,@Param("blogContext") String blogContext,
                                  @Param("blogClass") String blogClass);

    @Delete("delete from t_blog where blog_id=#{blogId}")
    public int deleteBlogByBlogId(Integer blogId);


    @Select("select * from t_blog where blog_class = #{blogClass}")
    @Results({
            @Result(id = true,property = "blogId",column = "blog_id"),
            @Result(property = "blogTitle",column = "blog_title"),
            @Result(property = "blogNote",column = "blog_note"),
            @Result(property = "blogImg",column = "blog_img"),
            @Result(property = "blogContext2",column = "blog_context2"),
            @Result(property = "blogContext",column = "blog_context"),
            @Result(property = "issueTime",column = "blog_issueTime"),
            @Result(property = "blogClass",column = "blog_class"),
            @Result(property = "readNumber",column = "blog_readNumber"),
            @Result(property = "author",column = "blog_author",one = @One(select = "com.xmj.dao.AuthorDao.selectAuthorById",fetchType = FetchType.LAZY)),
            @Result(property = "comments",column = "blog_id",many = @Many(select = "com.xmj.dao.CommentDao.selectComtentByBlogId",fetchType = FetchType.LAZY))
    })
    public List<Blog> selectBlogByBlogClass(String blogClass);

    @Select("SELECT * from t_blog")
    @Results({
            @Result(id = true,property = "blogId",column = "blog_id"),
            @Result(property = "blogTitle",column = "blog_title"),
            @Result(property = "blogNote",column = "blog_note"),
            @Result(property = "blogImg",column = "blog_img"),
            @Result(property = "blogContext2",column = "blog_context2"),
            @Result(property = "blogContext",column = "blog_context"),
            @Result(property = "issueTime",column = "blog_issueTime"),
            @Result(property = "blogClass",column = "blog_class"),
            @Result(property = "readNumber",column = "blog_readNumber"),
            @Result(property = "author",column = "blog_author",one = @One(select = "com.xmj.dao.AuthorDao.selectAuthorById",fetchType = FetchType.LAZY)),
            @Result(property = "comments",column = "blog_id",many = @Many(select = "com.xmj.dao.CommentDao.selectComtentByBlogId",fetchType = FetchType.LAZY))
    })
    public List<Blog> selectAllBlogs();




    @Select("select * from t_blog ORDER BY blog_readNumber desc LIMIT 5")
    @Results({
            @Result(id = true,property = "blogId",column = "blog_id"),
            @Result(property = "blogTitle",column = "blog_title"),
            @Result(property = "blogNote",column = "blog_note"),
            @Result(property = "blogImg",column = "blog_img"),
            @Result(property = "blogContext",column = "blog_context"),
            @Result(property = "issueTime",column = "blog_issueTime"),
            @Result(property = "blogClass",column = "blog_class"),
            @Result(property = "readNumber",column = "blog_readNumber"),
            @Result(property = "author",column = "blog_author",one = @One(select = "com.xmj.dao.AuthorDao.selectAuthorById",fetchType = FetchType.LAZY)),
    })
    public List<Blog> selectFiveHotBlogs();


    @Update("update t_blog  set blog_readNumber=blog_readNumber+1 where blog_id =#{blogId}")
    public int updateBlogReadNumberAddOne(Integer blogId);


    @Select("select * from t_blog where blog_title like concat('%',#{key},'%')")
    @Results({
            @Result(id = true,property = "blogId",column = "blog_id"),
            @Result(property = "blogTitle",column = "blog_title"),
            @Result(property = "blogNote",column = "blog_note"),
            @Result(property = "blogImg",column = "blog_img"),
            @Result(property = "blogContext2",column = "blog_context2"),
            @Result(property = "blogContext",column = "blog_context"),
            @Result(property = "issueTime",column = "blog_issueTime"),
            @Result(property = "blogClass",column = "blog_class"),
            @Result(property = "readNumber",column = "blog_readNumber"),
            @Result(property = "author",column = "blog_author",one = @One(select = "com.xmj.dao.AuthorDao.selectAuthorById",fetchType = FetchType.LAZY)),
    })
    public List<Blog> selectBlogsByKey(@Param("key") String key);



}
