//USEUNIT lib_button
//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_DeleteJob
//USEUNIT lib_deviceInfo
//USEUNIT lib_DeviceSelectedDetail
//USEUNIT lib_OpenJob
//USEUNIT lib_SaveJob
//USEUNIT lib_UserRole
//USEUNIT TC_ChangeIP


/*
  *@function  
*/
function verifyDeviceDetail()
{
      //save a startup job
      lib_common.launchUI();
      if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) ==  lib_err.err_FUNC_SUCCESS)
      {        
              if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))    
                       lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, lib_SaveJob.randomJobName(), lib_const.const_isDefaultJob_Y , lib_const.isMonitorMode_N);         
      }
      lib_DeviceSelectedDetail.verifyDeviceSelectedDetail(lib_deviceInfo.const_Device_IP_Adress);
}

/*
  *@function  
*/
function taskSelection ()
{
  aqTestCase.Begin("taskSelection");
         //lhoang
         verifyDeviceDetail();
          //
          lib_UserRole.initUISetting_UserRole();    
          lib_common.launchUI();     
          var ip = lib_deviceInfo.const_Device_IP_Adress; 
          var jobName = lib_SaveJob.randomJobName(); 
          //on device
          if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS)
          {
             //TS_025
             if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                     //TS_01                   
                     lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, jobName , lib_const.const_isDefaultJob_Y, lib_const.isMonitorMode_N); 
          }
          if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS)
          {  //TS_02  
             if (lib_OpenJob.openOnDevice(jobName ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))  
                      Log.Message("TS_02");
          }
          if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS)
          {
             //TS_03 
                    lib_DeleteJob.deleteOnDevice( jobName  );  
                    Log.Message("TS_03");                             
          }
          //*********************************************************        
          // on PC          
          var path1 = lib_deviceInfo.const_fileNameJob_SavePC;
          if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS)
          {
             //TS_01
             if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                     lib_SaveJob.saveOnPC(jobName , path1, lib_const.const_saveIncludeImage_Y);
          }
          if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS)
          {  //TS_02  
             if (lib_OpenJob.openLoadFromPC(jobName, path1))  
                      Log.Message("TS_02");
              lib_common.gettingStarted();
              Delay(lib_const.const_delay_2000);
          }  
          
          //TS_15
           var myDevIndex = lib_common.getDeviceIndex(lib_deviceInfo.const_Device_SerialNumber);
           //lib_ChangeIP.changeDHCP(myDevIndex);
           delay (lib_const.const_delay_5000);
           if (lib_common.connectToDeviceByIndex(lib_deviceInfo.const_Device_SerialNumber) == lib_err.err_FUNC_SUCCESS)
           {  
                 if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                          Log.Message("TS_15");
           }
           if (lib_common.connectToDeviceByIndex(lib_deviceInfo.const_Device_SerialNumber) == lib_err.err_FUNC_SUCCESS)
           {  
                 lib_button.clickMenuMonitor();
                 Log.Message("TS_11");
           }
           lib_ChangeIP.changeStaticIP(lib_common.getDeviceIndex(lib_deviceInfo.const_Device_SerialNumber) , lib_deviceInfo.const_Device_IP_Adress);
           delay (lib_const.const_delay_5000);
           lib_button.clickClose();
           aqTestCase.End();
}

