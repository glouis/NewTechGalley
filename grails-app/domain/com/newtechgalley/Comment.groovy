package com.newtechgalley

class Comment {
    String content
    int note
    Date creationDate
    Date lastEditDate

    User user
    static belongsTo = [post:Post]

    static constraints = {
        content blank: false, nullable: false, unique: true
        user nullable: false
        creationDate blank: false, nullable: false
        lastEditDate nullable: true
    }
}
