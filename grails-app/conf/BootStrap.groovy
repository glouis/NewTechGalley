import com.newtechgalley.Category
import com.newtechgalley.Comment
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
        def lambdaUser2 = new User(username: 'V', password: 'dieu')
        lambdaUser2.save(flush: true)

        def categoryPhp = new Category(name: "PHP")
        categoryPhp.save(flush: true)
        def categoryJava = new Category(name: "Java")
        categoryJava.save(flush: true)
        def categoryCpp = new Category(name: "C++")
        categoryCpp.save(flush: true)
        def categoryWeb = new Category(name: "web")
        categoryWeb.save(flush: true)
        def categoryOther = new Category(name: "other")
        categoryOther.save(flush: true)
        def categoryCSharp = new Category(name: "C#")
        categoryCSharp.save(flush: true)

        UserRole.create testUser, adminRole, true
        UserRole.create testUser, userRole, true
        UserRole.create lambdaUser, userRole, true
        UserRole.create lambdaUser2, userRole, true

        def post1 = new Post(title: "How NewTechGalley works ?", content: "Hello friends, I’m a newbi on NewTechGalley and I want to know how it works ? Could you help me ?\n XXX :-D", note: 0, creationDate : new Date(), user: lambdaUser2, categories: [categoryWeb, categoryOther])
        post1.save(flush: true)
        def post2 = new Post(title: "How to use register in C# without admin rights ?", content: "All is in the question ! ;-)", note: 0, creationDate : new Date(), user: lambdaUser, categories: categoryCSharp)
        post2.save(flush: true)

        def comment1 = new Comment(content: "Just go on http://www.NewTechGalley.fr (or just on localhost because this project is not accessible online) and follow the link on the menu that interest you.", user:lambdaUser, post: post1, note: 0, creationDate : new Date())
        comment1.save(flush: true)
        def comment2 = new Comment(content: "V is really bad, use NewTechGalley is really easy !! And this site is the most beautifull site I've ever seen. And its source code is awsome ! I love it.", user:testUser, post: post1, note: 0, creationDate : new Date())
        comment2.save(flush: true)

        assert User.count() == 3
        assert Role.count() == 2
        assert UserRole.count() == 4
        assert Post.count() == 2
        assert Comment.count() == 2
        assert Category.count() == 6
    }
}
