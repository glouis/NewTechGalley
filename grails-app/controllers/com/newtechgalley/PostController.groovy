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
        params.date = new Date()

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

        User user = (User) springSecurityService.currentUser

        postInstance.creationDate = new Date()
        postInstance.note = 0
        postInstance.validated = false
        postInstance.votes = new HashMap<String, VoteType>()

        postInstance.save flush: true

        log.info 'Post '+ postInstance.id + ' created by user ' + user.id

        user.actionList.put((new Date().toString()), "Post: " + postInstance.content)
        user.save(flush: true)

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

        log.info 'Post '+ postInstance.id + ' updated by user ' + ((User) springSecurityService.currentUser).id

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

            long pId = postInstance.id

            postInstance.delete flush: true

            log.info 'Post '+ pId + ' deleted by user ' + ((User) springSecurityService.currentUser).id

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.deleted.message', args: [message(code: 'post.label', default: 'Post'), postInstance.id])
                    redirect(uri : '/index')
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

        log.info 'Post '+ p.id + ' upvoted by ' + ((User) springSecurityService.currentUser).id

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

        log.info 'Post '+ p.id + ' downvoted by ' + ((User) springSecurityService.currentUser).id

        redirect(controller: "post", action:"show", id:p.id)
    }

    @Transactional
    @Secured(['ROLE_USER'])
    def un_validate(Post postInstance)
    {
        if(postInstance.user.id == ((User) springSecurityService.currentUser).id
                || SpringSecurityUtils.ifAllGranted("ROLE_ADMIN"))
        {
            if (postInstance == null) {
                notFound()
                return
            }

            long pId = postInstance.id

            postInstance.validated = !postInstance.validated
            postInstance.save flush: true

            if(postInstance.validated) {
                log.info 'Post ' + pId + ' validate by user ' + ((User) springSecurityService.currentUser).id

                request.withFormat {
                    form multipartForm {
                        flash.message = message(code: 'default.validated.message', args: [message(code: 'post.label', default: 'Post'), postInstance.id])
                        redirect(postInstance)
                    }
                    '*' { render status: NO_CONTENT }
                }
            }
            else {
                log.info 'Post ' + pId + ' unvalidate by user ' + ((User) springSecurityService.currentUser).id

                request.withFormat {
                    form multipartForm {
                        flash.message = message(code: 'default.unvalidated.message', args: [message(code: 'post.label', default: 'Post'), postInstance.id])
                        redirect(postInstance)
                    }
                    '*' { render status: NO_CONTENT }
                }
            }
        }
        else
        {
            redirect(controller: "login", action: "denied")
        }
    }
}
