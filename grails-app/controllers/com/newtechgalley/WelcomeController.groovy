package com.newtechgalley

import org.springframework.security.access.annotation.Secured

@Secured(['ROLE_ADMIN'])
class WelcomeController {

    def index() {
        render 'Hello World!' //Printing a Message
    }
}
