//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_OpenJob
//USEUNIT lib_UserRole

/* 
Scenario
Step 1 : NOTCONNECT_DEVICE
-- validate menu bar
Step 2: CONNECT_DEVICE
-- validate menu bar
Step 3: MONITOR
-- validate menu bar
*/

function menubar_Device_Jazz()
{
  aqTestCase.Begin("MenuBar_Device");
  MenuBar_Device(false, lib_label.const_lb_InstallerExpert);
  aqTestCase.End();
}

function MenuBar_Device ( btFindDevices, userRole)// only for Installer Basic and Expert (not UserBasic)
{
   //US_68,US_69,US_70,US_71,US_72,US_73,US_74,US_75,US_78,US_79
//   if ( ! lib_validate.isDLCODERunning())
   lib_common.launchUI();  
   try
   {       
        
        var ip = lib_deviceInfo.const_Device_IP_Adress;
         //*************************************************************************************************************************
         //Step 1 : NOTCONNECT_DEVICE         
         Log["Message"](lib_messageLog.msg_NOTCONNECT_DEVICE);
         while ( !isGettingStartedScreen())
         {
               lib_common.gettingStarted();
              Sys.Process("DL.CODE").Refresh(); 
         }
         if (isGettingStartedScreen())
         {
              var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 
              IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click();
             
             delay (lib_const.const_delay_3000);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_ConnectToDevice +"", 1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_FindDevices +"", 2), "Enabled", cmpEqual, btFindDevices);              
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 3), "Enabled", cmpEqual, true);             
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_UpdatePackage+"", 4), "Enabled", cmpEqual, false);
              
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_MultiDevicePackageUpdate +"", 5), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_ChangeCurrentConfiguration +"", 6), "Enabled", cmpEqual, false);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RestartDevice +"", 7), "Enabled", cmpEqual, false);             
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_Backup_Restore+"", 8), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RAMImageBufferSettings +"", 9), "Enabled", cmpEqual, false);

             
         }
         //validate getting Started when connecting to device
         Log["Message"](lib_messageLog.msg_CONNECT_DEVICE);   
         if (lib_common.connectToDevice(ip)== lib_err.err_FUNC_SUCCESS )
         {    
      
           var role = lib_DeviceSelectedDetail.getDeviceRole();
           //*************************************************************************************************************************
           //Step 2: CONNECT_DEVICE
           Log["Message"](lib_messageLog.msg_CONNECT_DEVICE); 
           var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");             
           IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click();             
//             // check menu Device
           Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", "Connect to Device", 1)
           var path = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
           //1.8.0 enables 'Connect To Device' even though one device is already selected
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_ConnectToDevice +"", 1), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_FindDevices +"", 2), "Enabled", cmpEqual, btFindDevices);              
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 3), "Enabled", cmpEqual, true);             
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_UpdatePackage+"", 4), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_MultiDevicePackageUpdate +"", 5), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_ChangeCurrentConfiguration +"", 6), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_RestartDevice +"", 7), "Enabled", cmpEqual, true);             
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_Backup_Restore+"", 8), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_RAMImageBufferSettings +"", 9), "Enabled", cmpEqual, false);
           
          // lhoang add this to verify US_003
// Verify that Installer Basic only has three tasks enabled (Open Device Configuration, PackTrack Calibration, Monitor Device)
        if(userRole == lib_label.const_lb_InstallerBasic)
        {
          var arrPro = ["ClrClassName", "WPFControlText", "ChildCount"];
          var arrVal = ["TextBlock", "Monitor Device", 0];
          var temp = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
          var count = 10;
          var ListTaskItemObj;
          if(temp.Exists)
          {
            while(count > 0)
            {
              temp = temp.Parent;
              ListTaskItemObj = temp.FindChild("ClrClassName", "ItemsPresenter", 1000);
              if(ListTaskItemObj.Exists) break;
              delay(1000);
              count --;
            }
          }
          if(ListTaskItemObj.Exists)
          {
            var childCOunt = ListTaskItemObj.ChildCount;    
            var TaskButton;
            for(var index= 1; index <= 2; index++)
            {
              TaskButton = ListTaskItemObj.WPFObject("ListBoxItem", "", index).FindChild("ClrClassName", "RadioButton", 1000);
              aqObject.CheckProperty(TaskButton, "Enabled", cmpEqual, true);      
            }
            for(var index= 4; index <= childCOunt; index++)
            {
              TaskButton = ListTaskItemObj.WPFObject("ListBoxItem", "", index).FindChild("ClrClassName", "RadioButton", 1000);
              aqObject.CheckProperty(TaskButton, "Enabled", cmpEqual, true);      
            }
          }
          if(childCOunt > 4)
          {
            TaskButton = ListTaskItemObj.WPFObject("ListBoxItem", "", 3).FindChild("ClrClassName", "RadioButton", 1000);  
            aqObject.CheckProperty(TaskButton, "Enabled", cmpEqual, false); 
          }
          else
          {
            TaskButton = ListTaskItemObj.WPFObject("ListBoxItem", "", 3).FindChild("ClrClassName", "RadioButton", 1000);  
            aqObject.CheckProperty(TaskButton, "Enabled", cmpEqual, true); 
          }
          
       }   
          // lhoang -- end
    
    
           if( lib_deviceInfo.cosnt_Device_Model == lib_const.const_M300)
             aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_PacktrackCalibration +"", 11), "Enabled", cmpEqual, true);            
             
                          
           IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Settings);
//           check subPath Settings
           var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
           if (userRole == lib_label.const_lb_InstallerBasic || userRole ==lib_label.const_lb_UserBasic)
           {
                 aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 1), "Enabled", cmpEqual, false);
                 aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_WebMonitorSecuritySettings +"", 6), "Enabled", cmpEqual, false);
           }
           else
           {
                 aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 1), "IsEnabled", cmpEqual, true);
                 aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_WebMonitorSecuritySettings +"", 6), "Enabled", cmpEqual, true);
           
           }
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ConfigurationSettings +"", 2), "Enabled", cmpEqual, false);  
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ResetStatistics +"", 3), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ResetDiagnostics +"", 4), "Enabled", cmpEqual, true);    
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ViewConfigurationHMPShortcuts +"", 5), "Enabled", cmpEqual, false);
           
             
//           check subMenu Restore/Backup           
           IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Backup_Restore);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_SingleReaderBackup +"", 1), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_SingleReaderRestore +"", 2), "Enabled", cmpEqual, true);
           //depend on Role of device
           Log.Message("BR_013")
           if (role == lib_label.const_lb_Slave)
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_BackupCurrentInternalNetworkConfigurations +"", 3), "Enabled", cmpEqual, false);
           else
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_BackupCurrentInternalNetworkConfigurations +"", 3), "Enabled", cmpEqual, true);
           
           if (lib_deviceInfo.const_Device_Model == lib_const.const_M120)
           {
               
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_InternalNetworkReplacement +"", 4), "Enabled", cmpEqual, false);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_BackupToExternalStorageDevice +"", 5), "Enabled", cmpEqual, false);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_RestoreFromExternalStorageDevice +"", 6), "Enabled", cmpEqual, false);
           }else
           {
               
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_InternalNetworkReplacement +"", 4), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_BackupToExternalStorageDevice +"", 5), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_RestoreFromExternalStorageDevice +"", 6), "Enabled", cmpEqual, true);
           }
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_RestoreDefaults +"", 7), "Enabled", cmpEqual, true);
             
//             check subMenu Restore/Backup           
           IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Backup_Restore+"|" +const_lb_RestoreDefaults);
             
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RestoreDefaultEnvironment +"", 1), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RestoreDefaultStartupConfiguration +"", 2), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RestoreFactoryDefaults +"", 3), "Enabled", cmpEqual, true);
    
             
           //*************************************************************************************************************************
           //Step 2.1: CONNECTING_DEVICE
           Log["Message"](lib_messageLog.msg_CONNECTING_DEVICE);      
           if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == false)
             return ;
              
           IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click();             
//             // check menu Device
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_ConnectToDevice +"", 1), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_FindDevices +"", 2), "Enabled", cmpEqual, false);              
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 3), "Enabled", cmpEqual, true);             
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_UpdatePackage+"", 4), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_MultiDevicePackageUpdate +"", 5), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_ChangeCurrentConfiguration +"", 6), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RestartDevice +"", 7), "Enabled", cmpEqual, true);             
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_Backup_Restore+"", 8), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RAMImageBufferSettings +"", 9), "Enabled", cmpEqual, true);
           if( lib_deviceInfo.cosnt_Device_Model == lib_const.const_M300)
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_PacktrackCalibration +"", 11), "Enabled", cmpEqual, true);
             
             
                          
           IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Settings);
//           check subPath Settings
           var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
           //if (userRole == lib_label.const_lb_InstallerBasic || userRole ==lib_label.const_lb_UserBasic)
           if (userRole == lib_label.const_lb_InstallerBasic ) // user basic cannot enter configuration
           {
                  aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 1), "Enabled", cmpEqual, false);
                  aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ViewConfigurationHMPShortcuts +"", 5), "Enabled", cmpEqual, false);
           }else // expert
           {      aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 1), "IsEnabled", cmpEqual, true);
                  aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ViewConfigurationHMPShortcuts +"", 5), "IsEnabled", cmpEqual, true);
           }
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ConfigurationSettings +"", 2), "Enabled", cmpEqual, true);  
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ResetStatistics +"", 3), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ResetDiagnostics +"", 4), "Enabled", cmpEqual, true);


                        
//           check subMenu Restore/Backup           
           IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Backup_Restore);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_SingleReaderBackup +"", 1), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_SingleReaderRestore +"", 2), "Enabled", cmpEqual, true);
//           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_BackupCurrentInternalNetworkConfigurations +"", 3), "Enabled", cmpEqual, false);
           //depend on Role of device
           if (role == lib_label.const_lb_Slave)
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_BackupCurrentInternalNetworkConfigurations +"", 3), "Enabled", cmpEqual, false);
           else
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_BackupCurrentInternalNetworkConfigurations +"", 3), "Enabled", cmpEqual, true);
               
           
           if (lib_deviceInfo.const_Device_Model == lib_const.const_M120)
           {
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_InternalNetworkReplacement +"", 4), "Enabled", cmpEqual, false); 
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_BackupToExternalStorageDevice +"", 5), "Enabled", cmpEqual, false);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_RestoreFromExternalStorageDevice +"", 6), "Enabled", cmpEqual, false);
           }else
           {
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_InternalNetworkReplacement +"", 4), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_BackupToExternalStorageDevice +"", 5), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_RestoreFromExternalStorageDevice +"", 6), "Enabled", cmpEqual, true);
           }
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_RestoreDefaults +"", 7), "Enabled", cmpEqual, true);
             
//             check subMenu Restore/Backup           
           IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Backup_Restore+"|" +const_lb_RestoreDefaults);
             
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RestoreDefaultEnvironment +"", 1), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RestoreDefaultStartupConfiguration +"", 2), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RestoreFactoryDefaults +"", 3), "Enabled", cmpEqual, true);
             
           //*************************************************************************************************************************
           //Step 2.1.1: MONITOR_DEVICE    
           Log["Message"](lib_messageLog.msg_MONITOR_DEVICE);
           Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
//           Log.Warning("teessss");
           //validate monitor
           if (lib_validate.isMonitorMode()== false)
                    lib_common.waitDelay(lib_validate.isMonitorMode(), 10000, 10);
           if (lib_validate.isMonitorMode()== false)
           {
                Log.Error("Cannot switch to Monitor");
                return;
           }
//           Log.Warning("teessss");
           //validate monitor successful
           
           IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click();             
//             // check menu Device
           Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", "Connect to Device", 1)
//           var path = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_ConnectToDevice +"", 1), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_FindDevices +"", 2), "Enabled", cmpEqual, false);              
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 3), "Enabled", cmpEqual, true);             
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_UpdatePackage+"", 4), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_MultiDevicePackageUpdate +"", 5), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_ChangeCurrentConfiguration +"", 6), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RestartDevice +"", 7), "Enabled", cmpEqual, false);             
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_Backup_Restore+"", 8), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RAMImageBufferSettings +"", 9), "Enabled", cmpEqual, false);
           if( lib_deviceInfo.cosnt_Device_Model == lib_const.const_M300 || lib_deviceInfo.cosnt_Device_Model == lib_const.const_M410|| lib_deviceInfo.cosnt_Device_Model == lib_const.const_M450)
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_PacktrackCalibration +"", 11), "Enabled", cmpEqual, true);            
             
                          
           IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Settings);
//           check subPath Settings
           var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 1), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ConfigurationSettings +"", 2), "Enabled", cmpEqual, false);  
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ResetStatistics +"", 3), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ResetDiagnostics +"", 4), "Enabled", cmpEqual, true);    
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ViewConfigurationHMPShortcuts +"", 5), "Enabled", cmpEqual, false);
           if (userRole == lib_label.const_lb_InstallerExpert)
                aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_WebMonitorSecuritySettings +"", 6), "Enabled", cmpEqual, true);
           else
                aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_WebMonitorSecuritySettings +"", 6), "Enabled", cmpEqual, false);
         }               
     }
     catch (e)
     {
        Log.Warning(lib_err.err_FUNC_EXCEPTION);
     }
     //lib_common.terminateUI();
}



function MenuBar_Device_UserBasic ( btFindDevices)// only for Installer Basic and Expert (not UserBasic)
//US_135,US_136,US_137,US_138,US_139
{
   Log.Message("US_135,US_136,US_137,US_138,US_139");
//   if ( ! lib_validate.isDLCODERunning())
     lib_common.launchUI();  
   try
   {       
        
        var ip = lib_deviceInfo.const_Device_IP_Adress;
         //*************************************************************************************************************************
         //Step 1 : NOTCONNECT_DEVICE         
         Log["Message"](lib_messageLog.msg_NOTCONNECT_DEVICE);
         while ( !isGettingStartedScreen())
         {
               lib_common.gettingStarted();
              Sys.Process("DL.CODE").Refresh(); 
         }
         if (isGettingStartedScreen())
         {
              var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 
              IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click();
             
             delay (lib_const.const_delay_3000);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_ConnectToDevice +"", 1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_FindDevices +"", 2), "Enabled", cmpEqual, btFindDevices);              
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 3), "Enabled", cmpEqual, true);             
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_UpdatePackage+"", 4), "Enabled", cmpEqual, false);
              
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_MultiDevicePackageUpdate +"", 5), "Enabled", cmpEqual, false);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_ChangeCurrentConfiguration +"", 6), "Enabled", cmpEqual, false);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RestartDevice +"", 7), "Enabled", cmpEqual, false);             
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_Backup_Restore+"", 8), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RAMImageBufferSettings +"", 9), "Enabled", cmpEqual, false);

             
         }
         //validate getting Started when connecting to device          
         if (lib_common.connectToDevice(ip))
         {    
          // lhoang add verify open from pc, open from device are disable
          aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("ToolTip", "Open Device Configuration", 1000), "Enabled", cmpEqual, false);
          aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("ToolTip", "Save on Device", 1000), "Enabled", cmpEqual, false);
          aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("ToolTip", "Load from PC", 1000), "Enabled", cmpEqual, false);
          aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("ToolTip", "Save on PC", 1000), "Enabled", cmpEqual, false);
          aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("ToolTip", "Save Configuration in Temporary Memory", 1000), "Enabled", cmpEqual, false);
          aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("ToolTip", "Switch to Configuration / Monitor", 1000), "Enabled", cmpEqual, false);
          
          
    
    
           var role = lib_DeviceSelectedDetail.getDeviceRole();
           //*************************************************************************************************************************
           //Step 2: CONNECT_DEVICE
           Log["Message"](lib_messageLog.msg_CONNECT_DEVICE); 
           var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");             
           IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click();             
//             // check menu Device
           
           var path = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
           //linhtnguyen comment
           //aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_ConnectToDevice +"", 1), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_ConnectToDevice +"", 1), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_FindDevices +"", 2), "Enabled", cmpEqual, btFindDevices);              
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 3), "Enabled", cmpEqual, true);             
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_UpdatePackage+"", 4), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_MultiDevicePackageUpdate +"", 5), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_ChangeCurrentConfiguration +"", 6), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_RestartDevice +"", 7), "Enabled", cmpEqual, false);             
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_Backup_Restore+"", 8), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_RAMImageBufferSettings +"", 9), "Enabled", cmpEqual, false);
           if( lib_deviceInfo.cosnt_Device_Model == lib_const.const_M300)
             aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_PacktrackCalibration +"", 11), "Enabled", cmpEqual, false);            
             
                          
           IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Settings);
//           check subPath Settings
           var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
          
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 1), "Enabled", cmpEqual, false);
           
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ConfigurationSettings +"", 2), "Enabled", cmpEqual, false);  
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ResetStatistics +"", 3), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ResetDiagnostics +"", 4), "Enabled", cmpEqual, true);    
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ViewConfigurationHMPShortcuts +"", 5), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_WebMonitorSecuritySettings +"", 6), "Enabled", cmpEqual, false);
           // lhoang add for US_133
           aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("ToolTip", "Save on Device", 1000), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("ToolTip", "Save Configuration in Temporary Memory", 1000), "Enabled", cmpEqual, false);             
//          
           //*************************************************************************************************************************
           //Step 2.1.1: MONITOR_DEVICE    
           Log["Message"](lib_messageLog.msg_MONITOR_DEVICE); 
           var path =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1);
//         check menu Device
           if(  (lib_deviceInfo.const_Device_Model == lib_const.const_M300 )|| 
                (lib_deviceInfo.const_Device_Model == lib_const.const_M410 )||
                (lib_deviceInfo.const_Device_Model == lib_const.const_M450 ) ||
                lib_deviceInfo.const_Device_Model == lib_const.const_M320)
           {
                  path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor ).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1).Click();
           }
           //DEVICE IS M210      
           if((lib_deviceInfo.const_Device_Model == lib_const.const_M220 )||   //add more M200 from 1.6.0  
               lib_deviceInfo.const_Device_Model == lib_const.const_M210)
           {     
                 path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1).Click();
           }
           //DEVICE IS M210    
           if(  lib_deviceInfo.const_Device_Model == lib_const.const_M120 )
           {
               //edit path from 1.4.1
                path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1).Click();
                
           }  
           
          
           //validate monitor
           if (lib_validate.isMonitorMode()== false)
                    lib_common.waitDelay(lib_validate.isMonitorMode(), 1000, 10);
           if (lib_validate.isMonitorMode()== false)
           {
                Log.Error("Cannot switch to Monitor");
                return;
           }
           // lhoang add
           lib_UserRole.changeUserRole(lib_label.const_lb_InstallerExpert, true);
           lib_UserRole.changeUserRole(lib_label.const_lb_InstallerBasic, true);
           lib_UserRole.changeUserRole(lib_label.const_lb_UserBasic, true);
	   // lhoang end
//           Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 4).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").Click();
           IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click();   
//           var path = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_ConnectToDevice +"", 1), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_FindDevices +"", 2), "Enabled", cmpEqual, false);              
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 3), "Enabled", cmpEqual, true);             
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_UpdatePackage+"", 4), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_MultiDevicePackageUpdate +"", 5), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_ChangeCurrentConfiguration +"", 6), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RestartDevice +"", 7), "Enabled", cmpEqual, false);             
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_Backup_Restore+"", 8), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_RAMImageBufferSettings +"", 9), "Enabled", cmpEqual, false);
           
           if( lib_deviceInfo.cosnt_Device_Model == lib_const.const_M300 || lib_deviceInfo.cosnt_Device_Model == lib_const.const_M410)
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_PacktrackCalibration +"", 11), "Enabled", cmpEqual, false);            
             
                          
           IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Settings);
//           check subPath Settings
           var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 1), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ConfigurationSettings +"", 2), "Enabled", cmpEqual, false);  
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ResetStatistics +"", 3), "Enabled", cmpEqual, true);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ResetDiagnostics +"", 4), "Enabled", cmpEqual, true);    
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ViewConfigurationHMPShortcuts +"", 5), "Enabled", cmpEqual, false);
           aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_WebMonitorSecuritySettings +"", 6), "Enabled", cmpEqual, false);

                                   
          }              
     }catch (e)
     {
        Log.Warning(lib_err.err_FUNC_EXCEPTION);
     }
     //lib_common.terminateUI();
}