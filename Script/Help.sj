//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo
//USEUNIT lib_UserRole

/*  
		*@function 
*/
function MenuBar_Help ()
{
   aqTestCase.Begin("MenuBar_Help");
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
              IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Help  , 4).Click();  
   
             //check maim menu   
              //var path = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
              delay (lib_const.const_delay_3000);
              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+lib_label.const_lb_About+"" , 1), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+lib_label.const_lb_UserGuide+"", 2), "Enabled", cmpEqual, true);
           }
           //validate getting Started when connecting to device
           Log["Message"](lib_messageLog.msg_CONNECT_DEVICE);           
           if (lib_common.connectToDevice(ip))
           {    
               //*************************************************************************************************************************
               //Step 2: CONNECT_DEVICE
               Log["Message"](lib_messageLog.msg_CONNECT_DEVICE); 
               var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Help  , 4).Click();  
               var path = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_About+"" , 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_UserGuide+"", 2), "Enabled", cmpEqual, true);
               
               //*************************************************************************************************************************
               //Step 2.1: CONNECTING_DEVICE
               Log["Message"](lib_messageLog.msg_CONNECTING_DEVICE); 
               if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == false)
                   return ;
               
               IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Help  , 4).Click();    
               //check maim menu                  
               delay (lib_const.const_delay_3000);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_About+"" , 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_UserGuide+"", 2), "Enabled", cmpEqual, true);
               
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
//               Log.Warning("teessss");             

               IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Help, 4).Click();                     
               //check maim menu                  
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_About+"" , 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(path.WPFObject("MenuItem", ""+lib_label.const_lb_UserGuide+"", 2), "Enabled", cmpEqual, true);
               
           }
     
   }
   catch (e)
   {
     Log.Warning(lib_err.err_FUNC_EXCEPTION);
   }   
   //lib_common.terminateUI();      
    aqTestCase.End();      
 }