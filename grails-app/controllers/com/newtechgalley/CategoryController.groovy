package com.newtechgalley

import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CategoryController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Category.list(params), model: [categoryInstanceCount: Category.count()]
    }

    def show(Category categoryInstance) {
        respond categoryInstance
    }

    @Secured(['ROLE_ADMIN'])
    def create() {
        respond new Category(params)
    }

    @Transactional
    @Secured(['ROLE_ADMIN'])
    def save(Category categoryInstance) {
        if (categoryInstance == null) {
            notFound()
            return
        }

        if (categoryInstance.hasErrors()) {
            respond categoryInstance.errors, view: 'create'
            return
        }

        categoryInstance.save flush: true

        log.info 'Category '+ categoryInstance.id + ' created by admin with id ' + ((User) springSecurityService.currentUser).id

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'category.label'), categoryInstance.id])
                redirect categoryInstance
            }
            '*' { respond categoryInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_ADMIN'])
    def edit(Category categoryInstance) {
        respond categoryInstance
    }

    @Transactional
    @Secured(['ROLE_ADMIN'])
    def update(Category categoryInstance) {
        if (categoryInstance == null) {
            notFound()
            return
        }

        if (categoryInstance.hasErrors()) {
            respond categoryInstance.errors, view: 'edit'
            return
        }

        categoryInstance.save flush: true

        log.info 'Category '+ categoryInstance.id + ' updated by admin with id ' + ((User) springSecurityService.currentUser).id

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'category.label'), categoryInstance.id])
                redirect categoryInstance
            }
            '*' { respond categoryInstance, [status: OK] }
        }
    }

    @Transactional
    @Secured(['ROLE_ADMIN'])
    def delete(Category categoryInstance) {

        if (categoryInstance == null) {
            notFound()
            return
        }

        long cId = categoryInstance.id

        categoryInstance.delete flush: true

        log.info 'Category '+ cId + ' created by admin with id ' + ((User) springSecurityService.currentUser).id

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'category.label'), categoryInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
