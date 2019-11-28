package com.xmj.until;

import com.xmj.pojo.Blog;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

//此处使用了设计模式中的单例模式
public class BlogListSort {

    private static BlogListSort instance;
    private BlogListSort (){}

    public static BlogListSort getInstance() {
        if (instance == null) {
            instance = new BlogListSort();
        }
        return instance;
    }

    public void blogsSortByTime(List<Blog> list){

        Collections.sort(list, new Comparator<Blog>() {

            SimpleDateFormat sdf=new SimpleDateFormat("yy-MM-dd");
            @Override
            public int compare(Blog o1, Blog o2) {
                try {
                    Date date1=sdf.parse(o1.getIssueTime());
                    Date date2=sdf.parse(o2.getIssueTime());
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
