﻿//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_OpenJob
//USEUNIT lib_validate
//USEUNIT lib_deviceInfo
//USEUNIT lib_UserRole

/*  
		*@function 
*/
function MenuBar_File ()
{
//   if ( ! lib_validate["isDLCODERunning"]())
aqTestCase.Begin("Menu File Bar");
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
               IvsMenu.WPFObject("MenuItem",lib_label.const_lb_File, 1).Click();
               // check menu File
               aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_File_GettingStarted +"", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_File_Open +"", 2), "Enabled", cmpEqual, true);              
               aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_File_Save +"", 3), "Enabled", cmpEqual, true);             
               //aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Setup_Internal_Network+"", 4), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_File_Monitor +"", 4), "Enabled", cmpEqual, false);
               aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_File_Exit +"", 5), "Enabled", cmpEqual, true); 
         }
         //validate getting Started when connecting to device
          
         if (lib_common.connectToDevice(ip))
         { 
               //*************************************************************************************************************************
               //Step 2: CONNECT_DEVICE
               Log["Message"](lib_messageLog.msg_CONNECT_DEVICE);   
               var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 
               IvsMenu.WPFObject("MenuItem",lib_label.const_lb_File, 1).Click();  
               // check menu File
               var path = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_GettingStarted +"", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Open +"", 2), "Enabled", cmpEqual, true);              
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Save +"", 3), "Enabled", cmpEqual, true);     
               if (lib_deviceInfo.const_Device_Model == lib_const.const_M120 )
               {
                     aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Monitor +"", 4), "Enabled", cmpEqual, true);
                     aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Exit +"", 5), "Enabled", cmpEqual, true);
               }else
               {
                     aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Setup_Internal_Network+"", 4), "Enabled", cmpEqual, true);
                     aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Monitor +"", 5), "Enabled", cmpEqual, true);
                     aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Exit +"", 6), "Enabled", cmpEqual, true);
               }          
               IvsMenu.WPFMenu.Click(lib_label.const_lb_File +"|" + lib_label.const_lb_Open);
             
               var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Open_Config_PC +"", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Open_Config_Device +"", 2), "Enabled", cmpEqual, true);             
              
               //*************************************************************************************************************************
               //Step 2.1: CONNECTING_DEVICE
               Log["Message"](lib_messageLog.msg_CONNECTING_DEVICE);                  
               if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == false)
                 return ;
               else
               {
                 
                   // check menu File
                   IvsMenu.WPFObject("MenuItem",lib_label.const_lb_File, 1).Click();  
  //                 var path = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
    
                   delay (lib_const.const_delay_3000);
                   aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_File_GettingStarted +"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_File_Open +"", 2), "Enabled", cmpEqual, true);              
                   aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_File_Save +"", 3), "Enabled", cmpEqual, true); 
                   if (lib_deviceInfo.const_Device_Model == lib_const.const_M120 )
                   {
                         aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Monitor +"", 4), "Enabled", cmpEqual, true);
                         aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Exit +"", 5), "Enabled", cmpEqual, true);
                   }else
                   {
                         aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Setup_Internal_Network+"", 4), "Enabled", cmpEqual, true);
                         aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Monitor +"", 5), "Enabled", cmpEqual, true);
                         aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Exit +"", 6), "Enabled", cmpEqual, true);
                   }
                          
                   IvsMenu.WPFMenu.Click(lib_label.const_lb_File +"|" + lib_label.const_lb_Open);             
                   aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Open_Config_PC +"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Open_Config_Device +"", 2), "Enabled", cmpEqual, true);             
             
                   IvsMenu.WPFMenu.Click(lib_label.const_lb_File +"|" + lib_label.const_lb_Save);
                   aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Save_Config_PC +"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Save_Config_Device +"", 2), "Enabled", cmpEqual, true);
             
                   //check Save Config on Device
                   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
                   Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", lib_label.const_lb_File_Save_Config_Device)
                   if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: JobListDialogWindow", lib_label.const_lb_File_Save_Config_Device, lib_const.const_delay_2000).Exists)
                   {             
                      var path2 = Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", lib_label.const_lb_File_Save_Config_Device).WPFObject("JobListDialogWindow", lib_label.const_lb_File_Save_Config_Device, 1).WPFObject("Grid", "", 1);
                      aqObject.CheckProperty(path2.WPFObject("StackPanel", "", 1).WPFObject("RadioButton", const_lb_SaveNewConfiguration, 1), "Enabled", cmpEqual, true);
                      aqObject.CheckProperty(path2.WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("RadioButton", "*", 1), "WPFControlText", cmpEqual, const_lb_OverwriteConfig);
                      aqObject.CheckProperty(path2.WPFObject("Grid", "", 1).WPFObject("CheckBox", const_lb_SetStartupConfig, 1), "Enabled", cmpEqual, true);
                
                      path2.WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();             
                   }
                   //*************************************************************************************************************************
                   //Step 2.1.1: MONITOR_DEVICE    
                   Log["Message"](lib_messageLog.msg_MONITOR_DEVICE);
                   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
                   //validate monitor
                   if (lib_validate.isMonitorMode()== false)
                            lib_common.waitDelay(lib_validate.isMonitorMode(), 1000, 10);
                   if (lib_validate.isMonitorMode()== false)
                   {
                        Log.Error("Cannot switch to Monitor");
                        return;
                   }
//                   Log.Warning("teessss");
                   
                   
                   IvsMenu.WPFObject("MenuItem",lib_label.const_lb_File, 1).Click();    
                   // check menu File                 
                   aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_GettingStarted +"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Open +"", 2), "Enabled", cmpEqual, true);              
                   aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Save +"", 3), "Enabled", cmpEqual, true);             
                   if (lib_deviceInfo.const_Device_Model == lib_const.const_M120 )
                   {//From 1.8.0, 'Monitor' is disabled when staying on Monitor mode
                   
                         aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Monitor +"", 4), "Enabled", cmpEqual, false);
                         aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Exit +"", 5), "Enabled", cmpEqual, true);
                   }else
                   {
                         aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Setup_Internal_Network+"", 4), "Enabled", cmpEqual, false);
                         aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Monitor +"", 5), "Enabled", cmpEqual, false);
                         aqObject.CheckProperty(path.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Exit +"", 6), "Enabled", cmpEqual, true);
                   }
                 
                   IvsMenu.WPFMenu.Click(lib_label.const_lb_File +"|" + lib_label.const_lb_Open);             
                   aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Open_Config_PC +"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Open_Config_Device +"", 2), "Enabled", cmpEqual, true);             
             
                   IvsMenu.WPFMenu.Click(lib_label.const_lb_File +"|" + lib_label.const_lb_Save);
                   aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Save_Config_PC +"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_File_Save_Config_Device +"", 2), "Enabled", cmpEqual, true); 
               }                 
          }
             
     }catch (e)
     {
        Log.Warning(lib_err.err_FUNC_EXCEPTION);
     }
     //lib_common.terminateUI();
aqTestCase.End();
}