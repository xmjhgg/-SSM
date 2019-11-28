<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/bootstrap.min.css" >
    <link rel="stylesheet" href="css/myheader.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/blogShowr.js"></script>
    <title>index</title>

    <script>
        $(document).ready(function() {
            $.ajax({
                url:'/getFiveHotBlogs',
                type:'get',
                success:function(data) {
                    var blogs=data.blogs
                    $("#1Img").attr('src', blogs[0].blogImg);
                    $("#2Img").attr('src', blogs[1].blogImg);
                    $("#3Img").attr('src', blogs[2].blogImg);
                    $("#4Img").attr('src', blogs[3].blogImg);
                    $("#1ImgTitle").html(blogs[0].blogTitle)
                    $("#2ImgTitle").html(blogs[1].blogTitle)
                    $("#3ImgTitle").html(blogs[2].blogTitle)
                    $("#4ImgTitle").html(blogs[3].blogTitle)

                    $("#1ImgHref").attr("href","blogInfo.jsp?blogId="+blogs[0].blogId+"");
                    $("#2ImgHref").attr("href","blogInfo.jsp?blogId="+blogs[1].blogId+"");
                    $("#3ImgHref").attr("href","blogInfo.jsp?blogId="+blogs[2].blogId+"");
                    $("#4ImgHref").attr("href","blogInfo.jsp?blogId="+blogs[3].blogId+"");
                }

            })

            $.ajax({
                url:'/updateReadNumber',
                type:'post',
                success:function (data) {
                    $("#webReadNumber").html(data.webNumber.readNumber);
                    $("#webCommentNumber").html(data.webNumber.commentNumber);
                }
            })



        })



    </script>

</head>
<body>

<div  id="mynavigation">

    <nav class="navbar mynavigationa " role="navigation">
        <div class="col-md-8 col-lg-offset-4 ">
                <ul class="nav navbar-nav ">
                    <li>
                        <a href="#">HOME</a>
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
            本站至今..<br/>
            已有<span id="webReadNumber"></span>人点击...<br>
            <span id="webCommentNumber"></span>条评论..<br>
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
                关于网站：<br>
                &nbsp;&nbsp;good good study,day day up!
            </p>
        </div>
    </div>
</div>
</div>

<!--空白填充-->
    <div class="row">
        <div style="height: 80px;"></div>
    </div>

    <div class="row">
        <div class="col-md-8 col-lg-offset-4 goToBlog" style="height: 100px">

            <a href="#"onclick="getBlogsByBlogClass('所有博客','1',0)" class="btn btn-default" style="color:#696969">
                <span class="h2">
                    &nbsp;&nbsp; Go &nbsp;&nbsp; To &nbsp;&nbsp; Read &nbsp;&nbsp; Blogs &nbsp;&nbsp;
                </span>
            </a>
            
        </div>
    </div>

<div class="row">
    <div class="col-md-8 col-lg-offset-4">
        <span class="h1 lastTxt">
            L &nbsp;A&nbsp;T&nbsp;E&nbsp;S&nbsp;T &nbsp;&nbsp;&nbsp;&nbsp;S&nbsp;T&nbsp;O&nbsp;R&nbsp;I&nbsp;E&nbsp;S
        </span>
    </div>
</div>

<!--空白填充-->
<div class="row">
    <div class="col-md-12" style="height: 80px">

    </div>
</div>

<div class="row">
    <div class="col-md-12 headImg">
        <a href="#" id="1ImgHref">
            <div class="col-md-3 text-center lead">
                <img src="" class="img-thumbnail"id="1Img" STYLE="width: 400px;height: 300px"><br/>
                <span id="1ImgTitle" class="text-center"></span>

            </div>
        </a>
        <a href="#" id="2ImgHref">
            <div class="col-md-3 text-center lead">
                <img src="" class="img-thumbnail" id="2Img" STYLE="width: 400px;height: 300px"><br/>
                <span id="2ImgTitle"></span>
            </div>
        </a>

        <a href="#" id="3ImgHref">
        <div class="col-md-3 text-center lead">
            <img src="" class="img-thumbnail" id="3Img" STYLE="width: 400px;height: 300px"><br/>
            <span id="3ImgTitle"></span>
        </div>
        </a>

        <a href="#" id="4ImgHref">
        <div class="col-md-3 text-center lead">
            <img src="" class="img-thumbnail" id="4Img" STYLE="width: 400px;height: 300px"><br/>
            <span id="4ImgTitle"></span>
        </div>
        </a>

    </div>

</div>



</body>
</html>