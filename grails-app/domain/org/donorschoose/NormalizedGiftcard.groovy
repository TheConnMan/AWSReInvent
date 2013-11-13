package org.donorschoose

class NormalizedGiftcard {
	
	String _giftcardid //text NOT NULL,
	String  dollar_amount //text,
  
	String _buyer_acctid //text NOT NULL,
	Date date_purchased //date,
	String  _buyer_cartid //text,
  
	String _recipient_acctid //text,
	boolean redeemed //boolean,
	Date date_redeemed //date,
	String _redeemed_cartid //text

    static constraints = {
    }
}
