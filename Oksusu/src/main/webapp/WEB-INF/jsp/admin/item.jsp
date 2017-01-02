<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/slick/slick.grid.css'/>" />
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/slick/jquery-ui-1.8.16.custom.css'/>" />
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/slick/slick.grid.examples.css'/>" />
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/slick/slick-default-theme.css'/>" />
  
  <!-- jQuery -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
		  integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="
		  crossorigin="anonymous"></script>
  <script src="<c:url value='/js/jquery.event.drag-2.2.js'/>"></script>
		
  <script src="<c:url value='/js/slick/firebugx.js'/>"></script>
  
  <script src="<c:url value='/js/slick/slick.core.js'/>"></script>
  <script src="<c:url value='/js/slick/plugins/slick.cellrangedecorator.js'/>"></script>
  <script src="<c:url value='/js/slick/plugins/slick.cellrangeselector.js'/>"></script>
  <script src="<c:url value='/js/slick/plugins/slick.cellselectionmodel.js'/>"></script>
  <script src="<c:url value='/js/slick/plugins/slick.rowselectionmodel.js'/>"></script>
  <script src="<c:url value='/js/slick/plugins/slick.checkboxselectcolumn.js'/>"></script>
  <script src="<c:url value='/js/slick/controls/slick.columnpicker.js'/>"></script>
  <script src="<c:url value='/js/slick/slick.formatters.js'/>"></script>
  <script src="<c:url value='/js/slick/slick.editors.js'/>"></script>
  <script src="<c:url value='/js/slick/slick.grid.js'/>"></script>
  <script src="<c:url value='/js/slick/slick.dataview.js'/>"></script>

  <style>
    .cell-title {
      font-weight: bold;
    }
    .cell-effort-driven {
      text-align: center;
    }
  </style>
</head>
<body>
<div style="position:relative">
  <div style="float: right;">
     <button class="btn btn-success" id="btnSelect" >조회</button>
     <button class="btn btn-success" id="btnDelete" >삭제</button>
  </div>
  <div style="width:100%;">
    <div id="myGrid" style="width:100%;height:600px;"></div>
  </div>
</div>

<script>
  function requiredFieldValidator(value) {
    if (value == null || value == undefined || !value.length) {
      return {valid: false, msg: "This is a required field"};
    } else {
      return {valid: true, msg: null};
    }
  }
  var grid;
  //Create the DataView.
  var dataView;
  var rowIndex;
  
  var checkboxSelector = new Slick.CheckboxSelectColumn({
      cssClass: "slick-cell-checkboxsel"
  });

  var columns = [
	{id: "IMAGE", name: "이미지", field: "STORED_IMG_NAME", width: 200, formatter: Slick.Formatters.Image },
	{id: "IMG_BTN", name: "업로드", field: "IMG_BTN", width: 67, formatter: Slick.Formatters.File },
    {id: "ITEM_CD", name: "품번", field: "ITEM_CD", width: 120, cssClass: "cell-title", editor: Slick.Editors.Text, validator: requiredFieldValidator},
    {id: "ITEM_NM", name: "품명", field: "ITEM_NM", width: 150, cssClass: "cell-title", editor: Slick.Editors.Text, validator: requiredFieldValidator},
    {id: "ITEM_DC", name: "설명", field: "ITEM_DC", width: 190, editor: Slick.Editors.LongText},
    {id: "PRICE", name: "가격", field: "PRICE", width: 100, editor: Slick.Editors.Text},
    {id: "ITEM_TYPE", name: "품목타입", field: "ITEM_TYPE",  options: "LIVE,FIRE,STEAM,OTHER", editor: Slick.Editors.Select},
    {id: "GOOD", name: "만족도", field: "GOOD", width: 100, resizable: false, formatter: Slick.Formatters.PercentCompleteBar, editor: Slick.Editors.PercentComplete},
    {id: "VIEW_YN", name: "사용여부", field: "VIEW_YN", width: 100, minWidth: 20, maxWidth: 80, cssClass: "cell-effort-driven", formatter: Slick.Formatters.Checkmark, editor: Slick.Editors.Checkbox},
  ];
  columns.unshift(checkboxSelector.getColumnDefinition());
  
  var options = {
    editable: true,
    enableAddRow: false,
    enableCellNavigation: true,
    asyncEditorLoading: false,
    autoEdit: false,
    rowHeight: 50,
  };
  
  $(document).ready(function(){ 
	  dataView = new Slick.Data.DataView();
	  grid = new Slick.Grid("#myGrid", dataView, columns, options);
	  //grid.setSelectionModel(new Slick.CellSelectionModel());
	  grid.setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false}));
	  grid.registerPlugin(checkboxSelector);
	  //var columnpicker = new Slick.Controls.ColumnPicker(columns, grid, options);

	  // wire up model events to drive the grid
	  dataView.onRowCountChanged.subscribe(function (e, args) {
	    grid.updateRowCount();
	    grid.render();
	  });

	  dataView.onRowsChanged.subscribe(function (e, args) {
	    grid.invalidateRows(args.rows);
	    grid.render();
	  });
	    
	  grid.onActiveCellChanged.subscribe(function (e, args) {
		  if (rowIndex != undefined &&
		      rowIndex != args.row) {	  
			 var row = grid.getDataItem(rowIndex);
			 if (row.RowState == 'Added' ||
			     row.RowState == 'Modified'){	
				 saveData(row.RowState == 'Added' ? 'I' : 'U', row);
				 row.RowState = "UnChanged";
				 grid.invalidateRow(rowIndex);
				 grid.render();
			 }	
		  }
		  
		  rowIndex = args.row;
	  });
	  
	  grid.onCellChange.subscribe(function (e, args) {
		  rowIndex = args.row;
		  grid.invalidateRow(args.row);
		  grid.render();
		  
		  if (grid.getDataItem(dataView.getLength() - 1).RowState != 'Empty') {
			  addNewRow();
		  }	
	  }); 
	  
	  selectList();

	  // 조회 버튼
	  $('#btnSelect').click(function() {
		  selectList();  
	  });
	  
	  // 삭제 버튼
	  $('#btnDelete').click(function() {
		  var rows = grid.getSelectedRows();
		  for (i = 0; i < rows.length; i++) {
			  var row = grid.getDataItem(rows[i]);
			  deleteList(row);  
			  dataView.deleteItem(row.id);
		  }
	  });
  });
  
  function addNewRow(){
	   var item = { "id": "new_" + (Math.round(Math.random() * 10000)), "RowState": "Empty",
			        "ITEM_CD": "", "ITEM_NM": "", "ITEM_DC": "", "ORIGINAL_IMG_NAME": "", "STORED_IMG_NAME": "",
			        "GOOD": undefined, "INSERT_DT": "", "INSERT_ID": "", "PRICE": undefined, "ITEM_TYPE": "", "VIEW_YN": "" };             
	   dataView.addItem(item);
	}
  
  function fileChange(f){
		var file = f.files; 
	    if (file) {
	    	var row = grid.getDataItem(rowIndex);
	    	if (row) {
	    	  saveImg(row, rowIndex);
	    	}
	    }
  }
  
  function selectList() {
	  $.ajax({
          url: '/items/itemSelect.do',
          type: "get",
          dataType: 'json',
          data: {"type": "", "view_yn": "", "item_cd": ""},
          async: false,
          cache: false,
          success: function(data) {  
        	  dataView.beginUpdate();
    	      dataView.setItems(data);
    	      addNewRow();
    	      dataView.endUpdate();
    	      grid.invalidate();
  	      },
  	      error:function(request,status,error){
  	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
  	      }
      });
  }
  
  function deleteList(row) {
	  $.ajax({
          url: '/items/itemSave.do',
          type: "POST",
          dataType: 'json',
          data: { "dml_fg": "D", "row": JSON.stringify(row) },
          async: false,
          cache: false,
          success: function(data) {  	
  	      },
  	      error:function(request,status,error){
  	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
  	      }
      });
  }
  
  function saveData(fg, row) {
	  $.ajax({
          url: '/items/itemSave.do',
          type: "POST",
          dataType: 'json',
          data: { "dml_fg": fg, "row": JSON.stringify(row) },
          async: false,
          cache: false,
          success: function(data) {  	
  	      },
  	      error:function(request,status,error){
  	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
  	      }
      });
  } 
  
  function saveImg(row, rowIndex) {
	    var formData = new FormData();
	    // 파일태그
	    formData.append("uploadfile",$("#file_" + row.id)[0].files[0]);
	    $.ajax({
	          url: '/items/imgSave.do',
	          type: "POST",
	          data: formData,
	          async: false,
	          cache: false,
	          contentType: false,
	          processData: false,
	          success: function(data) {  
	        	var array = eval(data);
	        	if (array && array.length > 0) {
	        		row.STORED_IMG_NAME = array[0].STORED_IMG_NAME;
	        		row.ORIGINAL_IMG_NAME = array[0].ORIGINAL_IMG_NAME;
	        		if (row.RowState == undefined ||
	        			row.RowState == 'Empty') {
	        			row.RowState = 'Added';
	                } else if (row.RowState == 'UnChanged') {
	                	row.RowState = 'Modified';
	                }
	        		grid.invalidateRow(rowIndex);
					grid.render();
	        	}
	  	      },
	  	      error:function(request,status,error){
	  	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	  	      }
	      });
  }

</script>
</body>
</html>