package com.newtechgalley

import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CommentController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Comment.list(params), model: [commentInstanceCount: Comment.count()]
    }

    def show(Comment commentInstance) {
        respond commentInstance
    }

    def create() {
        params.user = (User) springSecurityService.currentUser
        params.creationDate = new Date()

        respond new Comment(params)
    }

    @Transactional
    def save(Comment commentInstance) {
        if (commentInstance == null) {
            notFound()
            return
        }

        if (commentInstance.hasErrors()) {
            respond commentInstance.errors, view: 'create'
            return
        }

        commentInstance.creationDate = new Date()
        commentInstance.note = 0
        commentInstance.votes = new HashMap<String, VoteType>()
        commentInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'comment.label', default: 'Comment'), commentInstance.id])
                redirect commentInstance
            }
            '*' { respond commentInstance, [status: CREATED] }
        }
    }

    def edit(Comment commentInstance) {
        respond commentInstance
    }

    @Transactional
    def update(Comment commentInstance) {
        if (commentInstance == null) {
            notFound()
            return
        }

        if (commentInstance.hasErrors()) {
            respond commentInstance.errors, view: 'edit'
            return
        }

        commentInstance.lastEditDate = new Date()
        commentInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Comment.label', default: 'Comment'), commentInstance.id])
                redirect commentInstance
            }
            '*' { respond commentInstance, [status: OK] }
        }
    }

    @Transactional
    @Secured(['ROLE_ADMIN'])
    def delete(Comment commentInstance) {

        if (commentInstance == null) {
            notFound()
            return
        }

        commentInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Comment.label', default: 'Comment'), commentInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Secured(['ROLE_USER'])
    def upvote() {
        User user = (User) springSecurityService.currentUser

        def idComment = Long.parseLong((String) params.id)
        Comment c = Comment.get(idComment)

        if(c.votes.get(user.id.toString())) // existing vote
        {
            if(c.votes.get(user.id.toString()) == VoteType.DOWNVOTE) // changing vote
            {
                c.votes.put(user.id.toString(), VoteType.UPVOTE)
                c.note = c.note + 2
            }
        }
        else // new vote
        {
            c.votes.put(user.id.toString(), VoteType.UPVOTE)
            ++c.note
        }

        c.save(flush: true, failOnError: true)
        redirect(controller: "post", action:"show", id:c.post.id)
    }

    @Secured(['ROLE_USER'])
    def downvote() {
        User user = (User) springSecurityService.currentUser

        def idComment = Long.parseLong((String) params.id)
        Comment c = Comment.get(idComment)

        if(c.votes.get(user.id.toString())) // existing vote
        {
            if(c.votes.get(user.id.toString()) == VoteType.UPVOTE) // changing vote
            {
                c.votes.put(user.id.toString(), VoteType.DOWNVOTE)
                c.note = c.note - 2
            }
        }
        else // new vote
        {
            c.votes.put(user.id.toString(), VoteType.DOWNVOTE)
            --c.note
        }

        c.save(flush: true, failOnError: true)
        redirect(controller: "post", action:"show", id:c.post.id)
    }
}
