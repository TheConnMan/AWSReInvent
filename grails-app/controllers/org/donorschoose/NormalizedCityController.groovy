package org.donorschoose

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN','ROLE_USER'])
class NormalizedCityController {

      def scaffold = true
}
