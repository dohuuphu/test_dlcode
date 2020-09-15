//USEUNIT lib_err
//USEUNIT lib_deviceInfo
//USEUNIT lib_const
 

/**
  *@function return array values of one Column
  *@param{String} path
  *@param{String} fileName
  *@param{String} sheetName
  *@param{String} columnName 
*/
function driverXLS ( path, fileName, sheetName, columnName )
{ 
//      Log.AppendFolder("func: driverXLS");
      var array = new Array();  
//      try{
          var driver =DDT.ExcelDriver(path + "\\" + fileName ,sheetName, true);  
     
          while  (! driver.EOF()) 
              { 
                //Gets a value from the storage and posts it to the log
                array.push (driver.Value(columnName));
                DDT.CurrentDriver.Next(); 
              }
          if ( array.length == 0) 
          {
            Log.Message(lib_err.err_FILE_XLS_NULL);
          } 
         DDT.CloseDriver(driver.Name);
//      }
//      catch(e)
//      {
//        Log.Message(lib_err.err_FUNC_EXCEPTION);
//      }
      Log.PopLogFolder();
      return array;
}

/**
  *@function insert value at position (rowIndex, columnIndex)
  *@param {String} path
  *@param {String} fname
  *@param {String} sheetName
  *@param {String} rowIndex
  *@param {String} ColumnIndex
  *@param {String} valueString
*/
function AddCell(path, fname, sheetName,rowIndex,ColumnIndex,valueString ) // insert value at position (rowIndex, columnIndex)
{
//          Log.AppendFolder("func: AddCell");
          var app = Sys.OleObject("Excel.Application");
          delay (lib_const.const_delay_3000);        
          var book = app.Workbooks.Open(path + "\\"+fname);
          delay (lib_const.const_delay_1000);  
          var sheet = book.Sheets(sheetName);
          app.DisplayAlerts = false;  
          // Write an index of the current row and column to a cell   
          sheet.Cells(rowIndex, ColumnIndex) = valueString; 
          book.Save();  
//          Log.Message("@@End AddColum:" + lib_err.err_FUNC_SUCCESS) ;
//          Log.PopLogFolder();
          return lib_err.err_FUNC_SUCCESS;
}



/**
  *@function insert value at Column (columnIndex)
  *@param {String} path
  *@param {String} fname
  *@param {String} sheetName
  *@param {String} ColumnIndex
  *@param {String} array
*/
function insertColumn(path, fname, sheetName,ColumnIndex,array ) // insert value at position (rowIndex, columnIndex)
{
          Log.AppendFolder("func: insertColumn");
          var app = Sys.OleObject("Excel.Application");
          delay (lib_const.const_delay_1000);        
          var book = app.Workbooks.Open(path + "\\"+fname);
          delay (lib_const.const_delay_1000);  
          var sheet = book.Sheets(sheetName);
          app.DisplayAlerts = false;  
          // Write an index of the current row and column to a cell   
          for (var i = 1; i <= array.length ; i ++)
          {
               sheet.Cells(i+1, ColumnIndex) = array[i-1]; 
          }
          book.Save(); 
          app.Quit();
          Log.Message("@@End insertColumn:" + lib_err.err_FUNC_SUCCESS) ;
          Log.PopLogFolder();
          return lib_err.err_FUNC_SUCCESS;
}

/**
  * @function example
*/
function Main()
{
           var fileName = lib_deviceInfo.const_fileNameJob;
           var path = lib_deviceInfo.const_fileNameJob_Path;
           var sheetName = lib_deviceInfo.const_fileNameJob_SheetName; 
 
           var num_job = lib_connection.driverXLS (path,"ConfigList.xls", sheetName ,"Configuration"); 
           for ( var a = 1 ; a <= num_job.length ; a ++)
           {
                 var valueString  = num_job[a-1]+ "-" + "Pass";
                 AddColum(path, "ConfigList.xls", sheetName, a + 1, 2, valueString );
           }
           for ( var a = 1 ; a <= num_job.length ; a ++)
           {
                 var valueString  = num_job[a-1]+ "-" + "Pass";
                 AddColum(path, "ConfigList.xls", sheetName, a + 1, 3, valueString );
           }
           for ( var a = 1 ; a <= num_job.length ; a ++)
           {
                 var valueString  = num_job[a-1]+ "-" + "Pass";
                 AddColum(path, "ConfigList.xls", sheetName, a + 1, 4, valueString );
           }
}
/**
  * @function example
*/
function call_Test_AddColum()
{
   var fileName = lib_deviceInfo.const_fileNameJob;
   var path = lib_deviceInfo.const_fileNameJob_Path;
   var sheetName = lib_deviceInfo.const_fileNameJob_SheetName;
   Test_AddColum(path,  "Test_AddColum" ,sheetName);
}

/**
  * @function example
*/
function Test_AddColum(path, fname, sheetName )
{
    var app = Sys.OleObject("Excel.Application");
    while (Sys.WaitProcess("excel", lib_const.const_delay_1000).Exists)
    {
        Delay(lib_const.const_delay_5000)
    }      
    var book = app.Workbooks.Open(path + "\\"+fname);
    var sheet = book.Sheets(sheetName);
    app.DisplayAlerts = false;  
    // Write an index of the current row and column to a cell
    var rowCount = sheet.UsedRange.Rows.Count + 1;  
    var columnCount = sheet.UsedRange.Columns.Count + 1;  
    
    Log.Message("#Excel Sheet current:");
    Log.Message("## -> rowCount current:" + rowCount);
    Log.Message("## -> columnCount current:" + columnCount); 
    
    for(var row = 2; row < rowCount ; row++) 
    {    
        sheet.Cells(row, columnCount) = "Add" + row + ", " + columnCount;
    } 
    book.Save();
    app.Quit();
}

/**
  * @function example
*/
 
function WriteExcelSheet_Standard(fname, sheetName)
{
    var maxcol = 2, maxrow = 5;
    
    var app = Sys.OleObject("Excel.Application");
      
    var book = app.Workbooks.Open(fname);
    var sheet = book.Sheets(sheetName);
    app.DisplayAlerts = false;  
    // Write an index of the current row and column to a cell
    var rowCount = sheet.UsedRange.Rows.Count + 1;
    for(var row = rowCount; row < rowCount + maxrow; row++)
      for(var col = 1; col <= maxcol; col++)
        sheet.Cells(row, col) = "Hello" + row + ", " + col;
    
    book.Save();
    app.Quit();   
}


/**
  * @function example
*/
function WriteExcelSheet(fname, sheetName)
{
    var maxcol = 2, maxrow = 5;
    var app = Sys.OleObject("Excel.Application");
      
    var book = app.Workbooks.Open(fname);
    var sheet = book.Sheets(sheetName);
    app.DisplayAlerts = false;  
    // Write an index of the current row and column to a cell
    var rowCount = sheet.UsedRange.Rows.Count + 1;  
    for(var row = rowCount; row < rowCount + maxrow; row++)
      for(var col = 1; col <= maxcol; col++)
        sheet.Cells(row, col) = "Hello" + row + ", " + col; 
    book.Save();
    app.Quit();
}



/**
  *@function 
  *@param{String} sPath
*/
function Deleting_AddingFolder(sPath)
{  
         Log.AppendFolder("func: Deleting_AddingFolder");
         var FolderInf = aqFileSystem.GetFolderInfo(sPath); 
         // Deletes both the folder and the file
         FolderInf.Delete(true);
         // Creates a folder
         aqFileSystem.CreateFolder(sPath); 
         Log.PopLogFolder();
}



/**
  *@function example
  *@param{String} fileName
*/
function openXLS(fileName)
{
      Log.AppendFolder("func: openXLS");
      var explorer;
      var trayShowDesktopButtonWClass;
      var folderView;
      explorer = Aliases.explorer;
      trayShowDesktopButtonWClass = explorer.wndShell_TrayWnd.TrayNotifyWnd.TrayShowDesktopButtonWClass;
      trayShowDesktopButtonWClass.Click(8, 21);
      folderView = explorer.wndWorkerW.SHELLDLL_DefView.FolderView;
      folderView.Click(219, 490);
      folderView.DblClickItem(fileName, 0);
      Log.PopLogFolder();
}

