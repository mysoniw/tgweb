var topics = {};

$.Topic = function(id, topicType) {
    var callbacks, method, topic = id && topics[id];
    if (!topic) {
        callbacks = $.Callbacks(topicType);
        topic = {
            publish: callbacks.fire,
            subscribe: callbacks.add,
            unsubscribe: callbacks.remove
        };
        if (id) {
            topics[id] = topic;
        }
    }
    return topic;
};
$.Topic.hasCallback = function(id) {
	if (topics[id])	return true;
	return false;
}