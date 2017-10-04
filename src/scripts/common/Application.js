function Application () {}

Application.prototype = {
	modules: {},

	config:{},

	setConfig: function(key, value){
		this.config[key] = value;
		return this;
	},

	getConfig: function(key){

		var config = this.config[key];

		if (!config) {
			console.error('Config "'+key+'" is not set.');
		}

		return config;
	},

	/* ======== run application ======== */
	run: function(){
		this
			.init()
			.parse(jQuery('body'));	
	},

	/* ======== init modules ======== */
	init: function(){
		for(var module in this.getModules()){
			module = this.modules[module];

			if (typeof module.init !== "function") {continue;}

			module.init();
		}

		return this;
	},

	/* ======== parse modules ======== */
	parse: function($context){
		for(var module in this.getModules()){
			module = this.modules[module];

			if (typeof module.parse !== "function") {continue;}

			module.parse($context);
		}

		return this;
	},

	/* ======== add new module ======== */
	addModule: function(module, name){
		this.modules[name] = module;
		return this;
	},

	/* ======== get module by name ======== */
	getModule: function(name){

		var modules = this.getModules();

		if (typeof modules[name] === 'undefined') {
			console.error('Module "' + name + '" is not defined');
			return false;
		}

		return modules[name];
	},

	/* ======== get all modules ======== */
	getModules: function(){
		return this.modules;
	}
};