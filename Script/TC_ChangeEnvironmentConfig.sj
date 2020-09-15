//USEUNIT lib_deviceInfo
//USEUNIT lib_validate
//USEUNIT lib_err
//USEUNIT lib_common
//USEUNIT lib_SaveJob
//USEUNIT lib_OpenJob
//USEUNIT lib_DeviceSelectedDetail


/*
  *@function 
*/
function change_verifyEnvironmentConfig ()
{
  aqTestCase.Begin("Change Environment Configuration");
//        if ( ! lib_validate.isDLCODERunning() || lib_validate.isUnExpectedWindowExists() )
        lib_common.launchUI();
        var device_Before = new Object();  
        var device_Expected = new Object();
        var device_After = new Object();    
        var device_Before = lib_DeviceSelectedDetail.getDeviceCurrent(lib_deviceInfo.const_Device_IP_Adress);      
        var device_Expected = lib_DeviceSelectedDetail.getDeviceFromDeviceInfo();   
        //open and save job default before change environment 
        if (lib_common.connectToDevice(device_Expected.IP)==lib_err.err_FUNC_SUCCESS)
        {
           if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
               //save job but don't be startup job
               lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, device_Expected.startupJob , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);               
        }    
        //change Environment      
        if (lib_DeviceSelectedDetail.changeDeviceInformation (device_Before, device_Expected) ) 
        {
              var device_After = lib_DeviceSelectedDetail.getDeviceCurrent(lib_deviceInfo.const_Device_IP_Adress);  
              //verify After & Expected
              var compare = lib_DeviceSelectedDetail.compareDevice(device_After, device_Expected);
              //verify selected & Environment            
              if ( compare)
              { 
                     lib_DeviceSelectedDetail.verifyDeviceSelectedDetail (device_After.IP);
                     Log.Message("verifyEnvironmentConfig: Case EVN_04 : OK" );
              }else
                    Log.Warning("compareDevice: " + compare);
        }else
                    Log.Warning("changeEmvironmentConfig: " + false);  
//        lib_common.terminateUI();
aqTestCase.End();
}
