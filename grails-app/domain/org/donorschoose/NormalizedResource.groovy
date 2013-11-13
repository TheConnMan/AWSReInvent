package org.donorschoose

class NormalizedResource {
	
	String _resourceid //text NOT NULL,
	String _projectid //text NOT NULL,
	String vendorid //integer,
	String vendor_name //text,
	String project_resource_type //text,
	String item_name //text,
	String item_number //text,
	String item_unit_price //text,
	String item_quantity //text

    static constraints = {
    }
}
