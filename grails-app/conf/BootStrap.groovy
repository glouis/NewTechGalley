import com.newtechgalley.Category
import com.newtechgalley.Post
import com.newtechgalley.Role
import com.newtechgalley.User
import com.newtechgalley.UserRole

class BootStrap {

    def init = { servletContext ->

        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        def testUser = new User(username: 'me', password: 'password')
        testUser.save(flush: true)
        def lambdaUser = new User(username: 'foo', password: 'bar')
        lambdaUser.save(flush: true)

        def categoryPhp = new Category(name: "PHP")
        categoryPhp.save(flush: true)
        def categoryJava = new Category(name: "Java")
        categoryJava.save(flush: true)
        def categoryCpp = new Category(name: "C++")
        categoryCpp.save(flush: true)
        def categoryWeb = new Category(name: "web")
        categoryWeb.save(flush: true)

        UserRole.create testUser, adminRole, true
        UserRole.create lambdaUser, userRole, true

        def post1 = new Post(title: "welcome", content: "welcome you!", note: 0, user: testUser, categories: categoryWeb)
        post1.save(flush: true)

        assert User.count() == 2
        assert Role.count() == 2
        assert UserRole.count() == 2
    }
}
