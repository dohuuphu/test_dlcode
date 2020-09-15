//USEUNIT lib_common
//USEUNIT lib_connection
//USEUNIT lib_DeleteJob
//USEUNIT lib_deviceInfo
//USEUNIT lib_OpenJob
//USEUNIT lib_UserRole

/*
  *@function 
*/
function open_Save_DeleteJob()
{ 
 
   if ( ! lib_validate.isDLCODERunning())
     lib_common.launchUI();   
   var ip   = lib_deviceInfo.const_Device_IP_Adress;      
  
   if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS ) 
   {       
             if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
             {
               
                   if (lib_err.err_FUNC_SUCCESS  == lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N,lib_deviceInfo.const_firmware , lib_const.const_isDefaultJob_Y, lib_const.isMonitorMode_N))
                   {   
                         var result =lib_DeleteJob.deleteOnDevice( lib_deviceInfo.const_firmware);
                         if (result == lib_err.err_FUNC_SUCCESS )
                         {                         
                                 //click open job
                                 Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
 
                                 // waiting Job List Dialog
                                 if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: JobListDialogWindow", "*", 2000).Exists)
                                 {
                                      //CFG_005
                                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Open Device Configuration").WPFObject("JobListDialogWindow", "Open Device Configuration", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JobListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("Border").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 1) ,"WPFControlText", cmpEqual,"[Temp]");
                                       
                                      Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Open Device Configuration").WPFObject("JobListDialogWindow", "Open Device Configuration", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
                                      //CFG_48
                                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "[Temp]", 3) ,"WPFControlText", cmpEqual,"[Temp]");
                                                                            
                                 }                                
                         }
                   }                  
             }  
  }  
   //lib_common.terminateUI();
}
//updated 1.5.0
/*
  *@function 
*/
function tc_DeleteJobOnDevice()
{ 
   var ip = lib_deviceInfo.const_Device_IP_Adress;   
   var fileName = lib_deviceInfo.const_fileNameJob;
   var path = lib_deviceInfo.const_fileNameJob_Path;
   var sheetName = "Sheet1";
   var columnName = lib_deviceInfo.const_fileNameJob_ColumnName; 
   if ( ! lib_validate.isDLCODERunning())
     lib_common.launchUI();   
   var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName); 
   if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS ) 
   {       
             for ( var a = 1 ; a <=  num_job.length ; a ++)
             {    
                   //CFG_003
                   var result =lib_DeleteJob.deleteOnDevice( num_job[a-1]);
                   lib_connection.AddCell(path, fileName, sheetName, a + 1, 4, result +":"+ num_job[a-1] );         

             } 

  }  
//   lib_common.terminateUI();
}


