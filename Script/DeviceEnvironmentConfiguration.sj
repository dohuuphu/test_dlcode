//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo
//USEUNIT lib_UserRole
//USEUNIT lib_validate

/* 
		*update 1.5.0a5
		*@function: validate menu bar NOTCONNECT_DEVICE & CONNECT_DEVICE 
*/

function deviceEnvironmentConfiguration ()
{
aqTestCase.Begin("deviceEnvironmentConfiguration");
   if ( ! lib_validate.isDLCODERunning())
       lib_common.launchUI();  
//   try
//   {
         
           var _mySerialDevice =lib_deviceInfo.const_Device_SerialNumber;
           var ip = lib_deviceInfo.const_Device_IP_Adress;
         
           if (lib_UserRole.getUserRoleCurrent() != lib_label.const_lb_InstallerExpert)
              changeUserRole(lib_label.const_lb_InstallerExpert , false);  
           //*************************************************************************************************************************
            while ( !isGettingStartedScreen())
           {
              gettingStarted();
              Sys.Process("DL.CODE").Refresh(); 
           }           
                    
           if (lib_common.connectToDevice(ip))
           {   
               //*************************************************************************************************************************
               //Step: CONNECT_DEVICE
               var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
               IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click();                 
               IvsMenu.WPFMenu.Click(lib_label.const_lb_Device + "|" +  lib_label.const_lb_Settings  + "|" +  lib_label.const_lb_Settings);
               
               var path =Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration ).WPFObject("DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration , 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1);
               aqObject.CheckProperty(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.const_lb_DeviceName , 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", lib_label.const_lb_StartupConfiguration, 1), "Enabled", cmpEqual, true); 
               
               aqObject.CheckProperty(path.WPFObject("ContentExpander", lib_label.const_lb_AboutDevice, 1).WPFObject("TextBlock", lib_label.const_lb_AboutDevice, 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("ContentExpander", lib_label.const_lb_EthernetSettings, 2).WPFObject("TextBlock", lib_label.const_lb_EthernetSettings, 1), "Enabled", cmpEqual, true);
               //M120 doesnt have Internal Nertwork
               if (lib_deviceInfo.const_Device_Model != lib_const.const_M120)
               {
                  aqObject.CheckProperty(path.WPFObject("ContentExpander", "", 3).WPFObject("TextBlock", "", 1).WPFObject("InlineUIContainer", "", 1).WPFObject("TextBlock", "", 1), "WPFControlText" , cmpEqual, lib_label.const_lb_InternalNetworkSettings);
               }
               aqObject.CheckProperty(path.WPFObject("ContentExpander", lib_label.const_lb_XPRESSConfiguration, 4).WPFObject("TextBlock", lib_label.const_lb_XPRESSConfiguration, 1), "Enabled", cmpEqual, true);
               
//               if ( lib_deviceInfo.const_Device_Model == lib_const.const_M300 && lib_deviceInfo.const_Device_ModelM300_472_011 == lib_const.const_M300_472_011)
//               {
//                   aqObject.CheckProperty(path.WPFObject("ContentExpander", lib_label.const_lb_PacktrackCalibration, 5).WPFObject("TextBlock", lib_label.const_lb_PacktrackCalibration, 1), "Enabled", cmpEqual, true);                   
//               }
//               if ( lib_deviceInfo.const_Device_Model == lib_const.const_M410)
//               {
//                   aqObject.CheckProperty(path.WPFObject("ContentExpander", lib_label.const_lb_PacktrackCalibration, 5).WPFObject("TextBlock", lib_label.const_lb_PacktrackCalibration, 1), "Enabled", cmpEqual, true);                   
//               }
               aqObject.CheckProperty(path.WPFObject("ContentExpander", lib_label.const_lb_LEDConfiguration, 6).WPFObject("TextBlock", lib_label.const_lb_LEDConfiguration, 1), "Enabled", cmpEqual, true);                   
               aqObject.CheckProperty(path.WPFObject("ContentExpander", "", 7).WPFObject("TextBlock", "", 1).WPFObject("InlineUIContainer", "", 1).WPFObject("TextBlock", "", 1),"WPFControlText" , cmpEqual, lib_label.const_lb_MaintenanceSettings);
               var contentExpander = Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration  ).WPFObject("DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration , 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1);
               
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).isExpanded == true)
               {
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_DeviceModel+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_ApplicationSWVersion+"", 1), "Enabled", cmpEqual, true);
                   //add new 1.5.0 
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("TextBlock", ""+ lib_label.lb_ConfigurationSchemaRelease+"", 1), "Enabled", cmpEqual, true);
                   //end
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3 +1).WPFObject("TextBlock", ""+ lib_label.const_lb_BootSWVersion+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4+1).WPFObject("TextBlock", ""+ lib_label.const_lb_LoaderSWVersion+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5+1).WPFObject("TextBlock", ""+ lib_label.const_lb_RecoverySWVersion+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 6+1).WPFObject("TextBlock", ""+ lib_label.const_lb_VLVersion+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 7+1).WPFObject("TextBlock", ""+ lib_label.const_lb_MVLVersion+"", 1), "Enabled", cmpEqual, true);
                     
              
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).isExpanded == true)
               {
                   
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_MACAddress+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_UseDHCP+"", 1), "Enabled", cmpEqual, true);        
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("CheckBox", "", 1).IsChecked == false)
                   {
                    /* 1.8.0 changed interface -- linhtnguyen comment              
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_IPAddress+"", 2), "Enabled", cmpEqual, true);
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_SubnetMask+"", 2), "Enabled", cmpEqual, true);
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_GatewayAddress+"", 2), "Enabled", cmpEqual, true);
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_DNS1Address+"", 2), "Enabled", cmpEqual, true);
                   */
                   
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("TextBlock", ""+ lib_label.const_lb_IPAddress+"", 1), "Enabled", cmpEqual, true);
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_SubnetMask+"", 2), "Enabled", cmpEqual, true);
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4).WPFObject("TextBlock", ""+ lib_label.const_lb_GatewayAddress+"", 1), "Enabled", cmpEqual, true);
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_DNS1Address+"", 2), "Enabled", cmpEqual, true);
                   
                   }                     
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_KeepAliveTimeout+"", 2), "Enabled", cmpEqual, true);
              
               }
               //M120 doesnt have Internal Nertwork
               if (lib_deviceInfo.const_Device_Model != lib_const.const_M120)
               {
                    if (contentExpander.WPFObject("ContentExpander", "", 3).isExpanded == false)
                     {
                          contentExpander.WPFObject("ContentExpander", "", 3).set_IsExpanded(true);
                     }
                     if (contentExpander.WPFObject("ContentExpander", "", 3).isExpanded == true)
                     {
                          //verify label
                          if (contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1).wText ==   "[1, "   + lib_label.const_lb_Master +   "]")
                          {
                          
                                var cbbRole = contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1);
                                cbbRole.ClickItem (1) ;
                               
                          }//add new 1.5.0a5
                          if (contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1).wText == "[2, Slave]")
                                                                          
                          {
                                aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_ReadingPointAddress+"", 2), "Enabled", cmpEqual, true);
                                aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_InternalNetworkRole+"", 2), "Enabled", cmpEqual, true);
                          
                                aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_MasterDeviceType+"", 2), "Enabled", cmpEqual, true);
//                                Log.Warning("chua add item cho MAster device type with role = Slave");
                                var cbbMasterDeviceType = contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1) 
                                cbbMasterDeviceType.DropDown();  
                                aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_MatrixDevice+"", 1), "Enabled", cmpEqual, true);
                                aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_ControllerSC4000+"", 1), "Enabled", cmpEqual, true);
                                                                                               
                          }
                          aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_InternalNetworkBaudRate+"", 2), "Enabled", cmpEqual, true);
                          //verify cbb Role
                          var comboBoxRole = contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1);
                          comboBoxRole.DropDown();  
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_Master+"", 1), "Enabled", cmpEqual, true);
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_Slave+"", 1), "Enabled", cmpEqual, true);
                          //verify cbb Baurate                    
                          var comboBaurate = contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 
                          comboBaurate.DropDown();  
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_19200+"", 1), "Enabled", cmpEqual, true);
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_38400+"", 1), "Enabled", cmpEqual, true);
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 3).WPFObject("TextBlock", ""+ lib_label.const_lb_57600+"", 1), "Enabled", cmpEqual, true);
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 4).WPFObject("TextBlock", ""+ lib_label.const_lb_125Kb+"", 1), "Enabled", cmpEqual, true);
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 5).WPFObject("TextBlock", ""+ lib_label.const_lb_250Kb+"", 1), "Enabled", cmpEqual, true);
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 6).WPFObject("TextBlock", ""+ lib_label.const_lb_500Kb+"", 1), "Enabled", cmpEqual, true);
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 7).WPFObject("TextBlock", ""+ lib_label.const_lb_1Mb+"", 1), "Enabled", cmpEqual, true);              
                     }
               }
               
               
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_XPRESSConfiguration+"", 4).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_XPRESSConfiguration+"", 4).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_XPRESSConfiguration+"", 4).isExpanded == true)
               {
                   //verify label
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_ConfigurationStatus+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_X_PRESSFunction1+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_X_PRESSFunction2+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_X_PRESSFunction3+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_X_PRESSFunction4+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_NumberOfSamples+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 7).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_TestTimeout+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 8).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_AimTimeout+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 9).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_SavingOptions+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 10).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_ConfigurationName+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 11).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_AutolearnTimeout+"", 2), "Enabled", cmpEqual, true);
                   //verify default
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[1, Test Mode]");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[2, AIM Mode]");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[3, Auto Setup]");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[4, Code Autolearning]");
                                                                                                                                         
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1),"Text", cmpEqual, "20");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 7).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1),"Text", cmpEqual, "180");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 8).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1),"Text", cmpEqual, "180");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 11).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1),"Text", cmpEqual, "180");
                   
                   //verify cbb                   
                    var comboSavingOptions = contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 9).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 
                    comboSavingOptions.DropDown();  
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_Temporary+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_Permanent+"", 1), "Enabled", cmpEqual, true);
                    
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 10).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_ConfigurationName+"", 2), "Enabled", cmpEqual, true);
                    var txtSavingOptions = contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 9).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1).wText;
                    if (txtSavingOptions == "[1, Permanent]")
                          aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 10).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_ConfigurationName+"", 2), "Visible", cmpEqual, true);
                    else
                          aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 10).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_ConfigurationName+"", 2), "Visible", cmpEqual, false);
             
               } 
               
//               if ( lib_deviceInfo.const_Device_Model == lib_const.const_M300 && lib_deviceInfo.const_Device_ModelM300_472_011 == lib_const.const_M300_472_011)
//               {
//                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_PacktrackCalibration+"", 5).isExpanded == false)
//                   {
//                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_PacktrackCalibration+"", 5).Click();
//                   }
//                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_PacktrackCalibration+"", 5).isExpanded == true)
//                   {
//                        Log["Warning"]("Can not spy object");            
//              
//                   }                   
//               }

              if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_LEDConfiguration+"", 6).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_LEDConfiguration+"", 6).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_LEDConfiguration+"", 6).isExpanded == true)
               {
               
                   var beeper = Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", "Device Environment Configuration").WPFObject("DeviceEnvironmentConfigurationPopup", "Device Environment Configuration", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "LED Configuration", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("CheckBox", "", 1);
                   if (beeper.IsChecked == false)
                        beeper.set_IsChecked(true);
                    //verify label
                   if (lib_deviceInfo.const_Device_Model != lib_const.const_M120)
                   {
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_SelectCOMLEDFunction+"", 2), "Enabled", cmpEqual, true);
                         //verify cbb                   
                        var comboCOMLED = contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 
                        comboCOMLED.DropDown();  
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_MainSerialPortRX+"", 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_MainSerialPortTX+"", 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[1, "+ lib_label.const_lb_MainSerialPortTX+"]");
                    
                   }
                    //verify label
//                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_SelectCOMLEDFunction+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_EnableBeeperStatus+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_EnableBeeperActiveEvents+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_BeeperDeactivationTimeout+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_LEDsDeactivationTimeout+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_FocusingPointerStatus+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 8).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_MultipleReadTreatedAs+"", 2), "Enabled", cmpEqual, true);
                   
                  
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_GoodRead_Success_CodeMatch+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_GoodRead_Success_CodeMatch+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_MultipleRead+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_MultipleRead+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 3).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_NoRead_Failure_NoMatch+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_NoRead_Failure_NoMatch+"", 1), "Enabled", cmpEqual, true);
                    
                    
                    var comboFocusingPointerStatus = contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 1
                    comboFocusingPointerStatus.DropDown();  
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_Disabled+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_AlwaysOn+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 3).WPFObject("TextBlock", ""+ lib_label.const_lb_CalibrationOnly+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[2, "+ lib_label.const_lb_CalibrationOnly+"]");
                    
                    var comboMultipleReadTreatedAs = contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 8).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 
                    comboMultipleReadTreatedAs.DropDown();  
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_NoRead+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_CompleteRead+"", 1), "Enabled", cmpEqual, true);                   
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 8).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[1, "+ lib_label.const_lb_CompleteRead+"]");
                  
                    if (contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("CheckBox", "", 1).IsChecked == true)
                    {                    
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_GoodRead_Success_CodeMatch+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_GoodRead_Success_CodeMatch+"", 1), "Visible", cmpEqual, true);
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_MultipleRead+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_MultipleRead+"", 1), "Visible", cmpEqual, true);
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 3).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_NoRead_Failure_NoMatch+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_NoRead_Failure_NoMatch+"", 1), "Visible", cmpEqual, true);
                    
                    
                    }else
                    {
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_GoodRead_Success_CodeMatch+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_GoodRead_Success_CodeMatch+"", 1), "Visible", cmpEqual, false);
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_MultipleRead+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_MultipleRead+"", 1), "Visible", cmpEqual, false);
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 3).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_NoRead_Failure_NoMatch+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_NoRead_Failure_NoMatch+"", 1), "Visible", cmpEqual, false);
                    
                    }
                 
               }                
               if (contentExpander.WPFObject("ContentExpander", "", 7).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", "", 7).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", "", 7).isExpanded == true)
               {
                   //There are many different things between M120 and others
                   
                   var existPPIfucntion = existsPPI(lib_deviceInfo.const_Device_Model, const_Device_SerialNumber);
                   if (existPPIfucntion == true) 
                   {
                         Log.Message("POP_052");
                         aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_PPI+"", 2), "Enabled", cmpEqual, true);  
                   }
                   if (lib_deviceInfo.const_Device_Model == lib_const.const_M120)
                   {
                          aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_CurrentIlluminatorModel+"", 1), "Enabled", cmpEqual, true);
                          aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_Keyboard_Layout+"", 2), "Enabled", cmpEqual, true);
                   }else
                   {
                         aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_CurrentIlluminatorModel+"", 1), "Enabled", cmpEqual, true);      
                                     
                         aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_EnableBM100Detection+"", 2), "Enabled", cmpEqual, true);
//                         aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_BM150DisplayLayout+"", 2), "Enabled", cmpEqual, true);
                         aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_BM150DisplayLayout+"", 2), "Enabled", cmpEqual, true);
                         var comboBoxBM150 = contentExpander.WPFObject("ContentExpander", "", 7).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1)
                         
                         lib_common.cbb_NonLogicalAdornerDecorator(comboBoxBM150, "Reading Mask / Device State");
                         lib_common.cbb_NonLogicalAdornerDecorator(comboBoxBM150, "Reading Mask Only");
                   }
                                                                                                        
              
               }
               
               Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration ).WPFObject("DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration , 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 1).ClickButton();    
               Delay(3000); 
                       
               //*************************************************************************************************************************
               //: CONNECTING_DEVICE
               Log.Message(lib_messageLog.msg_CONNECTING_DEVICE);                
               if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == false)
                   return ;
              
               
               IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click();                   
               IvsMenu.WPFMenu.Click(lib_label.const_lb_Device + "|" +  lib_label.const_lb_Settings  + "|" +  lib_label.const_lb_Settings);    
               //check maim menu                  
               // check content expander 
               aqObject.CheckProperty(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.const_lb_DeviceName , 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", lib_label.const_lb_StartupConfiguration, 1), "Enabled", cmpEqual, true); 
               
               aqObject.CheckProperty(path.WPFObject("ContentExpander", lib_label.const_lb_AboutDevice, 1).WPFObject("TextBlock", lib_label.const_lb_AboutDevice, 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("ContentExpander", lib_label.const_lb_EthernetSettings, 2).WPFObject("TextBlock", lib_label.const_lb_EthernetSettings, 1), "Enabled", cmpEqual, true);
               //M120 doesnt have Internal Nertwork
               if (lib_deviceInfo.const_Device_Model != lib_const.const_M120)
               {
                  aqObject.CheckProperty(path.WPFObject("ContentExpander", "", 3).WPFObject("TextBlock", "", 1).WPFObject("InlineUIContainer", "", 1).WPFObject("TextBlock", "", 1), "WPFControlText" , cmpEqual, lib_label.const_lb_InternalNetworkSettings);
               }
               aqObject.CheckProperty(path.WPFObject("ContentExpander", lib_label.const_lb_XPRESSConfiguration, 4).WPFObject("TextBlock", lib_label.const_lb_XPRESSConfiguration, 1), "Enabled", cmpEqual, true);
               
//               if ( lib_deviceInfo.const_Device_Model == lib_const.const_M300 && lib_deviceInfo.const_Device_ModelM300_472_011 == lib_const.const_M300_472_011)
//               {
//                   aqObject.CheckProperty(path.WPFObject("ContentExpander", lib_label.const_lb_PacktrackCalibration, 5).WPFObject("TextBlock", lib_label.const_lb_PacktrackCalibration, 1), "Enabled", cmpEqual, true);                   
//               }
//               if ( lib_deviceInfo.const_Device_Model == lib_const.const_M410)
//               {
//                   aqObject.CheckProperty(path.WPFObject("ContentExpander", lib_label.const_lb_PacktrackCalibration, 5).WPFObject("TextBlock", lib_label.const_lb_PacktrackCalibration, 1), "Enabled", cmpEqual, true);                   
//               }
               aqObject.CheckProperty(path.WPFObject("ContentExpander", lib_label.const_lb_LEDConfiguration, 6).WPFObject("TextBlock", lib_label.const_lb_LEDConfiguration, 1), "Enabled", cmpEqual, true);                   
               aqObject.CheckProperty(path.WPFObject("ContentExpander", "", 7).WPFObject("TextBlock", "", 1).WPFObject("InlineUIContainer", "", 1).WPFObject("TextBlock", "", 1),"WPFControlText" , cmpEqual, lib_label.const_lb_MaintenanceSettings);
//               var contentExpander = Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration  ).WPFObject("DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration , 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1);
               
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).isExpanded == true)
               {
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_DeviceModel+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_ApplicationSWVersion+"", 1), "Enabled", cmpEqual, true);
                    //add new 1.5.0 
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("TextBlock", ""+ lib_label.lb_ConfigurationSchemaRelease+"", 1), "Enabled", cmpEqual, true);
                   //end
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3 +1).WPFObject("TextBlock", ""+ lib_label.const_lb_BootSWVersion+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4 +1).WPFObject("TextBlock", ""+ lib_label.const_lb_LoaderSWVersion+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5+1).WPFObject("TextBlock", ""+ lib_label.const_lb_RecoverySWVersion+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 6+1).WPFObject("TextBlock", ""+ lib_label.const_lb_VLVersion+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 7+1).WPFObject("TextBlock", ""+ lib_label.const_lb_MVLVersion+"", 1), "Enabled", cmpEqual, true);
                     
              
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).isExpanded == true)
               {
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_MACAddress+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_UseDHCP+"", 1), "Enabled", cmpEqual, true);          
                   
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("CheckBox", "", 1).IsChecked == false)
                   {
                     /* linhtnguyen comment  
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_IPAddress+"", 2), "Enabled", cmpEqual, true);
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_SubnetMask+"", 2), "Enabled", cmpEqual, true);
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_GatewayAddress+"", 2), "Enabled", cmpEqual, true);
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_DNS1Address+"", 2), "Enabled", cmpEqual, true);
                     */      
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("TextBlock", ""+ lib_label.const_lb_IPAddress+"", 1), "Enabled", cmpEqual, true);
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_SubnetMask+"", 2), "Enabled", cmpEqual, true);
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4).WPFObject("TextBlock", ""+ lib_label.const_lb_GatewayAddress+"", 1), "Enabled", cmpEqual, true);
                           aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_DNS1Address+"", 2), "Enabled", cmpEqual, true);                       
                           
                   }  
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_KeepAliveTimeout+"", 2), "Enabled", cmpEqual, true);
                   // aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_KeepAliveTimeout+"", 2), "Enabled", cmpEqual, true);
              
               }
               //M120 doesnt have Internal Nertwork
               if (lib_deviceInfo.const_Device_Model != lib_const.const_M120)
               {
                   if (contentExpander.WPFObject("ContentExpander", "", 3).isExpanded == false)
                   {
                        contentExpander.WPFObject("ContentExpander", "", 3).set_IsExpanded(true);
                   }
                   if (contentExpander.WPFObject("ContentExpander", "", 3).isExpanded == true)
                   {
                        //verify label
                       //verify label
                          if (contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1).wText ==   "[1, "   + lib_label.const_lb_Master +   "]")
                          {
                          
                                var cbbRole = contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1);
                                cbbRole.ClickItem (1) ;
                               
                          }//add new 1.5.0a5
                          if (contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1).wText == "[2, Slave]")
                                                                          
                          {
                                aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_ReadingPointAddress+"", 2), "Enabled", cmpEqual, true);
                                aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_InternalNetworkRole+"", 2), "Enabled", cmpEqual, true);
                          
                                aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_MasterDeviceType+"", 2), "Enabled", cmpEqual, true);
//                                Log.Warning("chua add item cho MAster device type with role = Slave");
                                var cbbMasterDeviceType = contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1) 
                                cbbMasterDeviceType.DropDown();  
                                aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_MatrixDevice+"", 1), "Enabled", cmpEqual, true);
                                aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_ControllerSC4000+"", 1), "Enabled", cmpEqual, true);
                                                                                               
                          }
                          aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_InternalNetworkBaudRate+"", 2), "Enabled", cmpEqual, true);
                         //verify cbb Role
                        var comboBoxRole = contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1);
                        comboBoxRole.DropDown();  
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_Master+"", 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_Slave+"", 1), "Enabled", cmpEqual, true);
                        //verify cbb Baurate                    
                        var comboBaurate = contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 
                        comboBaurate.DropDown();  
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_19200+"", 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_38400+"", 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 3).WPFObject("TextBlock", ""+ lib_label.const_lb_57600+"", 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 4).WPFObject("TextBlock", ""+ lib_label.const_lb_125Kb+"", 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 5).WPFObject("TextBlock", ""+ lib_label.const_lb_250Kb+"", 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 6).WPFObject("TextBlock", ""+ lib_label.const_lb_500Kb+"", 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 7).WPFObject("TextBlock", ""+ lib_label.const_lb_1Mb+"", 1), "Enabled", cmpEqual, true);              
                   }
               }
               
               
               
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_XPRESSConfiguration+"", 4).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_XPRESSConfiguration+"", 4).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_XPRESSConfiguration+"", 4).isExpanded == true)
               {
                   //verify label
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_ConfigurationStatus+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_X_PRESSFunction1+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_X_PRESSFunction2+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_X_PRESSFunction3+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_X_PRESSFunction4+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_NumberOfSamples+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 7).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_TestTimeout+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 8).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_AimTimeout+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 9).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_SavingOptions+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 10).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_ConfigurationName+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 11).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_AutolearnTimeout+"", 2), "Enabled", cmpEqual, true);
                   //verify default
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[1, Test Mode]");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[2, AIM Mode]");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[3, Auto Setup]");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[4, Code Autolearning]");
                                                                                                                                         
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1),"Text", cmpEqual, "20");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 7).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1),"Text", cmpEqual, "180");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 8).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1),"Text", cmpEqual, "180");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 11).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1),"Text", cmpEqual, "180");
                   
                   //verify cbb                   
                    var comboSavingOptions = contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 9).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 
                    comboSavingOptions.DropDown();  
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_Temporary+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_Permanent+"", 1), "Enabled", cmpEqual, true);
                    
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 10).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_ConfigurationName+"", 2), "Enabled", cmpEqual, true);
                    var txtSavingOptions = contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 9).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1).wText;
                    if (txtSavingOptions == "[1, Permanent]")
                          aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 10).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_ConfigurationName+"", 2), "Visible", cmpEqual, true);
                    else
                          aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_XPRESSConfiguration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 10).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_ConfigurationName+"", 2), "Visible", cmpEqual, false);
             
               } 
               
//               if ( lib_deviceInfo.const_Device_Model == lib_const.const_M300 && lib_deviceInfo.const_Device_ModelM300_472_011 == lib_const.const_M300_472_011)
//               {
//                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_PacktrackCalibration+"", 5).isExpanded == false)
//                   {
//                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_PacktrackCalibration+"", 5).Click();
//                   }
//                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_PacktrackCalibration+"", 5).isExpanded == true)
//                   {
//                        Log["Warning"]("Can not spy object");            
//              
//                   }                   
//               }

              if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_LEDConfiguration+"", 6).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_LEDConfiguration+"", 6).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_LEDConfiguration+"", 6).isExpanded == true)
               {
                   var beeper = Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", "Device Environment Configuration").WPFObject("DeviceEnvironmentConfigurationPopup", "Device Environment Configuration", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "LED Configuration", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("CheckBox", "", 1);
                   if (beeper.IsChecked == false)
                        beeper.set_IsChecked(true);
                    //verify label
                   if (lib_deviceInfo.const_Device_Model != lib_const.const_M120)
                   {
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_SelectCOMLEDFunction+"", 2), "Enabled", cmpEqual, true);
                         //verify cbb                   
                        var comboCOMLED = contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 
                        comboCOMLED.DropDown();  
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_MainSerialPortRX+"", 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_MainSerialPortTX+"", 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[1, "+ lib_label.const_lb_MainSerialPortTX+"]");
                   
                   }
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_EnableBeeperStatus+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_EnableBeeperActiveEvents+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_BeeperDeactivationTimeout+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_LEDsDeactivationTimeout+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_FocusingPointerStatus+"", 2), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 8).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_MultipleReadTreatedAs+"", 2), "Enabled", cmpEqual, true);
                   
                   
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_GoodRead_Success_CodeMatch+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_GoodRead_Success_CodeMatch+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_MultipleRead+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_MultipleRead+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 3).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_NoRead_Failure_NoMatch+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_NoRead_Failure_NoMatch+"", 1), "Enabled", cmpEqual, true);
                    
                    
                    var comboFocusingPointerStatus = contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 1
                    comboFocusingPointerStatus.DropDown();  
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_Disabled+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_AlwaysOn+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 3).WPFObject("TextBlock", ""+ lib_label.const_lb_CalibrationOnly+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[2, "+ lib_label.const_lb_CalibrationOnly+"]");
                    
                    var comboMultipleReadTreatedAs = contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 8).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 
                    comboMultipleReadTreatedAs.DropDown();  
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_NoRead+"", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_CompleteRead+"", 1), "Enabled", cmpEqual, true);                   
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 8).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[1, "+ lib_label.const_lb_CompleteRead+"]");
                  
                    if (contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("CheckBox", "", 1).IsChecked == true)
                    {                    
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_GoodRead_Success_CodeMatch+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_GoodRead_Success_CodeMatch+"", 1), "Visible", cmpEqual, true);
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_MultipleRead+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_MultipleRead+"", 1), "Visible", cmpEqual, true);
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 3).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_NoRead_Failure_NoMatch+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_NoRead_Failure_NoMatch+"", 1), "Visible", cmpEqual, true);
                    
                    
                    }else
                    {
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_GoodRead_Success_CodeMatch+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_GoodRead_Success_CodeMatch+"", 1), "Visible", cmpEqual, false);
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_MultipleRead+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_MultipleRead+"", 1), "Visible", cmpEqual, false);
                        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  ""+ lib_label.const_lb_LEDConfiguration+"" , 6).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 3).WPFObject("Grid", "", 1).WPFObject("CheckBox", ""+lib_label.const_lb_NoRead_Failure_NoMatch+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_NoRead_Failure_NoMatch+"", 1), "Visible", cmpEqual, false);
                    
                    }
                 
               }                
               if (contentExpander.WPFObject("ContentExpander", "", 7).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", "", 7).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", "", 7).isExpanded == true)
               { 
                   //There are many different things between M120 and others
                   if (lib_deviceInfo.const_Device_Model == lib_const.const_M120) // M120
                   { 
                          aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_CurrentIlluminatorModel+"", 1), "Enabled", cmpEqual, true);
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", "Device Environment Configuration").WPFObject("DeviceEnvironmentConfigurationPopup", "Device Environment Configuration", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "", 7).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "PPI", 2), "Enabled", cmpEqual, true);
                          aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_Keyboard_Layout+"", 2), "Enabled", cmpEqual, true);
                   }else //M210 220 300 410 450
                   {
                         aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_CurrentIlluminatorModel+"", 1), "Enabled", cmpEqual, true);
                         aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_EnableBM100Detection+"", 2), "Enabled", cmpEqual, true);
                         aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_BM150DisplayLayout+"", 2), "Enabled", cmpEqual, true);
//                         aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander",  "", 7).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_BM150DisplayLayout+"", 2), "Enabled", cmpEqual, true);
                   }
              
               }
               
               Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration ).WPFObject("DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration , 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 1).ClickButton();
        
           }
     
//   }
//   catch (e)
//   {
//     Log["Warning"](lib_err.err_FUNC_EXCEPTION);
//   }         
   //lib_common.terminateUI();     
   aqTestCase.End();
 }