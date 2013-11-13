package org.donorschoose

class NormalizedDonation {
	
	// IDs
	String _donationid //textNOT NULL,
	String _projectid //text NOT NULL,
	String  _donor_acctid //text NOT NULL,
	String  _cartid 
  
 // Donation Times and Amounts
	Date donation_timestamp // timestamp without time zone,
	String dollar_amount 
	boolean donation_included_optional_support 
  
  //Payment Types
	String  payment_method 
	boolean payment_included_acct_credit 
	boolean payment_included_campaign_gift_card 
	boolean payment_included_web_purchased_gift_card 
  
  //Donation Types
	boolean via_giving_page
	boolean for_honoree 
	boolean thank_you_packet_mailed 

    static mapping = { 
        donation_timestamp  sqlType: 'timestamp' 
    } 
}
