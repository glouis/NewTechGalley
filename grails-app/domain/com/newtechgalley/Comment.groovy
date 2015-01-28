package com.newtechgalley

class Comment {
    String content
    int note

    User user
    static belongsTo = [post:Post]

    static constraints = {
        content blank: false, nullable: false, unique: true
        user nullable: false
    }
}
