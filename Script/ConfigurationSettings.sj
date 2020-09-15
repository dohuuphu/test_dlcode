//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo

/*
    verify Default Configuration Window
*/
function configurationSettings ()
{
   aqTestCase.Begin("configurationSettings");
   lib_common.launchUI();  
   try
   {           
           var _mySerialDevice =lib_deviceInfo.const_Device_SerialNumber;
           var ip = lib_deviceInfo.const_Device_IP_Adress;           
           //*************************************************************************************************************************
//           while ( !isGettingStartedScreen())
//           {
//              gettingStarted();
//              Sys.Process("DL.CODE").Refresh(); 
//           }        
           if (lib_common.connectToDevice(ip))
           {   
               //*************************************************************************************************************************
               //: CONNECTING_DEVICE
               Log.Message(lib_messageLog.msg_CONNECTING_DEVICE);                
               if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == false)
                   return ;
               var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");               
               IvsMenu.WPFMenu.Click(lib_label.const_lb_Device + "|" +  lib_label.const_lb_Settings  + "|" +  lib_label.lb_ConfigurationSettings);    
               //check maim menu                  
               // check content expander
               if (!Sys.Process("DL.CODE").WaitWPFObject("HwndSource: ConfigurationSettingsWindow", lib_label.lb_ConfigurationSettings,lib_const.const_delay_1000).Exists)
                        return;
               var contentExpander = Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationSettingsWindow", lib_label.lb_ConfigurationSettings).WPFObject("ConfigurationSettingsWindow", lib_label.lb_ConfigurationSettings, 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1);                                                         
               aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+lib_label.const_lb_Configuration+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_Configuration+"", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+lib_label.const_lb_Statistics+"", 2).WPFObject("TextBlock", ""+lib_label.const_lb_Statistics+"", 1), "Enabled", cmpEqual, true); 
               aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+lib_label.const_lb_WebsentinelConfiguration+"", 3).WPFObject("TextBlock", ""+lib_label.const_lb_WebsentinelConfiguration+"", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+lib_label.lb_SC5000Configuration+"", 4).WPFObject("TextBlock", ""+lib_label.lb_SC5000Configuration+"", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+lib_label.lb_CrisplantConfiguration+"", 5).WPFObject("TextBlock", ""+lib_label.lb_CrisplantConfiguration+"", 1), "Enabled", cmpEqual, true);
               
               //**************************************        
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Configuration+"", 1).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Configuration+"", 1).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Configuration+"", 1).isExpanded == true)
               {                 
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Configuration+"", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+lib_label.const_lb_ConfigurationName+"", 2), "Visible", cmpEqual, true);
                    aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Configuration+"", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+lib_label.const_lb_ConfigurationVersion+"", 2), "Enabled", cmpEqual, true);                                 
               }
               //**************************************
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Statistics+"", 2).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Statistics+"", 2).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Statistics+"", 2).isExpanded == true)
               {
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Statistics+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+lib_label.const_lb_Session+"", 2), "Visible", cmpEqual, true);
                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Statistics+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+lib_label.const_lb_EnabledCounters+"", 2), "Visible", cmpEqual, true);
                  
                  //verify label
                  for (var i = 1; i<= lib_label.lb_arr_Statistics.length; i++)
                  {
                      aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Statistics+"", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", i).WPFObject("Grid", "", 1).WPFObject("CheckBox", lib_label.lb_arr_Statistics[i-1], 1).WPFObject("TextBlock", lib_label.lb_arr_Statistics[i-1], 1), "WPFControlText", cmpEqual, lib_label.lb_arr_Statistics[i-1]);
                  }
                             
                 contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Statistics+"", 2).set_IsExpanded(false);
               }
               //**************************************
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_WebsentinelConfiguration+"", 3).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_WebsentinelConfiguration+"", 3).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_WebsentinelConfiguration+"", 3).isExpanded == true)
               {
                     aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_WebsentinelConfiguration+"", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+lib_label.const_lb_WebsentinelMonitorStatus+"", 2), "Visible", cmpEqual, true);
                     
                     var comboWebsentinelMonitorStatuss = contentExpander.WPFObject("ContentExpander",  ""+ lib_label.lb_WebsentinelConfiguration+"" , 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 
                     comboWebsentinelMonitorStatuss.DropDown();  
                     aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_Disabled+"", 1), "Enabled", cmpEqual, true);
                     aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_Enabled+"", 1), "Enabled", cmpEqual, true);
                     comboWebsentinelMonitorStatuss.ClickItem(1);
                     if (contentExpander.WPFObject("ContentExpander",  ""+ lib_label.lb_WebsentinelConfiguration+"" , 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1).wText == "[1, "   + lib_label.const_lb_Enabled +   "]") 
                     {      aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_WebsentinelConfiguration+"", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+lib_label.const_lb_MasterDiagnosticCheckPeriod+"", 2), "Visible", cmpEqual, true);
                     
                     }//click here to cancel popup
                     contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_WebsentinelConfiguration+"", 3).set_IsExpanded(false);     
                    
               }
               
               //**************************************
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SC5000Configuration+"",4).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SC5000Configuration+"", 4).set_IsExpanded(true);
               }
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SC5000Configuration+"", 4).isExpanded == true)
               {
                      
                     aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_SC5000Configuration, 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.lb_SC5000Status, 2), "Visible", cmpEqual, true);
                     var comboSC5000Configuration = contentExpander.WPFObject("ContentExpander",  ""+ lib_label.lb_SC5000Configuration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 
                     comboSC5000Configuration.DropDown();  
                     aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_Disabled+"", 1), "Enabled", cmpEqual, true);
                     aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_Enabled+"", 1), "Enabled", cmpEqual, true);
                     comboSC5000Configuration.ClickItem(1);
                     if (contentExpander.WPFObject("ContentExpander",  ""+ lib_label.lb_SC5000Configuration+"" , 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1).wText == "[1, "   + lib_label.const_lb_Enabled +   "]") 
                     {
                            
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_SC5000Configuration, 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.lb_SC5000IPAddress , 2), "Enabled", cmpEqual, true); 
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_SC5000Configuration, 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.lb_SC5000Port , 2), "Enabled", cmpEqual, true);
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_SC5000Configuration, 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.lb_SC5000StartPosition , 2), "Enabled", cmpEqual, true);                           
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_SC5000Configuration, 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.lb_SC5000HeartbitTimeout , 2), "Enabled", cmpEqual, true);
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_SC5000Configuration, 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.lb_SC5000DiagnosticTimeout , 2), "Enabled", cmpEqual, true);
                            
                            // verify default parameters
                            //SC5000 IP Address
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_SC5000Configuration, 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("IpAddress"), "IpAddress", cmpEqual, lib_label.lb_Default_SC5000IPAddress);
                            //SC500 Port
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_SC5000Configuration, 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Text", cmpEqual, lib_label.lb_Default_SC5000Port);
                            // Start Position
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_SC5000Configuration, 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Text", cmpEqual, lib_label.lb_Default_SC5000StartPosition);
                            // Heartbeat
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_SC5000Configuration, 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Text", cmpEqual, lib_label.lb_Default_SC5000HeartbitTimeout);
                            //Diagnostic
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_SC5000Configuration, 4).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Text", cmpEqual, lib_label.lb_Default_SC5000DiagnosticTimeout);
                     }      
                     //click here to cancel popup                      
                     contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_SC5000Configuration+"", 4).set_IsExpanded(false);     
                    
               }
               
               //**************************************    
               
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_CrisplantConfiguration+"", 5).isExpanded == false)
               {
                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_CrisplantConfiguration+"", 5).set_IsExpanded(true);
               }
               
               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_CrisplantConfiguration+"", 5).isExpanded == true)
               {
                     Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationSettingsWindow", "Configuration Settings").WPFObject("ConfigurationSettingsWindow", "Configuration Settings", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Crisplant Configuration", 5).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "Status", 2)
                     aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_CrisplantConfiguration, 5).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.lb_Status_1, 2), "Visible", cmpEqual, true);
                     var cbbCrisplantConfiguration = Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationSettingsWindow", "Configuration Settings").WPFObject("ConfigurationSettingsWindow", "Configuration Settings", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Crisplant Configuration", 5).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1)                                               
                    // var cbbCrisplantConfiguration=  contentExpander.WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1);
                     cbbCrisplantConfiguration.DropDown();  
                     aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_Disabled+"", 1), "Enabled", cmpEqual, true);
                     aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_Enabled+"", 1), "Enabled", cmpEqual, true);
                     cbbCrisplantConfiguration.ClickItem(1);
                     if (contentExpander.WPFObject("ContentExpander",  ""+ lib_label.lb_CrisplantConfiguration+"" , 5).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1).wText == "[1, "   + lib_label.const_lb_Enabled +   "]") 
                     {
                            
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_CrisplantConfiguration, 5).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.lb_Version , 2), "Enabled", cmpEqual, true);
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_CrisplantConfiguration, 5).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.lb_Length , 2), "Enabled", cmpEqual, true);  
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_CrisplantConfiguration, 5).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("TextBlock", lib_label.lb_HeartbeatTimeout , 2), "Enabled", cmpEqual, true);
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_CrisplantConfiguration, 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "", 1), "Enabled", cmpEqual, true);
                            
                            // version
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_CrisplantConfiguration, 5).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[0, P10]");
                            // length
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_CrisplantConfiguration, 5).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[4, 4 digits]");                                                                                                           
                            // Heartbeat
                            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", lib_label.lb_CrisplantConfiguration, 5).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Text", cmpEqual, "60");
//                                                      
//                            //Channels
//                            Log.Warning("chua verify default channels");
//                            var cbbChannels ;
//                            cbbChannels = contentExpander.WPFObject("ContentExpander", lib_label.lb_CrisplantConfiguration, 5).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ComboBox", "", 1);
//                            cbbChannels.DropDown();  
//                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 1).WPFObject("TextBlock", ""+ lib_label.const_lb_MatrixTCPServer+"", 1), "Enabled", cmpEqual, true);
//                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 2).WPFObject("TextBlock", ""+ lib_label.const_lb_Main+"", 1), "Enabled", cmpEqual, true);
//                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", 3).WPFObject("TextBlock", ""+ lib_label.const_lb_AUX+"", 1), "Enabled", cmpEqual, true);
//                     
                     }
                     //click here to cancel popup 
                     contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_CrisplantConfiguration+"", 5).set_IsExpanded(false);     
               }
               
               //**************************************                                
               Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationSettingsWindow", lib_label.const_lb_ConfigurationSettings).WPFObject("ConfigurationSettingsWindow", lib_label.const_lb_ConfigurationSettings, 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 1).ClickButton();
           }
     
   }
   catch (e)
   {
     Log["Warning"](lib_err.err_FUNC_EXCEPTION);
   }    
   //lib_common.terminateUI();       
   aqTestCase.End();   
 }