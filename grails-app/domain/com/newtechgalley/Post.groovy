package com.newtechgalley

class Post {
    String title
    String content
    Date creationDate = new Date()
    Date lastEditDate
    int note = 0

    User user
    static hasMany = [categories: Category, comments:Comment]

    static mapping = {content type: 'text'}

    static constraints = {
        title blank: false, nullable: false, unique: true
        content blank: false, nullable: false
        user nullable: false
        creationDate blank: false, nullable: false
        lastEditDate nullable: true
    }
}
