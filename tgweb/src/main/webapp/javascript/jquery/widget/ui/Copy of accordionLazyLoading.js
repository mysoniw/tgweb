;(function($, window, document, undefined) {
	$.widget("ui.accordionLazyLoading", {
		options : {
			method: "l",
			accordionDefault: {
				
				
				header: "> div > h3",
				
				
				
				
				
				collapsible: true,
				autoHeight: false
			}
		},
		_create : function() {
			var self = this, 
			isFirstTime = true;
			
			$(this.element).accordion($.extend(self.options.accordionDefault, {
				changestart: function(event, ui) {
					if (ui.options.active !== false) {
						if (self.options.url && isFirstTime) {
							ui.newContent.load(self.options.url, $("#" + self.options.formId).serializeObject(), function(responseText, statusText, xhr) {
								// callback
							});
							isFirstTime = false;
						}
						
					}
				}
			})).sortable({
				axis: "y",
				handle: "h3",
				create: function(event, ui) {
					console.log(ui);
				},
				stop: function(event, ui) {
					ui.item.children("h3").triggerHandler("focusout");
				}
			});
			
			if (this.options.active) {
				$(this.element).accordion("activate", false);
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
