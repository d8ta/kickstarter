(function(jQuery){

	/* ======== Common includes ======== */
	//= include common/Application.js
	//= include common/Module.js
	
	/* ======== Module includes ======== */

	/* ======== Application Setup ======== */
	var application = new Application();
	application
		//.addModule(new Name(), 'name')
		.run();

})(jQuery);