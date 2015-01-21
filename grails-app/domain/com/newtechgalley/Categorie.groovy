package com.newtechgalley

class Categorie {
    String name
    static hasMany = [posts: Post]

    static constraints = {
        name blank: false
    }
}
