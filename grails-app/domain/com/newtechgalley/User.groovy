package com.newtechgalley

class User {

	transient springSecurityService

	String username
	String password
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired
	int points
	String mailAddress

	static transients = ['springSecurityService']
	static hasMany = [badges: Badge]
	
	static constraints = {
		username blank: false, unique: true
		password blank: false
		points nullable: true
		mailAddress nullable: true, email: true
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}

	@Override
	String toString() {
		return username
	}
}
