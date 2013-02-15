;(function($, window, document, undefined) {
	$.widget("form.select", {
		options : {
			key: "id",
			value: "label",
			ajax: true,
			dependon: "",
			url: "",
			emptyLabel:"선택",
			data: {name:""}
		},
		_create : function() {
			var self = this;
			
			if (!this.options.dependon) {
				this._load();
			} else {
				//console.debug(this);
				self._initOptions();
				$("#" + self.options.dependon).on("change", function() {
					self._load();
				});
			}
		},
		_load: function() {
			var self = this;
			
			if (this.options.dependon) {
				if ($("#" + this.options.dependon).val() == "")	 {
					self._initOptions();
					return false;
				}
			}
			//console.debug($.extend(this.options.data, $("input[type='hidden']", "#" + this.options.formId).serializeObject()));
			$.ajax({
				url: this.options.url,
				data: (this.options.dependon ? $.extend(
							this.options.data, {name: $("#" + this.options.dependon).attr("name"), value: $("#" + this.options.dependon).val()}, $("input[type='hidden']", "#" + this.options.formId).serializeObject()
						) : $.extend(this.options.data, $("input[type='hidden']", "#" + this.options.formId).serializeObject())),
				type: this.options.type || "post",
				datatype: "json",
				success: function(_response) {
					self._initOptions();
					$.each(_response, function(key, value) {
						$(self.element).append($("<option></option>").attr("value", value.id).text(value.label));
					});
				},
				error: function(xhr, desc, er) {
					//console.debug("error");
				}
			});
		},
		_initOptions: function() {
			var self = this;
			$(self.element).find('option').remove();
			$(self.element).append(($("<option></option>").attr("value", "").text(self.options.emptyLabel)));
			$(self.element).trigger("change");
		},
		destroy : function() {
			$.Widget.prototype.destroy.call(this);
		},
		_setOption : function(key, value) {
			$.Widget.prototype._setOption.apply(this, arguments);
		}
	});

})(jQuery, window, document);
