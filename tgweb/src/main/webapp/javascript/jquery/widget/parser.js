;(function($, window, document, undefined) {
	$.widget("common.parser", {
		options : {},
		_create : function() {
			switch(this.element[0].tagName.toLowerCase()) {
			case "button":
				switch($(this.element).attr("class")) {
				case "search":
					$.extend(this.options, {icons:{primary:"ui-icon-search"}});
					break;
				case "excel":
					$.extend(this.options, {icons:{primary:"ui-icon-disk"}});
					break;
/*
				case "excel report":
					$.extend(this.options, {icons:{primary:"ui-icon-newwin"}});
					break;
*/
				case "report":
					$.extend(this.options, {icons:{primary:"ui-icon-newwin"}});
					break;
				case "reset":
					$.extend(this.options, {icons:{primary:"ui-icon-arrowreturnthick-1-w"}});
					break;
				case "formSubmit":
					$.extend(this.options, {icons:{primary:"ui-icon-key"}});
					break;
				}
				
				$(this.element).button(this.options);
				break;
			}
		},
		destroy : function() {
			$.Widget.prototype.destroy.call(this);
		},
		_setOption : function(key, value) {
			$.Widget.prototype._setOption.apply(this, arguments);
		}
	});

})(jQuery, window, document);
