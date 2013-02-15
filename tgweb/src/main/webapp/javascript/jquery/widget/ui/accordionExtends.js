// extend jquery ui accordion to allow multiple
// sections at once if the multiple option is true

$.extend($.ui.accordion.prototype.options,{multiple: false});
var _toggle = $.ui.accordion.prototype._toggle;
var _clickHandler = $.ui.accordion.prototype._clickHandler;
$.extend($.ui.accordion.prototype,{
	_toggle: function(toShow, toHide, data, clickedIsActive, down){
		if (this.options.collapsible && this.options.multiple && toShow.is(':visible')) {
			arguments[1] = arguments[0];
			arguments[3] = true;
		}
		else if (this.options.collapsible && this.options.multiple) {
			arguments[1] = $([]);			
		}
		_toggle.apply(this,arguments);
		this.active
			.removeClass( "ui-state-active ui-corner-top" )
			.addClass( "ui-state-default ui-corner-all" )
	},
	_clickHandler: function(event, target){
		if ($(target).next().is(':visible:not(:animated)')) {
			this.active = $(target);
		}
		_clickHandler.apply(this,arguments)
	}
});
