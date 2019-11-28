
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" >
    <link rel="stylesheet" href="css/myheader.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/blogShowr.js"></script>

    <style>
        .mynavigationa-img{height:250px;background-color: #343434;color: white}

        #blogContextCSS table {
            border-top: 1px solid #ccc;
            border-left: 1px solid #ccc;
        }
        #blogContextCSS table td,
        #blogContextCSS table th {
            border-bottom: 1px solid #ccc;
            border-right: 1px solid #ccc;
            padding: 3px 5px;
        }
        #blogContextCSS table th {
            border-bottom: 2px solid #ccc;
            text-align: center;
        }

        /* blockquote 样式 */
        #blogContextCSS blockquote {
            display: block;
            border-left: 8px solid #d0e5f2;
            padding: 5px 10px;
            margin: 10px 0;
            line-height: 1.4;
            font-size: 100%;
            background-color: #f1f1f1;
        }

        /* code 样式 */
        #blogContextCSS code {
            display: inline-block;
            *display: inline;
            *zoom: 1;
            background-color: #f1f1f1;
            border-radius: 3px;
            padding: 3px 5px;
            margin: 0 3px;
        }
        #blogContextCSS pre code {
            display: block;
        }
        /* ul ol 样式 */
        #blogContextCSS ul, ol {
            margin: 10px 0 10px 20px;
        }


    </style>

    <script>


        $(document).ready(function() {
            $("#issueCommentTip").hide(); //隐藏评论提示

            var pageUrl=window.location+'';
            var index=pageUrl.lastIndexOf('\?')+8;
            var blogId=parseInt(pageUrl.substr(index,pageUrl.length)); //从URL中截取出博客的ID，转换为Int类型

            $.ajax({
                url:'/getBlogInfoShow',
                type:'post',
                dayaType:"json",
                contentType : "application/json;charset=UTF-8",
                data:JSON.stringify( {
                    blogId:blogId
                }),

                success:function (data) {
                    var blog=data.blog; //获取后端传过来的博客数据
                    $("#blogTitle").html(blog.blogTitle);
                    $("#blogIssueTime").html(blog.issueTime);
                    $("#blogAuthorName").html(blog.author.name);
                    $("#blogContext").html(blog.blogContext);
                    $("#blogReadNumber").html(blog.readNumber);
                    $("#blogAutherNote").html(blog.blogNote);
                    $("#blogAuthorImg").html(blog.author.headImg);
                    $("#blogAuhtorName2").html(blog.author.name);
                    $("#blogAuthorIntroduce").html(blog.author.introduce);


                    $("#blogId").val(blog.blogId);
                    $("#blogAuthorImg").attr('src',blog.author.headImg);

                    var commentListHtml='';
                    var comments=blog.comments;
                    for (var i=0;i<comments.length;i++){ //因为评论有多条数据，所以通过for循环将每条评论取出，再进行处理
                        var commnetHtml=''
                        commnetHtml='<span class="h4">'+comments[i].commentName+'：</span>' +
                            '<span class="h4">'+comments[i].commentContext+'</span>&nbsp;&nbsp;&nbsp;' +
                            '<span>评论于：'+comments[i].commentTime+'</span><br/><br/>';
                        commentListHtml+=commnetHtml;
                    }
                    $("#commentList").html(commentListHtml); //将组装好的评论的H5代码放入DIV中



                }
            })

            $("#commentSubmitBtn").click(function() {
                $("#issueCommentTip").hide();
                if ($("#commentName").val()==''||$("#commentContext").val()==''){
                    $("#issueCommentTip").show();
                    return;
                }
                var commentFormData=new FormData($("#issueCommentFormData")[0]);
                $.ajax({
                    url:'/issueComent',
                    type:'post',
                    cache:false,
                    processData:false,
                    contentType:false,
                    data:commentFormData,
                    success:function(data) {
                        alert('评论成功！');
                        var commnetHtml='';
                        commnetHtml+='<span class="h4">'+data.commentName+'：</span>' +
                            '<span class="h4">'+data.commentContext+'</span>&nbsp;&nbsp;&nbsp;' +
                            '<span>评论于：'+data.commentTime+'</span><br/><br/>';
                        commnetHtml+=$("#commentList").html()
                        $("#commentList").html(commnetHtml);
                    }
                })
            })



        })
    </script>
</head>
<body>
<div id="header">
    <div  id="mynavigation">

        <nav class="navbar mynavigationa row" role="navigation">
            <!--col-md-6 设置div的宽度,offset设置列的偏移度-->
            <div class="col-md-8 col-lg-offset-4 ">
                <ul class="nav navbar-nav ">
                    <li>
                        <a href="index.jsp">HOME</a>
                    </li>

                    <li class="dropdown">
                        <a href="blog.jsp" class="dropdown-toggle" data-toggle="dropdown">
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
                <div class="row">
                    <div class="col-md-4 col-lg-offset-1 left lead">
                        本站至今..<br>
                        已有<SPAN id="webReadNumber">${sessionScope.webNumber.readNumber}</SPAN>人点击...<br>
                        <SPAN id="webCommentNumber">${sessionScope.webNumber.commentNumber}</SPAN>条评论..<br>
                    </div>

                    <div class="col-md-4 col-md-offset-5  welcom">
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
    </div>
</div>



<div class="row" style="margin-top: 45px;">

    <div class="col-md-1 col-md-offset-1">

    </div>

    <div class="col-md-8">
        <div class="text-center">

            <span id="blogTitle" class="h1"></span>
        </div>
        <div class="col-md-10 col-md-offset-2" style="margin-top: 20px">
            <span id="blogIssueTime" class="h4">2019-5-3 00:00:00</span>
            <span class="h4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;作者：</span>
            <span id="blogAuthorName" class="h4">等等</span>
            <span class="h4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;阅读数：</span>
            <span id="blogReadNumber" class="h4">30</span>
            <HR class="bolgHr" width="100%" align="left"/>
        </div>


        <div class="row" id="blogContextCSS">
            <span  class="lead" id="blogContext"></span>
            <HR class="bolgHr" width="80%" align="left"/>
        </div>

        <div class="row">
            <span class="h4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;作者备注：</span>
            <span id="blogAutherNote" class="h4"></span>
            <HR class="bolgHr" width="80%" align="left"/>
        </div>

        <div class="row">
            <div class="col-md-2">
                <img id="blogAuthorImg" src="" class="img-thumbnail img-responsive">

            </div>

            <div class="col-md-10" style="margin-top: 10px">
                <span class="h4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;作者：</span>
                <span id="blogAuhtorName2" class="h4"></span><br/><br/>
                <span class="h4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;作者简介：</span>
                <span id="blogAuthorIntroduce" class="h4"></span>

            </div>
            <div class="col-md-12">

                <HR class="bolgHr" width="80%" align="left"/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-10" id="commentList">
            </div>
            <HR class="bolgHr" width="80%" align="left"/>
        </div>

        <div class="row">
            <div class="col-md-8">
                <span class="h3">发布评论</span><span id="issueCommentTip" class="lead" style="margin-left: 60px;color: #c7254e">请将信息补充完整!</span>
                <form style="margin-top: 20px" id="issueCommentFormData">
                    <input type="text" name="blogId" id="blogId" style="display: none">
                    <span class="lead">评论昵称：</span>
                    <input  id="commentName" type="text" name="commentName" style="height: 30px;font-size: 20px;width: 300px"><br/><br/>
                    <span class="lead">评论内容：</span><br/><br/>
                    <textarea id="commentContext" name="commentContext" style="resize:none;font-size: 15px" rows="10" cols="80" ></textarea>
                    <button type="button" id="commentSubmitBtn" class="btn btn-info btn-lg" style="margin-left: 10px;margin-bottom: 35px">发表</button>
                </form>
            </div>
        </div>


    </div>

</div>




</body>
</html>
