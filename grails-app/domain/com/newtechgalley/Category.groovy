package com.newtechgalley

class Category {
    String name

    static constraints = {
        name blank: false, nullable: false
    }

    @Override
    String toString () {
        return name
    }
}
