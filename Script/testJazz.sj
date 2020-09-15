//USEUNIT lib_common
//USEUNIT lib_deviceInfo
//USEUNIT lib_validate

function testJazz()
{   
   
        if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI();  
        var ip = lib_deviceInfo.const_Device_IP_Adress;    
        lib_common.connectToDevice(ip);
        lib_common.terminateUI();
 
}

