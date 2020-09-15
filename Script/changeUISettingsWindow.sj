//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_label
 
//USEUNIT lib_OpenJob
//USEUNIT lib_validate
//USEUNIT lib_deviceInfo
//USEUNIT lib_UserRole

/**
   * Configuration_View Window: checked All (unchecked Simulator Window + Automatically start Run Mode in Configuration)
   * Monitor_View Window: checked All (unchecked Simulator Window + Automatically start Run Mode in Monitor)
   * Global Settings: checked Enable Automatic Device Discovery and Serial Devices Discovery
*/
function changeUISettingsWindow()
{    
     //change UI Settings
     process_UISetting_Configuration();
	 // verify what changeUISettingsWindow
     verify_UISetting_Configuration();
}

function process_UISetting_Configuration()
 {  
    if ( ! lib_validate.isDLCODERunning())
          lib_common.launchUI();  
    try{
            var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 
            IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_UI_Settings);   
            if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: UserControl", lib_const.const_delay_1000).Exists)
            {    
                   var path_config = Sys.Process("DL.CODE").WPFObject("HwndSource: UserControl").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1);
                   //Configuration
                   path_config.ClickTab(0); 
                   aqObject.CheckProperty(path_config.WPFObject("TabItem", ""+lib_label.lb_UISettingsConfigTab+"", 1).WPFObject("TextBlock", ""+lib_label.lb_UISettingsConfigTab+"", 1), "Enabled", cmpEqual, true);
                   //check all content expander 
                   var contentExpander = path_config.WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1);
                   // check content expander lb_ViewWindow
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).isExpanded == false)
                   {
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).set_IsExpanded(true);
                   }
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).isExpanded == true)
                   {
       
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 7).WPFObject("CheckBox", "", 1).set_IsChecked(true);
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 8).WPFObject("CheckBox", "", 1).set_IsChecked(true);
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 10).WPFObject("CheckBox", "", 1).set_IsChecked(true);
                        //false
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 9).WPFObject("CheckBox", "", 1).set_IsChecked(false);
                   }
                   
                   //Monitor
                   path_config.ClickTab(1);
                   // check content expander lb_ViewWindow
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).isExpanded == false)
                   {
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).set_IsExpanded(true);
                   }
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).isExpanded == true)
                   {    
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("CheckBox", "", 1).set_IsChecked(true);
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5).WPFObject("CheckBox", "", 1).set_IsChecked(false);
                   }
                   path_config.ClickTab(2);
                    
                   // check content expander lb_LogOptions
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).isExpanded == false)
                   {
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).set_IsExpanded(true);                 
                   }
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).isExpanded == true)
                   {
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("IsDiscoveryPollingEnabledCheckBox").set_IsChecked(true);
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 1).WPFObject("IsSerialDiscoveryEnabledCheckBox").set_IsChecked(true);
                   }    
             }
 
       Sys.Process("DL.CODE").WPFObject("HwndSource: UserControl").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 2).ClickButton();
       }catch (e)
       {
             Log.Warning(lib_err.err_FUNC_EXCEPTION);
       }
     
 } 
 
 

function verify_UISetting_Configuration()
 {  
    
    try{
            var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 
            IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_UI_Settings);   
            if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: UserControl", lib_const.const_delay_1000).Exists)
            {    
                   var path_config = Sys.Process("DL.CODE").WPFObject("HwndSource: UserControl").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1);
                   //Configuration
                   path_config.ClickTab(0); 
                   aqObject.CheckProperty(path_config.WPFObject("TabItem", ""+lib_label.lb_UISettingsConfigTab+"", 1).WPFObject("TextBlock", ""+lib_label.lb_UISettingsConfigTab+"", 1), "Enabled", cmpEqual, true);
                   //check all content expander 
                   var contentExpander = path_config.WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1);
                   // check content expander lb_ViewWindow
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).isExpanded == false)
                   {
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).set_IsExpanded(true);
                   }
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).isExpanded == true)
                   {
       
                        aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 7).WPFObject("CheckBox", "", 1), "IsChecked", cmpEqual, true);
                        aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 8).WPFObject("CheckBox", "", 1), "IsChecked", cmpEqual, true);
                        aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 10).WPFObject("CheckBox", "", 1),"IsChecked", cmpEqual, true);
                        //false
                        aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 9).WPFObject("CheckBox", "", 1), "IsChecked", cmpEqual, false);
                   }
                   
                   //Monitor
                   path_config.ClickTab(1);
                   // check content expander lb_ViewWindow
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).isExpanded == false)
                   {
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).set_IsExpanded(true);
                   }
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).isExpanded == true)
                   {    
                        aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("CheckBox", "", 1),"IsChecked", cmpEqual, true);
                        aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_ViewWindow+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5).WPFObject("CheckBox", "", 1),"IsChecked", cmpEqual, false);
                   }
                   path_config.ClickTab(2);
                    
                   // check content expander lb_LogOptions
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).isExpanded == false)
                   {
                        contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).set_IsExpanded(true);                 
                   }
                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).isExpanded == true)
                   {
                        aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("IsDiscoveryPollingEnabledCheckBox"),"IsChecked", cmpEqual, true);
                        aqObject.CheckProperty( contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_FindDevices+"", 3).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 1).WPFObject("IsSerialDiscoveryEnabledCheckBox"),"IsChecked", cmpEqual, true);
                   }    
             }
 
       Sys.Process("DL.CODE").WPFObject("HwndSource: UserControl").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "*", 1).ClickButton();
       }catch (e)
       {
             Log.Warning(lib_err.err_FUNC_EXCEPTION);
       }
     
 } 