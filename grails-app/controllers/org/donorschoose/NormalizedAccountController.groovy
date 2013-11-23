package org.donorschoose

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN','ROLE_USER'])
class NormalizedAccountController {

     def scaffold = true
}
