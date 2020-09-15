//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_deviceInfo
//USEUNIT lib_validate
//USEUNIT lib_UserRole

/*  
		*@function 
*/
function helpRightPanel()
{
//   if ( ! lib_validate.isDLCODERunning())
   lib_common.launchUI();  
   try
   { 
           
           var ip = lib_deviceInfo.const_Device_IP_Adress;
          
           //validate getting Started when connecting to device
           Log["Message"](lib_messageLog.msg_CONNECT_DEVICE);           
           if (lib_common.connectToDevice(ip))
           {    
               //*************************************************************************************************************************
               //Step 2: CONNECT_DEVICE
               Log["Message"](lib_messageLog.msg_CONNECT_DEVICE);                
               var path =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1);               
               aqObject.CheckProperty(path.WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", lib_label.const_lb_DeviceSelection , 1).WPFObject("TextBlock", lib_label.const_lb_DeviceSelection, 1), "Enabled", cmpEqual, true);               
               
               var subPath = path.WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", lib_label.const_lb_DeviceSelection , 1);
               
               aqObject.CheckProperty(subPath.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.lb_Name, 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", lib_label.lb_Model, 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("TextBlock", lib_label.lb_LayoutType, 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4).WPFObject("TextBlock", lib_label.const_lb_InternalNetworkRole, 1), "Enabled", cmpEqual, true);
                                              
               aqObject.CheckProperty(subPath.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5).WPFObject("TextBlock", lib_label.lb_Status_1, 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 6).WPFObject("TextBlock", lib_label.lb_StartupInfo, 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 7).WPFObject("TextBlock", lib_label.const_lb_IpAddress, 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 9).WPFObject("TextBlock", lib_label.lb_ApplicationSWVersion, 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(subPath.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 10).WPFObject("TextBlock", lib_label.lb_LoaderVersion, 1), "Enabled", cmpEqual, true);
               //DEVICE IS M300||M410||M450               
               if(  (lib_deviceInfo.const_Device_Model == lib_const.const_M300 )|| 
                    (lib_deviceInfo.const_Device_Model == lib_const.const_M410 )||
                    (lib_deviceInfo.const_Device_Model == lib_const.const_M450 ) )
               {
                    //edit path from 1.4.1
                    aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_OpenDeviceConfiguration).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_OpenDeviceConfiguration , 1), "Enabled", cmpEqual, true);
                    //update from 1.5.0a5 Presentation mode
                    aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PresentationMode).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_PresentationMode , 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_SetupInternalNetworkConfiguration , 1), "IsEnabled", cmpEqual, true);                    
                    aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PackTrack).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_PackTrackCalibration , 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
               }
               //DEVICE IS M210      
               if(  lib_deviceInfo.const_Device_Model == lib_const.const_M210 )
               {
                    //edit path from 1.4.1
                    aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_OpenDeviceConfiguration).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_OpenDeviceConfiguration , 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PresentationMode).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_PresentationMode , 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_SetupInternalNetworkConfiguration , 1), "Enabled", cmpEqual, true);   
                    aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor -1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
               }
               //DEVICE IS M120    
               if(  lib_deviceInfo.const_Device_Model == lib_const.const_M120 )
               {
                   //edit path from 1.4.1
                   aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_OpenDeviceConfiguration).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_OpenDeviceConfiguration , 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PresentationMode).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_PresentationMode , 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
               }               
               
           }
     
   }
   catch (e)
   {
     Log.Warning(lib_err.err_FUNC_EXCEPTION);
   }  

}