package newtechgalley

import grails.plugin.springsecurity.SpringSecurityService

class IsLoggedTagLib {

    SpringSecurityService springSecurityService

    def isLogged = { attrs, body ->
        def isLoggedIn = springSecurityService.loggedIn
        if(isLoggedIn) {
            out << body()
        }
    }

    def isNotLogged = { attrs, body ->
        def isLoggedIn = springSecurityService.loggedIn
        if(!isLoggedIn) {
            out << body()
        }
    }
}
