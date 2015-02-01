package com.newtechgalley


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BadgeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Badge.list(params), model: [badgeInstanceCount: Badge.count()]
    }

    def show(Badge badgeInstance) {
        respond badgeInstance
    }

    def create() {
        respond new Badge(params)
    }

    @Transactional
    def save(Badge badgeInstance) {
        if (badgeInstance == null) {
            notFound()
            return
        }

        if (badgeInstance.hasErrors()) {
            respond badgeInstance.errors, view: 'create'
            return
        }

        badgeInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'badge.label', default: 'Badge'), badgeInstance.id])
                redirect badgeInstance
            }
            '*' { respond badgeInstance, [status: CREATED] }
        }
    }

    def edit(Badge badgeInstance) {
        respond badgeInstance
    }

    @Transactional
    def update(Badge badgeInstance) {
        if (badgeInstance == null) {
            notFound()
            return
        }

        if (badgeInstance.hasErrors()) {
            respond badgeInstance.errors, view: 'edit'
            return
        }

        badgeInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Badge.label', default: 'Badge'), badgeInstance.id])
                redirect badgeInstance
            }
            '*' { respond badgeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Badge badgeInstance) {

        if (badgeInstance == null) {
            notFound()
            return
        }

        badgeInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Badge.label', default: 'Badge'), badgeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'badge.label', default: 'Badge'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
