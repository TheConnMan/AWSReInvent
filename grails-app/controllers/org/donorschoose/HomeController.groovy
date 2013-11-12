package org.donorschoose

import grails.converters.JSON
import java.sql.*;
import groovy.sql.*;

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
		//Class.forName("org.postgresql.Driver");
		String connectionURL = "jdbc:postgresql://ec2-54-205-113-208.compute-1.amazonaws.com/dcpoc";
		Properties props = new Properties();
		props.setProperty("user","dcpoc");
		props.setProperty("password","dcpoc123");
		props.setProperty("ssl","true");
		Connection connection = DriverManager.getConnection(connectionURL, props);
		Statement statement = null;
		ResultSet rs = null;
		int updateQuery = 0;
		statement = connection.createStatement();
		String QueryString = "SELECT * from dcpoc;";
		rs = statement.executeQuery(QueryString);
		while (rs.next()) {
			System.out.println(rs);
		}
		rs.close();
		statement.close();
		connection.close();
	}
}