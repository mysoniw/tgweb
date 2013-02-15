;(function($, window, document, undefined) {
	$.widget("button.search", {
		options : {
			gridId: "",
			formId: "searchForm",
			data: {
				method: "s"
			}
		},
		_create : function() {
			var self = this;
			$(this.element).on("click", function(event) {
				if ($.Topic.hasCallback("search/beforeClickEvent"))	$.Topic("search/beforeClickEvent").publish();
				
				var data = $.extend({}, $("#" + self.options.formId).serializeObject(), self.options.data);
				$("#" + self.options.gridId).jqGrid("setGridParam", {postData: $.extend({page:1}, data)}).trigger("reloadGrid");

				if ($.Topic.hasCallback("search/afterClickEvent"))	$.Topic("search/afterClickEvent").publish();
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
