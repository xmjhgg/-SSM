package com.xmj.dao;


import com.xmj.pojo.Author;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;


public interface AuthorDao {
    @Insert("Insert into t_author (name,username,password)\n" +
            "                values(#{name},#{username},#{password})")
    public int addAuthor(Author author);

    @Select("select username from t_author where username=#{username}")
    public String selectUsername(String username);

    @Select("select id,username,password,name,introduce,headImg from t_author where username=#{username} and password=#{password}")
    public Author selectAuthorByUsernameAndPassword(@Param("username") String username, @Param("password") String password);

    @Select("select id,username,password,name,introduce,headImg from t_author where id=#{id}")
    public Author selectAuthorById(Integer id);

    @Update("update t_author set introduce=#{introduce} where id=#{id}")
    public int updateAuthorIntroduceById(@Param("id") Integer id,@Param("introduce") String introduce);

    @Update("update t_author set introduce=#{introduce},headImg=#{headImg} where id=#{id}")
    public int updateAuthorIntroduceAndHeadImgById(@Param("introduce") String introduce,@Param("headImg")String headImg,@Param("id")Integer id);

    @Update("update t_author set password=#{password} where id=#{id}")
    public int updateAuthorPasswordById(@Param("password") String password,@Param("id")Integer id);


    @Select("select * from t_author where id=#{id}")
    @Results({
            @Result(id = true,property = "id",column = "id"),
            @Result(property = "blogs",column = "id",many = @Many(select = "com.xmj.dao.BlogDao.selectBlogByAuthorId",fetchType = FetchType.LAZY))
    })
    public Author selectAuthorBlogsById(Integer id);

}
