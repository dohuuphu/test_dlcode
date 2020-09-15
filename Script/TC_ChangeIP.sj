//USEUNIT lib_ChangeIP
//USEUNIT lib_common 
//USEUNIT lib_const
//USEUNIT lib_deviceInfo 
//USEUNIT lib_err
//USEUNIT lib_OpenJob
//USEUNIT lib_SaveJob
 

//update 1.5.0a5
/*
  *@function 
*/
function TC_ChangeIpRandom ()
{
/* steps:
1. launch IVS
2. open change IP popup & change IP
3. Close IVS
*/

        var _mySerialDevice = lib_deviceInfo.const_Device_SerialNumber;
        lib_common.launchUI();
        var newIp = lib_ChangeIP.randomIP();  
        var deviceIndex = lib_common.getDeviceIndex(_mySerialDevice);
        if ( deviceIndex!= "")
        {      
                if (lib_ChangeIP.changeStaticIP(deviceIndex, newIp) == lib_err.err_FUNC_SUCCESS ) 
                {
                        if (lib_ChangeIP.verifyChangeIP(_mySerialDevice, newIp))
                        {                         
                                if (lib_common.connectToDevice(newIp) == lib_err.err_FUNC_SUCCESS)
                                          lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);
                        }   
                } 
        }  else
                Log.Message(lib_messageLog.msg_DEVICE_NOTFOUND)
//        lib_common.terminateUI();
}

function TC_ChangeStatic ()//change IP to IP in lib_DeviceInfo
{
      var _mySerialDevice = lib_deviceInfo.const_Device_SerialNumber;
      var ip = lib_deviceInfo.const_Device_IP_Adress;
//      if ( ! lib_validate.isDLCODERunning())
      lib_common.launchUI();  
      var deviceIndex = lib_common.getDeviceIndex(_mySerialDevice);
      if ( deviceIndex!= "")
      { 
            if (lib_ChangeIP.changeStaticIP(deviceIndex , ip)== lib_err.err_FUNC_SUCCESS) 
            {
                     if (lib_ChangeIP.verifyChangeIP(_mySerialDevice, ip))
                    {
                           if (lib_common.connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
                           lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);
                    }
                   
            }  
      }  else
                Log.Message(lib_messageLog.msg_DEVICE_NOTFOUND)
      
//      lib_common.terminateUI();
}
/*
  *@function 
*/
function TC_ChangeDHCP ()
{
	/* steps:
	1. launch IVS
	2. open change IP popup & change IP
	3. Close IVS
	*/

    var _mySerialDevice = lib_deviceInfo.const_Device_SerialNumber; 
//    if ( ! lib_validate.isDLCODERunning())
    lib_common.launchUI(); 
    
    var deviceIndex = lib_common.getDeviceIndex(_mySerialDevice);
    if ( deviceIndex!= "")
    {                  
              if (lib_ChangeIP.changeDHCP(deviceIndex) == lib_err.err_FUNC_SUCCESS)
              {
                   Log.Message(lib_err.err_FUNC_SUCCESS);
              } 
    }  else
              Log.Message(lib_messageLog.msg_DEVICE_NOTFOUND)
    
//    
    lib_common.terminateUI();
}

/*
  *@function 
*/
function TC_ChangeDefaultIP ()
{
	/* steps:
	1. launch IVS
	2. open change IP popup & change IP
	3. Close IVS
	*/

    var _mySerialDevice = lib_deviceInfo.const_Device_SerialNumber;   
    lib_common.launchUI();     
    var deviceIndex = lib_common.getDeviceIndex(_mySerialDevice);
    if ( deviceIndex!= "")
    {     
              if(lib_ChangeIP.changeDefaultIP(deviceIndex)== lib_err.err_FUNC_SUCCESS)    
              {
                   Log.Message(lib_err.err_FUNC_SUCCESS);
              }
    }  else
              Log.Message(lib_messageLog.msg_DEVICE_NOTFOUND)
       
          
//    lib_common.terminateUI();
}