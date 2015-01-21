package com.newtechgalley

class Comment {
    String content
    int note

    static constraints = {
        content blank: false, unique: true
    }
}
