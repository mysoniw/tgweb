;(function($, window, document, undefined) {
	$.widget("form.selectmenuWrap", {
		options: {
			key: "id",
			value: "label",
			ajax: true,
			dependon: "",
			url: "",
			emptyLabel:"선택",
			data: {}
		},
		selectmenuOptions: {
			style: "dropdown",
			icons: [
				{find: '.emptyOption', icon: 'ui-icon-info'}
			]
		},
		_create: function() {
			var self = this;
			
			$.Topic("reset/reset").subscribe(function() {
				self._createFunction.apply(self);
			});
			this._createFunction();
//			console.debug(this);
			
		},
		_createFunction: function() {
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
					$(self.element).selectmenu("destroy").selectmenu(self.selectmenuOptions);
					return false;
				}
			}
			//console.debug($.extend(this.options.data, $("input[type='hidden']", "#" + this.options.formId).serializeObject()));
			
			self._loadingProcess();
			
			$.ajax({
				url: this.options.url,
				data: (this.options.dependon ? $.extend(
							this.options.data, {name: $("#" + this.options.dependon).attr("name"), value: $("#" + this.options.dependon).val()}, $("input[type='hidden']", "#" + this.options.formId).serializeObject()
						) : $.extend(this.options.data, {name: ""}, $("input[type='hidden']", "#" + this.options.formId).serializeObject())),
				type: this.options.type || "post",
				datatype: "json",
				success: function(_response) {
					self._initOptions();
					$.each(_response, function(key, value) {
						$(self.element).append($("<option></option>").attr("value", value.id).text(value.label));
					});
					
					$(self.element).selectmenu("destroy").selectmenu(self.selectmenuOptions);
				},
				error: function(xhr, desc, er) {
					//console.debug("error");
				}
			});
		},
		_initOptions: function() {
			var self = this;
			$(self.element).find('option').remove();
			$(self.element).append(($("<option></option>").attr("value", "").text(self.options.emptyLabel).addClass("emptyOption")));
			$(self.element).trigger("change");
		},
		_loadingProcess: function() {
			var self = this;
			$(self.element).find('option').remove();
			$(self.element).append(($("<option></option>").attr("value", "").text("loading....")));
			$(self.element).trigger("change");
			$(self.element).selectmenu("destroy").selectmenu(self.selectmenuOptions);
		},
		destroy: function() {
			$.Widget.prototype.destroy.call(this);
		},
		_setOption: function(key, value) {
			$.Widget.prototype._setOption.apply(this, arguments);
		}
	});

})(jQuery, window, document);
