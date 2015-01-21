package com.newtechgalley

import org.springframework.security.access.annotation.Secured

@Secured(['ROLE_ADMIN'])
class SecureController {

    def index() {
        render 'Secure access only'
    }
}
