package com.xmj.until;

import com.xmj.pojo.Blog;
import com.xmj.pojo.Comment;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

//此处也使用了单例模式
public class CommentListSort {

    private static  CommentListSort instance;
    private CommentListSort (){}

    public static CommentListSort getInstance() {
        if (instance == null) {
            instance = new CommentListSort();
        }
        return instance;
    }

    public void commentSortByTime(List<Comment> list){
     Collections.sort(list, new Comparator<Comment>() {

        SimpleDateFormat sdf=new SimpleDateFormat("yy-MM-dd");
        @Override
        public int compare(Comment o1, Comment o2) {
            try {
                Date date1=sdf.parse(o1.getCommentTime());
                Date date2=sdf.parse(o2.getCommentTime());
                if (date1.getTime()>date2.getTime()){
                    return -1;
                }else if(date1.getTime()<date2.getTime()){
                    return 1;
                }else {
                    return 0;
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
            return 0;
        }
    });


}
}
