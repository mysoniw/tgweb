Common = {}

Common.format = function(text) {
    if (arguments.length <= 1) {
        return text;
    }
    var tokenCount = arguments.length - 2;
    for (var token = 0; token <= tokenCount; token++) {
        text = text.replace(new RegExp("\\{" + token + "\\}", "gi"),
                                                arguments[token + 1]);
    }
    return text;
}

Common.escapeHTML = function(str) {
    str = str.replace(/&/g, "&amp;");
    str = str.replace(/</g, "&lt;");
    str = str.replace(/>/g, "&gt;");

    return str;
}

Common.formatDate = function(date, formatString)
{
    var tempDateString;
    tempDateString = formatString.replace("yyyy", date.getFullYear());
    tempDateString = tempDateString.replace("MM", date.getMonth() + 1);
    tempDateString= tempDateString.replace("dd", date.getDate());
    
    return tempDateString;
}

Common.showProgressBox = function(message) {
    $("#progressBox").modal({
        close: false,
        position: ["20%", ],
        overlayId: 'modalBackground',
        containerId: 'modalContainer',
        onShow: function(dialog) {
            dialog.data.find('#message').append(message);
            dialog.data.find('#close').click(function() {
                $.modal.close();
            });
        }
    });
}

var stringEscape = {
    '\b': '\\b',
    '\t': '\\t',
    '\n': '\\n',
    '\f': '\\f',
    '\r': '\\r',
    '"': '\\"',
    '\\': '\\\\'
};

Common.replaceJSONSafeEscape = function(string) {
    return string
            .replace(
				/[\x00-\x1f\\"]/g,
				function(a) {
                    var b = stringEscape[a];
				    if (b)
				        return b;
				    else 
				        return a;
				}
			);
}

Common.queryString = function(name) {
    var q = location.search.replace(/^\?/, '').replace(/\&$/, '').split('&');
    for (var i = q.length - 1; i >= 0; i--) {
        var p = q[i].split('='), key = p[0], val = p[1];
        if (name.toLowerCase() == key.toLowerCase()) return val;
    }

    return "";
}