package com.newtechgalley

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Comment)
class CommentSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test toString"() {
        User user = new User(username: "Name", password: "Mdp")
        Comment comment = new Comment(content: "Test", user: user)
        expect:
        comment.toString() == "Test"
    }
}
