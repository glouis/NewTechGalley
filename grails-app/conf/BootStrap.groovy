import com.newtechgalley.Category
import com.newtechgalley.Role
import com.newtechgalley.User
import com.newtechgalley.UserRole

class BootStrap {

    def init = { servletContext ->

        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        def testUser = new User(username: 'me', password: 'password')
        testUser.save(flush: true)

        def categoryPhp = new Category(name: "PHP")
        categoryPhp.save(flush: true)
        def categoryJava = new Category(name: "Java")
        categoryJava.save(flush: true)
        def categoryCpp = new Category(name: "C++")
        categoryCpp.save(flush: true)
        def categoryWeb = new Category(name: "web")
        categoryWeb.save(flush: true)

        UserRole.create testUser, adminRole, true

        assert User.count() == 1
        assert Role.count() == 2
        assert UserRole.count() == 1
    }
}
