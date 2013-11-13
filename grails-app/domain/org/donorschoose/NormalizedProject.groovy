package org.donorschoose

class NormalizedProject {
	
	// IDs
	String _projectid 
	String _teacher_acctid 
	String _schoolid 
  
   // Project Categories
	String  primary_focus_subject 
	String primary_focus_area 
	String secondary_focus_subject 
	String secondary_focus_area 
	String resource_usage 
	String resource_type 
	String poverty_level 
	String grade_level
  
   // Project Pricing and Impact
	Number vendor_shipping_charges //numeric(10,2),
	Number sales_tax //numeric(10,2),
	Number payment_processing_charges //numeric(10,2),
	Number fulfillment_labor_materials //numeric(10,2),
	Number total_price_excluding_optional_support //numeric(10,2),
	Number total_price_including_optional_support //numeric(10,2),
	int students_reached 
	boolean used_by_future_students 
  
   // Project Donations
	Number total_donations //numeric(10,2),
	int num_donors 
	boolean eligible_double_your_impact_match 
	boolean eligible_almost_home_match 
  
   // Project Status
	String funding_status 
	Date date_posted
	Date date_completed 
	Date date_thank_you_packet_mailed 
	Date date_expiration 

    static constraints = {
    }
}
