package newtechgalley

class IsLoggedTagLib {
    static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]
    def springSecurityService
    def isLogged = { attrs, body ->
        def isLoggedIn = springSecurityService.loggedIn
        if(isLoggedIn == true) {
            out << body()
        }
    }

    def isNotLogged = { attrs, body ->
        def isLoggedIn = springSecurityService.loggedIn
        if(isLoggedIn == false) {
            out << body()
        }
    }
}
