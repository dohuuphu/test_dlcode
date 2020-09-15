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
 

 
/*
  *@function 
*/
function tc_OpenJobDefault(numJob)
{
         if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI();  
         var ip = lib_deviceInfo.const_Device_IP_Adress;
         
         for ( var a = 0 ; a < numJob ; a ++)
        
         {
              Log.Warning("Time:"+ a);   
              if (lib_common.connectToDevice(ip))
              {         
                lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);   
              }
        }  
        //lib_common.terminateUI();
}
//updated 1.5.0
/*
  *@function 
*/
function tc_OpenJobOnDevice()
{
         var ip          = lib_deviceInfo.const_Device_IP_Adress;   
         var fileName    = lib_deviceInfo.const_fileNameJob;
         var path        = lib_deviceInfo.const_fileNameJob_Path;
         var sheetName   = "Sheet1";
         var columnName  = lib_deviceInfo.const_fileNameJob_ColumnName;

         if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI();    
         var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName); 
         if (lib_common.connectToDevice(ip))
         {      
               for ( var a = 1 ; a <= num_job.length ; a ++)
              {         
                   
                   var result = lib_OpenJob.openOnDevice( num_job[a-1] ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);
                    lib_connection.AddCell(path, fileName, sheetName, a + 1, 3, result +":"+ num_job[a-1] );       
              }  
        }  
        //lib_common.terminateUI();
}
//updated 1.5.0
/*
  *@function 
*/
function tc_OpenJobFromPC()
{     
  aqTestCase.Begin("Open job from PC");
         var ip          = lib_deviceInfo.const_Device_IP_Adress;   
         var fileName    = lib_deviceInfo.const_fileNameJob;
         var path        = lib_deviceInfo.const_fileNameJob_Path;
         var path1       = lib_deviceInfo.const_fileNameJob_SavePC;
         var sheetName   = "Sheet1";
         var columnName  = lib_deviceInfo.const_fileNameJob_ColumnName;
   
         if ( ! lib_validate.isDLCODERunning())
               lib_common.launchUI();     
         var num_job = lib_connection.driverXLS (path,fileName, sheetName ,columnName);  
         if (lib_common.connectToDevice(ip)) 
         { 
              for ( var a = 1 ; a <=num_job.length ; a ++) 
              {              
                    var result = lib_OpenJob.openLoadFromPC(num_job[a -1 ], path1);
                    lib_connection.AddCell(path, fileName, sheetName, a + 1, 5, result +":"+ num_job[a-1] );      
              }     
        }  
        //lib_common.terminateUI();
        aqTestCase.End();
}