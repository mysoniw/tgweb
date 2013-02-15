(function ($) {
    $.fn.styleTable = function (options) {
        var defaults = {
            css: 'styleTable'
        };
        options = $.extend(defaults, options);

        return this.each(function () {

            input = $(this);
            input.addClass(options.css);

            $(input.find("tr")).on('mouseover mouseout', function (event) {
                if (event.type == 'mouseover') {
                    $(this).children("th").addClass("styleTable-state-hover");
                    $(this).children("td").addClass("styleTable-state-hover");
                } else {
                    $(this).children("th").removeClass("styleTable-state-hover");
                    $(this).children("td").removeClass("styleTable-state-hover");
                }
            });

            input.find("th").addClass("styleTable-state-default");
            input.find("td").addClass("styleTable-widget-content");

            input.find("tr").each(function () {
                $(this).children("td:not(:first)").addClass("first");
                $(this).children("th:not(:first)").addClass("first");
            });
        });
    };
})(jQuery);