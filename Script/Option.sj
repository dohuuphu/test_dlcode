//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_OpenJob
//USEUNIT lib_validate
//USEUNIT lib_deviceInfo
//USEUNIT lib_UserRole
/* 
Scenario
Step 1 : NOTCONNECT_DEVICE
         -- validate menu bar
Step 2: CONNECT_DEVICE
        -- validate menu bar
        Step 2.1: CONNECTING_DEVICE
                  -- validate menu bar
                  Step 2.1.1: MONITOR_DEVICE
                  -- validate menu bar
        
*/


//updated 1.5.0 (add M220&M420)
function MenuBar_Options ()
{
    aqTestCase.Begin("Menubar Option");
//   if ( ! lib_validate.isDLCODERunning())
//   lib_common.launchUI();  
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
             var IvsMenu =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 

             //check main menu 
             IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+lib_label.const_lb_Options_Change_Language+"" , 1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+lib_label.const_lb_Options_UI_Settings+"", 2), "Enabled", cmpEqual, true);                       
             //linhtnguyen comment
             //aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+lib_label.const_lb_Options_Change_Log_Level+"", 3), "Enabled", cmpEqual, true);
             //
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+lib_label.const_lb_Options_Log+"", 3), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+lib_label.const_lb_Options_Change_User+"", 4), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+lib_label.const_lb_Options_Restore_To_Default+"", 5), "Enabled", cmpEqual, true);
             
             //check subMenu language
             IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();
             IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_Language);
             var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem",  ""+lb_Italian+"", 1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_English+"", 2), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_Chinese+"", 3), "Enabled", cmpEqual, true);      
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_German+"", 4), "Enabled", cmpEqual, true);      
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_Japanese+"", 5), "Enabled", cmpEqual, true);      
             
              if (subPath.WPFObject("MenuItem", ""+lib_label.lb_English+"", 2).IsChecked != true)
                  Log.Warning(lib_err.err_ENGLISH_DEFAULT + subPath.WPFObject("MenuItem", ""+lib_label.lb_English+"", 2).IsChecked) ;  
   
             //check subMenu log level (old)
             /* linhtnguyen comment
             IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();
             IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_Log_Level);
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Verbose+"",1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Information+"", 2), "Enabled", cmpEqual, true);      
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3), "Enabled", cmpEqual, true); 
             
              if (subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3).IsChecked != true)
                  Log.Warning(lib_err.err_ERROR_DEFAULT +  subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3).IsChecked) ;
             */ 
             
             // check new menu Save All Logs + Reset Logs -- linhtnguyen comment
             IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click(); 
             IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Log);
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_SaveAllLogs+"",2), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_ResetLog+"",3), "Enabled", cmpEqual, true);
             
             //check Log -> Change Log Level
             IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click(); 
             IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Log + "|" + lib_label.const_lb_Options_Change_Log_Level);
           
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Verbose+"",1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Information+"", 2), "Enabled", cmpEqual, true);      
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3), "Enabled", cmpEqual, true); 
             
              if (subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3).IsChecked != true)
                  Log.Warning(lib_err.err_ERROR_DEFAULT +  subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3).IsChecked) ;
                              
                  
             //check subMenu change user   
             IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();
             IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_User);  
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_InstallerBasic +"",1), "IsEnabled", cmpEqual, true);
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_InstallerExpert +"", 2), "IsEnabled", cmpEqual, false); 
             aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_UserBasic +"", 3), "Enabled", cmpEqual, true);
             UISetting();  
         }
         //validate getting Started when connecting to device
         
         if (lib_common.connectToDevice(ip))
         {    
         
  
               //*************************************************************************************************************************
               //Step 2: CONNECT_DEVICE
               Log["Message"](lib_messageLog.msg_CONNECT_DEVICE);
               var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();    
               //check maim menu   
               var path = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_Change_Language+"" , 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_UI_Settings+"", 2), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_Log+"", 3), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_Change_User+"", 4), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_Restore_To_Default+"", 5), "Enabled", cmpEqual, true);
   
               //check subMenu language
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();
               IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_Language); 
               var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem",  ""+lb_Italian+"", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_English+"", 2), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_Chinese+"", 3), "Enabled", cmpEqual, true);      
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_German+"", 4), "Enabled", cmpEqual, true);      
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_Japanese+"", 5), "Enabled", cmpEqual, true);      
               
               if (subPath.WPFObject("MenuItem", ""+lib_label.lb_English+"", 2).IsChecked != true)
                  Log.Warning(lib_err.err_ENGLISH_DEFAULT + subPath.WPFObject("MenuItem", ""+lib_label.lb_English+"", 2).IsChecked) ;   
                 
               //change subMenu log level   
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();
               IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Log + "|" + lib_label.const_lb_Options_Change_Log_Level); 
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Verbose+"",1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Information+"", 2), "Enabled", cmpEqual, true);      
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3), "Enabled", cmpEqual, true); 
               
               if (subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3).IsChecked != true)
                  Log.Warning(lib_err.err_ERROR_DEFAULT + subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3).IsChecked) ;

               //check subMenu change user   
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();
               IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_User);   
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_InstallerBasic +"",1), "IsEnabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_InstallerExpert +"", 2), "IsEnabled", cmpEqual, false);   
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_UserBasic +"", 3), "Enabled", cmpEqual, true); 
               UISetting();
                 
               //*************************************************************************************************************************
               //Step 2.1: CONNECTING_DEVICE    
               if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == false)
                    return ;
               var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();   
               //check maim menu    
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_Change_Language+"" , 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_UI_Settings+"", 2), "Enabled", cmpEqual, true);               
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_Log+"", 3), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_Change_User+"", 4), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_Restore_To_Default+"", 5), "Enabled", cmpEqual, true);
   
               //check subMenu language
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();
               IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_Language);
//               var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem",  ""+lb_Italian+"", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_English+"", 2), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_Chinese+"", 3), "Enabled", cmpEqual, true);      
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_German+"", 4), "Enabled", cmpEqual, true);      
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_Japanese+"", 5), "Enabled", cmpEqual, true);     
               
               if (subPath.WPFObject("MenuItem", ""+lib_label.lb_English+"", 2).IsChecked != true)
                  Log.Warning(lib_err.err_ENGLISH_DEFAULT + subPath.WPFObject("MenuItem", ""+lib_label.lb_English+"", 2).IsChecked) ;   
   
               //change subMenu log level   
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();
               IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Log + "|" + lib_label.const_lb_Options_Change_Log_Level);
   
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Verbose+"",1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Information+"", 2), "Enabled", cmpEqual, true);      
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3), "Enabled", cmpEqual, true); 

                if (subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3).IsChecked != true)
                  Log.Warning(lib_err.err_ERROR_DEFAULT + subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3).IsChecked) ;

               //check subMenu change user 
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click(); 

               IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_User);   
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_InstallerBasic +"",1), "IsEnabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_InstallerExpert +"", 2), "IsEnabled", cmpEqual, false);    
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_UserBasic +"", 3), "Enabled", cmpEqual, true); 
               
               UISetting(); 
               
               //*************************************************************************************************************************
               //Step 2.1.1: MONITOR_DEVICE 
               Log["Message"](lib_messageLog.msg_MONITOR_DEVICE);
               Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
//               Log.Warning("teessss");
               //validate monitor
               if (lib_validate.isMonitorMode()== false)
                        lib_common.waitDelay(lib_validate.isMonitorMode(), 1000, 10);
               if (lib_validate.isMonitorMode()== false)
               {
                    Log.Error("Cannot switch to Monitor");
                    return;
               }
//           Log.Warning("teessss");
               
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();   
               //check maim menu   
//               var path = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_Change_Language+"" , 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_UI_Settings+"", 2), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_Log+"", 3), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_Change_User+"", 4), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_Options_Restore_To_Default+"", 5), "Enabled", cmpEqual, true);
   
               //check subMenu language
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();
               IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_Language);
//               var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
               aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem",  ""+lb_Italian+"", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_English+"", 2), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_Chinese+"", 3), "Enabled", cmpEqual, true);      
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_German+"", 4), "Enabled", cmpEqual, true);      
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.lb_Japanese+"", 5), "Enabled", cmpEqual, true);  

               if (subPath.WPFObject("MenuItem", ""+lib_label.lb_English+"", 2).IsChecked != true)
                  Log.Warning(lib_err.err_ENGLISH_DEFAULT + subPath.WPFObject("MenuItem", ""+lib_label.lb_English+"", 2).IsChecked) ;    
   
               //change subMenu log level   
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();
               IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Log + "|" + lib_label.const_lb_Options_Change_Log_Level);   
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Verbose+"",1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Information+"", 2), "Enabled", cmpEqual, true);      
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3), "Enabled", cmpEqual, true); 
               
               if (subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"", 3).IsChecked != true)
                  Log.Warning(lib_err.err_ERROR_DEFAULT + subPath.WPFObject("MenuItem", ""+lib_label.const_lb_Error+"",3).IsChecked) ;

               //check subMenu change user  \
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click(); 
               IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_User);   
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_InstallerBasic +"",1), "IsEnabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_InstallerExpert +"", 2), "IsEnabled", cmpEqual, false); 
               aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_UserBasic +"", 3), "Enabled", cmpEqual, true);
               
               UISetting();  
                 
         }  
   }
   catch (e)
   {
        Log.Warning(lib_err.err_FUNC_EXCEPTION);
   } 
   ////lib_common.terminateUI();
   aqTestCase.End();    
             
 }
  
 
 function UISetting()
 {
     if ( ! lib_validate.isDLCODERunning())
          lib_common.launchUI();  
     try{
         var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 
         IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_UI_Settings);   
         
         if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: UserControl", lib_const.const_delay_1000).Exists)
         {      
             UISetting_Configuration();
             UISetting_Monitor();
             UISetting_GlobalSettings();
         } 
         
         Sys.Process("DL.CODE").WPFObject("HwndSource: UserControl").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 1).ClickButton();
     }catch (e)
     {
           Log.Warning(lib_err.err_FUNC_EXCEPTION);
     }
 
 }
 
 
 function UISetting_otherWindow ()
{

   if ( ! lib_validate.isDLCODERunning())
          lib_common.launchUI();  
   try
   {           
         
         if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
          { 
                if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                {
                     var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 
                     IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_UI_Settings);   
         
                     if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: UserControl", lib_const.const_delay_1000).Exists)
                     {      
                         UISetting_Configuration();
                         UISetting_Monitor();
                         UISetting_GlobalSettings();
                     } 
         
                     Sys.Process("DL.CODE").WPFObject("HwndSource: UserControl").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 1).ClickButton();
      
             }
          }
         
   }
   catch (e)
   {
     Log["Warning"](lib_err.err_FUNC_EXCEPTION);
   }    
   //lib_common.terminateUI();          
 }
 
 function UISetting_Configuration()
 {
        try
        {
             var path_config = Sys.Process("DL.CODE").WPFObject("HwndSource: UserControl").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1);
             path_config.ClickTab(0); 
             aqObject.CheckProperty(path_config.WPFObject("TabItem", ""+lib_label.lb_UISettingsConfigTab+"", 1).WPFObject("TextBlock", ""+lib_label.lb_UISettingsConfigTab+"", 1), "Enabled", cmpEqual, true);
             //check all content expander 
             var contentExpander = path_config.WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1);
             aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("TextBlock", ""+ lib_label.lb_ConfigConsoleSettings+"", 1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_UIImageBuffer+"", 2).WPFObject("TextBlock", ""+ lib_label.lb_UIImageBuffer+"", 1), "Enabled", cmpEqual, true);
             
             //add new 1.5.0a5 
             aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LocalImagesFolderSettings+"", 3).WPFObject("TextBlock", ""+ lib_label.lb_LocalImagesFolderSettings+"", 1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DPMImagesDatabase+"", 4).WPFObject("TextBlock", ""+ lib_label.lb_DPMImagesDatabase+"", 1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("TextBlock", ""+ lib_label.lb_ViewWindow+"", 1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_PackTrackCalibration+"", 6).WPFObject("TextBlock", ""+ lib_label.lb_PackTrackCalibration+"", 1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DeviceRecalibration+"",7).WPFObject("TextBlock", ""+ lib_label.lb_DeviceRecalibration+"", 1), "Enabled", cmpEqual, true);
             // check content expander ConsoleSettings
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).isExpanded == false)
             {
                  contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).set_IsExpanded(true);
             }
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).isExpanded == true)
             {
       
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_CharacterFormat+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_DisplayTimestamp+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("TextBlock", ""+ lib_label.lb_Timestamp+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4).WPFObject("TextBlock", ""+ lib_label.lb_DontShowSpecialCharacter+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5).WPFObject("TextBlock", ""+ lib_label.lb_ConsoleOutputFolder+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 6).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultConsoleOutputFolder+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 7).WPFObject("TextBlock", ""+ lib_label.lb_AutomaticallyStartConsoleLog+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 8).WPFObject("TextBlock", ""+ lib_label.lb_ResetConsoleLogAtStartup+"", 1), "Enabled", cmpEqual, true);
           
                 //check Default by code
//                 if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ComboBox", "", 1).wText != "[3, "+ lib_label.lb_Symbol+"]")
//                     Log.Warning(lib_err.err_CHARACTER_FORMAT + contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ComboBox", "", 1).wText) ;  
//           
//                 if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("ComboBox", "", 1).wText != "[1, "+ lib_label.lb_Default+"]")
//                     Log.Warning(lib_err.err_TIMESTAMP + contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("ComboBox", "", 1).wText) ;

                 //check Default by checkpoint
                 delay (lib_const.const_delay_3000);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[3, "+ lib_label.lb_Symbol+"]");
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[1, "+ lib_label.lb_Default+"]");
                 
                 var cbbCharacterFormat;
                 cbbCharacterFormat = contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ComboBox", "", 1);
                 cbbCharacterFormat.DropDown();
                 aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1), "WPFControlText", cmpEqual, "[1, "+ lib_label.lb_Dec+"]");
                 aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2), "WPFControlText", cmpEqual, "[2, "+ lib_label.lb_Hex+"]");
                 aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 3), "WPFControlText", cmpEqual, "[3, "+ lib_label.lb_Symbol+"]");
                 
                 var cbbTimestamp ;
                 cbbDisplayTimestamp = contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ConfigConsoleSettings+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("ComboBox", "", 1);
                 cbbDisplayTimestamp.DropDown();
                 aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1), "WPFControlText", cmpEqual, "[1, "+ lib_label.lb_Default+"]");
                 aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2), "WPFControlText", cmpEqual, "[2, "+ lib_label.lb_Short+"]");
               
             }
       
             // check content expander lb_UIImageBuffer
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_UIImageBuffer+"", 2).isExpanded == false)
             {
                  contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_UIImageBuffer+"", 2).set_IsExpanded(true);
             }
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_UIImageBuffer+"", 2).isExpanded == true)
             {
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_UIImageBuffer+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_BufferSize+"", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_UIImageBuffer+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1), "Value", cmpEqual, lib_const.const_DEFAULT_BUFFER_SIZE);
                  //check default by code
                  /*
                  if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_UIImageBuffer+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).Value != lib_const.const_DEFAULT_BUFFER_SIZE)
                      Log.Warning(lib_err.err_BUFFER_SIZE + contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_UIImageBuffer+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).Value) ;
                      */
           
             }
 
             // check content expander lb_LocalImagesFolderSettings
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LocalImagesFolderSettings+"", 3).isExpanded == false)
             {
                  contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LocalImagesFolderSettings+"", 3).set_IsExpanded(true);
             }
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LocalImagesFolderSettings+"", 3).isExpanded == true)
             {
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LocalImagesFolderSettings+"", 3).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_MaxDownloadedImagesFolderSize+"", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LocalImagesFolderSettings+"", 3).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1), "Value", cmpEqual, lib_const.const_DEFAULT_FOLDER_SIZE);
           
                  //check Default by code
                  /*
                  if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LocalImagesFolderSettings+"", 3).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).Value != lib_const.const_DEFAULT_FOLDER_SIZE)
                      Log.Warning(lib_err.err_FOLDER_SIZE + contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LocalImagesFolderSettings+"", 3).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).Value) ;
                  */
           
             }
       
             // check content expander lb_DPMImagesDatabase
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DPMImagesDatabase+"", 4).isExpanded == false)
             {
                  contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DPMImagesDatabase+"", 4).set_IsExpanded(true);
             }
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DPMImagesDatabase+"", 4).isExpanded == true)
             {
                  Log.Message("lib_label.lb_DPMImagesDatabase");
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DPMImagesDatabase+"", 4).WPFObject("Grid", "", 1).WPFObject("TextBlock",""+ lib_label.lb_BufferSize+"", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DPMImagesDatabase+"", 4).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1), "Value", cmpLessOrEqual, lib_const.const_MAX_DB_BUFFER_SIZE);
                  //check Default by code
                  /*
                  if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DPMImagesDatabase+"", 4).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).Value > lib_const.const_MAX_DB_BUFFER_SIZE)
                      Log.Warning(lib_err.err_MAX_DB_BUFFER_SIZE + contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DPMImagesDatabase+"", 4).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).Value) ;
                  */
           
             }
 
              // check content expander lb_ViewWindow
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).isExpanded == false)
             {
                  contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).set_IsExpanded(true);
             }
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).isExpanded == true)
             {
       
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_UIImageBuffer+"", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_Console+"", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorWindow+"", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4).WPFObject("TextBlock", ""+ lib_label.lb_Result+"", 1), "Enabled", cmpEqual, true);
                  //lb_EnableCodeLocalizationMap add 1.5.0 a5 and remove khoi tu RC3
                  //aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5).WPFObject("TextBlock", ""+ lib_label.lb_EnableCodeLocalizationMap+"", 1), "Enabled", cmpEqual, true);
//                                                                                                                        .WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 6).WPFObject("TextBlock", "Focus Calibration", 1)
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 6 ).WPFObject("TextBlock", ""+ lib_label.lb_FocusCalibration+"", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 7 ).WPFObject("TextBlock", ""+ lib_label.lb_DPMImagesDatabase+"", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 8 ).WPFObject("TextBlock", ""+ lib_label.lb_DisplayPhaseOnImage+"", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 9 ).WPFObject("TextBlock", ""+ lib_label.lb_DisplayImageResolution+"", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 10 ).WPFObject("TextBlock", ""+ lib_label.lb_AutoStartRunModeConfiguration+"", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 11 ).WPFObject("TextBlock", ""+ lib_label.lb_DisplayImageName+"", 1), "Enabled", cmpEqual, true);
            
             }
 
  
              // check content expander lb_PackTrackCalibration
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_PackTrackCalibration+"", 6).isExpanded == false)
             {
                  contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_PackTrackCalibration+"", 6).set_IsExpanded(true);
             }
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_PackTrackCalibration+"", 6).isExpanded == true)
             {
       
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_PackTrackCalibration+"", 6).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_ShowOverlay+"", 1), "Enabled", cmpEqual, true);
          
             }
 
              // check content expander lb_DeviceRecalibration
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DeviceRecalibration+"", 7).isExpanded == false)
             {
       
                  contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DeviceRecalibration+"", 7).set_IsExpanded(true);
             }
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DeviceRecalibration+"", 7).isExpanded == true)
             {
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_DeviceRecalibration+"", 7).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_ShowRecalibrationResults+"", 1), "Enabled", cmpEqual, true);
             }
 
        }
        catch (e)
        {
              Log.Warning(lib_err.err_FUNC_EXCEPTION);
        }
     
 }
 
 function UISetting_Monitor()
 { 
        try 
        {
             var path_config = Sys.Process("DL.CODE").WPFObject("HwndSource: UserControl").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1); 
             path_config.ClickTab(1);
             aqObject.CheckProperty(path_config.WPFObject("TabItem", ""+lib_label.lb_UISettingsMonitorTab+"", 2).WPFObject("TextBlock", ""+lib_label.lb_UISettingsMonitorTab+"", 1), "Enabled", cmpEqual, true);
             //check all monitor tab
             var contentExpander = path_config.WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1);
             aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+lib_label.lb_MonitorImagesOptions+"", 1).WPFObject("TextBlock", ""+lib_label.lb_MonitorImagesOptions+"", 1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+lib_label.lb_ViewWindow+"", 2).WPFObject("TextBlock", ""+lib_label.lb_ViewWindow+"", 1), "Enabled", cmpEqual, true);
             
             
              // check content expander lb_MonitorImagesOptions
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_MonitorImagesOptions+"", 1).isExpanded == false)
             {
                  contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_MonitorImagesOptions+"", 1).set_IsExpanded(true);
             }
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_MonitorImagesOptions+"", 1).isExpanded == true)
             {                  
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_MonitorImagesOptions+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_EnableImageAndResultsTransfer+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_MonitorImagesOptions+"", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_DisplayROI+"", 1), "Enabled", cmpEqual, true);
                 //lb_EnableCodeLocalizationMap add new 1.5.0a5 and remove 1.5RC3
                 //aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_MonitorImagesOptions+"", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_EnableCodeLocalizationMap+"", 1), "Enabled", cmpEqual, true);  
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_MonitorImagesOptions+"", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3  ).WPFObject("TextBlock", ""+ lib_label.lb_DisplayPhaseOnImage+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_MonitorImagesOptions+"", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4 ).WPFObject("TextBlock", ""+ lib_label.lb_DisplayImageResolution+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_MonitorImagesOptions+"", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5 ).WPFObject("TextBlock", ""+ lib_label.lb_ImagesScalingFactor+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_MonitorImagesOptions+"", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5 ).WPFObject("ComboBox", "", 1), "wItemList", cmpEqual, "100%|75%|50%|25%");
            
             }
             
             // check content expander lb_ViewWindow
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).isExpanded == false)
             {
                  contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).set_IsExpanded(true);
             }
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).isExpanded == true)
             {                  
                 
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"",2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_Console+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"",2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_Configuration+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"",2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("TextBlock", ""+ lib_label.lb_EnableStatistics_Diagnostics+"", 1), "Enabled", cmpEqual, true);
                 
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"",2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4).WPFObject("TextBlock", ""+ lib_label.lb_Statistics_DiagnosticsRefreshRate+"", 1), "Enabled", cmpEqual, true);
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"",2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4).WPFObject("ExplicitUpdateIntegerUpDown", "", 1), "Value", cmpEqual, lib_const.const_Statistics_DiagnosticsRefreshRate);
                 
                 aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"",2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5).WPFObject("TextBlock", ""+ lib_label.lb_AutoStartRunModeMonitor+"", 1), "Enabled", cmpEqual, true);
            
             }
             
         
        }
        catch (e)
        {
              Log.Warning(lib_err.err_FUNC_EXCEPTION);
        }

 }
 
 function UISetting_GlobalSettings()
 {
        try 
        {
             var path_config = Sys.Process("DL.CODE").WPFObject("HwndSource: UserControl").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1); 
             path_config.ClickTab(2);
             aqObject.CheckProperty(path_config.WPFObject("TabItem", ""+lib_label.lb_UISettingsGlobalSettingsTab+"", 3).WPFObject("TextBlock", ""+lib_label.lb_UISettingsGlobalSettingsTab+"", 1), "Enabled", cmpEqual, true);
             //check all monitor tab
             var contentExpander = path_config.WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1);
             aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+lib_label.lb_LogOptions+"", 1).WPFObject("TextBlock", ""+lib_label.lb_LogOptions+"", 1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+lib_label.lb_SimulatorSettings+"", 2).WPFObject("TextBlock", ""+lib_label.lb_SimulatorSettings+"", 1), "Enabled", cmpEqual, true);
             aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+lib_label.lb_FindDevices+"", 3).WPFObject("TextBlock", ""+lib_label.lb_FindDevices+"", 1), "Enabled", cmpEqual, true);
             
             // check content expander lb_LogOptions
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LogOptions+"", 1).isExpanded == false)
             {
                  contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LogOptions+"", 1).set_IsExpanded(true);                 
             }
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LogOptions+"", 1).isExpanded == true)
             {
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LogOptions+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_MaxNumberOfFiles+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LogOptions+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1), "Value", cmpEqual, lib_const.const_MaxNumberOfFiles);
                   
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LogOptions+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_MaxFileSize+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_LogOptions+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ExplicitUpdateIntegerUpDown", "", 1), "Value", cmpEqual, lib_const.const_MaxFileSize);                 
             }
             // check content expander lb_LogOptions
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).isExpanded == false)
             {
                  contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).set_IsExpanded(true);                
             }
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).isExpanded == true)
             {
                   //lb_M120_210_000
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M120_210_000).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M120_210_000+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M120_210_000).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M120_210_000).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   //lb_M210N_235_111
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M210N_235_111).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M210N_235_111+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M210N_235_111).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M210N_235_111).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   //lb_M300N_482_010
                                                         
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M300N_482_010).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M300N_482_010+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M300N_482_010).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M300N_482_010).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   //lb_M300N_712_010 -- linhtnguyen comment                                                        
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M300N_712_010).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M300N_712_010+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M300N_712_010).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M300N_712_010).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                                   
                   //lb_M300N_772_010                                                         
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M300N_772_010).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M300N_772_010+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M300N_772_010).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M300N_772_010).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   
                   //lb_M320N_320_020                                                       
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M320_320_020).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M320_320_020+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M320_320_020).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M320_320_020).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   
                   
                   //lb_M410N_500_010
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M410N_500_010).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M410N_500_010+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M410N_500_010).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M410N_500_010).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   //lb_M410N_700_010
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M410N_700_010).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M410N_700_010+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M410N_700_010).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M410N_700_010).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                     
                   //lb_M410N_XRF_H2x
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M410N_XRF_H2x).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M410N_XRF_H2x+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M410N_XRF_H2x).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M410N_XRF_H2x).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   //lb_M450N_800_030
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M450N_800_030).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M450N_800_030+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M450N_800_030).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M450N_800_030).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   
                   //add from 1.5.0 (add M420 and M220)
                   //lb_M220_220_001
                   
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M220_355_040).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M220_355_040+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M220_355_040).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M220_355_040).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M220_382_010).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M220_382_010+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M220_382_010).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M220_382_010).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   
                   /*
                   //lb_M420_420_003
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M420_420_003).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M420_420_003+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M420_420_003).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M420_420_003).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   //lb_M420_420_005
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M420_420_005).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M420_420_005+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M420_420_005).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M420_420_005).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   //lb_M420_420_009
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M420_420_009).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M420_420_009+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M420_420_009).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M420_420_009).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                   //lb_M420_420_012
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M420_420_012).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_M420_420_012+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M420_420_012).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_SimulatorImagesFolder+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_M420_420_012).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_UseDefaultFolder+"",1), "Enabled", cmpEqual, true);
                  */
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_StartSimulator+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SimulatorSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_StartSimulator+"", 1), "Enabled", cmpEqual, true);
                            
             }
             
             // check content expander lb_LogOptions
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).isExpanded == false)
             {
                  contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).set_IsExpanded(true);                 
             }
             if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).isExpanded == true)
             {
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_EnableAutomaticDeviceDiscovery+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+ lib_label.lb_EnableSerialDevicesDiscovery+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 2).WPFObject("TextBlock", ""+ lib_label.lb_SerialParity+"", 1), "Enabled", cmpEqual, true);
                   
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 3).WPFObject("TextBlock", ""+ lib_label.lb_SerialDataBits+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 4).WPFObject("TextBlock", ""+ lib_label.lb_SerialStopBits+"", 1), "Enabled", cmpEqual, true);
                   
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 5).WPFObject("TextBlock", ""+ lib_label.lb_BaudRate_921600+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 6).WPFObject("TextBlock", ""+ lib_label.lb_BaudRate_460800+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 7).WPFObject("TextBlock", ""+ lib_label.lb_BaudRate_230400+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 8).WPFObject("TextBlock", ""+ lib_label.lb_BaudRate_115200+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 9).WPFObject("TextBlock", ""+ lib_label.lb_BaudRate_57600+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 10).WPFObject("TextBlock", ""+ lib_label.lb_BaudRate_38400+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 11).WPFObject("TextBlock", ""+ lib_label.lb_BaudRate_19200+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 12).WPFObject("TextBlock", ""+ lib_label.lb_BaudRate_9600+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 13).WPFObject("TextBlock", ""+ lib_label.lb_BaudRate_4800+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 14).WPFObject("TextBlock", ""+ lib_label.lb_BaudRate_2400+"", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 15).WPFObject("TextBlock", ""+ lib_label.lb_BaudRate_1200+"", 1), "Enabled", cmpEqual, true);
                                      
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 2).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[0, ParityNone]");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 3).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[8, 8]");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 4).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[1, StopBits_1]");
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 5).WPFObject("Serial_921600CheckBox"), "IsChecked", cmpEqual, true);
                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 8).WPFObject("Serial_115200CheckBox"), "IsChecked", cmpEqual, true);
                                   
             }      
        }
        catch (e)
        {
              Log.Warning(lib_err.err_FUNC_EXCEPTION);
        }
 }