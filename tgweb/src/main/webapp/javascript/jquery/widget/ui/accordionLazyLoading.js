;(function($, window, document, undefined) {
	$.widget("ui.accordionLazyLoading", {
		options : {
			method: "l",
			accordionDefault: {
				header: "> div.accordionPart > h3",
				multiple: true,
				collapsible: true,
				autoHeight: false
			},
			child: []
		},
		_create : function() {
			var self = this;
			
			$(this.element).find("div.accordionPart").each(function(i) {
				if ($(this).attr("data") !== undefined) {
					self.options.child[i] = $(this).metadata();
				}
			});
			$(this.element).accordion($.extend(self.options.accordionDefault, {
				changestart: function(event, ui) {
					
					if (ui.options.active !== false) {
						var _metadata;
						if ((_metadata = self.options.child[ui.options.active]) !== undefined && !_metadata.isLoaded) {
							ui.newContent.load(_metadata.url, $.extend($("#" + _metadata.formId).serializeObject(), _metadata), function(responseText, statusText, xhr) {
								// callback
							});
							/*
							ui.newContent.load(_metadata.url, $("#" + _metadata.formId).serializeObject(), function(responseText, statusText, xhr) {
								// callback
							});
							*/
							_metadata.isLoaded = true;
						}
					}
				}
			})).sortable({
				axis: "y",
				handle: "h3",
				stop: function(event, ui) {
					ui.item.children("h3").triggerHandler("focusout");
				}
			});
			
			$(this.element).find("> div.accordionPart").not(".closed").find("h3")
				.removeClass('ui-state-default')
				.addClass('ui-state-active')
				.removeClass('ui-corner-all')
				.addClass('ui-corner-top')
				.attr('aria-expanded', 'true')
				.attr('aria-selected', 'true')
				.attr('tabIndex', 0)
				.find('span.ui-icon')
				.removeClass('ui-icon-triangle-1-e')
				.addClass('ui-icon-triangle-1-s')
				.closest('h3').next('div')
				.show();
		},
		destroy : function() {
			$.Widget.prototype.destroy.call(this);
		},
		_setOption : function(key, value) {
			$.Widget.prototype._setOption.apply(this, arguments);
		}
	});

})(jQuery, window, document);
