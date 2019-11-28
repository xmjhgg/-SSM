package com.xmj.pojo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.List;

@JsonIgnoreProperties(value = {"handler"})
public class Blog {
    Integer blogId;
    String blogTitle;
    String blogNote;
    String blogContext;
    String blogContext2;
    String blogImg;
    String blogClass;
    String issueTime;
    Integer readNumber;
    Author author;

    List<Comment> comments;
    Integer blogCommentNumber;


    public String getBlogContext2() {
        return blogContext2;
    }

    public void setBlogContext2(String blogContext2) {
        this.blogContext2 = blogContext2;
    }

    public Integer getBlogCommentNumber() {
        return blogCommentNumber;
    }

    public void setBlogCommentNumber(Integer blogCommentNumber) {
        this.blogCommentNumber = blogCommentNumber;
    }

    @Override
    public String toString() {
        return "Blog{" +
                "blogId=" + blogId +
                ", blogTitle='" + blogTitle + '\'' +
                ", blogNote='" + blogNote + '\'' +
                ", blogContext='" + blogContext + '\'' +
                ", blogImg='" + blogImg + '\'' +
                ", blogClass='" + blogClass + '\'' +
                ", issueTime='" + issueTime + '\'' +
                ", readNumber=" + readNumber +
                ", author=" + author +
                ", comments=" + comments +
                '}';
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public String getBlogClass() {
        return blogClass;
    }

    public void setBlogClass(String blogClass) {
        this.blogClass = blogClass;
    }

    public String getBlogImg() {
        return blogImg;
    }

    public void setBlogImg(String blogImg) {
        this.blogImg = blogImg;
    }

    public String getIssueTime() {
        return issueTime;
    }

    public void setIssueTime(String issueTime) {
        this.issueTime = issueTime;
    }

    public Integer getReadNumber() {
        return readNumber;
    }

    public void setReadNumber(Integer readNumber) {
        this.readNumber = readNumber;
    }

    public Integer getBlogId() {
        return blogId;
    }

    public void setBlogId(Integer blogId) {
        this.blogId = blogId;
    }

    public String getBlogTitle() {
        return blogTitle;
    }

    public void setBlogTitle(String blogTitle) {
        this.blogTitle = blogTitle;
    }

    public String getBlogNote() {
        return blogNote;
    }

    public void setBlogNote(String blogNote) {
        this.blogNote = blogNote;
    }

    public String getBlogContext() {
        return blogContext;
    }

    public void setBlogContext(String blogContext) {
        this.blogContext = blogContext;
    }

    public Author getAuthor() {
        return author;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }
}
