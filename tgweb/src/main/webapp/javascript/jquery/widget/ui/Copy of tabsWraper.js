/*
;(function($, window, document, undefined) {
	
	var pushUnique = function(arg) {
		if (!this instanceof Array) {
			return false;
		}
		
		if (arg instanceof Object) {
			for (var key in arg) {
				if (arg.hasOwnProperty(key)) {
					for (var i = 0, size = this.length; i < size; i++) {
						if (this[i][key] === arg[key]) return this.length;
					}
				}
			}
			return this.push(arg);
		} else {
			return (this.indexOf(arg) > -1 ? this.length : this.push(arg));
		}
	};
	var remove = function(arg) {
		if (!this instanceof Array) {
			return false;
		}

		if (arg instanceof Object) {
			for (var key in arg) {
				if (arg.hasOwnProperty(key)) {
					for (var i = 0, size = this.length; i < size; i++) {
						if (this[i][key] === arg[key])	this.splice(i, 1);
					}
				}
			}
		} else {
			var index = this.indexOf(arg);
			if (index > -1)	this.splice(index, 1);
		}
		return this;
	};
	
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
				
				$.extend(true, window.smileGlobal.tabInfo, {"tabHash": ui.tab.hash});
				//$.extend(true, window.smileGlobal, {"tabInfo": {"tabHash": ui.tab.hash}});
				
				
				var isSkip = false;
				for (var key in window.smileGlobal.tabInfo.tabs) {
					if (window.smileGlobal.tabInfo.tabs.hasOwnProperty(key)) {
						if (ui.tab.hash.indexOf(key) > -1) {
							pushUnique.call(window.smileGlobal.tabInfo.tabs[key], {"tabHash": ui.tab.hash});
							isSkip = true;
						}
					}
				}
				
				if (!isSkip)	pushUnique.call(window.smileGlobal.tabInfo.tabs.root, {"tabHash": ui.tab.hash});

				
				if ($.Topic.hasCallback(ui.tab.hash)) {
					$.Topic(ui.tab.hash).publish(ui);
				}
			},
			remove: function(event, ui) {
				console.log("tabs remove");
				
				for (var key in window.smileGlobal.tabInfo.tabs) {
					if (window.smileGlobal.tabInfo.tabs.hasOwnProperty(key)) {
						console.log(key);
						
						if (ui.tab.hash.indexOf(key) > -1) {
							remove.call(window.smileGlobal.tabInfo.tabs[key], {"tabHash": ui.tab.hash});
							return;
						}
					}
				}
				
				remove.call(window.smileGlobal.tabInfo.tabs.root, {"tabHash": ui.tab.hash});
			}
		},
		_create: function() {
			
			if (!window.smileGlobal.tabInfo)	$.extend(window.smileGlobal, {"tabInfo": {"tabs":{}}});
			
			//$.extend(true, window.smileGlobal, {"tabInfo": {"": {}}});
			
			window.smileGlobal.tabInfo.tabs[window.smileGlobal.tabInfo.tabHash || "root"] = [];
			
			
			var options = $.extend({}, this.tabsOptions, this.options);
			
			// this.options의 disabled: false로 인해 오류 발생 해당 attr 삭제
			delete options["disabled"];
			$(this.element).tabs(options);
		},
		destroy: function() {
			$.Widget.prototype.destroy.call(this);
			
			var parentKey = "#" + this.element.context.id.replace("_srm_tabs", "");
			delete window.smileGlobal.tabInfo.tabs[parentKey];
		},
		_setOption: function(key, value) {
			$.Widget.prototype._setOption.apply(this, arguments);
		}
	});
})(jQuery, window, document);
*/