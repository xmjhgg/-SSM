<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>admin</title>

    <link rel="stylesheet" href="css/myheader.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/blogShowr.js"></script>
    <script type="text/javascript" src="js/wangEditor.min.js"></script>
    <style>

        .all{height:980px;background: url("img/2.jpg") no-repeat;background-size: cover;color: 	#FFFFFF}
        .manage{height: 700px;background: url("img/5.jpg") no-repeat;background-size: contain ; display: block}
        .login{display: block}
        .register{display: none}
        .blogmanage{display: none;}
        .blogIssue{color: black;}
        #authorInfoUpdateDiv{display: block;}
        #authorNumberUpdateDiv{color: black;display: none}
        #blogMangerUpdate{color: black}

    </style>

    <script>


        $(document).ready(function() {

            $("#registerusernameTip").hide();
            $("#registerpasswordTip").hide();
            $("#registerpassword2Tip").hide();
            $("#registernameTip").hide();
            $("#loginPasswordTip").hide();
            $("#loginUsernameTip").hide();
            $("#loginErrorTip").hide();
            $("#blogIssueTitleTip").hide();
            $("#blogIssueContextTip").hide();
            $("#authorNumberUpdatePasswordTip").hide();
            $("#blogMangerUpdateTitleTip").hide();
            $("#blogMangerUpdateContextTip").hide();


            //wangEditor配置,发表博客
            var E = window.wangEditor;
            var editor = new E('#blogIssueContextEditerTop','#blogIssueContextEditerBottom');
            editor.customConfig.menus = [
                'head',  // 标题
                'bold',  // 粗体
                'fontSize',  // 字号
                'fontName',  // 字体
                'italic',  // 斜体
                'underline',  // 下划线
                'strikeThrough',  // 删除线
                'foreColor',  // 文字颜色
                'backColor',  // 背景颜色
                'link',  // 插入链接
                'list',  // 列表
                'justify',  // 对齐方式
                'quote',  // 引用
                'table',  // 表格
                'code',  // 插入代码
                'undo',  // 撤销
                'redo'  // 重复
            ];
            editor.create();

            //修改博客的wangEditor
            var F = window.wangEditor;
            var editor2 = new F('#blogMangerUpdateEditerTop','#blogMangerUpdateEditerBottom');
            editor2.customConfig.menus = [
                'head',  // 标题
                'bold',  // 粗体
                'fontSize',  // 字号
                'fontName',  // 字体
                'italic',  // 斜体
                'underline',  // 下划线
                'strikeThrough',  // 删除线
                'foreColor',  // 文字颜色
                'backColor',  // 背景颜色
                'link',  // 插入链接
                'list',  // 列表
                'justify',  // 对齐方式
                'quote',  // 引用
                'table',  // 表格
                'code',  // 插入代码
                'undo',  // 撤销
                'redo'  // 重复
            ];
            editor2.create();

            $("#submitRegister").attr('disabled',true);
            $("#loginbtn").attr('disabled',true);

            var registerBtnCheck=[0,0,0,0];
            var loginBtnCheck=[0,0];

            $("#goRegister").click(function() {
                $("#login").hide();
                $("#register").show();
            })

            $("#backLogin").click(function() {
                $("#login").show();
                $("#register").hide();
            })

            $("#loginUsername").blur(function() {
                if ($("#loginUsername").val().length==0) {
                    $("#loginUsernameTip").show();
                    loginBtnCheck[0]=0;
                    loginBtnCheckChange()
                    return
                }

                loginBtnCheck[0]=1;
                loginBtnCheckChange()
                $("#loginUsernameTip").hide();
            })

            $("#loginPassword").blur(function() {
                if ($("#loginPassword").val().length==0) {
                    $("#loginPasswordTip").show();
                    loginBtnCheck[1]=0;
                    loginBtnCheckChange()
                    return
                }
                loginBtnCheck[1]=1;
                loginBtnCheckChange()
                $("#loginPasswordTip").hide();
            })

            function loginBtnCheckChange(){
                var sum=0;
                for(i in loginBtnCheck){
                    sum+=Number(loginBtnCheck[i]);
                }
                if (sum==2){
                    $("#loginbtn").attr('disabled',false);
                } else {
                    $("#loginbtn").attr('disabled',true);
                }
            }

            $("#loginbtn").click(function(){
                    $.ajax({
                        url:"/login",
                        type:"post",
                        dayaType:"json",
                        contentType : "application/json;charset=UTF-8",
                        data:JSON.stringify( {
                            username:$("#loginUsername").val(),
                            password:$("#loginPassword").val()
                        }),

                        success:function (data) {
                            if (data.msg=="FAIL"){
                                $("#loginErrorTip").show();
                            }
                            else {
                                $("#authorName").html("你好,"+data.authorUsername);
                                if (data.authorHeadImg!=null){
                                    document.getElementById('authorHeadImg').src=data.authorHeadImg;
                                }
                                $("#authorIntroduce").html(data.authorIntroduce);
                                $("#login").hide();
                                $("#blogmanage").show()
                            }
                        }
                    })
                })

            $("#registerusername").blur(function() {
                if ( $("#registerusername").val()==""){
                    $("#registerusernameTip").html("请输入账号！");
                    $("#registerpasswordTip").show();
                    registerBtnCheck[0]=0;
                    registerBtnCheckChange()
                    return;
                }
                var isEmail=new RegExp("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$");
                if (!isEmail.test($("#registerusername").val())){
                    $("#registerusernameTip").html("请输入合法的邮箱！")
                    registerBtnCheck[0]=0;
                    registerBtnCheckChange()
                    return;
                }
                    $.ajax({
                        url:"/usernameCheck",
                        type:"post",
                        dayaType:"json",
                        contentType : "application/json;charset=UTF-8",
                        data:JSON.stringify( {
                            username:$("#registerusername").val()
                        }),
                        success:function (data) {
                            $("#registerusernameTip").show();
                            if (data=="NONE") {
                                $("#registerusernameTip").html("请输入邮箱！")
                                registerBtnCheck[0]=0;
                                registerBtnCheckChange()
                            }
                            if (data=="EXIST") {
                                $("#registerusernameTip").html("该邮箱已被注册！")
                                registerBtnCheck[0]=0;
                                registerBtnCheckChange()
                            }
                            if (data=="OK") {
                                $("#registerusernameTip").html("√该邮箱可以使用，邮箱注册后无法修改");
                                registerBtnCheck[0]=1;
                                registerBtnCheckChange()
                            }
                        }
                    })
            })

            $("#registerpassword").blur(function() {
                if ($("#registerpassword").val().length==0){
                    $("#registerpasswordTip").html("请输入密码");
                    $("#registerpasswordTip").show();
                    registerBtnCheck[1]=0;
                    registerBtnCheckChange()
                    return;
                }
                if ($("#registerpassword2").val().length!=0&&$("#registerpassword2").val()!=$("#registerpassword").val()) {
                    $("#registerpasswordTip").html("两次输入密码不一致");
                    $("#registerpasswordTip").show();
                    registerBtnCheck[1]=0;
                    registerBtnCheckChange()
                    return
                }
                    $("#registerpasswordTip").html("√密码合法");
                    $("#registerpasswordTip").show();
                    registerBtnCheck[1]=1;
                registerBtnCheckChange()
            })

            $("#registerpassword2").blur(function() {
                if ($("#registerpassword2").val()==""){
                    registerBtnCheck[2]=0;
                    $("#registerpassword2Tip").html("请再次输入密码");
                    $("#registerpassword2Tip").show();
                    registerBtnCheckChange()
                    return;
                }

                if ($("#registerpassword2").val()==$("#registerpassword").val()){
                    $("#registerpassword2Tip").show();
                    $("#registerpassword2Tip").html("√两次输入密码一致");
                    registerBtnCheck[2]=1;
                    registerBtnCheckChange()
                }else {
                    $("#registerpassword2Tip").show();
                    $("#registerpassword2Tip").html("两次输入密码不一致");
                    registerBtnCheck[2]=0;
                    registerBtnCheckChange()
                }


            })

            $("#registername").blur(function() {
                if ($("#registername").val().length==0){
                    $("#registernameTip").html("请输入姓名！")
                    $("#registernameTip").show();
                    registerBtnCheck[3]="0";
                    registerBtnCheckChange();
                    return
                }
                $("#registernameTip").html("√姓名合法，注册后无法修改")
                $("#registernameTip").show();
                registerBtnCheck[3]="1";
                registerBtnCheckChange()
            })

            function registerBtnCheckChange() {
                var sum=0;
                for( var i in registerBtnCheck ){
                    sum=Number(sum)+Number(registerBtnCheck[i]);
                }
                if (sum==4){
                    $("#submitRegister").attr('disabled',false);
                } else {
                    $("#submitRegister").attr('disabled',true);
                }
            }
            $("#submitRegister").click(function() {
                $.ajax({
                    url:"/register",
                    type:"post",
                    dayaType:"json",
                    contentType:"application/json;charset=UTF-8",
                    data:JSON.stringify({
                        username:$("#registerusername").val(),
                    password:$("#registerpassword").val(),
                    name:$("#registername").val()
                }),
                    success:function(data) {
                        if(data=="OK"){
                            alert("注册成功！")
                            window.location.reload();
                        }else {
                            alert("注册失败")
                        }
                    }
                })
                })


            $("#authorUpdateBtn").click(function() {  //作者信息修改按钮点击事件
                var headData=new FormData($("#AuthorUpdate")[0]); //获取修改作者信息的form表单数据
                        $.ajax({
                        url:"/author/authorUpdate",     //发送ajax请求 ，成功后弹出修改是否成功的信息
                        type:"post",
                        cache:false,
                        processData:false,
                        contentType:false,
                        data:headData,

                        success:function(data) {
                            alert(data.msg);
                        }
                    })
            })

            document.getElementById('upHeadImg').onchange=function () {
                var reader = new FileReader();
                var headImg = this.files[0];
                reader.readAsDataURL(headImg);
                reader.onload = function () {
                    document.getElementById('authorHeadImg').src=this.result;
                }
            }



            document.getElementById('blogIssueImg').onchange=function () {
                var reader = new FileReader();
                var headImg = this.files[0];
                reader.readAsDataURL(headImg);
                reader.onload = function () {
                    document.getElementById('blogIssueShowImg').src=this.result;
                }
            }




            $("#blogIssueBtn").click(function() {
                $("#blogIssueTitle").val("");
                $("#blogIssueNote").val("");
                $("#blogIssueContext").val("");
                editor.txt.clear();
                $("#blogIssueContextTip").hide();
                $("#blogIssueTitleTip").hide();
            });

            $("#newblogIssueBtn").click(function() {
                if ($("#blogIssueTitle").val().length==0){
                    $("#blogIssueTitleTip").show();
                    return;
                }
                if (editor.txt.text().length==0){
                    $("#blogIssueContextTip").show()
                    return
                }

                var blogData=new FormData($("#blogIssueFrom")[0]);

                blogData.set('blogContext',editor.txt.html());
                blogData.set('blogContext2',editor.txt.text());
                $.ajax({
                    url:"/author/issueBlog",
                    type:"post",
                    cache:false,
                    processData:false,
                    contentType:false,
                    data:blogData,
                    success:function(data) {
                        alert(data.msg);
                        $("#blogIssue").modal('hide');

                    }


                })

            })

            $("#authorInfoBtn").click(function() {
                $("#authorNumberUpdateDiv").hide();
                $("#authorInfoUpdateDiv").show();
            })

            $("#authorNumberUpdateBtn").click(function() {
                $("#authorInfoUpdateDiv").hide();
                $("#authorNumberUpdateDiv").show();
                $.ajax({
                    url:"/author/authorNumberGet",
                    type:"get",
                    success:function(data) {
                        $("#authorNumberUpdateUsername").html(data);
                    }
                })

            })

            $("#authorNumberUpdateSubmitBtn").click(function() {
                $("#authorNumberUpdatePasswordTip").hide();
                if ($("#authorNumberUpdatePassword").val()==""||$("#authorNumberUpdatePassword2").val()==""){
                    $("#authorNumberUpdatePasswordTip").html("请输入密码！");
                    $("#authorNumberUpdatePasswordTip").show();
                    return
                }
                if ($("#authorNumberUpdatePassword").val()!=$("#authorNumberUpdatePassword2").val()){
                    $("#authorNumberUpdatePasswordTip").html("两次输入的密码不一致！");
                    $("#authorNumberUpdatePasswordTip").show();
                    return
                }

                $.ajax({
                    url:"/author/authorNumberUpdate",
                    type:"post",
                    dayaType:"json",
                    contentType:"application/json;charset=UTF-8",
                    data: JSON.stringify({password:$("#authorNumberUpdatePassword").val()}),
                    success:function (data) {
                        alert(data.msg);
                        $("#authorNumberUpdatePassword").val("");
                        $("#authorNumberUpdatePassword2").val("")
                    }

                })


            })



            $("#blogMangerBtn").click(function() {
                $.ajax({
                    url:"/author/getAuthorBlogsList",
                    type:"post",
                    success:function(data) {
                        var blogsList=data.blogsList;
                        var divHtmlText="";
                        var blogsId=new Array(blogsList.length-1);
                        for (var i=0;i<blogsList.length;i++){
                            blogsId[i]=blogsList[i].blogId;
                            divHtmlText+="<tr>";
                            divHtmlText+="<td>"+blogsList[i].blogId+"</td>";
                            divHtmlText+="<td>"+blogsList[i].blogTitle+"</td>";
                            divHtmlText+="<td>"+blogsList[i].blogNote+"</td>";
                            divHtmlText+="<td>"+blogsList[i].blogClass+"</td>";
                            divHtmlText+="<td><buntton  class='btn-primary btn' name='blogLook' >查看</buntton>";
                            divHtmlText+="<buntton  class='btn-primary btn' name='blogUpdate' style='margin-left:15px' data-toggle=\"modal\" data-target=\"#blogMangerUpdate\" >修改</buntton>";
                            divHtmlText+="<buntton  class='btn-primary btn' name='blogDelete' style='margin-left:15px'>删除</buntton>";
                            divHtmlText+="</td>";
                            divHtmlText+="</tr>";
                        }
                        $("#authorBlogsListTest").html(
                            divHtmlText
                        );
                        var blogUpdateBtn= document.getElementsByName('blogUpdate');
                        var blogLookBtn=document.getElementsByName('blogLook');
                        var blogDeleteBtn=document.getElementsByName('blogDelete');

                        for (var i=0;i<blogUpdateBtn.length;i++){
                            (function(arg) {
                                    var blogId=blogsId[arg];
                                    blogUpdateBtn[arg].onclick=function() {
                                        blogMangerUpdateUpdate(blogId);
                                    }
                                    blogLookBtn[arg].onclick=function() {
                                        blogMangerUpdateLook(blogId);
                                    }
                                    blogDeleteBtn[arg].onclick=function() {
                                        blogMangerUpdateDelete(blogId,this);
                                    }
                                })(i)
                        }
                    }

                })
                


            })


            function blogMangerUpdateLook(id) {
                window.open("blogInfo.jsp?blogId="+id+"");
            }

            function blogMangerUpdateUpdate(id) {
                $("#blogMangerUpdateId").val('');
                $("#blogMangerUpdateTitle").val('');
                $("#blogMangerUpdateNote").val('');
                editor2.txt.clear();
                $.ajax({
                    url:"/author/blogMangerBlogLook",
                    type:"post",
                    dayaType:"json",
                    contentType:"application/json;charset=UTF-8",
                    data:JSON.stringify({blogId:id}),
                    success:function(data) {
                        $("#blogMangerUpdateId").val(data.blogId);
                        $("#blogMangerUpdateTitle").val(data.blogTitle);
                        $("#blogMangerUpdateNote").val(data.blogNote);
                        editor2.txt.html(data.blogContext);

                        switch (data.blogClass){
                            case "学习笔记":
                                $("#blogMangerUpdateClass").find("option:contains('学习笔记')").attr("selected", true);break;
                            case "错误记录":
                                $("#blogMangerUpdateClass").find("option:contains('错误记录')").attr("selected", true);break;
                            case "项目搭建":
                                $("#blogMangerUpdateClass").find("option:contains('项目搭建')").attr("selected", true);break;
                            case "其他":
                                $("#blogMangerUpdateClass").find("option:contains('其他')").attr("selected", true);break;
                        }

                    }




                })

            }

            function blogMangerUpdateDelete(id,btn){
                if (!confirm('博客写之不易，确认要删除吗？')){
                    return false;
                }
                $.ajax({
                    url:"/author/blogMangerDeleteBlog",
                    type:"post",
                    dayaType:"json",
                    contentType:"application/json;charset=UTF-8",
                    data:JSON.stringify({
                        blogId:id
                    }),
                    success:function(data) {
                        alert(data);
                        var thisTr=btn.parentNode.parentNode;
                        thisTr.parentNode.removeChild(thisTr);
                    }
                })

            }

            $("#blogMangerUpdateUpdateSubmitBtn").click(function() {
                $("#blogMangerUpdateTitleTip").hide();
                $("#blogMangerUpdateContextTip").hide();
                if ($("#blogMangerUpdateTitle").val()==''){
                    $("#blogMangerUpdateTitleTip").show();
                    return;
                }
                if (editor2.txt.text().length==0){
                    $("#blogMangerUpdateContextTip").show();
                    return
                }

                var updateBlogFormData=new FormData($("#blogMangerUpdateFrom")[0]);
                updateBlogFormData.set("blogContext2",editor2.txt.text());
                updateBlogFormData.set("blogContext",editor2.txt.html());

                $.ajax({
                    url:"/author/blogMangerUpdateBlog",
                    type:"post",
                    cache:false,
                    processData:false,
                    contentType:false,
                    data:updateBlogFormData,
                    success:function(data) {
                        alert(data);
                        $("#blogMangerUpdate").modal('hide');
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
                        <a href="#">Message Board</a>
                    </li>
                    <li>
                        <a href="admin.jsp">admin</a>
                    </li>
                </ul>
            </div>
        </nav>


    </div>


</div>



<div class="all">


    <div class="row">
        <div class="col-md-4 col-md-offset-2"  style="height: 100px">
            <br/>
            <h4 id="authorName">你好,${sessionScope.user.name}</h4>
        </div>
    </div>

    <div id="login" class="row login">

        <div class="col-md-4 col-lg-offset-4">

            <form class="form-horizontal" action="">

                <div class="form-group col-md-12">
                    <label for="loginUsername" class="col-md-2 control-label">Email</label>
                    <div class="col-md-6">
                        <input type="email" class="form-control" id="loginUsername" placeholder="Email">
                    </div>
                    <label for="loginUsername" class="col-md-4 control-label" id="loginUsernameTip" style="color: #ff0000">请输入账号！</label>
                </div>
                <div class="form-group col-md-12">
                    <label for="loginPassword" class="col-md-2 control-label">Password</label>
                    <div class="col-md-6">
                        <input type="password" class="form-control" id="loginPassword" placeholder="Password">
                    </div>
                    <label for="loginPassword" class="col-md-4 control-label" id="loginPasswordTip" style="color: #ff0000">请输入密码！</label>
                </div>

                <div class="col-md-8 col-lg-offset-2">
                    <span class="lead" id="loginErrorTip">账号或密码错误！</span>
                    <br/>
                    <br/>
                </div>

                <div class="form-group col-md-12">
                    <div class="col-md-offset-2 col-md-2">
                        <button type="button" class="btn btn-default btn-lg" id="loginbtn">login</button>
                    </div>

                    <div class="col-md-4 col-lg-offset-1">
                        <button type="button" class="btn btn-default btn-lg" id="goRegister">register</button>
                    </div>

                </div>
            </form>
        </div>

    </div>

    <div id="register"class="row register">

        <div class="col-md-6 col-lg-offset-3">

            <form class="form-horizontal" action="" id="register_form">
                <div class="form-group col-md-12">
                    <label for="registerusername" class="col-md-4 control-label">Email：</label>
                    <div class="col-md-4">
                        <input type="email" class="form-control" id="registerusername" placeholder="Email">
                    </div>
                    <div class="col-md-4">
                        <label for="registerusername" class="control-label" style="color: red" id="registerusernameTip">请输入邮箱！</label>
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <label for="registerpassword" class="col-md-4 control-label">Password：</label>
                    <div class="col-md-4">
                        <input type="password" class="form-control" id="registerpassword" placeholder="Password">
                    </div>
                    <div class="col-md-4">
                        <label for="registerpassword" class="control-label" style="color: red" id="registerpasswordTip">请输入密码！</label>
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <label for="registerpassword2" class="col-md-4 control-label">Confirm Password：</label>
                    <div class="col-md-4">
                        <input type="password" class="form-control" id="registerpassword2" placeholder="Password">
                    </div>
                    <div class="col-md-4">
                        <label for="registerpassword2" class="control-label" style="color: red" id="registerpassword2Tip">请输入密码！</label>
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <label for="registername" class="col-md-4 control-label">Name：</label>
                    <div class="col-md-4">
                        <input type="text" class="form-control" id="registername">
                    </div>
                    <div class="col-md-4">
                        <label for="registername" class="control-label" style="color: red" id="registernameTip">请输入姓名！</label>
                    </div>
                </div>

                <div class="col-md-8 col-lg-offset-4">
                    <div class="col-md-4">
                        <button type="button" class="btn btn-default btn-lg"  id="submitRegister" style="position: absolute;left: 5px">submit</button>
                    </div>

                    <div class="col-md-4 ">
                        <button type="button" class="btn btn-default btn-lg" style="position: absolute;left: 5px" id="backLogin">back</button>
                    </div>
                </div>




            </form>
        </div>



    </div>


    <div id="blogmanage" class="blogmanage">
        <div class="row">

            <div class="col-md-1 col-md-offset-3">
                <button type="button" class="btn btn-default btn-lg" style="margin-top: 100px" id="authorInfoBtn">作者信息</button>
                <button type="button" class="btn btn-default btn-lg" style="margin-top: 30px" id="authorNumberUpdateBtn">账号修改</button>
                <button type="button" class="btn btn-default btn-lg" style="margin-top: 30px" id="blogMangerBtn" data-toggle="modal" data-target="#blogMangerModal">管理博客</button>
                <button type="button" class="btn btn-default btn-lg" style="margin-top: 30px" id="blogIssueBtn" data-toggle="modal" data-target="#blogIssue">发表博客</button>
            </div>

            <div class="col-md-8  manage">
                <div id="authorInfoUpdateDiv">

                <div class="row">
                    <div class="col-md-4">
                        <img src="img/1.jpg" class="img-responsive" id="authorHeadImg" style="margin-left: 200px;margin-top: 62px;width: 300px;height: 200px">
                        <br/>
                    </div>
                </div>

                <form id="AuthorUpdate" method="post" enctype="multipart/form-data">
                <div class="row">

                    <div class="col-md-4 col-lg-offset-2">
                        <span style="color: #000000;margin-left: 18px">上传头像：</span>
                        <input type="file" style="display: inline" id="upHeadImg" name="headImg">
                    </div>
                </div>

                <div class="row">
                    <br/>
                    <div class="col-md-1  col-lg-offset-1">
                        <span style="color: #000000;font-size: 15px" >作者信息：</span><br/><br/>
                    </div>

                    <div class="col-md-3 ">
                            <textarea class="form-control" style="resize:none" rows="9" id="authorIntroduce" name="authorIntroduce"></textarea>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 col-md-offset-4">
                        <br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="button" class="btn btn-default" id="authorUpdateBtn">保存</button>
                    </div>
                </div>
                </form>
                </div>

                <div id="authorNumberUpdateDiv">
                    <div class="row">
                        <div class="col-md-6 col-md-offset-1">
                           <div class="row">
                               <h3 style="margin-top: 150px;margin-right: 40px">当前邮箱账号：<span id="authorNumberUpdateUsername"></span></h3>
                           </div>
                            <div class="row">
                                <label class="h4" style="margin-top: 30px" for="authorNumberUpdatePassword">请输入新密码：</label>
                                <input style="height: 30px;font-size: 25px" type="password" id="authorNumberUpdatePassword">
                            </div>
                            <div class="row">
                                <label class="h4" style="margin-top: 30px" for="authorNumberUpdatePassword2">请确认新密码：</label>
                                <input style="height: 30px;font-size: 25px" type="password" id="authorNumberUpdatePassword2">
                                <h4 style="color: red" id="authorNumberUpdatePasswordTip">请输入密码！</h4>
                            </div>
                            <div class="row">
                                <div class="col-md-offset-6" style="margin-top: 30px;margin-left: 380px">
                                    <button type="button" class="btn btn-default" id="authorNumberUpdateSubmitBtn">提交</button>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>



            </div>


        </div>  <!--作者信息以及修改密码-->

        <div class="row">
            <div class="modal fade blogIssue" id="blogIssue" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-show="true" data-backdrop="static"	>
                <div class="modal-dialog" style="width: 1100px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">
                                &times;
                            </button>
                            <h4 class="modal-title text-center lead">
                                发表新博客
                            </h4>
                        </div>
                        <div class="modal-body" >
                            <form method="post" enctype="multipart/form-data" id="blogIssueFrom">
                            <div class="row">
                                <div class="col-md-3">
                                    <h3>博客标题图片</h3><br/>
                                    <img src="img/2.jpg"id="blogIssueShowImg" style="height: 200px;width: 230px;margin-top: -20px;margin-bottom: 10px">
                                    <input type="file" name="blogImg" style="color: white;" id="blogIssueImg">
                                </div>
                                <div class="col-md-4">
                                    <h2>博客标题：</h2>
                                    <input type="text" id="blogIssueTitle" name="blogTitle" style="width: 450px;height: 50px;font-size: 35px">
                                    <label for="blogIssueTitle" id="blogIssueTitleTip" style="color: red">请输入博客标题</label>
                                    <h3>作者备注：</h3>
                                    <input type="text" id="blogIssueNote" name="blogNote" style="width: 450px;height: 40px;font-size: 25px"><br/>
                                </div>
                                <div class="col-md-2" style="margin-top: 10px;margin-left: 130px">
                                    <label class="h4">博客类别：</label>
                                    <select class="form-control" style="margin-top: 15px" name="blogClass">
                                        <option>学习笔记</option>
                                        <option>错误记录</option>
                                        <option>项目搭建</option>
                                        <option>其他</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <h2 class="text-center">---------------------------------------------------------------------------------------------------------</h2>
                                    <h2 class="text-center">博客内容：</h2>
                                    <br/>

                                    <div id="blogIssueContextEditerTop" style="border: 1px solid #ccc;"></div>
                                    <div id="blogIssueContextEditerBottom" style="border: 1px solid #ccc;height: 800px;"></div>

                                    <label for="blogIssueContextEditerBottom" id="blogIssueContextTip" style="color: red">请输入博客内容</label><br/>

                                </div>
                            </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                            </button>
                            <button type="button" class="btn btn-primary" id="newblogIssueBtn">
                                发表
                            </button>
                        </div>
                        </form>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal -->
            </div>
        </div>



        </div>  <!--发表博客的模态框-->

        <div class="row">
            <div class="modal fade blogIssue" id="blogMangerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-show="true" data-backdrop="static"	>
                <div class="modal-dialog" style="width: 1100px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">
                                &times;
                            </button>
                            <h4 class="modal-title text-center lead">
                                博客管理
                            </h4>
                        </div>
                        <div class="modal-body" >
                            <table class="table table-bordered table-hover" >
                                <thead>
                                    <tr>
                                        <th>博客编号</th>
                                        <th>博客标题</th>
                                        <th>博客备注</th>
                                        <th>博客类别</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody id="authorBlogsListTest">

                                </tbody>
                            </table>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>
            </div>
        </div>  <!--管理博客的博客列表模态框-->

        <div class="row">       <!--修改博客的模态框-->
            <div class="modal fade blogIssue" id="blogMangerUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-show="true" data-backdrop="static"	>
                <div class="modal-dialog" style="width: 1100px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">
                                &times;
                            </button>
                            <h4 class="modal-title text-center lead">
                                博客详情
                            </h4>
                        </div>
                        <div class="modal-body" >
                            <form method="post" enctype="multipart/form-data" id="blogMangerUpdateFrom">
                                <div class="row">
                                    <div class="col-md-4">
                                        <input type="text" id="blogMangerUpdateId" name="blogId" style="display: none"></input>
                                        <h2>博客标题：</h2>
                                        <input type="text" id="blogMangerUpdateTitle" name="blogTitle" style="width: 450px;height: 50px;font-size: 35px">
                                        <label for="blogMangerUpdateTitle" class="h4" id="blogMangerUpdateTitleTip" style="color: red">请输入博客标题</label>
                                        <h3>作者备注：</h3>
                                        <input type="text" id="blogMangerUpdateNote" name="blogNote" style="width: 450px;height: 40px;font-size: 25px"><br/>
                                    </div>
                                    <div class="col-md-3" style="margin-top: 10px;margin-left: 210px">
                                        <label class="h4">博客类别：</label>
                                        <select class="form-control" style="margin-top: 15px" name="blogClass" id="blogMangerUpdateClass">
                                            <option>学习笔记</option>
                                            <option>错误记录</option>
                                            <option>项目搭建</option>
                                            <option>其他</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <h2 class="text-center">----------------------------------------------------------------------------------------------------------</h2>
                                        <h2 class="text-center">博客内容：</h2>

                                        <div id="blogMangerUpdateEditerTop" style="border: 1px solid #ccc;"></div>
                                        <div id="blogMangerUpdateEditerBottom" style="border: 1px solid #ccc;height: 800px;"></div>
                                        <label for="blogMangerUpdateEditerBottom" class="h4" id="blogMangerUpdateContextTip" style="color: red">请输入博客内容</label>

                                    </div>
                                </div>





                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                                    </button>
                                    <button type="button" class="btn btn-primary" id="blogMangerUpdateUpdateSubmitBtn">
                                        保存修改
                                    </button>
                                </div>
                            </form>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>
            </div>



        </div>

    </div>

    </div>
</body>
</html>