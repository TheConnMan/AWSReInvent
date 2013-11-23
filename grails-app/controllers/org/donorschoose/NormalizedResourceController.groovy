package org.donorschoose

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class NormalizedResourceController {

     def scaffold = true
}
