﻿//USEUNIT lib_ChangeIP
//USEUNIT lib_CodeSetup
//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_DeviceSelectedDetail
//USEUNIT lib_OpenJob
//USEUNIT lib_SaveJob
//USEUNIT lib_UserRole
//USEUNIT lib_validate



//add new 1.7.0
/*
  *@function 
*/

function tc648_GUI_SaveConfiguration_Cluster()
{
    aqTestCase.Begin("tc648_GUI_SaveConfiguration_Cluster");
           lib_common.launchUI();      
           var ip = lib_deviceInfo.const_Device_IP_Adress;
           if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS)
           {
                   if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))    
                   {
                            // open via button on Toolbar
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
                            delay (2000);
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1), "WPFControlText", cmpEqual, "Set as Startup Configuration");
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 2), "WPFControlText", cmpEqual, "Save on Slave Device");
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 3), "WPFControlText", cmpEqual, "Clone Master Configuration on Slaves");
                            aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("WPFControlText", lib_label.const_lb_OverwriteExistingConfiguration, 1000), "Visible", cmpEqual, true);
                            
                            Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
                          
                   }
  
          }  
          //lib_common.terminateUI();
          aqTestCase.End();
}

//update 1.9.0A3
/*
  *@function 
  *Step 1: open Default 
  *Step 2: save Default with name from xls
  *Step 3: load job from PC
  *Step 4: save overwrite with name from step 2
  =>repeat step 1-4 for new job
*/
function loadJobAndSaveOverwite()
{
  aqTestCase.Begin("loadJobAndSaveOverwite");
        lib_UserRole.changeUserRole(lib_label.const_lb_InstallerExpert, true);
         var ip          = lib_deviceInfo.const_Device_IP_Adress;            
         var fileName    = lib_deviceInfo.const_Older_JobList_xls;
         var path        = lib_deviceInfo.const_Older_JobList_Folder;    
         var sheetName   = "Sheet2";//linhtnguyen commented
         var columnName  = lib_deviceInfo.const_Older_JobList_ColumnName;

         lib_common.launchUI();     
         var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName);  
         if (lib_common.connectToDevice(ip)) 
         {    
             
              for ( var a = 1 ; a <= num_job.length ; a ++) 
              { 
                         //save job on pc with name from xls
                      if ( lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y)== true)
                      {                                          
                        var resultSave =  lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, num_job[a-1] , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);
                        //load job from PC
                        var resultLoadFromPC = lib_OpenJob.openLoadFromPC(num_job[a-1], path);   
                        lib_connection.AddCell(path, fileName, sheetName, a + 1, 2,resultLoadFromPC +" : "+ num_job[a-1] + "load job from PC on " + lib_deviceInfo.const_Device_Model);       
                        lib_button.clickAdvancedSetup();
                        lib_button.ui_PlayAndPause(3000 , false);
                        //save overwrite
                        var resultOverwrite =  lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_O, num_job[a-1] , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);
                        lib_connection.AddCell(path, fileName, sheetName, a + 1, 3, resultOverwrite +":"+ num_job[a-1]);                  
                  }
              }
        }  
aqTestCase.End();
}

/*
  *@function
  * the same function at Load_confi... 
*/
/*
function tc_OpenScriptFormattingJobFromPC()
{     
         var ip          = lib_deviceInfo.const_Device_IP_Adress;   
         
         var fileName    = lib_deviceInfo.const_Older_JobList_xls;
         var path        = lib_deviceInfo.const_Older_JobList_Folder;    
         var sheetName   = "Sheet1";// List of the Script Formatting configuration
         var columnName  = lib_deviceInfo.const_Older_JobList_ColumnName;
   
         if ( ! lib_validate.isDLCODERunning())
               lib_common.launchUI();     
         var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName);  
         if (lib_common.connectToDevice(ip)) 
         { 
              for ( var a = 1 ; a <= num_job.length ; a ++) 
              {              
                    
                    var result = lib_OpenJob.openLoadFromPC(num_job[a-1], path); 
                    lib_connection.AddCell(path, fileName, sheetName, a + 1, 2,result +" : "+ num_job[a-1]);   
                    lib_button.clickPlay(false);
                    lib_button.clickOpenConsoleTab();
                    delay (lib_const.const_delay_60000);
                    lib_button.clickPause(false);   
                    Log.Message("Please check here"); 
                    var resultSave =  lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, num_job[a-1] , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);
                    lib_connection.AddCell(path, fileName, sheetName, a + 1, 3, resultSave +":"+ num_job[a-1]);    
                    lib_button.clickPlay(false);
                    Delay(3000);     
                    lib_button.clickPause(false); 
                                
              }     
        }  
        //lib_common.terminateUI();
}

*/
function tc_OpenOlderJobFromPC()
{     
         var ip          = lib_deviceInfo.const_Device_IP_Adress;   
         
         var fileName    = lib_deviceInfo.const_Older_JobList_xls;
         var path        = lib_deviceInfo.const_Older_JobList_Folder;    
         var sheetName   = lib_deviceInfo.const_Older_JobList_SheetName;//Continuos
         var columnName  = lib_deviceInfo.const_Older_JobList_ColumnName;
   
         if ( ! lib_validate.isDLCODERunning())
               lib_common.launchUI();     
         var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName);  
         if (lib_common.connectToDevice(ip)) 
         { 
              for ( var a = 1 ; a <= num_job.length ; a ++) 
              {              
                    
                    var result = lib_OpenJob.openLoadFromPC(num_job[a-1], path); 
                    lib_connection.AddCell(path, fileName, sheetName, a + 1, 2,result +" : "+ num_job[a-1]);   
                    lib_button.clickPlay(false);
                    lib_button.clickOpenConsoleTab();
                    delay (lib_const.const_delay_60000);
                    lib_button.clickPause(false);   
                    Log.Message("Please check here"); 
                    var resultSave =  lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, num_job[a-1] , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);
                    lib_connection.AddCell(path, fileName, sheetName, a + 1, 3, resultSave +":"+ num_job[a-1]);    
                    lib_button.clickPlay(false);
                    Delay(3000);     
                    lib_button.clickPause(false);                                 
              }     
        }  
//        //lib_common.terminateUI();
}

//updated 1.5.0
/*
  *@function 
*/
function mainSaveOnDevice()
{

         var ip         = lib_deviceInfo.const_Device_IP_Adress;   
         var fileName   = lib_deviceInfo.const_fileNameJob;
         var path       = lib_deviceInfo.const_fileNameJob_Path;
         var sheetName  = "Sheet1";
         var columnName = lib_deviceInfo.const_fileNameJob_ColumnName;
         if ( ! lib_validate.isDLCODERunning())
                lib_common.launchUI(); 
         var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName);     
         if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS)
         {
                for ( var a = 1 ; a <= num_job.length ; a ++)
                {  
                   if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                   {
                          var result =  lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, num_job[a-1] , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);
                          lib_connection.AddCell(path, fileName, sheetName, a + 1, 2, result +":"+ num_job[a-1]);               
                   }               
                }   
        }  
        //lib_common.terminateUI();
}

//updated 1.5.0
/*
  *@function 
*/
function mainSaveOnDevice_Overwrite()
{

           var ip         = lib_deviceInfo.const_Device_IP_Adress;   
           var fileName   = lib_deviceInfo.const_fileNameJob;
           var path       = lib_deviceInfo.const_fileNameJob_Path;
           var sheetName  = lib_deviceInfo.const_fileNameJob_SheetName;
           var columnName = lib_deviceInfo.const_fileNameJob_ColumnName;
           if ( ! lib_validate.isDLCODERunning())
                  lib_common.launchUI(); 
           var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName);     
           if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS)
           {
                  for ( var a = 1 ; a <= num_job.length ; a ++)
                  {  
                     if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                     {
                        var result =  lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_O, num_job[a-1] , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);
                        lib_connection.AddCell(path, fileName, sheetName, a + 1, 2, result +":"+ num_job[a-1] );               
                     }               
                  }   
          }  
          //lib_common.terminateUI();
}


//updated 1.5.0
/*
  *@function 
*/
function randomSaveOnDevice( numJob)
{
//           if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI();      
           var ip = lib_deviceInfo.const_Device_IP_Adress;
           if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS)
           {
                    for ( var a = 0 ; a < numJob ; a ++)
                    {
                       if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))    
                         lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N,  a+ "-"+ lib_SaveJob.randomJobName(), lib_const.const_isDefaultJob_Y , lib_const.isMonitorMode_N);
                    }  
          }  
          //lib_common.terminateUI();
}


//updated 1.5.0  
/*
  *@function 
*/
function mainSaveOnPC()
{
  aqTestCase.Begin("Save Job on PC");
            if ( ! lib_validate.isDLCODERunning())
                      lib_common.launchUI(); 
           var ip         = lib_deviceInfo.const_Device_IP_Adress; 
           var fileName   = lib_deviceInfo.const_fileNameJob;
           var path       = lib_deviceInfo.const_fileNameJob_Path;//path to get folder of file xls
           var path1      = lib_deviceInfo.const_fileNameJob_SavePC;//path folder contain the config
           var sheetName  = "Sheet1";
           var columnName = lib_deviceInfo.const_fileNameJob_ColumnName;
   
           var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName);
           if (lib_common.connectToDevice(ip))  
           {
                   for ( var a = 1 ; a <= num_job.length ; a ++)
                   {  
                          {   
                             lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);    
                             var result = lib_SaveJob.saveOnPC(num_job[a -1] , path1, lib_const.const_saveIncludeImage_Y); 
                             lib_connection.AddCell(path, fileName, sheetName, a + 1, 6, result +":"+ num_job[a-1] );          
                          } 
                  }  
          }
          //lib_common.terminateUI();
          aqTestCase.End();
}
