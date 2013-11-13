package org.donorschoose

import grails.converters.JSON
import groovy.grape.Grape
import groovy.sql.Sql
import org.postgresql.Driver

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
	
	def queryDB() {
		Class.forName("org.postgresql.Driver");
		// Groovy way of creating a DB connection
		def db = Sql.newInstance (
			 'jdbc:postgresql://ec2-54-205-113-208.compute-1.amazonaws.com:5432/dcpoc',
			 'dcpoc',
			 'dcpoc123',
			 'org.postgresql.Driver')
		 
		// even Groovier...
		db.eachRow('SELECT * FROM mytable') {
			println  it.mycolumnname
		}
	}
}