package com.newtechgalley

import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PostController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Post.list(params), model: [postInstanceCount: Post.count()]
    }

    def show(Post postInstance) {
        if(postInstance == null)
        {
            render(status: 404)
        }
        respond postInstance
    }

    @Secured(['ROLE_USER'])
    def create() {
        params.user = (User) springSecurityService.currentUser

        respond new Post(params)
    }

    @Transactional
    def save(Post postInstance) {
        if (postInstance == null) {
            notFound()
            return
        }

        if (postInstance.hasErrors()) {
            respond postInstance.errors, view: 'create'
            return
        }

        postInstance.creationDate = new Date()
        postInstance.note = 0
        postInstance.votes = new HashMap<String, VoteType>()
        postInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'post.label', default: 'Post'), postInstance.id])
                redirect postInstance
            }
            '*' { respond postInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_USER'])
    def edit(Post postInstance)
    {
        if(postInstance.user.id == ((User) springSecurityService.currentUser).id
            || SpringSecurityUtils.ifAllGranted("ROLE_ADMIN"))
        {
            respond postInstance
        }
        else
        {
            redirect(controller: "login", action: "denied")
        }
    }

    @Transactional
    @Secured(['ROLE_USER'])
    def update(Post postInstance) {
        if (postInstance == null) {
            notFound()
            return
        }

        if (postInstance.hasErrors()) {
            respond postInstance.errors, view: 'edit'
            return
        }

        postInstance.lastEditDate = new Date()
        postInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'post.label', default: 'Post'), postInstance.id])
                redirect postInstance
            }
            '*' { respond postInstance, [status: OK] }
        }
    }

    @Transactional
    @Secured(['ROLE_USER'])
    def delete(Post postInstance)
    {
        if(postInstance.user.id == ((User) springSecurityService.currentUser).id
                || SpringSecurityUtils.ifAllGranted("ROLE_ADMIN"))
        {
            if (postInstance == null) {
                notFound()
                return
            }

            postInstance.delete flush: true

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.deleted.message', args: [message(code: 'post.label', default: 'Post'), postInstance.id])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
        else
        {
            redirect(controller: "login", action: "denied")
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'post.label', default: 'Post'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Secured(['ROLE_USER'])
    def upvote() {
        User user = (User) springSecurityService.currentUser

        long idPost = Long.parseLong((String) params.id)
        Post p = Post.get(idPost)

        if(p.votes.get(user.id.toString())) // existing vote
        {
            if(p.votes.get(user.id.toString()) == VoteType.DOWNVOTE) // changing vote
            {
                p.votes.put(user.id.toString(), VoteType.UPVOTE)
                p.note = p.note + 2
            }
        }
        else // new vote
        {
            p.votes.put(user.id.toString(), VoteType.UPVOTE)
            ++p.note
        }

        p.save(flush: true, failOnError: true)
        redirect(controller: "post", action:"show", id:p.id)
    }

    @Secured(['ROLE_USER'])
    def downvote() {
        User user = (User) springSecurityService.currentUser

        def idPost = Long.parseLong((String) params.id)
        Post p = Post.get(idPost)

        if(p.votes.get(user.id.toString())) // existing vote
        {
            if(p.votes.get(user.id.toString()) == VoteType.UPVOTE) // changing vote
            {
                p.votes.put(user.id.toString(), VoteType.DOWNVOTE)
                p.note = p.note - 2
            }
        }
        else // new vote
        {
            p.votes.put(user.id.toString(), VoteType.DOWNVOTE)
            --p.note
        }

        p.save(flush: true, failOnError: true)
        redirect(controller: "post", action:"show", id:p.id)
    }
}
