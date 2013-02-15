;(function($, window, document, undefined) {
	$.widget("form.waterMark", {
		options : {
			waterMarkText: "type here",
			style: {fontStyle: "italic", color: "#CCCCCC"}
		},
		_create : function() {
			var self = this;
			var element = $(this.element);

			this._initWaterMark(element);
			
		    $(this.element).focus(function() {
		        $(this).filter(function() {
		            return $(this).val() == "" || $(this).val() == self.options.waterMarkText;
		        }).css({fontStyle: "", color: ""}).val("");
		    });

		    $(this.element).blur(function() {
		        $(this).filter(function() {
		            return $(this).val() == "";
		        }).css(self.options.style).val(self.options.waterMarkText);
		    });
		    
			$.Topic("reset/reset").subscribe(function(formElement) {
				self._initWaterMark(element);
			});
			$.Topic("search/beforeClickEvent").subscribe(function() {
				if (element.val() == self.options.waterMarkText) {
					element.val("");
				}
			});
			$.Topic("search/afterClickEvent").subscribe(function() {
				self._initWaterMark(element);
			});
			$.Topic("excel/beforeClickEvent").subscribe(function() {
				if (element.val() == self.options.waterMarkText) {
					element.val("");
				}
			});
			$.Topic("excel/afterClickEvent").subscribe(function() {
				self._initWaterMark(element);
			});
		},
		_initWaterMark : function(element) {
			var self = this;
			if (element.val() == "") {
				element.css(self.options.style).val(self.options.waterMarkText);
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
