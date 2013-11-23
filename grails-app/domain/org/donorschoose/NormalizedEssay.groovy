package org.donorschoose

class NormalizedEssay {
	
	String _projectid //text NOT NULL,
	String title //text,
	String short_description //text,
	String need_statement //text,
	String essay //text,
	String paragraph1 //text,
	String paragraph2 //text,
	String paragraph3 //text,
	String paragraph4 //text

    static constraints = {
    }
	
	static mapping = {
		//datasource 'postgres'
	}
}
