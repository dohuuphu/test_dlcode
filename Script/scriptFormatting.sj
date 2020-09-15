//USEUNIT lib_common 
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_DeviceSelectedDetail
//USEUNIT lib_OpenJob
//USEUNIT lib_SaveJob
//USEUNIT lib_validate

/*
 *@function
*/
function testSuite_655_ScriptFormatting()
{
        aqTestCase.Begin("ScriptFormatting");
         var ip          = lib_deviceInfo.const_Device_IP_Adress; 
         if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI();    
         if (lib_common.connectToDevice(ip))
         {         
              if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y)== false)
                  return;
              lib_button.clickDataFortmating();
              //verify Default
              var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 4);
              aqObject.CheckProperty(path.WPFObject("TreeViewItem", "", 2), "Visible", cmpEqual, true);
              aqObject.CheckProperty(path.WPFObject("TreeViewItem", "", 4), "Visible", cmpEqual, false);
              //Message 1
              aqObject.CheckProperty(path.WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Message", 1), "WPFControlText", cmpEqual, "Message");
              aqObject.CheckProperty(path.WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "1", 3), "WPFControlText", cmpEqual, "1");
              //Message 2
              aqObject.CheckProperty(path.WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 2).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Message", 1), "WPFControlText", cmpEqual, "Message");
              aqObject.CheckProperty(path.WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 2).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "2", 3), "WPFControlText", cmpEqual, "2");
              
              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 4).WPFObject("TreeViewItem", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "General Settings", 1).Click();
              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("CheckBox", "", 1).set_IsChecked(true);
                            
              //veriy left panel: Script Formatting label
              aqObject.CheckProperty(path.WPFObject("TreeViewItem", "", 2), "Visible", cmpEqual, false);// Message 1 + 2 hidden
              aqObject.CheckProperty(path.WPFObject("TreeViewItem", "", 4), "Visible", cmpEqual, true);
              aqObject.CheckProperty(path.WPFObject("TreeViewItem", "", 4).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, "Script Formatter");
               
              //verify icon toolbar
              path.WPFObject("TreeViewItem", "", 4).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "", 1).Click();
              delay (2000);
              var pathBtt =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Border", "", 2).WPFObject("AvalonScriptEdit", "", 1).WPFObject("DockPanel", "", 1).WPFObject("ToolBar", "", 1);
              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Border", "", 2).WPFObject("AvalonScriptEdit", "", 1).WPFObject("DockPanel", "", 1).WPFObject("ToolBar", "", 1).WPFObject("Button", "", 2).WPFObject("Image", "", 1)
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Open).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Save).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_SaveAs).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Cut).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Copy).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Paste).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Delete).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Undo).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Redo).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
              aqObject.CheckProperty(pathBtt.WPFObject("CheckBox", "", lib_const.const_btt_SCPT_WordWrap).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(pathBtt.WPFObject("CheckBox", "", lib_const.const_btt_SCPT_ShowLineNumber).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(pathBtt.WPFObject("CheckBox", "", lib_const.const_btt_SCPT_ShowEndOfLine).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(pathBtt.WPFObject("TemplateButton").WPFObject("StackPanel", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);   
               
              // lhoang add to verify  that the disabled icons still have the tooltips on Script Formatting as if the icons are enabled
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Open).WPFObject("Image", "", 1).ToolTip, "Text", cmpEqual, "Open Script File");
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Save).WPFObject("Image", "", 1).ToolTip, "Text", cmpEqual, "Save Script File");
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_SaveAs).WPFObject("Image", "", 1).ToolTip, "Text", cmpEqual, "Save As Script File");
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Cut).WPFObject("Image", "", 1).ToolTip, "Text", cmpEqual, "Cut");
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Copy).WPFObject("Image", "", 1).ToolTip, "Text", cmpEqual, "Copy");
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Paste).WPFObject("Image", "", 1).ToolTip, "Text", cmpEqual, "Paste");
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Delete).WPFObject("Image", "", 1).ToolTip, "Text", cmpEqual, "Delete");
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Undo).WPFObject("Image", "", 1).ToolTip, "Text", cmpEqual, "Undo");
              aqObject.CheckProperty(pathBtt.WPFObject("Button", "", lib_const.const_btt_SCPT_Redo).WPFObject("Image", "", 1).ToolTip, "Text", cmpEqual, "Redo");
              aqObject.CheckProperty(pathBtt.WPFObject("CheckBox", "", lib_const.const_btt_SCPT_WordWrap).ToolTip, "Text", cmpEqual, "Word Wrap");
              aqObject.CheckProperty(pathBtt.WPFObject("CheckBox", "", lib_const.const_btt_SCPT_ShowLineNumber).ToolTip, "Text", cmpEqual, "Show Line Numbers");
              aqObject.CheckProperty(pathBtt.WPFObject("CheckBox", "", lib_const.const_btt_SCPT_ShowEndOfLine).ToolTip, "Text", cmpEqual, "Show End of Line");
              aqObject.CheckProperty(pathBtt.WPFObject("TemplateButton").ToolTip, "Text", cmpEqual, "Template");    
              // lhoang 61229 - Verify that Script channel visible and connect to at least one channel when Script Formatting is enabled
              
              var arrPro = ["ClrClassName", "WPFControlText"];
              var arrVal = ["ContentExpander", "Output Channels"];;
              var OutputChannelContent = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);               
              arrPro = ["ClrClassName", "Visible"]
              arrVal = ["Checkbox", true];
              var OutputChannelArr =  (new VBArray(OutputChannelContent.FindAllChildren(arrPro, arrVal,1000))).toArray();
              var ChannelConnectCount = 0; 
              for( var indexOutputChannelArr = 0; indexOutputChannelArr < OutputChannelArr.length;indexOutputChannelArr++)
              {
                if(OutputChannelArr[indexOutputChannelArr].IsChecked) ChannelConnectCount++;
              }
              if(ChannelConnectCount >=1)
              {
                Log.Checkpoint("Script channel visible and connect to at least one channel when Script Formatting is enabled");                
              }
              else
              {
                Log.Error("Script channel is NOT connect to at least one channel when Script Formatting is enabled");
              }
              aqObject.CheckProperty(OutputChannelContent, "Visible", cmpEqual, true);
              //lhoang end
              
              
              //verify center panel
              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("ResultCollectionCanvas").WPFObject("EventItem", "", 1).WPFObject("MainBorder").WPFObject("PART_ContentPresenter").WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "Script", 1), "Visible", cmpEqual, true);
              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("ResultCollectionCanvas").WPFObject("EventItem", "", 1).WPFObject("MainBorder").WPFObject("PART_ContentPresenter").WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "Script", 1), "WPFControlText", cmpEqual, "Script");
              
              
              //verify Script Events
              lib_button.clickOutputSetup();
	      var index = 10
	      if(lib_deviceInfo.const_Device_Model == "M320")  index = 9
              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab6Border").WPFObject("ScrollViewer", "", 1).WPFObject("OutputSetupCanvas").WPFObject("DesignerItem", "", index).WPFObject("PART_ContentPresenter").WPFObject("PART_DragThumb").Click();
              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("PropertyViewHeader").WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, "Output Setup :  Script Event 1 ");
               
              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab6Border").WPFObject("ScrollViewer", "", 1).WPFObject("OutputSetupCanvas").WPFObject("DesignerItem", "", index+1).WPFObject("PART_ContentPresenter").WPFObject("PART_DragThumb").Click();
              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("PropertyViewHeader").WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, "Output Setup :  Script Event 2 "); 
              
              
              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab6Border").WPFObject("ScrollViewer", "", 1).WPFObject("OutputSetupCanvas").WPFObject("DesignerItem", "", index+2).WPFObject("PART_ContentPresenter").WPFObject("PART_DragThumb").Click();
              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("PropertyViewHeader").WPFObject("TextBlock", "* ", 1), "WPFControlText", cmpEqual, "Output Setup :  Script Event 3 ");
              
              
              lib_button.clickIVSMonitorButton();
              if (lib_validate.isMonitorMode() == true)
                   aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Configuration", 2).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 4).WPFObject("TreeViewItem", "", 4).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, "Script Formatter");
                
              
        }  
//        lib_common.terminateUI();
aqTestCase.End();
}