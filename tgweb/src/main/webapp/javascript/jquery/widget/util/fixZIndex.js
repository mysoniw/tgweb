/* Fixes z-index issues - Version 1.2
Update v1.2 - fixed an issue when this is being called on an element that is not in the DOM tree.

This plugin fixes z-index issues typically occur in IE. It traverses up the DOM to make sure that all the ancestors of the target element have a high z-index value.

This fixes a common z-index issue that an element with high z-index is showing underneath its ancestor's sibling that has the same explicit or implicit (e.g. IE's implied zero z-index when position: relative is applied) z-index as the corresponding ancestor.
For IE 6's z-index issues with input boxes, see the jQuery bgiframe plugin.

www.davidtong.me/z-index-misconceptions-bugs-fixes/

param obj:
    recursive: boolean (default: true) - set to false to reduce the number of loops and if it still works, go for false
    exclude: string - a list of class names to be excluded in the fix
    msieOnly: boolean (default: false) - set to true to only apply the fix to IE browsers
    zIndex: string (default: '9999') - a big number that should just be high enough to make the element-to-be-fixed stay on top of other elements
*/
(function($) {
    $.fn.fixZIndex = function(params) {
        params = params || {};
        if (params.msieOnly && !$.browser.msie) return this;
        var num_of_jobj = this.length;
        for (var i = num_of_jobj; i--;) {
            var curr_element = this[i];
            var config_recursive = params.recursive || true;
            var config_exclude = params.exclude || null;
            while (curr_element != document.body) {
                if (!$(curr_element).hasClass(config_exclude) && ($(curr_element).css('position') == 'relative' || $(curr_element).css('position') == 'absolute')) {
                    if ($.data(curr_element, 'zIndex') == undefined) {
                        $.data(curr_element, 'zIndex', curr_element.style.zIndex || '-1');
                    }
                    curr_element.style.zIndex = params.zIndex || '9999';
                }
                curr_element = curr_element.parentNode;
                if (!config_recursive) break;
            }
        }
        return this;
    };

    // optional function to restore z-index if needed
    $.fn.restoreZIndex = function(params) {
        params = params || {};
        if (params.msieOnly && !$.browser.msie) return this;
        var num_of_jobj = this.length;
        for (var i = num_of_jobj; i--;) {
            var curr_element = this[i];
            var config_exclude = params.exclude || null;
            while (curr_element && curr_element != document.body) {
                var currZIndex = $.data(curr_element, 'zIndex');
                if (currZIndex > -1 && !$(curr_element).hasClass(config_exclude)) {
                    curr_element.style.zIndex = currZIndex;
                    $.removeData(curr_element, 'zIndex');
                }
                else if (currZIndex == -1) {
                    curr_element.style.zIndex = '';
                }
                curr_element = curr_element.parentNode;
            }
        }
        return this;
    };
})(jQuery);