"use strict";

// Avoid `console` errors in browsers that lack a console.
if (!(window.console && (console.log || console.debug))) {
    (function() {
        var noop = function() {};
        var methods = ["assert", "clear", "count", "debug", "dir", "dirxml", "error", "exception", "group", "groupCollapsed", "groupEnd", "info", "log", "markTimeline", "profile", "profileEnd", "markTimeline", "table", "time", "timeEnd", "timeStamp", "trace", "warn"];
        var length = methods.length;
        var console = window.console = {};
        while (length--) {
            console[methods[length]] = noop;
        }
    }());
}

// common functions
var getKeys = function(obj) {
	var keys = [];
	for (var key in obj) {
		keys.push(key);
	}
	return keys;
};

var getValues = function(objArr, whatKey, isNum) {
	var values = [];
	
	$.each(objArr, function() {
		for (var key in this) {
			if (key === whatKey) {
				values.push(isNum ? parseFloat(this[key]) : this[key]);
			}
		}
	});
	
	return values;
};

var getArrayValues = function(objArr, whatKeyArr, isNum) {
	var values = [];
	
	$.each(objArr, function() {
		var retObj = {};
		for (var key in this) {
			var _this = this;
			$.each(whatKeyArr, function() {
				if (key === this.key) {
					retObj[this.series] = (isNum ? parseFloat(_this[key]) : _this[key]);
				}
			});
		}
		values.push(retObj);
	});
	
	return values;
};


(function() {
	// extends jQuery
	$.fn.serializeObject = function() {
		var o = {};
		var a = this.serializeArray();
		$.each(a, function() {
			if (o[this.name] !== undefined) {
				if (!o[this.name].push) {
					o[this.name] = [ o[this.name] ];
				}
				o[this.name].push(this.value || "");
			} else {
				o[this.name] = this.value || "";
			}
		});
		return o;
	};
	
	// implement JSON.stringify serialization
	JSON.stringify = JSON.stringify || function (obj) {
	    var t = typeof (obj);
	    if (t != "object" || obj === null) {
	        // simple data type
	        if (t == "string") obj = '"'+obj+'"';
	        return String(obj);
	    }
	    else {
	        // recurse array or object
	        var n, v, json = [], arr = (obj && obj.constructor == Array);
	        for (n in obj) {
	            v = obj[n]; t = typeof(v);
	            if (t == "string") v = '"'+v+'"';
	            else if (t == "object" && v !== null) v = JSON.stringify(v);
	            json.push((arr ? "" : '"' + n + '":') + String(v));
	        }
	        return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
	    }
	};

	// extends String prototype
	String.prototype.startsWith = function(t, i) { 
		if (i==false) { 
			return (t == this.substring(0, t.length)); 
		} else { 
			return (t.toLowerCase() == this.substring(0, t.length).toLowerCase()); 
		} 
	}; 
	// extends String prototype
	String.prototype.endsWith = function(t, i) { 
		if (i==false) { 
			return (t == this.substring(this.length - t.length)); 
		} else { 
			return (t.toLowerCase() == this.substring(this.length - t.length).toLowerCase()); 
		} 
	};
	


	// Add ECMA262-5 method binding if not supported natively
	//
	if (!("bind" in Function.prototype)) {
	    Function.prototype.bind= function(owner) {
	        var that= this;
	        if (arguments.length<=1) {
	            return function() {
	                return that.apply(owner, arguments);
	            };
	        } else {
	            var args= Array.prototype.slice.call(arguments, 1);
	            return function() {
	                return that.apply(owner, arguments.length===0? args : args.concat(Array.prototype.slice.call(arguments)));
	            };
	        }
	    };
	}

	// Add ECMA262-5 string trim if not supported natively
	//
	if (!("trim" in String.prototype)) {
	    String.prototype.trim= function() {
	        return this.replace(/^\s+/, "").replace(/\s+$/, "");
	    };
	}

	// Add ECMA262-5 Array methods if not supported natively
	//
	if (!("indexOf" in Array.prototype)) {
	    Array.prototype.indexOf= function(find, i /*opt*/) {
	        if (i===undefined) i= 0;
	        if (i<0) i+= this.length;
	        if (i<0) i= 0;
	        for (var n= this.length; i<n; i++)
	            if (i in this && this[i]===find)
	                return i;
	        return -1;
	    };
	}
	if (!("lastIndexOf" in Array.prototype)) {
	    Array.prototype.lastIndexOf= function(find, i /*opt*/) {
	        if (i===undefined) i= this.length-1;
	        if (i<0) i+= this.length;
	        if (i>this.length-1) i= this.length-1;
	        for (i++; i-->0;) /* i++ because from-argument is sadly inclusive */
	            if (i in this && this[i]===find)
	                return i;
	        return -1;
	    };
	}
	if (!("forEach" in Array.prototype)) {
	    Array.prototype.forEach= function(action, that /*opt*/) {
	        for (var i= 0, n= this.length; i<n; i++)
	            if (i in this)
	                action.call(that, this[i], i, this);
	    };
	}
	if (!("map" in Array.prototype)) {
	    Array.prototype.map= function(mapper, that /*opt*/) {
	        var other= new Array(this.length);
	        for (var i= 0, n= this.length; i<n; i++)
	            if (i in this)
	                other[i]= mapper.call(that, this[i], i, this);
	        return other;
	    };
	}
	if (!("filter" in Array.prototype)) {
	    Array.prototype.filter= function(filter, that /*opt*/) {
	        var other= [], v;
	        for (var i=0, n= this.length; i<n; i++)
	            if (i in this && filter.call(that, v= this[i], i, this))
	                other.push(v);
	        return other;
	    };
	}
	if (!("every" in Array.prototype)) {
	    Array.prototype.every= function(tester, that /*opt*/) {
	        for (var i= 0, n= this.length; i<n; i++)
	            if (i in this && !tester.call(that, this[i], i, this))
	                return false;
	        return true;
	    };
	}
	if (!("some" in Array.prototype)) {
	    Array.prototype.some= function(tester, that /*opt*/) {
	        for (var i= 0, n= this.length; i<n; i++)
	            if (i in this && tester.call(that, this[i], i, this))
	                return true;
	        return false;
	    };
	}
}());