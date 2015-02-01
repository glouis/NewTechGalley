package com.newtechgalley


class Badge {
    String name

    static constraints = {
        name blank: false, nullable: false
    }
}
