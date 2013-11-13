class UrlMappings {

	static mappings = {
     //   "/$controller/$action?/$id?(.${format})?"{
			"/$controller/$action?/$id?"{
            constraints {
                // apply constraints here
            }
        }
		//	"/controllers"(view:"/index")
	   //"/"(controller:"home")
       "/"(view:"/index")
        "500"(view:'/error')
	}
}
