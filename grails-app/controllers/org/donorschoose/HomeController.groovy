package org.donorschoose

class HomeController {

    def index() {
		def columns = ['*', 'Test1', 'Test2'];
		[columns: columns]
	}
	
	def SQL() { }
}
