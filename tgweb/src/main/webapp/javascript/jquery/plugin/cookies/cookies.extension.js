(function() {
	if (window.jQuery && window.jQuery.cookies) {
		(function($) {
			$.cookies.constructor.prototype.cookieList = function(cookieName) {
				var cookie = $.cookies.get(cookieName) + "";
				var items = cookie ? cookie.split(/,/) : new Array();
				
				return {
					"add": function(val) {
						items.push(val);
						$.cookies.set(cookieName, items.join(","));
					},
					"remove": function(val) {
						var index = items.indexOf(val);
						if (index != -1)	items.splice(index, 1);
						$.cookies.set(cookieName, items.join(","));
					},
					"items": function() {
						return items;
					}
				};
			};
		})(window.jQuery);
	}
})();