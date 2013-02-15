;(function($, window, document, undefined) {
	$.widget("grid.dataGrid", {
		colModelOptions: {
			align:"center"
		},
		options: {
			scrollOffset: 180,
			//width: 1000,
			colNames: [],
			colModel: [],
			singleRowNum: false,
			rowNum: 15,
			rowList: [15,30,50,100,200,500,1000],
			height: "100%",
			//autowidth: true,
			shrinkToFit: false,
			rownumbers: true,
			viewrecords: true,
			gridview: true,
			//search: true,
			sortable: true,
			datatype: "json",
			sortname: "ROWNUM",
			sortorder: "asc",
			ajaxGridOptions: {
				contentType: "application/json", 
				complete: function(xhr) {
					var url = this.url.split("?")[0];
					if ($.Topic.hasCallback("dataGrid/xhrComplete/" + url))	$.Topic("dataGrid/xhrComplete/" + url).publish($.parseJSON(xhr.responseText));
				}
			},
			pager: "#pager",
			caption: "caption",
			//url: "",
			postData: {method:"s"},
			jsonReader : {
				repeatitems: false,
				id: "TC_IDX"
			},
			key: "",
			loadonce: false,
			editable: false,
			onCellSelect: function(rowid, iCol, cellcontent, e) {
				//console.debug(this);
			},
			resizeStop: function () {
				var shrinkToFit = $(this).jqGrid("getGridParam", "shrinkToFit");
				
				if ($(this)[0].bDiv) {
					var $grid = $(this.bDiv).find(">div:first>table.ui-jqgrid-btable:first");
					$grid.jqGrid("setGridWidth", $(this)[0].newWidth, shrinkToFit);
				} else {
					$(this).jqGrid("setGridWidth", $(this).width(), shrinkToFit);
				}
            },
			beforeProcessing: function(data, st, xhr) {
				var self = $(this).data("dataGrid");
				var filterGrid = self.options.customOptions.filterGrid;
				if (filterGrid && filterGrid.column != "") {
					var ret = $.grep(data.rows, function(n, i) {
						return n[filterGrid.column] == filterGrid.value;
					});
					data.rows = ret;
					data.records = parseInt(filterGrid.len);
					data.total = Math.ceil(parseInt(filterGrid.len) / $(this).jqGrid("getGridParam", "rowNum"));
				}
			},
			customOptions: {},
			mainGrid: [
	           {
	        	   category: "ACAM",
	        	   include: ["RS_485", "PTZ"]
	           },
	           {
	        	   category: "NCAM",
	        	   include: ["SEARCH_STREAM", "LIVE_STREAM", "BANDWIDTH", "VIEW_LATENCY", "IMAGE_CONFIRM", "WEB", "LIVE_STREAM_WEB", "RS_485", "PTZ", "DST"]
	           },
	           {
	        	   category: "NVR",
	        	   include: ["SEARCH_STREAM", "LIVE_STREAM", "BANDWIDTH", "VIEW_LATENCY", "IMAGE_CONFIRM", "PTZ", "DST"]
	           },
	           {
	        	   category: "DVR",
	        	   include: ["SEARCH_STREAM", "LIVE_STREAM", "BANDWIDTH", "VIEW_LATENCY", "IMAGE_CONFIRM", "PTZ", "DST"]
	           }
	        ]
		},
		_create : function() {
			this.options.jsonReader.id = this.options.key;
			this.grid = $(this.element);
			if (this.options.singleRowNum) {
				//this.options.rowList = [this.options.rowNum];
				this.options.rowList = [];
			} else {
				this._individualOptions();
			}
			this._initOptions();
			this._extract();
			this._generateGrid();
			//$.Topic("testTopic").publish($(this.grid).jqGrid("getGridParam","data"));
		},
		_individualOptions: function() {
			if (window.smileGlobal && window.smileGlobal.rowList) {
				var rowList = window.smileGlobal.rowList;
				
				if (rowList.size < 1) {
					return null;
				}
				this.options.rowNum = rowList[0];
				this.options.rowList = rowList; 
			}
		},
		_initOptions : function() {
//			$.extend(this.options.postData, $("input[type='hidden']", "#" + this.options.formId).serializeObject());
			$.extend(this.options.postData, $("#" + this.options.formId).serializeObject());
			
			if (this.options.loadonce)	$.extend(this.options.postData, {loadOnce:true});
			
			if ($(this.grid).attr("filterGrid")) {
				var filterGrid = $.parseJSON($(this.grid).attr("filterGrid").replace(/'/g, '\"'));
				this.options.customOptions.filterGrid = filterGrid;
				$.extend(this.options.postData, {filterColumn: filterGrid.column});
			}
		},
		_extract : function() {
			var self = this;
			var item;
			$(this.grid).find("th").each(function(i, _item) {
				self.options.colNames.push($(_item).text());
				item = $.extend({}, self.colModelOptions, {name: $(_item).attr("field"), width: $(_item).attr("width"), editable: self.options.editable, editrules: {required: ($(_item).attr("field") == self.options.key ? true : false)}});
				
				if ($(_item).attr("editable") != undefined) {
					$.extend(item, {editable: $(_item).attr("editable")});
				}
				if ($(_item).attr("edittype") != undefined) {
					$.extend(item, {edittype: $(_item).attr("edittype")});
				}
				if ($(_item).attr("editrules") != undefined) {
					var editrules = $.parseJSON($(_item).attr("editrules").replace(/'/g, '\"'));
					// attr의 value중 ()로 끝나는 것은 function으로 parsing
					for (i in editrules) {
						if (typeof editrules[i] === "string") {
							if (editrules[i].indexOf("()") > -1) {
								var _funtionName = editrules[i].replace("()", "");
								if ($.isFunction(window[_funtionName])) {
									editrules[i] = window[_funtionName];
								}
							}
						}
					}
					$.extend(item.editrules, editrules);
				}
				if ($(_item).attr("editoptions") != undefined) {
					var editoptions = $.parseJSON($(_item).attr("editoptions").replace(/'/g, '\"'));
					$.extend(item, {editoptions: editoptions});
				}
				if ($(_item).attr("hidden") != undefined) {
					$.extend(item, {hidden: $(_item).attr("hidden")});
				}
				if ($(_item).attr("url") != undefined || $(_item).attr("syntax") != undefined) {
					item["formatter"] = self._formatter;
					item["formatoptions"] = {baseLinkUrl: $(_item).attr("url"), addParam: $(_item).attr("addParam"), uid: $(_item).attr("uid"), syntax: $(_item).attr("syntax")};
					
				}
				if ($(_item).attr("format") == "button") {
					item["formatter"] = self._downloadButtonFormatter;
					item["formatoptions"] = {formId: self.options.formId, url: self.options.url};
				}
				if (self.options.customOptions.chartCell && $.inArray($(_item).attr("field"), self.options.customOptions.chartCell) > -1) {
					item["formatter"] = self._chartingFormatter;
				}
				
				self.options.colModel.push(item);
			});
		},
		_formatter : function(cellvalue, options, rowObject, d, e) {
			var matcher = "ALL", flag, syntaxColor;
			var o = options.colModel, f = o.formatoptions;
			var retVal;
			
			retVal = cellvalue;
			
			if (f.syntax) {
				if (f.syntax.startsWith("{") && f.syntax.endsWith("}")) {
					var object = $.parseJSON(f.syntax.replace(/'/g, '\"'));
					flag = object.flag;
					matcher = object.matcher || "MATCH";
					syntaxColor = object.syntaxColor;
				} else {
					flag = f.syntax;
				}
			}
			
			if (f.baseLinkUrl) {
				var addParam = $.parseJSON(f.addParam.replace(/'/g, '\"'));
				retVal = "<div class='dataGrid-link' onclick=\"$('#" + options.gid + "').dataGrid('tabContainer', '" + f.baseLinkUrl + "', '" + $.param($.extend({}, addParam, rowObject)) + "', '" + options.rowId + "_" + (f.uid ? f.uid : o.name) + options.pos + "', '" + (addParam.tabTitle != undefined ? rowObject[addParam.tabTitle] + " " : "") + cellvalue + "')\"" + " style='color:" + (syntaxColor ? syntaxColor : "blue") + ";'>" + cellvalue + "</div>";
			} else if (syntaxColor) {
				retVal = "<p style='color:" + syntaxColor + ";'>" + cellvalue + "</p>";
			} 

			switch (matcher) {
			case "ALL" :
				break;
			case "MATCH" :
				retVal = flag == cellvalue ? retVal : cellvalue;
				break;
			case "NOT_MATCH" :
				retVal = flag != cellvalue ? retVal : cellvalue;
				break;
			case "OVER" :
				retVal = parseFloat(flag) < cellvalue ? retVal : cellvalue;
				break;
			case "UNDER" :
				retVal = parseFloat(flag) > cellvalue ? retVal : cellvalue;
				break;
			case "RANGE" :
				retVal = (parseFloat(flag[0]) + parseFloat(flag[1]) < cellvalue) || (parseFloat(flag[0]) - parseFloat(flag[1]) > cellvalue) ? retVal : cellvalue;
				break;
			}
			
			return retVal;
		},
		_downloadButtonFormatter : function(cellvalue, options, rowObject) {
			return '<button type="button" class="file" data="{formId:\'' + options.colModel.formatoptions.formId + '\',IDX:\'' + rowObject.IDX + '\',url:\'' + options.colModel.formatoptions.url + '?method=file\'}"><span class="ui-icon ui-icon-document"></span>';
		},
		_chartingFormatter : function(cellvalue, options, rowObject) {
			return '<div class="' + options.colModel.name + ' charting_div" style="background:transparent url(/images/gradient.png) repeat-x top left; height:20px; width:0%">' + cellvalue + '</div>';
		},
		_generateGrid : function() {
			var self = this;
			$(this.grid).jqGrid($.extend({}, this.options, {
				loadComplete : function(data) {
					var chartCellArr = self.options.customOptions.chartCell;
					if (chartCellArr && chartCellArr.length > 0) {
						var maxValue = [];
						$(data.rows).each(function() {
							for (var i = 0; i < chartCellArr.length; i++) {
								if (!$.isNumeric(maxValue[i]) || ($.isNumeric(this[chartCellArr[i]]) && maxValue[i] < parseFloat(this[chartCellArr[i]])))	maxValue[i] = this[chartCellArr[i]];
							}
						});
						$(this).find($(".charting_div")).each(function() {
							if ($(this).text() != "") {
								for (var i = 0; i < chartCellArr.length; i++) {
									if ($(this).attr("class").indexOf(chartCellArr[i]) > -1)	$(this).css("width", ($(this).text() / maxValue[i] * 100) + "%");
								}
							}
						});
					}
					var includeArr = [];
					var colorCellArr = self.options.customOptions.colorCell;
					var mainGrid = self.options.mainGrid;
					
					if (colorCellArr && colorCellArr.length > 0) {
						$(data.rows).each(function() {
							var row = this;
							$(mainGrid).each(function() {
								if (this.category === row.CATEGORY) {
									includeArr.push(this.include);
								}
							});
						});
						
						$(this).find($("tr")).each(function(i) {
							$(this).find("td").each(function() {
								if ($(this).attr("aria-describedby")) {
									var field = $(this).attr("aria-describedby").substring($(this).attr("aria-describedby").indexOf("grid_") + 5, $(this).attr("aria-describedby").length);
									if ($.inArray(field, colorCellArr) > -1) {
										if (!($.inArray(field, includeArr[i - 1]) > -1)) {
											$(this).text(" ");
											$(this).css("background-color", "#A4A4A4");
										}
									}
								}
							});
						});
					}
					
					if ($.Topic.hasCallback("dataGrid/loadComplete"))	$.Topic("dataGrid/loadComplete").publish(data);
				}
			}));
			var navGridOptions = {edit:false,add:false,del:false,search:false};
			
			if (this.options.editable) {
				$.extend(navGridOptions, {edit:true,add:true,del:true},
					{}, // use default settings for edit
					{}, // use default settings for add
					{},  // delete instead that del:false we need this
					{}, // enable the advanced searching
					{closeOnEscape:true} /* allow the view dialog to be closed when user press ESC key*/
				);
				if (this.options.inlineNav) {
					$.extend(navGridOptions, {edit:false,add:false});
				}
			}
			
			$(this.grid).jqGrid("navGrid", this.options.pager, navGridOptions);
			if (this.options.inlineNav)		$(this.grid).jqGrid("inlineNav", this.options.pager, {editParams:{aftersavefunc:function() {$(this).trigger("reloadGrid");}}});
			///$(this.grid).jqGrid("gridResize", {minWidth:350,maxWidth:2000,minHeight:80,maxHeight:2000});
		},
		tabContainer : function(url, params, id, value) {
			var maintab = $("#tabs");
            var st = "#tab_" + id;
            var hiddenValue = $("input[type='hidden']", "#" + this.options.formId).serializeObject();
            
			$.each(params.split("&"), function(){ 
				var pair = this.split("=");
				delete hiddenValue[pair[0]];
			});
            
			if($(st).html() != null ) {
				maintab.tabs("select", st);
			} else {
				maintab.tabs("add", st, value);
				$.ajax({
					url: url + "?" + params,
					data: $.extend({}, {_wid: id}, hiddenValue),
					type: "GET",
					dataType: "html",
					complete : function (req, err) {
						$(st,"#tabs").append(req.responseText);
					}
				});
				maintab.tabs("select", st);
			}
        },
		_onCellSelect : function(rowid, iCol, cellcontent, e) {
			//console.debug(rowid, iCol, cellcontent, e);
		},
		destroy : function() {
			$.Widget.prototype.destroy.call(this);
		},
		_setOption : function(key, value) {
			$.Widget.prototype._setOption.apply(this, arguments);
		}
	});
})(jQuery, window, document);
