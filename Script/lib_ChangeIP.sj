//USEUNIT lib_common
//USEUNIT lib_deviceInfo

 
//update 1.5.0 a5 : UI add new MAC Address
/*
  *@function
  *@param getIP{String}
*/
function getIP (mySerialNumber)
{
          try {
              var ipAdress = "" ;  // 
                      if (lib_validate.isDLCODERunning() == false)
                            return ipAdress;    
              if ( !lib_validate.isGettingStartedScreen())
              {
                    lib_common.gettingStarted();
              } 
              //verify that the device is working else waiting in 5 minutes
              var time =0 ;
              while (lib_common.getDeviceIndex(mySerialNumber) == 0)
              {    
                  Delay(lib_const.const_timeOut);                     
                  time = time + 1;
                  Sys.Process("DL.CODE").Refresh();
                  if (time == lib_const.const_time_timeOut)
                  {
                         Log.Warning(lib_err.msg_ERR_CONNECTTODEVICE_TIMEOUT + ":" +  time*lib_const.const_timeOut + " milliseconds");
                         return ipAdress;
                  }
              }
                  
              if (  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WaitWPFObject("OnlineDevicesAccordionItem", lib_const.const_delay_1000).Exists)
              {                    
                    var onlineDevicesAccordionItem = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WPFObject("OnlineDevicesAccordionItem");
                    if (onlineDevicesAccordionItem.WaitWPFObject("DeviceTreeView", "", lib_const.const_timeOut).Exists  )
                    {
                            var onlineDeviceTree = onlineDevicesAccordionItem.WPFObject("DeviceTreeView", "", 1);
                            //get .WPFObject of TreeView
                            while (onlineDeviceTree.ChildCount == 1 )
                            {     
                                  Delay(lib_const.const_delay_4000);
                                  Sys.Process("DL.CODE").Refresh();    
                            }  
                            if  (onlineDeviceTree.ChildCount > 1 )
                            { 
                                    //In TreeView Online Device, there is 1 item - last index - AdornerLayer - is not a TreeListItem of Device
                                    for (var i = 1; i < onlineDeviceTree.ChildCount ; i++)
                                    {
                                             //current device has index i
                                            var currentDevice = onlineDeviceTree.WPFObject("TreeViewItem", "", i);
                                            //get serial number of current device
                                            var serialNumber = currentDevice.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("StackPanel", "", 2).WPFObject("TextBlock", "*", 3).get_Text();
                                            //compare current device with my device
                                            if ( serialNumber.ToString() == mySerialNumber)   
                                            {           
                                                          ipAdress =  currentDevice.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
                                                          ipAdress =  aqString.Trim(ipAdress, aqString.stAll);
                                                          return ipAdress;
                                            }   
                                    }                                 
                            }  
                    }  
              }
            return ipAdress; 
          }catch (e)
          { 
               Log["Message"](lib_err.err_FUNC_EXCEPTION);        
          }
         
}
 
/*
  *@function change to DHCP ip 
  *@param myDeviceIndex{String}
*/
function changeDHCP (myDeviceIndex)
{
        var flag= lib_err.err_FUNC_FAILED; 
        if ( !lib_validate.isGettingStartedScreen())
        {
              lib_common.gettingStarted();
        }
        //  get path to OnlineDeviceTree
        var onlineDeviceTree = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WPFObject("OnlineDevicesAccordionItem").WPFObject("DeviceTreeView", "", 1);

         //openChangeIPWindow by click on button
        onlineDeviceTree.WPFObject("TreeViewItem", "", myDeviceIndex).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).Click();   
        delay (lib_const.const_delay_3000);
                            
        // wait EthernetSettingsConfigurationPopup
        if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration, lib_const.const_delay_2000).Exists)
        {
                               
                var pathDHCP = Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration, 1);
                var dhcpCheckBox = pathDHCP.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("dhcpCheckBox");
                                           
                var isChecked = dhcpCheckBox.get_IsChecked();
                Log["Message"]("dhcpCheckBox is checked:" + isChecked , isChecked);
   
                // IP is using static IP
                if (isChecked == true)
                {          
                        dhcpCheckBox.ClickButton(cbUnchecked);     
                        dhcpCheckBox.ClickButton(cbChecked);
                }
                 //change to  dynamic IP
                if (isChecked == false)
                {
                        dhcpCheckBox.ClickButton(cbChecked);
                }      
                if (Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "*", 1).Visible == true)
                        Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "*", 1).ClickButton();
                   
                //get popup restart device
                while (!Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window",lib_const.const_delay_3000).Exists ) 
                { 
                        lib_const.const_delay_5000;
                }
                if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", lib_const.const_delay_1000 ).Exists ) 
                {                      
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, lib_label.lb_DeviceIsRestarting);
                        Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();                     
                        flag= lib_err.err_FUNC_SUCCESS;
                        delay (lib_const.const_delay_5000);
                }     
         }  
         return flag;
}


 
/*
  *@function change to static ip
  *@param myDeviceIndex{String}
  *@param newIP{String}
*/
function changeStaticIP (myDeviceIndex,newIP)
{
       
        var flag= lib_err.err_FUNC_FAILED;
        if ( !lib_validate.isGettingStartedScreen())
        {
              lib_common.gettingStarted();
        }
        //  get path to OnlineDeviceTree
        var onlineDeviceTree = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware , 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WPFObject("OnlineDevicesAccordionItem").WPFObject("DeviceTreeView", "", 1);
        while (!onlineDeviceTree.WaitWPFObject("TreeViewItem", "", myDeviceIndex, lib_const.const_delay_1000).Exists)
        {  
                delay (lib_const.const_delay_3000);
        }  
         //openChangeIPWindow by click on button
        onlineDeviceTree.WPFObject("TreeViewItem", "", myDeviceIndex).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).Click();
        delay (lib_const.const_delay_3000);        
   
        // wait EthernetSettingsConfigurationPopup       
            
        if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration, lib_const.const_delay_2000).Exists)
        {
                var pathDHCP = Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration, 1);
                var dhcpCheckBox = pathDHCP.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("dhcpCheckBox");
                var isChecked = dhcpCheckBox.IsChecked; 
                if (isChecked == true)
                {    
                        // IP is using dynamic IP , then change to static IP
                        dhcpCheckBox.ClickButton(cbUnchecked);            
                }
             
                var ipPath = Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "*", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("IpAddress");
                             
                //focus on ipAddress
                dhcpCheckBox.Keys("[Tab]");              
                var oldIp = Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration, 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("IpAddress").get_IpAddress ;//= "192.168.1.140";
                Log.Message("oldIp: " + oldIp);  
                Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration, 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("IpAddress").set_IpAddress (newIP);
                //add new Getway default
                Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", "Device Environment Configuration").WPFObject("EthernetSettingsConfigurationPopup", "Device Environment Configuration", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("GatewayAddress").set_IpAddress (const_Gateway_Default);
                Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", "Device Environment Configuration").WPFObject("EthernetSettingsConfigurationPopup", "Device Environment Configuration", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("GatewayAddress").Enter();
                Log.Message("newIp: " +Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration, 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("IpAddress").get_IpAddress );
                if(oldIp == newIP)
                {
                      Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", "Device Environment Configuration").WPFObject("EthernetSettingsConfigurationPopup", "Device Environment Configuration", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
                      return flag;
                }     
                //tab to OK button visible
                Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration, 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("IpAddress").Keys("[Tab]");
                if (Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "*", 1).Visible == true)
                        Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "*", 1).ClickButton();
                   
                //get popup restart device
                while (!Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window",lib_const.const_delay_3000).Exists ) 
                { 
                        delay (lib_const.const_delay_5000);
                }
                if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", lib_const.const_delay_1000 ).Exists ) 
                {                      
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, lib_label.lb_DeviceIsRestarting);
                        Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();
                        flag= lib_err.err_FUNC_SUCCESS;
                        while (findDeviceInGettingStarted()== false)
                              delay (3000);
                }
         }
         return flag;  
}

/*
  *@function change to 192.168.3.100
  *@param myDeviceIndex{String} 
*/
function changeDefaultIP (myDeviceIndex )
{
          var flag= lib_err.err_FUNC_FAILED;
          if ( !lib_validate.isGettingStartedScreen())
          {
                lib_common.gettingStarted();
          }
          if (Sys.Process("DL.CODE").Exists == false)
          {
                Log.Error(lib_err.err_DLCODE_RUNNING);
          }
          //  get path to OnlineDeviceTree
          var onlineDeviceTree = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WPFObject("OnlineDevicesAccordionItem").WPFObject("DeviceTreeView", "", 1);
         
           //openChangeIPWindow by click on button
          onlineDeviceTree.WPFObject("TreeViewItem", "", myDeviceIndex).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).Click();
          delay (lib_const.const_delay_3000);
          // wait EthernetSettingsConfigurationPopup
          if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration, lib_const.const_delay_2000).Exists)
          {
                var pathDHCP = Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration, 1);
                var dhcpCheckBox = pathDHCP.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("dhcpCheckBox");
                var isChecked = dhcpCheckBox.IsChecked; 
                if (isChecked == true)
                      dhcpCheckBox.ClickButton(cbUnchecked);
                else
                {           
                        dhcpCheckBox.ClickButton(cbChecked);           
                        dhcpCheckBox.ClickButton(cbUnchecked);
                }
                if (Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "*", 1).Visible == true)
                        Sys.Process("DL.CODE").WPFObject("HwndSource: EthernetSettingsConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration).WPFObject("EthernetSettingsConfigurationPopup", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "*", 1).ClickButton();
                   
                //get popup restart device
                while (!Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window",lib_const.const_delay_3000).Exists ) 
                { 
                        delay (lib_const.const_delay_5000);
                }
                if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", lib_const.const_delay_1000 ).Exists ) 
                {                      
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, lib_label.lb_DeviceIsRestarting);
                        Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();
                        flag= lib_err.err_FUNC_SUCCESS;
                        delay (lib_const.const_delay_5000);
                }
          }
          return flag;    
}

/*
  *@function
  *@param serialNumber{String}
  *@param ipExpected{String}
*/
function verifyChangeIP (serialNumber, ipExpected)
{
      var flag = true;
      var ip = lib_ChangeIP.getIP(serialNumber);
      if (ip != "" )
      {
              //verify ip default   
              if (ip != ipExpected )
              {
                      flag =   false    ;  
                      Log.Warning(lib_messageLog.msg_IP_NOT_EXPECTED);
              } 
      }
      Log.Message("verifyChangeIP:" + flag);
      return flag;
}


/*
  *@function random value ip from 180 - 190 
*/
function randomIP ()
{
        var x =  Math.floor((Math.random() * 10) + 1)+180;
        x = "10.84.30." + x;
        return x;
}