function Module() {}

Module.prototype = {

    selectors: {},
    elements: {},

    getSelector: function(name, noDot){

        var selector = this.selectors[name];

        if (!noDot) {
            selector = '.' + selector;
        }

        return selector;
    },

    getElement: function(name){
        return this.elements[name];
    },

    loadDependency: function(file, callback){

        var defered = jQuery.ajax({
            context: this,
            url: file,
            type: "GET",
            cache: true,
            dataType: 'script'
        });

        if (callback) {
            defered.done(callback);
        }

        defered.fail(function(){
            console.error('Failed to load file: ' + file);
        });

        return defered;
    },
};
