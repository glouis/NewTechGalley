package com.newtechgalley

import grails.plugin.springsecurity.SpringSecurityUtils
import groovy.util.logging.Log
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Log
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

    @Secured(['ROLE_USER'])
    def create() {
        def currentUser = (User) springSecurityService.currentUser
        params.user = currentUser
        params.creationDate = new Date()
        currentUser.actionList.add(new Date(), "comment")

        Comment c = new Comment(params)

        respond c

        log.info 'Comment '+ c.id + ' constructed by user ' + c.user.id
    }

    @Transactional
    @Secured(['ROLE_USER'])
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

    @Secured(['ROLE_USER'])
    def edit(Comment commentInstance) {

        if(commentInstance.user.id == ((User) springSecurityService.currentUser).id
                || SpringSecurityUtils.ifAllGranted("ROLE_ADMIN"))
        {
            respond commentInstance
        }
        else
        {
            redirect(controller: "login", action: "denied")
        }
    }

    @Transactional
    @Secured(['ROLE_USER'])
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
                flash.message = message(code: 'default.updated.message', args: [message(code: 'comment.label', default: 'Comment'), commentInstance.id])
                redirect commentInstance
            }
            '*' { respond commentInstance, [status: OK] }
        }
    }

    @Transactional
    @Secured(['ROLE_USER'])
    def delete(Comment commentInstance)
    {
        if(commentInstance.user.id == ((User) springSecurityService.currentUser).id
                || SpringSecurityUtils.ifAllGranted("ROLE_ADMIN"))
        {
            if (commentInstance == null) {
                notFound()
                return
            }

            Post post = commentInstance.post
            post.removeFromComments(commentInstance)
            post.save(flush: false)

            commentInstance.save(flush: true)

            commentInstance.delete flush: true

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.deleted.message', args: [message(code: 'comment.label', default: 'Comment'), commentInstance.id])
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
