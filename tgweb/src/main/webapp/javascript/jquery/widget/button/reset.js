;(function($, window, document, undefined) {
	$.widget("button.reset", {
		options : {
			formId: "searchForm"
		},
		_create : function() {
			var self = this;
			$(this.element).on("click", function(event) {
				$("#" + self.options.formId).each(function() {
					var pager = $(this).find(".ui-pg-input");
					var pagerVal = pager.val();
					var select = $(this).find(".ui-pg-selbox");
					var selectVal = select.val();
					
					this.reset();
					
					// prevent pager reset
					pager.val(pagerVal);
					select.val(selectVal);
					
					if ($.Topic.hasCallback("reset/reset"))	$.Topic("reset/reset").publish();
				});
				event.preventDefault();
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
