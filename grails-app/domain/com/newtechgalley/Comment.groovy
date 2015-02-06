package com.newtechgalley

class Comment {
    String content
    int note
    Date creationDate
    Date lastEditDate
    Map<String,VoteType> votes

    User user
    static belongsTo = [post:Post]
    static hasMany = [votes:VoteType]

    static constraints = {
        content blank: false, nullable: false, unique: true
        user nullable: false
        creationDate blank: false, nullable: true
        lastEditDate nullable: true
        votes nullable: true
    }

    @Override
    String toString() {
        return content
    }
}
