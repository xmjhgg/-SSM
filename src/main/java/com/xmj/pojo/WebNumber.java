package com.xmj.pojo;

public class WebNumber {
    Integer readNumber;
    Integer commentNumber;

    public Integer getCommentNumber() {
        return commentNumber;
    }

    public void setCommentNumber(Integer commentNumber) {
        this.commentNumber = commentNumber;
    }

    public Integer getReadNumber() {

        return readNumber;
    }

    public void setReadNumber(Integer readNumber) {
        this.readNumber = readNumber;
    }

    @Override
    public String toString() {
        return "WebNumber{" +
                "readNumber=" + readNumber +
                ", commentNumber=" + commentNumber +
                '}';
    }
}
