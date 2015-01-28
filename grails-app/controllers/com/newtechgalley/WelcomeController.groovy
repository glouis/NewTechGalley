package com.newtechgalley

import org.springframework.security.access.annotation.Secured

@Secured(['ROLE_ADMIN'])
class WelcomeController {

    def index() {
        def user = getAuthenticatedUser()
        render 'Hello ' + user.username + ' !' //Printing a Message
    }
}
