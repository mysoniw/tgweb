;(function($, window, document, undefined) {
	$.widget("button.formSubmit", {
		options : {
			gridId: "",
			formId: "searchForm",
			data: {
				method: "up"
			},
			afterSuccessFunction: ""
		},
		_create : function() {
			var self = this;
			$(this.element).on("click", function(event) {
				if (typeof($(this).data().validation) === "function") {
					var returnObj = $(this).data().validation();
					if (!returnObj) {
						return false;
					}
				}
				$.each(self.options.data, function(key, value) { 
					var input = $("<input>").attr("type", "hidden").attr("name", key).val(value);
					$("#" + self.options.formId).append($(input));
				});
	
				$("#" + self.options.formId).attr("action", self.options.url);
				$("#" + self.options.formId).submit();
			});
		},
		destroy : function() {
			$.Widget.prototype.destroy.call(this);
		},
		_setOption : function(key, value) {
			$.Widget.prototype._setOption.apply(this, arguments);
		}
	});

})(jQuery, window, document);
