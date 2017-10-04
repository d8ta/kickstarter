function Profiler() {

	return {
		result: this.result.bind(this),
		start: this.start.bind(this),
		stop: this.stop.bind(this),
		test: this.test.bind(this)
	};
}

Profiler.prototype = {

	config: {
		tries: 500
	}, 

	vars: {
		start: 0
	},

	results: [],

	getTimestamp: function(){
		return window.performance.now();	
	},


	start: function(){
		this.vars.start = this.getTimestamp();	
	},

	stop: function(log){
		this.results.push(this.getTimestamp() -  this.vars.start);

		if (log) {
			this.result();
		}
	},

	result: function(){
		
		var sum = 0;

		for(var i = 0, len = this.results.length; i < len; i++){
			sum += this.results[i];
		}

		sum /= len;

		console.log('Result after ' + len + ' tries: ' + sum + 'ms');

	},

	test: function(callback, tries){

		tries = tries || this.config.tries;

		for(var i = 0; i < tries; i++){
			this.start();
			callback();
			this.stop();
		}

		this.result();
		this.reset();
	},

	reset: function(){
		this.results = [];
	}
};