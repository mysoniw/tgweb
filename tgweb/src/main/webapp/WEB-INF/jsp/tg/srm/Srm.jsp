<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(function() {
	var getKeys = function(obj) {
		var keys = [];
		for (var key in obj) {
			keys.push(key);
		}
		return keys;
	};
	
	var getValues = function(objArr, whatKey, isNum) {
		var values = [];
		
		$.each(objArr, function() {
			for (var key in this) {
				if (key === whatKey) {
					values.push(isNum ? parseFloat(this[key]) : this[key]);
				}
			}
		});
		
		return values;
	};
	
	$("#tab_${_wid}_srm_tabs").tabsWraper({
		closable: false,
		fx: {}
	});
	
	var data, cpu, memory, network, disk, cpu_chart, cpu_process_chart, network_chart, memory_chart, disk_chart, disk_io_chart;
	
	$.ajax({
		url: "tgSrm.do?method=data",
		type: "post",
		datatype: "json",
		async: false,
		success: function(_response) {
			data = _response;
		},
		error: function() {
			console.log("error", this);
		}
	});
	
	
	$.each(data, function() {
		switch (this.type) {
		case "CPU":
			cpu = this.rows;
			break;
		case "memory":
			memory = this.rows;
			break;
		case "network":
			network = this.rows;
			break;
		case "disk":
			disk = this.rows;
			break;
		};
	});
	
	cpu_chart = {
		chart: {
			renderTo: '${_wid}_srm_chart1',
		    zoomType: 'x',
		    spacingRight: 20
		},
		title: {
		    text: 'CPU Usage'
		},
		subtitle: {
		    text: document.ontouchstart === undefined ?
		        'Click and drag in the plot area to zoom in' :
		        'Drag your finger over the plot to zoom in'
		},
		xAxis: {
		    type: 'datetime',
		    maxZoom: 14 * 24 * 3600000, // fourteen days
		    title: {
		        text: null
		    }
		},
		yAxis: {
		    title: {
		        text: 'CPU Usage'
		    },
		    min: 0.6,
		    startOnTick: false,
		    showFirstLabel: false
		},
		tooltip: {
		    shared: true
		},
		legend: {
		    enabled: false
		},
		plotOptions: {
		    area: {
		        fillColor: {
		            linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
		            stops: [
		                [0, "#FF0000"],
		                [1, 'rgba(2,0,0,0)']
		            ]
		        },
		        lineWidth: 1,
		        marker: {
		            enabled: false,
		            states: {
		                hover: {
		                    enabled: true,
		                    radius: 5
		                }
		            }
		        },
		        shadow: false,
		        states: {
		            hover: {
		                lineWidth: 1
		            }
		        }
		    }
		},
		
		series: [{
		    type: 'area',
		    name: 'CPU Usage',
		    pointInterval: 24 * 3600 * 1000,
		    pointStart: Date.UTC(2006, 0, 01),
		    data: [
		        0.8446, 0.8445, 0.8444, 0.8451,    0.8418, 0.8264,    0.8258, 0.8232,    0.8233, 0.8258,
		        0.8283, 0.8278, 0.8256, 0.8292,    0.8239, 0.8239,    0.8245, 0.8265,    0.8261, 0.8269,
		        0.8273, 0.8244, 0.8244, 0.8172,    0.8139, 0.8146,    0.8164, 0.82,    0.8269, 0.8269,
		        0.8269, 0.8258, 0.8247, 0.8286,    0.8289, 0.8316,    0.832, 0.8333,    0.8352, 0.8357,
		        0.8355, 0.8354, 0.8403, 0.8403,    0.8406, 0.8403,    0.8396, 0.8418,    0.8409, 0.8384,
		        0.8386, 0.8372, 0.839, 0.84, 0.8389, 0.84, 0.8423, 0.8423, 0.8435, 0.8422,
		        0.838, 0.8373, 0.8316, 0.8303,    0.8303, 0.8302,    0.8369, 0.84, 0.8385, 0.84,
		        0.8401, 0.8402, 0.8381, 0.8351,    0.8314, 0.8273,    0.8213, 0.8207,    0.8207, 0.8215,
		        0.8242, 0.8273, 0.8301, 0.8346,    0.8312, 0.8312,    0.8312, 0.8306,    0.8327, 0.8282,
		        0.824, 0.8255, 0.8256, 0.8273, 0.8209, 0.8151, 0.8149, 0.8213, 0.8273, 0.8273,
		        0.8261, 0.8252, 0.824, 0.8262, 0.8258, 0.8261, 0.826, 0.8199, 0.8153, 0.8097,
		        0.8101, 0.8119, 0.8107, 0.8105,    0.8084, 0.8069,    0.8047, 0.8023,    0.7965, 0.7919,
		        0.7921, 0.7922, 0.7934, 0.7918,    0.7915, 0.787, 0.7861, 0.7861, 0.7853, 0.7867,
		        0.7827, 0.7834, 0.7766, 0.7751, 0.7739, 0.7767, 0.7802, 0.7788, 0.7828, 0.7816,
		        0.7829, 0.783, 0.7829, 0.7781, 0.7811, 0.7831, 0.7826, 0.7855, 0.7855, 0.7845,
		        0.7798, 0.7777, 0.7822, 0.7785, 0.7744, 0.7743, 0.7726, 0.7766, 0.7806, 0.785,
		        0.7907, 0.7912, 0.7913, 0.7931, 0.7952, 0.7951, 0.7928, 0.791, 0.7913, 0.7912,
		        0.7941, 0.7953, 0.7921, 0.7919, 0.7968, 0.7999, 0.7999, 0.7974, 0.7942, 0.796,
		        0.7969, 0.7862, 0.7821, 0.7821, 0.7821, 0.7811, 0.7833, 0.7849, 0.7819, 0.7809,
		        0.7809, 0.7827, 0.7848, 0.785, 0.7873, 0.7894, 0.7907, 0.7909, 0.7947, 0.7987,
		        0.799, 0.7927, 0.79, 0.7878, 0.7878, 0.7907, 0.7922, 0.7937, 0.786, 0.787,
		        0.7838, 0.7838, 0.7837, 0.7836, 0.7806, 0.7825, 0.7798, 0.777, 0.777, 0.7772,
		        0.7793, 0.7788, 0.7785, 0.7832, 0.7865, 0.7865, 0.7853, 0.7847, 0.7809, 0.778,
		        0.7799, 0.78, 0.7801, 0.7765, 0.7785, 0.7811, 0.782, 0.7835, 0.7845, 0.7844,
		        0.782, 0.7811, 0.7795, 0.7794, 0.7806, 0.7794, 0.7794, 0.7778, 0.7793, 0.7808,
		        0.7824, 0.787, 0.7894, 0.7893, 0.7882, 0.7871, 0.7882, 0.7871, 0.7878, 0.79,
		        0.7901, 0.7898, 0.7879, 0.7886, 0.7858, 0.7814, 0.7825, 0.7826, 0.7826, 0.786,
		        0.7878, 0.7868, 0.7883, 0.7893, 0.7892, 0.7876, 0.785, 0.787, 0.7873, 0.7901,
		        0.7936, 0.7939, 0.7938, 0.7956, 0.7975, 0.7978, 0.7972, 0.7995, 0.7995, 0.7994,
		        0.7976, 0.7977, 0.796, 0.7922, 0.7928, 0.7929, 0.7948, 0.797, 0.7953, 0.7907,
		        0.7872, 0.7852, 0.7852, 0.786, 0.7862, 0.7836, 0.7837, 0.784, 0.7867, 0.7867,
		        0.7869, 0.7837, 0.7827, 0.7825, 0.7779, 0.7791, 0.779, 0.7787, 0.78, 0.7807,
		        0.7803, 0.7817, 0.7799, 0.7799, 0.7795, 0.7801, 0.7765, 0.7725, 0.7683, 0.7641,
		        0.7639, 0.7616, 0.7608, 0.759, 0.7582, 0.7539, 0.75, 0.75, 0.7507, 0.7505,
		        0.7516, 0.7522, 0.7531, 0.7577, 0.7577, 0.7582, 0.755, 0.7542, 0.7576, 0.7616,
		        0.7648, 0.7648, 0.7641, 0.7614, 0.757, 0.7587, 0.7588, 0.762, 0.762, 0.7617,
		        0.7618, 0.7615, 0.7612, 0.7596, 0.758, 0.758, 0.758, 0.7547, 0.7549, 0.7613,
		        0.7655, 0.7693, 0.7694, 0.7688, 0.7678, 0.7708, 0.7727, 0.7749, 0.7741, 0.7741,
		        0.7732, 0.7727, 0.7737, 0.7724, 0.7712, 0.772, 0.7721, 0.7717, 0.7704, 0.769,
		        0.7711, 0.774, 0.7745, 0.7745, 0.774, 0.7716, 0.7713, 0.7678, 0.7688, 0.7718,
		        0.7718, 0.7728, 0.7729, 0.7698, 0.7685, 0.7681, 0.769, 0.769, 0.7698, 0.7699,
		        0.7651, 0.7613, 0.7616, 0.7614, 0.7614, 0.7607, 0.7602, 0.7611, 0.7622, 0.7615,
		        0.7598, 0.7598, 0.7592, 0.7573, 0.7566, 0.7567, 0.7591, 0.7582, 0.7585, 0.7613,
		        0.7631, 0.7615, 0.76, 0.7613, 0.7627, 0.7627, 0.7608, 0.7583, 0.7575, 0.7562,
		        0.752, 0.7512, 0.7512, 0.7517, 0.752, 0.7511, 0.748, 0.7509, 0.7531, 0.7531,
		        0.7527, 0.7498, 0.7493, 0.7504, 0.75, 0.7491, 0.7491, 0.7485, 0.7484, 0.7492,
		        0.7471, 0.7459, 0.7477, 0.7477, 0.7483, 0.7458, 0.7448, 0.743, 0.7399, 0.7395,
		        0.7395, 0.7378, 0.7382, 0.7362, 0.7355, 0.7348, 0.7361, 0.7361, 0.7365, 0.7362,
		        0.7331, 0.7339, 0.7344, 0.7327, 0.7327, 0.7336, 0.7333, 0.7359, 0.7359, 0.7372,
		        0.736, 0.736, 0.735, 0.7365, 0.7384, 0.7395, 0.7413, 0.7397, 0.7396, 0.7385,
		        0.7378, 0.7366, 0.74, 0.7411, 0.7406, 0.7405, 0.7414, 0.7431, 0.7431, 0.7438,
		        0.7443, 0.7443, 0.7443, 0.7434, 0.7429, 0.7442, 0.744, 0.7439, 0.7437, 0.7437,
		        0.7429, 0.7403, 0.7399, 0.7418, 0.7468, 0.748, 0.748, 0.749, 0.7494, 0.7522,
		        0.7515, 0.7502, 0.7472, 0.7472, 0.7462, 0.7455, 0.7449, 0.7467, 0.7458, 0.7427,
		        0.7427, 0.743, 0.7429, 0.744, 0.743, 0.7422, 0.7388, 0.7388, 0.7369, 0.7345,
		        0.7345, 0.7345, 0.7352, 0.7341, 0.7341, 0.734, 0.7324, 0.7272, 0.7264, 0.7255,
		        0.7258, 0.7258, 0.7256, 0.7257, 0.7247, 0.7243, 0.7244, 0.7235, 0.7235, 0.7235,
		        0.7235, 0.7262, 0.7288, 0.7301, 0.7337, 0.7337, 0.7324, 0.7297, 0.7317, 0.7315,
		        0.7288, 0.7263, 0.7263, 0.7242, 0.7253, 0.7264, 0.727, 0.7312, 0.7305, 0.7305,
		        0.7318, 0.7358, 0.7409, 0.7454, 0.7437, 0.7424, 0.7424, 0.7415, 0.7419, 0.7414,
		        0.7377, 0.7355, 0.7315, 0.7315, 0.732, 0.7332, 0.7346, 0.7328, 0.7323, 0.734,
		        0.734, 0.7336, 0.7351, 0.7346, 0.7321, 0.7294, 0.7266, 0.7266, 0.7254, 0.7242,
		        0.7213, 0.7197, 0.7209, 0.721, 0.721, 0.721, 0.7209, 0.7159, 0.7133, 0.7105,
		        0.7099, 0.7099, 0.7093, 0.7093, 0.7076, 0.707, 0.7049, 0.7012, 0.7011, 0.7019,
		        0.7046, 0.7063, 0.7089, 0.7077, 0.7077, 0.7077, 0.7091, 0.7118, 0.7079, 0.7053,
		        0.705, 0.7055, 0.7055, 0.7045, 0.7051, 0.7051, 0.7017, 0.7, 0.6995, 0.6994,
		        0.7014, 0.7036, 0.7021, 0.7002, 0.6967, 0.695, 0.695, 0.6939, 0.694, 0.6922,
		        0.6919, 0.6914, 0.6894, 0.6891, 0.6904, 0.689, 0.6834, 0.6823, 0.6807, 0.6815,
		        0.6815, 0.6847, 0.6859, 0.6822, 0.6827, 0.6837, 0.6823, 0.6822, 0.6822, 0.6792,
		        0.6746, 0.6735, 0.6731, 0.6742, 0.6744, 0.6739, 0.6731, 0.6761, 0.6761, 0.6785,
		        0.6818, 0.6836, 0.6823, 0.6805, 0.6793, 0.6849, 0.6833, 0.6825, 0.6825, 0.6816,
		        0.6799, 0.6813, 0.6809, 0.6868, 0.6933, 0.6933, 0.6945, 0.6944, 0.6946, 0.6964,
		        0.6965, 0.6956, 0.6956, 0.695, 0.6948, 0.6928, 0.6887, 0.6824, 0.6794, 0.6794,
		        0.6803, 0.6855, 0.6824, 0.6791, 0.6783, 0.6785, 0.6785, 0.6797, 0.68, 0.6803,
		        0.6805, 0.676, 0.677, 0.677, 0.6736, 0.6726, 0.6764, 0.6821, 0.6831, 0.6842,
		        0.6842, 0.6887, 0.6903, 0.6848, 0.6824, 0.6788, 0.6814, 0.6814, 0.6797, 0.6769,
		        0.6765, 0.6733, 0.6729, 0.6758, 0.6758, 0.675, 0.678, 0.6833, 0.6856, 0.6903,
		        0.6896, 0.6896, 0.6882, 0.6879, 0.6862, 0.6852, 0.6823, 0.6813, 0.6813, 0.6822,
		        0.6802, 0.6802, 0.6784, 0.6748, 0.6747, 0.6747, 0.6748, 0.6733, 0.665, 0.6611,
		        0.6583, 0.659, 0.659, 0.6581, 0.6578, 0.6574, 0.6532, 0.6502, 0.6514, 0.6514,
		        0.6507, 0.651, 0.6489, 0.6424, 0.6406, 0.6382, 0.6382, 0.6341, 0.6344, 0.6378,
		        0.6439, 0.6478, 0.6481, 0.6481, 0.6494, 0.6438, 0.6377, 0.6329, 0.6336, 0.6333,
		        0.6333, 0.633, 0.6371, 0.6403, 0.6396, 0.6364, 0.6356, 0.6356, 0.6368, 0.6357,
		        0.6354, 0.632, 0.6332, 0.6328, 0.6331, 0.6342, 0.6321, 0.6302, 0.6278, 0.6308,
		        0.6324, 0.6324, 0.6307, 0.6277, 0.6269, 0.6335, 0.6392, 0.64, 0.6401, 0.6396,
		        0.6407, 0.6423, 0.6429, 0.6472, 0.6485, 0.6486, 0.6467, 0.6444, 0.6467, 0.6509,
		        0.6478, 0.6461, 0.6461, 0.6468, 0.6449, 0.647, 0.6461, 0.6452, 0.6422, 0.6422,
		        0.6425, 0.6414, 0.6366, 0.6346, 0.635, 0.6346, 0.6346, 0.6343, 0.6346, 0.6379,
		        0.6416, 0.6442, 0.6431, 0.6431, 0.6435, 0.644, 0.6473, 0.6469, 0.6386, 0.6356,
		        0.634, 0.6346, 0.643, 0.6452, 0.6467, 0.6506, 0.6504, 0.6503, 0.6481, 0.6451,
		        0.645, 0.6441, 0.6414, 0.6409, 0.6409, 0.6428, 0.6431, 0.6418, 0.6371, 0.6349,
		        0.6333, 0.6334, 0.6338, 0.6342, 0.632, 0.6318, 0.637, 0.6368, 0.6368, 0.6383,
		        0.6371, 0.6371, 0.6355, 0.632, 0.6277, 0.6276, 0.6291, 0.6274, 0.6293, 0.6311,
		        0.631, 0.6312, 0.6312, 0.6304, 0.6294, 0.6348, 0.6378, 0.6368, 0.6368, 0.6368,
		        0.636, 0.637, 0.6418, 0.6411, 0.6435, 0.6427, 0.6427, 0.6419, 0.6446, 0.6468,
		        0.6487, 0.6594, 0.6666, 0.6666, 0.6678, 0.6712, 0.6705, 0.6718, 0.6784, 0.6811,
		        0.6811, 0.6794, 0.6804, 0.6781, 0.6756, 0.6735, 0.6763, 0.6762, 0.6777, 0.6815,
		        0.6802, 0.678, 0.6796, 0.6817, 0.6817, 0.6832, 0.6877, 0.6912, 0.6914, 0.7009,
		        0.7012, 0.701, 0.7005, 0.7076, 0.7087, 0.717, 0.7105, 0.7031, 0.7029, 0.7006,
		        0.7035, 0.7045, 0.6956, 0.6988, 0.6915, 0.6914, 0.6859, 0.6778, 0.6815, 0.6815,
		        0.6843, 0.6846, 0.6846, 0.6923, 0.6997, 0.7098, 0.7188, 0.7232, 0.7262, 0.7266,
		        0.7359, 0.7368, 0.7337, 0.7317, 0.7387, 0.7467, 0.7461, 0.7366, 0.7319, 0.7361,
		        0.7437, 0.7432, 0.7461, 0.7461, 0.7454, 0.7549, 0.7742, 0.7801, 0.7903, 0.7876,
		        0.7928, 0.7991, 0.8007, 0.7823, 0.7661, 0.785, 0.7863, 0.7862, 0.7821, 0.7858,
		        0.7731, 0.7779, 0.7844, 0.7866, 0.7864, 0.7788, 0.7875, 0.7971, 0.8004, 0.7857,
		        0.7932, 0.7938, 0.7927, 0.7918, 0.7919, 0.7989, 0.7988, 0.7949, 0.7948, 0.7882,
		        0.7745, 0.771, 0.775, 0.7791, 0.7882, 0.7882, 0.7899, 0.7905, 0.7889, 0.7879,
		        0.7855, 0.7866, 0.7865, 0.7795, 0.7758, 0.7717, 0.761, 0.7497, 0.7471, 0.7473,
		        0.7407, 0.7288, 0.7074, 0.6927, 0.7083, 0.7191, 0.719, 0.7153, 0.7156, 0.7158,
		        0.714, 0.7119, 0.7129, 0.7129, 0.7049, 0.7095
		    ]
		}]
	};
	
	
	var maxArr = [95, 90, 85, 72, 62, 60, 57, 54, 51, 51, 29, 29, 29, 26, 22, 21, 17, 15, 15, 13, 10, 10, 9, 7, 5, 4, 3, 2, 1, 0];
	var currentArr = [10, 10, 9, 9, 9, 9, 9, 8, 8, 7, 6, 6, 5, 5, 5, 4, 4, 4, 3, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0];
	var computedMax = [];
	
	for (var i = 0, maxArrLength = maxArr.length; i < maxArrLength; i++) {
		computedMax.push(maxArr[i] - currentArr[i]);
	}
	
	cpu_process_chart = {
	    chart: {
	        renderTo: '${_wid}_srm_chart0',
	        type: 'bar'
	    },
	    title: {
	        text: 'CPU Process'
	    },
	    xAxis: {
	        categories: ["Process6409", "Process1602", "Process1826", "Process8323", "Process8622", "Process8897", "Process2295", "Process1168", "Process2138", "Process5230", "Process2589", "Process2572", "Process1289", "Process4767", "Process6942", "Process4226", "Process8654", "Process3751", "Process5319", "Process2823", "Process5576", "Process8917", "Process1332", "Process1544", "Process7477", "Process9866", "Process2527", "Process1184", "Process8695", "Process6145"]
	    },
	    yAxis: {
	        min: 0,
	    	max: 100,
	        title: {
	            text: 'Total fruit consumption'
	        }
	    },
	    legend: {
	        backgroundColor: '#FFFFFF',
	        reversed: true
	    },
	    tooltip: {
            crosshairs: {
                width: 2,
                color: "gray",
                dashStyle: "shortdot"
            },
	        formatter: function() {
	        	if (this.series.name === "max") {
	        		return this.series.name + ": " + this.point.stackTotal;
	        	} else {
	        		return this.series.name + ": " + this.y; 
	        	}
	        }
	    },
	    credits: {
	        enabled: false
		},
	    plotOptions: {
	        series: {
	            stacking: 'normal',
	            dataLabels: {
			        formatter: function() {
			        	if (this.series.name === "max") {
			        		return this.point.stackTotal;
			        	} else {
			        		return this.y; 
			        	}
			        },
	                enabled: true,
	                align: 'right',
	                color: '#FFFFFF',
	                x: -10
	            },
	            pointWidth: 8
	        }
	    },
	    series: [{
	        name: 'max',
	        data: computedMax,
	        color: 'red'
	    },
	    {
	        name: 'current',
	        data: currentArr,
	        color: 'yellow'
	    }]
	};
	
	network_chart = {
		chart: {
		    renderTo: '${_wid}_srm_chart2',
		    type: 'line',
		    marginRight: 130,
		    marginBottom: 25
		},
		title: {
		    text: 'Network traffic',
		    x: -20 //center
		},
		subtitle: {
		    text: 'up / down',
		    x: -20
		},
		yAxis: {
		    title: {
		        text: 'kbps'
		    },
		    plotLines: [{
		        value: 0,
		        width: 1,
		        color: '#808080'
		    }]
		},
		tooltip: {
		    formatter: function() {
		            return '<b>'+ this.series.name +'</b><br/>'+
		            this.x +': '+ this.y +'°C';
		    }
		},
		legend: {
		    layout: 'vertical',
		    align: 'right',
		    verticalAlign: 'top',
		    x: -10,
		    y: 100,
		    borderWidth: 0
		},
		series: [{
		    name: 'Up',
		    data: [1544, 1660, 574, 1307, 1978, 769, 1041, 576, 914, 1536, 966, 1067, 782, 609, 728, 1979, 978, 1591, 1870, 916, 951, 919, 1557, 1254, 1677, 1804, 1613, 1159, 1462, 684, 770, 1329, 1402, 1220, 1297, 1906, 1257, 1589, 1106, 570, 749, 1035, 956, 776, 1165, 1387, 1199, 1944, 1359, 1386, 1136, 967, 1109, 1854, 1832, 1383, 1135, 1686, 1367, 1674, 1074, 788, 689, 873, 1660, 1831, 1771, 1137, 1091, 719, 1672, 539, 1306, 616, 699, 1302, 804, 1642, 878, 1954, 656, 937, 1084, 1538, 1497, 721, 739, 604, 981, 1128, 1263, 1342, 1888, 931, 888, 1114, 1121, 614, 1548, 1070]
		}, {
		    name: 'Down',
		    data: [1407, 2413, 1862, 2216, 1477, 2719, 1842, 1450, 1332, 2612, 1112, 2333, 2877, 1999, 1481, 1007, 1291, 2956, 2199, 1462, 1611, 1851, 1465, 1466, 2727, 2828, 1454, 1119, 1009, 2886, 2978, 1500, 2335, 1564, 1639, 1806, 2626, 2594, 1989, 1743, 1583, 2562, 1707, 2464, 1442, 2651, 1340, 1189, 2463, 1694, 2230, 2705, 2934, 2395, 1741, 1867, 1145, 2010, 1397, 2284, 2403, 2630, 2284, 1669, 1563, 1710, 2932, 1269, 1986, 1336, 1255, 2101, 1957, 2076, 2507, 2820, 1954, 1820, 1462, 2106, 1839, 1793, 2835, 2670, 1609, 2032, 2979, 1525, 1885, 1180, 2430, 2355, 1216, 2350, 1290, 1769, 2553, 2369, 2284, 1602]
		}]
	};
	
	memory_chart = {
		chart: {
		    renderTo: '${_wid}_srm_chart3',
		    type: 'area'
		},
		title: {
		    text: 'Memory Usage',
		    x: -20 //center
		},
		subtitle: {
		    text: 'up / down',
		    x: -20
		},
		yAxis: {
			max: 100,
		    title: {
		        text: '%'
		    }
		},
		tooltip: {
		    formatter: function() {
		            return '<b>'+ this.series.name +'</b><br/>'+
		            this.x +': '+ this.y +'°C';
		    }
		},
		plotOptions: {
            area: {
                marker: {
                    enabled: false,
                    symbol: 'circle',
                    radius: 2,
                    states: {
                        hover: {
                            enabled: true
                        }
                    }
                }
            }
        },
		legend: {
		    layout: 'vertical',
		    align: 'right',
		    verticalAlign: 'top',
		    x: -10,
		    y: 100,
		    borderWidth: 0
		},
		series: [{
			color: '#FF0000',
		    name: 'Up',
		    data: [6, 3, 6, 4, 3, 8, 1, 8, 5, 0, 5, 3, 10, 1, 10, 4, 2, 7, 8, 2, 5, 2, 7, 1, 6, 7, 3, 10, 6, 8, 2, 1, 0, 10, 2, 3, 3, 8, 8, 9, 9, 0, 8, 7, 9, 6, 6, 0, 3, 9, 0, 7, 7, 0, 4, 9, 7, 0, 9, 0, 0, 10, 4, 10, 1, 8, 0, 1, 6, 2, 7, 3, 4, 3, 5, 0, 5, 8, 1, 2, 9, 4, 2, 0, 2, 3, 1, 2, 2, 7, 6, 4, 10, 10, 7, 8, 7, 10, 1, 0, 30, 56, 21, 57, 23, 54, 25, 32, 50, 21, 46, 45, 48, 52, 32, 47, 46, 12, 13, 30, 32, 55, 42, 50, 52, 10, 42, 56, 20, 16, 24, 37, 59, 30, 53, 55, 28, 15, 44, 52, 60, 27, 52, 26, 32, 38, 34, 26, 37, 33, 18, 52, 41, 55, 23, 41, 35, 11, 51, 41, 20, 55, 39, 23, 45, 12, 38, 27, 37, 49, 27, 17, 16, 50, 58, 52, 39, 10, 41, 30, 17, 31, 14, 17, 54, 44, 14, 40, 51, 41, 12, 12, 19, 14, 28, 45, 43, 40, 50, 27, 61, 65, 67, 56, 67, 66, 57, 50, 50, 54, 60, 66, 55, 52, 52, 55, 57, 53, 50, 54, 51, 70, 66, 62, 50, 55, 51, 69, 56, 53, 70, 55, 62, 54, 50, 70, 57, 64, 58, 69, 60, 59, 67, 70, 56, 68, 68, 60, 60, 59, 64, 58, 65, 68, 51, 63, 60, 64, 62, 63, 67, 67, 70, 57, 69, 63, 58, 62, 70, 57, 54, 53, 65, 55, 54, 58, 57, 66, 69, 51, 68, 52, 58, 58, 56, 62, 52, 59, 55, 68, 64, 67, 50, 61, 60, 52, 68, 68, 52, 57]
		}]
	};
	
	disk_chart = {
	    chart: {
	        renderTo: '${_wid}_srm_chart4',
	        type: 'line'
	    },
	    title: {
	        text: 'Stack analysis'
	    },
	    xAxis: {
	    	labels: {
	    		enabled: false
	    	},
	        categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas'
	                    ,'Apples1', 'Oranges1', 'Pears1', 'Grapes1', 'Bananas1'
	                    ,'Apples2', 'Oranges2', 'Pears2', 'Grapes2', 'Bananas2']
	    },
	    yAxis: {
	        min: 0,
	        max: 2,
	        title: {
	            text: 'Total fruit consumption'
	        }
	    },
	    legend: {
	        backgroundColor: '#FFFFFF',
	        reversed: true
	    },
	    tooltip: {
	        formatter: function() {
	            return ''+
	                this.series.name +': '+ this.y +'';
	        }
	    },
	    credits: {
	        enabled: false
	    },
	    plotOptions: {
	    	line: {
		        marker: {
		            enabled: false,
		            states: {
		                hover: {
		                    enabled: true,
		                    radius: 5
		                }
		            }
		        }
	    	},
	        series: {
	            dataLabels: {
	                enabled: true,
	                align: 'right',
	                color: '#FFFFFF',
	                x: -10
	            },
	            pointWidth: 15
	        },
	        line: {
	        	lineWidth: 0.3
	        }
	    },
	        series: [{
	        name: 'disk',
	        data: [1,1,0,0,0,1,0,1,2,0,1,2,2,1,0,0,0,1,1,2,2,1,0,1,2,1,1,1,0,2,1,0,0,0,2,0,1,2,2,2,0,1,2,1,0,0,1,2,0,0,1,0,2,2,2,1,2,1,2,2,1,0,0,0,1,2,2,0,0,2,2,0,2,1,0,2,2,1,0,0,1,2,2,2,0,1,2,1,2,1,2,0,0,2,1,1,2,2,1,2,2,2,2,2,1,2,2,1,0,2,0,0,1,1,1,1,2,0,1,1,0,0,2,2,1,0,2,1,1,2,1,1,2,0,2,1,1,2,2,1,0,0,2,1,1,2,1,1,1,2,2,0,1,2,1,1,1,2,1,0,2,2,2,2,0,0,0,0,1,1,0,1,1,0,2,1,0,2,2,2,2,2,1,0,2,0,1,0,1,0,2,0,2,0,0,1,1,0,1,0,2,0,0,1,1,0,2,2,0,0,2,1,0,1,0,0,0,1,0,0,0,2,2,1,1,2,2,0,1,1,1,0,0,2,0,1,2,0,2,0,1,0,1,2,1,2,2,0,0,0,2,2,0,1,0,2,1,0,0,0,2,2,1,2,2,1,0,2,0,2,1,0,1,2,1,2,2,0,2,1,0,0,0,1,0,1,1,2,2,0,1,0,1,1,2,2,2,0,2,2,2,2,1,2,0,2,1,1,2,1,0,1,1,1,1,0,1,0,2,1,2,1,2,1,1,0,0,2,0,1,2,0,1,1,1,1,1,1,1,2,0,2,1,0,0,2,1,2,2,2,2,1,1,2,2,1,1,2,0,2,2,0,2,1,1,1,1,1,2,0,1,2,0,0,0,1,2,0,2,2,2,1,1,2,2,1,1,2,1,2,0,0,2,2,2,0,2,2,0,0,0,2,2,2,1,0,2,0,2,2,1,0,2,1,0,0,1,2,1,1,2,0,1,2,2,0,2,2,1,2,1,2,2,0,0,2,2,0,2,2,2,2,1,1,0,2,0,0,1,2,0,2,0,1,2,1,1,1,2,2,2,1,0,2,2,2,1,2,2,2,0,2,2,0,1,2,0,1,1,0,0,1,0,1,2,2,0,2,1,2,0,2,2,1,2,2,0,2,1,0],
	        color: 'green'
	    }]
	};
	
	disk_io_chart = {
	    chart: {
	        renderTo: '${_wid}_srm_chart5',
	        type: 'bar'
	    },
	    title: {
	        text: 'Stack analysis'
	    },
	    xAxis: {
	        categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas'
	                    ,'Apples1', 'Oranges1', 'Pears1', 'Grapes1', 'Bananas1'
	                    ,'Apples2', 'Oranges2', 'Pears2', 'Grapes2', 'Bananas2']
	    },
	    yAxis: {
	        min: 0,
	        title: {
	            text: 'Total fruit consumption'
	        }
	    },
	    legend: {
	        backgroundColor: '#FFFFFF',
	        reversed: true
	    },
	    tooltip: {
	        formatter: function() {
	            return ''+
	                this.series.name +': '+ this.y +'';
	        }
	    },
	    credits: {
	        enabled: false
	    },
	    plotOptions: {
	        series: {
	            stacking: 'normal',
	            dataLabels: {
	                enabled: true,
	                align: 'right',
	                color: '#FFFFFF',
	                x: -10
	            },
	            pointWidth: 15
	        }
	    },
	        series: [{
	        name: 'free',
	        data: [13, 24, 26, 40, 68, 76, 79, 83, 85, 87, 92, 94, 95, 98, 99],
	        color: 'green'
	    }]
	};
	
	

	var chartArr = [cpu_process_chart, cpu_chart, network_chart, memory_chart, disk_chart, disk_io_chart];
	var tabs = window.smileGlobal.tabInfo.tabs;
	/*
	$.Topic("#tab_${_wid}_srm_tab1").subscribe(function tab1(ui) {
		$.Topic("#tab_${_wid}_srm_tab1").unsubscribe(tab1);
	});
	*/
	
	$.each(chartArr, function(i) {
		if (i !== 0) {
			
			(function(index) {
				$.Topic("#tab_${_wid}_srm_tab" + index).subscribe(function sub(ui) {
					
					var cc = new Highcharts.Chart(chartArr[index]);

					$.each(tabs["#tab_${_wid}"], function() {
						if (this.tabHash === "#tab_${_wid}_srm_tab" + index) {
							this["chart"] = cc;
						}
					});
					
					$.Topic("#tab_${_wid}_srm_tab" + index).unsubscribe(sub);
				});
			}(i));
		}
		
	});
	
	
	var cc = new Highcharts.Chart(cpu_process_chart);
	
	tabs["#tab_${_wid}"][0].chart = cc;
	
});
</script>
<div id="tab_${_wid}_srm_tabs" class="tabs">
    <ul>
        <li><a href="#tab_${_wid}_srm_tab0"><span>CPU (Total)</span></a></li>
        <li><a href="#tab_${_wid}_srm_tab1"><span>CPU (Process)</span></a></li>
        <li><a href="#tab_${_wid}_srm_tab2"><span>Network</span></a></li>
        <li><a href="#tab_${_wid}_srm_tab3"><span>Memory</span></a></li>
        <li><a href="#tab_${_wid}_srm_tab4"><span>Disk (Usage)</span></a></li>
        <li><a href="#tab_${_wid}_srm_tab5"><span>Disk (I/O)</span></a></li>
    </ul>
    <div id="tab_${_wid}_srm_tab0" style="height:400px;">
		<div id="${_wid}_srm_chart0"></div>		<!-- cpu process -->
    </div>
    <div id="tab_${_wid}_srm_tab1" style="height:400px;">
		<div id="${_wid}_srm_chart1"></div>		<!-- cpu -->
    </div>
    <div id="tab_${_wid}_srm_tab2" style="height:400px;">
		<div id="${_wid}_srm_chart2"></div>		<!-- network -->
    </div>
    <div id="tab_${_wid}_srm_tab3" style="height:400px;">
		<div id="${_wid}_srm_chart3"></div>		<!-- memory -->
    </div>
    <div id="tab_${_wid}_srm_tab4" style="height:400px;">
		<div id="${_wid}_srm_chart4"></div>		<!-- disk -->
    </div>
    <div id="tab_${_wid}_srm_tab5" style="height:400px;">
		<div id="${_wid}_srm_chart5"></div>		<!-- disk io -->
    </div>
</div>
