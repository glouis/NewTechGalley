package com.newtechgalley

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
class UserSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test toString"() {
        User user = new User(username: "Test", password: "Mdp")
        expect:
            user.toString() == "Test"
    }
}
