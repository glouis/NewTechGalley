package com.newtechgalley

class WelcomeController {

    def index() {
        def user = getAuthenticatedUser()
        def isLog = loggedIn

        if(user != null) {
            render "Welcome " + user.username + " !\n"
        }
        render isLog

        render view:'layouts', model: [isLogInView: isLog]
    }
}
