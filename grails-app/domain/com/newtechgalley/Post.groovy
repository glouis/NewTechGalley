package com.newtechgalley

public enum VoteType
{
    UPVOTE,
    DOWNVOTE
}

class Post {
    String title
    String content
    Date creationDate
    Date lastEditDate
    int note
    boolean validated
    Map<String,VoteType> votes

    User user
    static hasMany = [categories: Category, comments:Comment, votes:VoteType]

    static mapping = {content type: 'text'}

    static constraints = {
        title blank: false, nullable: false, unique: true
        content blank: false, nullable: false
        user nullable: false
        creationDate blank: false, nullable: true
        lastEditDate nullable: true
    }

    @Override
    String toString() {
        return title
    }
}
