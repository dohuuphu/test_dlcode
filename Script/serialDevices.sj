//USEUNIT lib_CodeSetup
//USEUNIT lib_common
//USEUNIT lib_connection
//USEUNIT lib_const
//USEUNIT lib_DeleteJob
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_OpenJob
//USEUNIT lib_validate
//USEUNIT lib_SER_common

  

/*
 *@function
 *@param numJob{Interger}
 Case 1:- Clean PC -> install 1.7.0 Alpha 5- Connect serial -> play 5' -> disconnect GUI -> reconnect -> play 5' (lap di lap lai nhieu lan)
*/
function case1( )
{    
          var serialNumber  = lib_deviceInfo.const_SerialDevice_SerialNumber;
          var playTime = 300000; // 5'
          
          for (var i = 1; i<= 300; i++)
          {               
                Log.Message("Time:" + i);
                if (connectToSerialDevice(serialNumber)==lib_err.err_FUNC_SUCCESS)
                {          
                    if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))    ;
//                         lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N,  lib_SaveJob.randomJobName(), lib_const.const_isDefaultJob_Y , lib_const.isMonitorMode_N);
                          lib_button.ui_PlayAndPause(playTime, false);              
                }
          }  
}


/*
 *@function
*/
function tc_DeleteJobOnDevice()
{
     var serialNumber  = lib_deviceInfo.const_SerialDevice_SerialNumber;
   
   var fileName = lib_deviceInfo.const_fileNameJob;
   var path = lib_deviceInfo.const_fileNameJob_Path;
   var sheetName = lib_deviceInfo.const_fileNameJob_SheetName;
   var columnName = lib_deviceInfo.const_fileNameJob_ColumnName;
   var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName); 

   for ( var a = 0 ; a < num_job.length ; a ++)
   {
         if (connectToSerialDevice(serialNumber)==lib_err.err_FUNC_SUCCESS)
         {    
               lib_DeleteJob.deleteOnDevice( num_job[a]);     
//               lib_DeleteJob.verifyDeleteJob(serialNumber, num_job[a]);
         } 
  }  
   lib_common.terminateUI();
}


/*
 *@function
*/
function tc_OpenJobOnDevice()
{
  
   var serialNumber  = lib_deviceInfo.const_SerialDevice_SerialNumber;
   
   var fileName = lib_deviceInfo.const_fileNameJob;
   var path = lib_deviceInfo.const_fileNameJob_Path;
   var sheetName = lib_deviceInfo.const_fileNameJob_SheetName;
   var columnName = lib_deviceInfo.const_fileNameJob_ColumnName;
   
   var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName); 
   for ( var a = 0 ; a <num_job.length ; a ++)
   {    
         if (connectToSerialDevice(serialNumber)==lib_err.err_FUNC_SUCCESS)
        {         
          lib_OpenJob.openOnDevice( num_job[a] ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);   
        }   
//     lib_common.gettingStarted(); 
  }  
   lib_common.closeUI();
} 

/*
 *@function
*/
function mainSaveOnDevice()
{
   if ( ! lib_validate["isDLCODERunning"]())
     lib_common["launchUI"]();  
   var serialNumber  = lib_deviceInfo.const_SerialDevice_SerialNumber;
   var fileName = lib_deviceInfo.const_fileNameJob;
   var path = lib_deviceInfo.const_fileNameJob_Path;
   var sheetName = lib_deviceInfo.const_fileNameJob_SheetName;
   var columnName = lib_deviceInfo.const_fileNameJob_ColumnName;
   
   var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName);     
   for ( var a = 0 ; a < num_job.length ; a ++)
   {           
            if (connectToSerialDevice(serialNumber)==lib_err.err_FUNC_SUCCESS)
            {
               if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                   lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, num_job[a] , lib_const.const_isDefaultJob_Y, lib_const.isMonitorMode_N);               
            }   
  }  
  lib_common.terminateUI();
}

/*
 *@function
 *@param numJob{Interger}
*/
function randomSaveOnDevice( numJob)
{
    
     var serialNumber  = lib_deviceInfo.const_SerialDevice_SerialNumber;
     for ( var a = 1 ; a <= numJob ; a ++)
     {          
          if (connectToSerialDevice(serialNumber)==lib_err.err_FUNC_SUCCESS)
          {          
              if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))    ;
                   lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, "Time_"+ a +"_" +lib_SaveJob.randomJobName(), lib_const.const_isDefaultJob_Y , lib_const.isMonitorMode_N);
          }        
          Log.Message("time  :" + a);    }  
    lib_common.terminateUI();
}

 
 