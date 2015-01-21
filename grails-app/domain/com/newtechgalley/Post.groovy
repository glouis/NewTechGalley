package com.newtechgalley

class Post {
    String title
    String content
    int note
    List<Comment> commentList

    static constraints = {
        title blank: false, unique: true
        content blank: false
    }
}
