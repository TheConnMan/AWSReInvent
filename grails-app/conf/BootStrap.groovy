import org.donorschoose.AWSAccount
import org.donorschoose.Role
import org.donorschoose.User
import org.donorschoose.UserRole

class BootStrap {
	
	def springSecurityService

	def createUser(user,pass,role) {
		def theUser = new User(username:user,enabled:true,password:springSecurityService.encodePassword(pass))
		theUser.save(flush:true)
		UserRole.create theUser, role, true
	}
	
    def init = { servletContext ->
			TimeZone.setDefault(TimeZone.getTimeZone("America/New_York"))
			try {
				if (Role.count() == 0) {
					//only populate DB if it appears empty
					def adminRole = new Role(authority:'ROLE_ADMIN').save(flush:true)
					def userRole = new Role(authority:'ROLE_USER').save(flush:true)
					createUser('admin','admin',adminRole)
					createUser('demo','demo',userRole)
				}
				if (AWSAccount.count()==0) {
					def acct=new AWSAccount(name:"dc-acct",bucketName:"dc-transfer",accessKey:"AKIAJUFMMII5U55FXE2Q",secretKey:"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").save(flush:true)
				}
			} catch (Exception e) {
			  println(e.toString());
			}
    }
    def destroy = {
    }
}
