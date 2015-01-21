package com.newtechgalley

import org.springframework.security.access.annotation.Secured

class SecureController {

    @Secured(['ROLE_ADMIN'])
    def index() {
        render 'Secure access only'
    }
}
