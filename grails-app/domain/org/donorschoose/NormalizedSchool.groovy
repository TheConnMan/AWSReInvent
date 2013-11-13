package org.donorschoose

class NormalizedSchool {
	
	// IDs
	String _schoolid
	String ncesid 
  
   //School Location
	Number latitude 
	Number longitude 
	int cityid 
	String zip 
	String metro
	String district 
	String county
  
   // School Types
	boolean charter
	boolean magnet 
	boolean year_round 
  
   //Charter Network Affiliation
	boolean nlns 
	boolean kipp 
	boolean charter_ready_promise

    static constraints = {
    }
}
