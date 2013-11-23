package org.donorschoose

class AWSAccount {
	
	String name
	String accessKey=""
	String secretKey=""
	String bucketName=""

	static constraints = {
		name()
		bucketName()
		accessKey()
		secretKey password: true
	}
	
	String toString() {
		name
	}
	
	static mapping = {
		//secretKey type: GormEncryptedStringType
	}
}
