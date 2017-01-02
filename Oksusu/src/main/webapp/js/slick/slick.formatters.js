/***
 * Contains basic SlickGrid formatters.
 * 
 * NOTE:  These are merely examples.  You will most likely need to implement something more
 *        robust/extensible/localizable/etc. for your use!
 * 
 * @module Formatters
 * @namespace Slick
 */

(function ($) {
  // register namespace
  $.extend(true, window, {
    "Slick": {
      "Formatters": {
        "PercentComplete": PercentCompleteFormatter,
        "PercentCompleteBar": PercentCompleteBarFormatter,
        "YesNo": YesNoFormatter,
        "Checkmark": CheckmarkFormatter,
        // #커스터마이징# 이미지 포맷
        "Image": ImageFormatter,
        // #커스터마이징# 버튼 포맷
        "Button": ButtonFormatter,
        // #커스터마이징# 버튼 포맷
        "File": FileFormatter,
      }
    }
  });

  function PercentCompleteFormatter(row, cell, value, columnDef, dataContext) {
    if (value == null || value === "") {
      return "-";
    } else if (value < 50) {
      return "<span style='color:red;font-weight:bold;'>" + value + "%</span>";
    } else {
      return "<span style='color:green'>" + value + "%</span>";
    }
  }

  function PercentCompleteBarFormatter(row, cell, value, columnDef, dataContext) {
    if (value == null || value === "") {
      return "";
    }

    var color;

    if (value < 30) {
      color = "red";
    } else if (value < 70) {
      color = "silver";
    } else {
      color = "green";
    }

    return "<span class='percent-complete-bar' style='background:" + color + ";width:" + value + "%'></span>";
  }

  function YesNoFormatter(row, cell, value, columnDef, dataContext) {
    return value ? "Yes" : "No";
  }

  function CheckmarkFormatter(row, cell, value, columnDef, dataContext) {
    return value ? "<img src='../images/slick/tick.png'>" : "";
  }
  
  // #커스터마이징# 이미지 포맷
  function ImageFormatter(row, cell, value, columnDef, dataContext) {
	  if (value == null || value === "") {
		  return "<img src='/images/item/NoImage.jpg' width='100%' height='100%' />";	 
	  } else {
		  return "<img src='/files/" + value + "' width='100%' height='100%' />";
	  }
  }
  
  // #커스터마이징# 버튼 포맷
  function ButtonFormatter(row, cell, value, columnDef, dataContext) {  
      var button = "<input class='btn' type='button' id='img_"+ dataContext.id +"' />";   
      return button;
  }
  
  // #커스터마이징# 파일 포맷
  function FileFormatter(row, cell, value, columnDef, dataContext) {  
      var file = "<input class='file' type='file' id='file_"+ dataContext.id +"' onchange='fileChange(this)' />";
      return file;
  }
  
})(jQuery);
