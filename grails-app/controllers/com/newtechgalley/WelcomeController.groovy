package com.newtechgalley

import org.springframework.security.access.annotation.Secured

@Secured(['ROLE_USER', 'ROLE_ADMIN'])
class WelcomeController {

    def index() {
        def user = getAuthenticatedUser()
        respond user
    }
}
