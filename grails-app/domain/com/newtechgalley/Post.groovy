package com.newtechgalley

class Post {
    String title
    String content
    int note
    static hasMany = [categories: Categorie, comments:Comment]

    static constraints = {
        title blank: false, unique: true
        content blank: false
    }
}
