//USEUNIT lib_common
//USEUNIT lib_deviceInfo
//USEUNIT lib_const
//USEUNIT lib_messageLog
//USEUNIT lib_err
//USEUNIT lib_validate
//USEUNIT lib_OpenJob

function iconToolbarJazz()
{
  iconToolbar(false);
}
/*  
		*@function 
		@param btFindDevices (true/false)
*/
function iconToolbar (btFindDevices )
{
   if ( ! lib_validate.isDLCODERunning())
       lib_common.launchUI();  
   try
   {
         
           
           var ip = lib_deviceInfo.const_Device_IP_Adress;
           //*************************************************************************************************************************
           //Step 1 : NOTCONNECT_DEVICE  
           Log["Message"](lib_messageLog.msg_NOTCONNECT_DEVICE);
           while ( !isGettingStartedScreen())
           {
              gettingStarted();
              Sys.Process("DL.CODE").Refresh(); 
           }
           if (isGettingStartedScreen())
           {
                if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1)["WaitWPFObject"]("IvsToolBar", lib_const.const_delay_1000).Exists)
                {
                    var ivsToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar");
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, btFindDevices);
                    //1.4.1 add UserRole and RestoreUI 
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_UserRole).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_RestoreUI).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    //1.4.1 add UserRole and RestoreUI
                }
            
           }
           //validate getting Started when connecting to device
           Log["Message"](lib_messageLog.msg_CONNECT_DEVICE);           
           if (lib_common.connectToDevice(ip))
           {    
               //*************************************************************************************************************************
               //Step 2: CONNECT_DEVICE
               if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1)["WaitWPFObject"]("IvsToolBar", lib_const.const_delay_1000).Exists)
               {
                    
                    var ivsToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar");
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, btFindDevices);
                    //1.4.1 add UserRole and RestoreUI 
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_UserRole).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_RestoreUI).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    //1.4.1 add UserRole and RestoreUI
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenFromPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveInTemp).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    if (lib_deviceInfo.const_Device_Model == lib_const.const_M300)
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    if (lib_deviceInfo.const_Device_Model == lib_const.const_M410)
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                
               }
              
               //*************************************************************************************************************************
               //Step 2.1: CONNECTING_DEVICE
               if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == false)
                 
                   return ;
                   
               if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1)["WaitWPFObject"]("IvsToolBar", lib_const.const_delay_1000).Exists)
               {
                    var ivsToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar");
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    //1.4.1 add UserRole and RestoreUI 
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_UserRole).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_RestoreUI).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    //1.4.1 add UserRole and RestoreUI
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenFromPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveInTemp).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                     if (lib_deviceInfo.const_Device_Model == lib_const.const_M300)
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    if (lib_deviceInfo.const_Device_Model == lib_const.const_M410)
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                
               }
               //*************************************************************************************************************************
               //Step 2.1.1: MONITOR_DEVICE    
               Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", 10).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
               //1.4.1 add UserRole and RestoreUI 
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_UserRole).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_RestoreUI).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               //1.4.1 add UserRole and RestoreUI
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenFromPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveInTemp).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               if (lib_deviceInfo.const_Device_Model == lib_const.const_M300)
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               if (lib_deviceInfo.const_Device_Model == lib_const.const_M410)
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                
                            
           }
     
   }
   catch (e)
   {
     Log.Warning(lib_err.err_FUNC_EXCEPTION);
   }    
   //lib_common.terminateUI();
}