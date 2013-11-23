package org.donorschoose

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class NormalizedProjectController {

   def scaffold = true
}
