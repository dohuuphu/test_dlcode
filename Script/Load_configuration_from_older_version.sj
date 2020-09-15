//USEUNIT lib_ChangeIP
//USEUNIT lib_CodeSetup
//USEUNIT lib_common
//USEUNIT lib_connection
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_DeviceSelectedDetail
//USEUNIT lib_OpenJob
//USEUNIT lib_SaveJob
//USEUNIT lib_validate
//USEUNIT lib_UserRole 
//USEUNIT testMatrix

/*
 *@function
*/
function tc_Open_ScriptFormatting()
{     
    aqTestCase.Begin("ScriptFormaating");
         var ip          = lib_deviceInfo.const_Device_IP_Adress;   
         var fileName    = lib_deviceInfo.const_Older_JobList_xls;
         var path        = lib_deviceInfo.const_Older_JobList_Folder;   
         var sheetName   = "Sheet1"; // SCRT Formatting
         var columnName  = "Configuration";  
   
         if ( ! lib_validate.isDLCODERunning())
               lib_common.launchUI();     
         var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName);  
         if (lib_common.connectToDevice(ip)) 
         { 
              for ( var a = 1 ; a <= num_job.length ; a ++) 
              {                                  
                    var result = lib_OpenJob.openLoadFromPC(num_job[a-1], path); 
                    lib_connection.AddCell(path, fileName, sheetName, a + 1, 2,result +" : "+ num_job[a-1]);                       
                    lib_button.clickOpenConsoleTab(); 
                    lib_button.ui_PlayAndPause(30000, false);
                    
                    var resultSave =  lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, num_job[a-1] , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);
                    lib_connection.AddCell(path, fileName, sheetName, a + 1, 3, resultSave +":"+ num_job[a-1]);    
                    lib_button.ui_PlayAndPause(30000, false); 
                                
              }     
        }  
//        lib_common.terminateUI();
aqTestCase.End();
}

/*
 *@function
*/
function tc_OpenOlderJobFromPC()
{     
         var ip          = lib_deviceInfo.const_Device_IP_Adress;   
         
         var fileName    = lib_deviceInfo.const_Older_JobList_xls;
         var path        = lib_deviceInfo.const_Older_JobList_Folder;    
         var sheetName   = "Sheet2"; // Continuous
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
                    lib_button.clickOpenConsoleTab();                     
                    lib_button.ui_PlayAndPause(30000, false);
                    Log.Message("Please check here"); 
                    var resultSave =  lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, num_job[a-1] , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);
                    lib_connection.AddCell(path, fileName, sheetName, a + 1, 3, resultSave +":"+ num_job[a-1]);    
                    lib_button.ui_PlayAndPause(30000, false); 
                                
              }     
        }  
//        lib_common.terminateUI();
}

/*
 *@function
*/
function tc_OpenOlderJobFromPC_Phase()
{     
         var ip          = lib_deviceInfo.const_Device_IP_Adress;   
         
         var fileName    = lib_deviceInfo.const_Older_JobList_xls;
         var path        = lib_deviceInfo.const_Older_JobList_Folder;    
         var sheetName   = "Sheet3"; //Phase Mode
         var columnName  = lib_deviceInfo.const_Older_JobList_ColumnName;
   
         if ( ! lib_validate.isDLCODERunning())
               lib_common.launchUI();     
         var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName);  
         if (lib_common.connectToDevice(ip)) 
         {    
              testMatrix.launch_Config_TM();
              
              for ( var a = 1 ; a <= num_job.length ; a ++) 
              {              
                    
                    var result = lib_OpenJob.openLoadFromPC(num_job[a-1], path); 
                    lib_connection.AddCell(path, fileName, sheetName, a + 1, 2,result +" : "+ num_job[a-1]);   
                    lib_button.clickPlay(false);
                    lib_button.clickOpenConsoleTab();
                    testMatrix.clickStartbtt();
                    delay (lib_const.const_delay_60000);
                    testMatrix.clickStopbtt();
                    lib_button.clickPause(false); 
                    Log.Message("Please check here"); 
                    var resultSave =  lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, num_job[a-1] , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);
                    lib_connection.AddCell(path, fileName, sheetName, a + 1, 3, resultSave +":"+ num_job[a-1]); 
                    lib_button.clickPlay(false);
                    Delay(3000);     
                    lib_button.clickPause(false);            
              }     
        }  
//        lib_common.terminateUI();
}