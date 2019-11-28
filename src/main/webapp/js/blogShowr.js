function getBlogsByBlogClass(blogClass,pageIndex,isBack) {

    $.ajax({
        url:'/blogShowByBlogClass',
        type:'post',
        dayaType:"json",
        contentType:"application/json;charset=UTF-8",
        data:JSON.stringify({
            blogClass:blogClass,
            pageIndex:pageIndex,
            isBack:isBack
        }),
        success:function() {
            $("#pageBlogClass").html(blogClass);
            window.location.href = "blog.jsp";
        }
    })
}