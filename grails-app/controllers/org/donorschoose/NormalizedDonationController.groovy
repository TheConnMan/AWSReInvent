package org.donorschoose

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class NormalizedDonationController {

      def scaffold = true
}
