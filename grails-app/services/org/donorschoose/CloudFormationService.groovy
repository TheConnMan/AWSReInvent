package org.donorschoose

import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.donorschoice.AWSAccount

import com.amazonaws.auth.AWSCredentials
import com.amazonaws.auth.BasicAWSCredentials
import com.amazonaws.services.cloudformation.AmazonCloudFormationClient
import com.amazonaws.services.cloudformation.model.CreateStackRequest
import com.amazonaws.services.cloudformation.model.CreateStackResult
import com.amazonaws.services.s3.AmazonS3Client

class CloudFormationService {

	def grailsApplication = ApplicationHolder.application

	def getS3Url(acct,String name,String text) {
		if (acct.bucketName.length()==0) return(null)
		AWSCredentials creds=new BasicAWSCredentials(acct.accessKey,acct.secretKey)
		AmazonS3Client client=new AmazonS3Client(creds)
		if (!client.doesBucketExist(acct.bucketName)) {
			println("Creating transfer bucket:"+acct.bucketName);
			client.createBucket(acct.bucketName);
		} else {
			println("Using existing transfer bucket:"+acct.bucketName);
		}
		File file=File.createTempFile("fulljson",".template")
		file.write(text)
		client.putObject(acct.bucketName,name,file)
		file.delete()
		String url=client.getResourceUrl(acct.bucketName,name)
		return(url)
	}

	def createStack(AWSAccount acct,String name,String script) {
		AWSCredentials creds=new BasicAWSCredentials(acct.accessKey,acct.secretKey)
		AmazonCloudFormationClient client=new AmazonCloudFormationClient(creds)
		CreateStackRequest createReq
		if (script.length()>51200) {
			println("Stack template exceeds string limit ("+script.length()+">51200) -- using S3 transfer")
			String url=getS3Url(acct,name+"-full.template",script)
			createReq=new CreateStackRequest().withTemplateURL(url)
		} else {
			createReq=new CreateStackRequest().withTemplateBody(script)
		}
		createReq.setStackName(name)
		try {
			CreateStackResult result=client.createStack(createReq)
			return("Stack "+result.stackId+" created.")
		} catch (Exception e) {
			return("Error: Stack creation failed: "+e.toString())
		}
	}
	
}
