;(function($, window, document, undefined) {
	$.widget("util.imagePreview", {
		options : {
			xOffset: 710,
			yOffset: 30
		},
		style : {
			position: "absolute",
			border: "1px solid #ccc",
			background: "#333",
			padding: "5px",
			display: "none",
			color: "#fff",
			zIndex: "99999"
		},
		_create : function() {
			var self = this;
			
			$(this.element).hover(function(e) {
				this.t = this.alt;
				this.alt = "";
				var c = (this.t != "") ? "<br/>" + this.t : "";
				$("body").append("<p id='preview' style='" + self.style.toString() + "'><img src='" + this.src + "' alt='Image preview' />" + c + "</p>");
				$("#preview")
					.css(self.style)
					//.css("top", (e.pageY - self.options.xOffset) + "px")
					.css("top", (e.pageY - (e.target.naturalHeight / 1.8)))
					.css("left", (e.pageX + self.options.yOffset) + "px")
					.fadeIn("fast");
			}, function() {
				this.alt = this.t;
				$("#preview").remove();
			});
			
			$(this.element).mousemove(function(e) {
				$("#preview")
					.css("top", (e.pageY - (e.target.naturalHeight / 1.8)) + "px")
					.css("left", (e.pageX + self.options.yOffset) + "px");
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
