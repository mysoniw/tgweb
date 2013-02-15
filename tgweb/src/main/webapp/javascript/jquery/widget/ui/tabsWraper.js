;(function($, window, document, undefined) {
	$.widget("ui.tabsWraper", {
		tabsOptions: {
			closable: true,
			fx: {
				height: "toggle",
				opacity: "toggle"
			},
			spinner: "Now loading...",
			select: function(event, ui) {
				$(this).css("height", $(this).height());
				$(this).css("overflow", "hidden");
			},
			show: function(event, ui) {
				$(this).css("height", "auto");
				$(this).css("overflow", "visible");
				
				if ($.Topic.hasCallback(ui.tab.hash)) {
					$.Topic(ui.tab.hash).publish(ui);
				} else {
					$.extend(window.smileGlobal, {"tabHash": ui.tab.hash});
				}
			}
		},
		_create: function() {
			var options = $.extend({}, this.tabsOptions, this.options);
			
			// this.options의 disabled: false로 인해 오류 발생 해당 attr 삭제
			delete options["disabled"];
			$(this.element).tabs(options);
		},
		destroy: function() {
			$.Widget.prototype.destroy.call(this);
		},
		_setOption: function(key, value) {
			$.Widget.prototype._setOption.apply(this, arguments);
		}
	});
})(jQuery, window, document);
