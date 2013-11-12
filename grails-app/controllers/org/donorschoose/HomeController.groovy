package org.donorschoose

import grails.converters.JSON

class HomeController {

    def index() {
		def tables = [:]
		tables << ['Test1' : ['Test11', 'Test12']]
		tables << ['Test2' : ['Test21', 'Test22']]
		tables << ['Test3' : ['Test31']]
		println new JSON(tables).toString()
		[tables: new JSON(tables).toString()]
	}
	
	def SQL() { }
}
