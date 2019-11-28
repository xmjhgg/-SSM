<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <meta charset="UTF-8">
    <title>Blog</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/myheader.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style>
        .hotBlogs{position: absolute;right: 200px}
        .commentListDiv{display: none}
    </style>

    <script>
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

        $(document).ready(function() {

            var pageGoBtn= $("#pageGoBtn");
            var pageBackBtn=$("#pageBackBtn");
            var blogClass=$("#pageBlogClass").html() ;
            var pageIndex=$("#pageIndex").html() ;

            if (pageGoBtn!=null){
                pageGoBtn.click(function() {
                    getBlogsByBlogClass(blogClass,pageIndex,1);
                })
            }
            if (pageBackBtn!=null){
                pageBackBtn.click(function() {
                    getBlogsByBlogClass(blogClass,pageIndex,2);
                })
            }

            $.ajax({
                url:'/getFiveHotBlogs',
                type:'post',

                success:function(data) {
                    var blogs=data.blogs;

                    $("#diYiHotBlog").html(blogs[0].blogTitle+'---'+blogs[0].author.name);
                    $("#diErHotBlog").html(blogs[1].blogTitle+'---'+blogs[1].author.name);
                    $("#diSanHotBlog").html(blogs[2].blogTitle+'---'+blogs[2].author.name);
                    $("#diSiHotBlog").html(blogs[3].blogTitle+'---'+blogs[3].author.name);
                    $("#diWuHotBlog").html(blogs[4].blogTitle+'---'+blogs[4].author.name);

                    $("#1hotBlog").attr("href","blogInfo.jsp?blogId="+blogs[0].blogId+"");
                    $("#2hotBlog").attr("href","blogInfo.jsp?blogId="+blogs[1].blogId+"");
                    $("#3hotBlog").attr("href","blogInfo.jsp?blogId="+blogs[2].blogId+"");
                    $("#4hotBlog").attr("href","blogInfo.jsp?blogId="+blogs[3].blogId+"");
                    $("#5hotBlog").attr("href","blogInfo.jsp?blogId="+blogs[4].blogId+"");
                }
            })


            $("#blogSearchBtn").click(function() {
                if ($("#blogSearchKey").val()==''){
                    return;
                }

                $.ajax({
                    url:'/searchBlogs',
                    type:'post',
                    dayaType:"json",
                    contentType:"application/json;charset=UTF-8",
                    data:JSON.stringify({
                        key:$("#blogSearchKey").val()
                    }),

                    success:function (data) {
                        if (data.msg=='NONE'){
                          alert("没有相关博客~")
                        } else {
                            window.location.href = "blog.jsp";
                        }

                    }


                })

            })

        })

        function commentShow(id) {
            var commentDiv=document.getElementsByName(id)[0];
            if (commentDiv.style.display=='block'){
                commentDiv.style.display='none';
            } else {
                commentDiv.style.display='block'
            }

        }

    </script>
</head>
<body>

<div  id="mynavigation">
    <nav class="navbar mynavigationa " role="navigation">
        <div class="col-md-10 col-lg-offset-2 ">
            <ul class="nav navbar-nav ">


                <li style="margin-top: 10px;margin-right:140px">
                    <input type="text" id="blogSearchKey" style="height: 28px;font-size: 15px">
                    <button type="button" class="btn btn-default" id="blogSearchBtn">搜索</button>
                </li>

                <li>
                    <a href="index.jsp">HOME</a>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        Blog
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu mynavigationa-menu">
                        <li><a href="#" id="allBlogBtn" onclick="getBlogsByBlogClass('所有博客','1',0)">所有博客</a></li>
                        <li><a href="#" id="studyNoteBlogBtn" onclick="getBlogsByBlogClass('学习笔记','1',0)">学习笔记</a></li>
                        <li><a href="#" id="errorNoteBlogBtn" onclick="getBlogsByBlogClass('错误记录','1',0)">错误记录</a></li>
                        <li><a href="#" id="projectConstructionBlogBtn" onclick="getBlogsByBlogClass('项目搭建','1',0)">项目搭建</a></li>
                        <li><a href="#" id="otherBlogBtn" onclick="getBlogsByBlogClass('其他','1',0)">其他</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">About</a>
                </li>
                <li>
                    <a href="#">Message Board</a>
                </li>
                <li>
                    <a href="admin.jsp">admin</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="row">
        <div class="col-md-12  mynavigationa-img">

            <div class="col-md-4 col-lg-offset-1 left lead">
                本站至今..<br>
                已有<SPAN id="webReadNumber">${sessionScope.webNumber.readNumber}</SPAN>人点击...<br>
                <%--X条留言...<br>--%>
                <SPAN id="webCommentNumber">${sessionScope.webNumber.commentNumber}</SPAN>条评论..<br>
            </div>

            <div class="col-md-6 col-lg-offset-5 welcom">
                <span>W</span>
                <span>E</span>
                <span>L</span>
                <span>C</span>
                <span>O</span>
                <span>M</span>
            </div>

            <div class="col-md-2 col-lg-offset-8">
                <p class="lead author">
                    关于作者：<br>
                    &nbsp;&nbsp;good good study,day day up!
                </p>
            </div>
        </div>
    </div>
</div>

    <div class="row" style="height: 50px">
        <div class="col-md-12"></div>
    </div>

    <div class="myBlogs row" id="myBlogs">
        <div class="col-md-11">
        <c:forEach items="${sessionScope.blogs}" var="blog">
            <div class="col-md-10">
                <a href="blogInfo.jsp?blogId=${blog.blogId}" style="color: black">
                    <div class="col-md-2 col-lg-offset-1">
                        <img src="${blog.blogImg}" class="img-thumbnail" style="width:200px;height: 180px">
                    </div>
                    <div class="col-md-4" style="margin-top: 11px;">
                        <span class="h3">${blog.blogTitle}</span><br/>
                        <span class="lead" id="blogContextStyle">&nbsp;&nbsp;${blog.blogContext2}</span>
                    </div>
                </a>
                <div class="col-md-4" style="margin-top: 90px">
                    <span class="lead">作者：${blog.author.name}</span><br/>
                    <span class="lead">博客类型：${blog.blogClass}</span><br/>
                    <span class="h4">发表时间：${blog.issueTime}</span>
                    <span class="h4">阅读量：${blog.readNumber}</span>
                    <button onclick="commentShow(${blog.blogId})" class="btn btn-default" style="margin-left: 10px" >
                        评论： <span>${blog.blogCommentNumber}</span>
                    </button>
                </div>

            </div>
            <div class="row">
                <div class="col-md-8 col-md-offset-1 commentListDiv" style="border: #8a6d3b solid 2px;padding: 10px"  name="${blog.blogId}">
                    <c:forEach items="${blog.comments}" var="comment">
                        <div class="col-md-12">
                            <span class="h4 col-md-5">${comment.commentName}：${comment.commentContext}</span>
                            <span class="h4 col-md-7">${comment.commentTime}</span>
                            <hr class="col-md-10" />
                        </div>
                    </c:forEach>
                </div>
            </div>


            <div class="col-md-10 col-lg-offset-1" style="height: 50px">
                <HR class="bolgHr" width="80%" align="left"/>
            </div>
        </c:forEach>
        </div>
        <div class="col-md-2 hotBlogs">
            <span class="h2">热门博客：<br/><br/></span>
            <div id="hotBlog" style="color: #843534">
                <a href="#" class="h1" id="1hotBlog"><span >[1]&nbsp;</span><span id="diYiHotBlog"></span></a><br/><br/>
                <a href="#" class="h2" id="2hotBlog"><span class="">[2]&nbsp;</span><span id="diErHotBlog"></span></a><br/><br/>
                <a href="#" class="h3" id="3hotBlog"><span class="">[3]&nbsp;</span><span id="diSanHotBlog"></span></a><br/><br/>
                <a href="#" class="h3" id="4hotBlog"><span class="">[4]&nbsp;</span><span id="diSiHotBlog"></span></a><br/><br/>
                <a href="#" class="h3" id="5hotBlog"><span class="">[5]&nbsp;</span><span id="diWuHotBlog"></span></a><br/><br/>
            </div>
        </div>

        <div class="col-md-4 col-md-offset-4" id="pageImpl">
            <span id="pageBlogClass" class="h3">${sessionScope.blogClass}</span> &nbsp;&nbsp;

            <c:if test="${sessionScope.pageIndex !=1}">
                <a href="#" id="pageBackBtn" class="btn btn-default"><<</a>
            </c:if>
            <span class="h4" id="pageIndex">${sessionScope.pageIndex}</span>
            <c:if  test="${sessionScope.pageIsEnd !=1}">
                <a href="#" id="pageGoBtn" class="btn-default btn">>></a>
            </c:if>
            <span class="h3">共${sessionScope.allBlogsNumber}条记录</span>

        </div>
    </div>




</body>
</html>