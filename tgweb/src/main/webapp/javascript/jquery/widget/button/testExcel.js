;(function($, window, document, undefined) {
	$.widget("button.testExcel", {
		options : {
			method: "x",
			title: ""
		},
		_create : function() {
			var self = this;
			
			var flag = this.options.gridId !== undefined;
			
			this.options.title = "aaaa";

			$(this.element).on("click", function(event) {
				if ($.Topic.hasCallback("excel/beforeClickEvent"))	$.Topic("excel/beforeClickEvent").publish();
				
				var data = $.extend({},$("#" + self.options.formId).serializeObject(), flag ? $("#" + self.options.gridId).data().metadata : {}, self.options);
				self._download("sampleExcel.do", data);
				
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
				iframeX = $("<iframe src='[removed]false;' name='iframeX' id='iframeX'></iframe>").appendTo("body").hide();
				if ($.browser.msie) {
					downloadInterval = setInterval(function() {
						// if loading then readyState is “loading” else
						// readyState is “interactive”
						if (iframeX && iframeX[0].readyState !== "loading") {
							callback();
							clearInterval(downloadInterval);
						}
					}, 23);
				} else if ($.isFunction(callback)) {
					iframeX.load(function() {
						callback();
					});
				}
			
				if(url && data){ 
					data = typeof data == "string" ? data : $.param(data);
					var inputs = "";
					$.each(data.split("&"), function(){ 
						var pair = this.split("=");
						inputs+="<input type='hidden' name='" + pair[0] + "' value='" + pair[1] + "' />"; 
					});
					$("<form action='" + url + "' method='" + (method || "post") + "' target='iframeX'>" + inputs + "</form>").appendTo("body").submit().remove();
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
