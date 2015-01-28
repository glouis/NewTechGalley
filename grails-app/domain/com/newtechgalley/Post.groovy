package com.newtechgalley

class Post {
    String title
    String content
    int note

    User user
    static hasMany = [categories: Category, comments:Comment]

    static constraints = {
        title blank: false, nullable: false, unique: true
        content blank: false, nullable: false
        user nullable: false
    }
}
