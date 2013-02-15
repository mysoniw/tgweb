;(function($, window, document, undefined) {
	$.widget("button.excel", {
		options : {
			method: "x",
			title: ""
		},
		_create : function() {
			var self = this;
			var flag = this.options.gridId !== undefined;
			
			this.options.title = flag ? $("#" + this.options.gridId).data("dataGrid").options.caption : this.options.title;
			
			$(this.element).on("click", function(event) {
				var data = $.extend({},$("#" + self.options.formId).serializeObject(), flag ? $("#" + self.options.gridId).data().metadata : {}, self.options);

				if ($.Topic.hasCallback("excel/beforeClickEvent"))	$.Topic("excel/beforeClickEvent").publish(event);
				if (typeof($(this).data().validation) === "function") {
					var returnObj = $(this).data().validation();
					if (!returnObj) {
						return false;
					}
					
					if (typeof(returnObj) === "object") {
						data.title = self.options.title + "_" + returnObj.join("_");
					}
				}
				self._download(data.url, data);
				
				if ($.Topic.hasCallback("excel/afterClickEvent"))	$.Topic("excel/afterClickEvent").publish();
				event.preventDefault();
			});
		},
		_download : function(url, data, method, callback){
			var iframeX;
			var downloadInterval;
			if (url && data) {
				// remove old iframe if has
				if ($("#iframeX"))
					$("#iframeX").remove();
				// creater new iframe
				iframeX = $("<iframe name='iframeX' id='iframeX'></iframe>").appendTo("body").hide();
				if ($.browser.msie) {
					downloadInterval = setInterval(function() {
						// if loading then readyState is “loading” else
						// readyState is “interactive”
						if (iframeX && iframeX[0].readyState !== "loading") {
							if (callback)	callback();
							clearInterval(downloadInterval);
						}
					}, 23);
				} else if ($.isFunction(callback)) {
					iframeX.load(function() {
						if (callback)	callback();
					});
				}
			
				if(url && data){ 
					var inputs = "";
					for (var key in data) {
						inputs += "<input type='hidden' name='" + key + "' value='" + data[key].toString() + "' />";
					}
					$("<form action='" + url + "' method='" + (method || "post") + "' target='iframeX'>" + inputs + "</form>").appendTo("body").submit().remove();
					/*
					data = typeof data == "string" ? data : decodeURIComponent($.param(data));
					var inputs = "";
					$.each(data.split("&"), function(){ 
						var pair = this.split("=");
						inputs+="<input type='hidden' name='" + pair[0] + "' value='" + pair[1] + "' />"; 
					});
					$("<form action='" + url + "' method='" + (method || "post") + "' target='iframeX'>" + inputs + "</form>").appendTo("body").submit().remove();
					*/
				}
			};
		},
		destroy : function() {
			$.Widget.prototype.destroy.call(this);
		},
		_setOption : function(key, value) {
			$.Widget.prototype._setOption.apply(this, arguments);
		}
	});

})(jQuery, window, document);
