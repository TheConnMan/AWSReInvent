package org.donorschoose

import org.donorschoice.AWSAccount;

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

/*import java.sql.Connection
import java.sql.DriverManager
import java.sql.ResultSet
import java.sql.Statement
import org.hibernate.SessionFactory*/
import groovy.sql.Sql

@Secured(['ROLE_ADMIN','ROLE_USER'])
class HomeController {
	String url='jdbc:postgresql://54.205.113.208:5432/dcpoc';
	String user='dcpoc'
	String password='dcpoc123'
	String driver='org.postgresql.Driver' ;
	
	def index() {
		/*def tables = [:]
		tables << ['Test1' : ['Test11', 'Test12']]
		tables << ['Test2' : ['Test21', 'Test22']]
		tables << ['Test3' : ['Test31']]
		println new JSON(tables).toString()
		[tables: new JSON(tables).toString()]*/
	//	String select="SELECT table_name FROM information_schema.tables WHERE table_schema='public' and table_name
		String select="SELECT COLUMN_NAME, TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME LIKE 'nor%'";
		// like 'nor%' "
		def tables = []
		groovy.sql.Sql sql = Sql.newInstance(url,user, password, driver)
		
		sql.eachRow(select) {
		  tables << it.toRowResult()	
		}
		def fixedTables = [:]

		//[tables: new JSON(tables).toString()]
		
		
		//tables.collect{key, value> }
		def results = tables.collect { r ->
			   [r.table_name ,  r.column_name] }
		for (i in results) {
			if (!fixedTables[i[0]]) {
				fixedTables << [(i[0]) : [(i[1])]]
			} else {
				def temp = fixedTables[i[0]]
				temp.push(i[1])
				fixedTables[i[0]] = temp
			}
		}
		[tables: new JSON(fixedTables).toString()]
	   }

	def CloudFormationService
		   
	def buildStack() {
	  File tfile=grailsApplication.parentContext.getResource("data/cloud-formation.template").file
	  AWSAccount acct=AWSAccount.first()
	  String scr=tfile.text.toString()
      CloudFormationService.createStack(acct,"DonorsChooseCustom",scr)
	  redirect(view:"index")
	}
	
	
	def SQL() { }
	
	def runSQL(){
	   def results = []
       groovy.sql.Sql sql = Sql.newInstance(url,user , password, driver)	
	   sql.eachRow( params.sql) {
		  results << it.toRowResult()		
       }
	   render(new JSON(results).toString())
	}
	
	//def dataSource2
	
	def queryDB() {
		//Class.forName("org.postgresql.Driver");
		/*String connectionURL = "jdbc:postgresql://ec2-54-205-113-208.compute-1.amazonaws.com/dcpoc";
		Properties props = new Properties();
		props.setProperty("user","dcpoc");
		props.setProperty("password","dcpoc123");
		props.setProperty("ssl","true");
		Connection connection = DriverManager.getConnection(connectionURL, props);*/
		//println 'trying....'
		/*
	groovy.sql.Sql sql = Sql.newInstance('jdbc:postgresql://54.205.113.208:5432/dcpoc',
		'dcpoc', 'dcpoc123', 'org.postgresql.Driver' )
	sql.eachRow( "SELECT table_name FROM information_schema.tables WHERE table_schema='public' and table_name like 'nor%' ") { 
		println " ${it.table_name} " }
	
	String select="SELECT table_name FROM information_schema.tables WHERE table_schema='public' and table_name like 'nor%' "
	def results = []
	sql.eachRow(select) {
	  results << it.toRowResult()
		
		println (results)
	
	}
	def results2=[]
	println "-----#####"
	[results: new JSON(results).toString()]
	println "------"
	println results
	*/
	
	//return results
	
		/*Statement statement = null;
		ResultSet rs = null;
		int updateQuery = 0;
		statement = connection.createStatement();
		String QueryString = "select * from normalized_city limit 5;";
		rs = statement.executeQuery(QueryString);
		while (rs.next()) {
			System.out.println(rs);
		}
		rs.close();
		statement.close();
		connection.close();*/
	}
    
}
