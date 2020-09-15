//USEUNIT lib_const
//USEUNIT lib_DeviceSelectedDetail
//USEUNIT lib_err
//USEUNIT lib_common
//USEUNIT lib_connection
//USEUNIT lib_DeleteJob
//USEUNIT lib_deviceInfo
//USEUNIT lib_OpenJob
//USEUNIT lib_UserRole
function simulator_IconToolbar (device, model , btFindDevices)
{
     if ( ! lib_validate(isDLCODERunning)() || lib_validate.isUnExpectedWindowExists())
                  lib_common(launchUI)();   
   try
   {
           //*************************************************************************************************************************
           //Step 1 : NOTCONNECT_DEVICE  
           Log(Message)(lib_messageLog.msg_NOTCONNECT_DEVICE);
           while ( !isGettingStartedScreen())
           {
              gettingStarted();
              Sys(Process)("DL.CODE").Refresh(); 
           }
           if (isGettingStartedScreen())
           {
                if (Sys(Process)("DL.CODE")(WPFObject)("HwndSource: Shell", lib_deviceInfo.const_firmware)(WPFObject)("Shell", lib_deviceInfo.const_firmware, 1)(WPFObject)("Border", "", 1)(WPFObject)("DockPanel", "", 1)(WPFObject)("Grid", "", 1)(WPFObject)("Border", "", 1)(WPFObject)("Border", "", 1)(WaitWPFObject)("IvsToolBar", lib_const.const_delay_1000).Exists)
                {
                    var ivsToolbar = Sys(Process)("DL.CODE")(WPFObject)("HwndSource: Shell", lib_deviceInfo.const_firmware)(WPFObject)("Shell", lib_deviceInfo.const_firmware, 1)(WPFObject)("Border", "", 1)(WPFObject)("DockPanel", "", 1)(WPFObject)("Grid", "", 1)(WPFObject)("Border", "", 1)(WPFObject)("Border", "", 1)(WPFObject)("IvsToolBar");
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 1)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 2)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, btFindDevices);
                }
            
           }
           //validate getting Started when connecting to device
           Log(Message)(lib_messageLog.msg_CONNECT_DEVICE);           
           if (connectToSimulator( device , model) == true)
           {    
               //*************************************************************************************************************************
               //Step 2: CONNECT_DEVICE
               if (Sys(Process)("DL.CODE")(WPFObject)("HwndSource: Shell", lib_deviceInfo.const_firmware)(WPFObject)("Shell", lib_deviceInfo.const_firmware, 1)(WPFObject)("Border", "", 1)(WPFObject)("DockPanel", "", 1)(WPFObject)("Grid", "", 1)(WPFObject)("Border", "", 1)(WPFObject)("Border", "", 1)(WaitWPFObject)("IvsToolBar", lib_const.const_delay_1000).Exists)
               {
                    var ivsToolbar = Sys(Process)("DL.CODE")(WPFObject)("HwndSource: Shell", lib_deviceInfo.const_firmware)(WPFObject)("Shell", lib_deviceInfo.const_firmware, 1)(WPFObject)("Border", "", 1)(WPFObject)("DockPanel", "", 1)(WPFObject)("Grid", "", 1)(WPFObject)("Border", "", 1)(WPFObject)("Border", "", 1)(WPFObject)("IvsToolBar");
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 1)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 2)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, btFindDevices);
                    
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 3)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 4)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 5)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 6)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 7)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 8)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, false);
                    if (device == lib_const.const_M300)
                      aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 9)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                    if (device == lib_const.const_M410)
                      aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 9)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                
               }
              
               //*************************************************************************************************************************
               //Step 2.1: CONNECTING_DEVICE
               if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == false)
                   return ;
                   
               if (Sys(Process)("DL.CODE")(WPFObject)("HwndSource: Shell", lib_deviceInfo.const_firmware)(WPFObject)("Shell", lib_deviceInfo.const_firmware, 1)(WPFObject)("Border", "", 1)(WPFObject)("DockPanel", "", 1)(WPFObject)("Grid", "", 1)(WPFObject)("Border", "", 1)(WPFObject)("Border", "", 1)(WaitWPFObject)("IvsToolBar", lib_const.const_delay_1000).Exists)
               {
                    var ivsToolbar = Sys(Process)("DL.CODE")(WPFObject)("HwndSource: Shell", lib_deviceInfo.const_firmware)(WPFObject)("Shell", lib_deviceInfo.const_firmware, 1)(WPFObject)("Border", "", 1)(WPFObject)("DockPanel", "", 1)(WPFObject)("Grid", "", 1)(WPFObject)("Border", "", 1)(WPFObject)("Border", "", 1)(WPFObject)("IvsToolBar");
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 1)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 2)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, false);
                    
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 3)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 4)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 5)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 6)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 7)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 8)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                     if (device == lib_const.const_M300)
                      aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 9)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                    if (device == lib_const.const_M410)
                      aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 9)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                
               }
               //*************************************************************************************************************************
               //Step 2.1.1: MONITOR_DEVICE    
               Sys(Process)("DL.CODE")(WPFObject)("HwndSource: Shell", lib_deviceInfo.const_firmware)(WPFObject)("Shell", lib_deviceInfo.const_firmware, 1)(WPFObject)("Border", "", 1)(WPFObject)("DockPanel", "", 1)(WPFObject)("Grid", "", 1)(WPFObject)("Border", "", 1)(WPFObject)("Border", "", 1)(WPFObject)("IvsToolBar")(WPFObject)("ContentPresenter", "", 8)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1).ClickButton();
               aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 1)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 2)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, false);
                    
               aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 3)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 4)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 5)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 6)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 7)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, false);
               aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 8)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
               if (device == lib_const.const_M300)
                      aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 9)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
               if (device == lib_const.const_M410)
                      aqObject(CheckProperty)(ivsToolbar(WPFObject)("ContentPresenter", "", 9)(WPFObject)("Grid", "", 1)(WPFObject)("Button", "", 1)(WPFObject)("Image", "", 1), "Enabled", cmpEqual, true);
                
                            
           }
     
   }
   catch (e)
   {
     Log.Warning(lib_err.err_FUNC_EXCEPTION);
   }    
}


function deleteOnDevice_Nhan (  jobName)
{
  
         var flag = lib_err.err_FUNC_FAILED;   
         try 
         {
                //get name of Startup Job
                var isStartUpJob = lib_DeviceSelectedDetail.isStartUpJob(jobName);
               //click open job
                Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("IvsToolBar")["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("Grid", "", 1)["WPFObject"]("Button", "", 1).ClickButton();
 
                 // waiting Job List Dialog
                 if (Sys["Process"]("DL.CODE")["WaitWPFObject"]("HwndSource: JobListDialogWindow", "*", 2000).Exists)
                 {
                       //get jobList Name
                       var jobList = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: JobListDialogWindow", "*")["WPFObject"]("JobListDialogWindow", "*", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("ListBox", "", 1);
                       //scroll
                       var Vscroll = jobList.VScroll;
                       var max = Vscroll.Max;
                      // Vscroll.Pos = max;  
                       var itemCount = jobList.wItemCount;
   
                       var isInputNameExits = false;
                       for ( var k = 0; k <= max; k++)
                       {
                          // Log.Message("k:"+k);
                           Vscroll.Pos = k;
                           jobList.Refresh();
                           jobList["WaitWPFObject"]("ListBoxItem", "*", lib_const.const_delay_5000);
       
                           var jMin , jMax;
                           if (itemCount > lib_const.const_record_openConfig)
                           {
                              jMin = k+1;
                              jMax = k + lib_const.const_record_openConfig;
                           }else 
                           { 
                              jMin = 1;
                              jMax = itemCount;
                           }
        
                           for (var j = jMin ; j <= jMax; j ++ )
                           {
                              //get name of every item   
                                 
                              jobList["WaitWPFObject"]("ListBoxItem", "*", j);
                              var name = jobList["WPFObject"]("ListBoxItem", "*", j)["WPFObject"]("Grid", "", 1)["WPFObject"]("TextBlock", "*",1).get_Text();
      
                              //find job name need open
                              if (name.ToString() == jobName)
                              {
                                     isInputNameExits = true;
                                     jobList["WPFObject"]("ListBoxItem", "*", j)["WPFObject"]("Grid", "", 1)["WPFObject"]("Button", "", 1).ClickButton();             
                                      //confirm to change tmp job                                                                    
                                     if (Sys["Process"]("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists ) 
                                     {
                                             aqObject.CheckProperty(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_confirm_DELETE_DEFAULT_JOB);                                   
                                             Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnYes").ClickButton();
                                     }
                                     Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: JobListDialogWindow", "*")["WPFObject"]("JobListDialogWindow", "*", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Button", "Cancel", 2).ClickButton();
                                     flag = lib_err.err_FUNC_SUCCESS;
                                     return flag;                      
                              }
                           }
                       }    
                       if ( isInputNameExits == false)
                       {
                            flag = lib_err.err_NO_EXIST;
                            Log.Warning(lib_err.err_NO_EXIST);
                            Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: JobListDialogWindow", "*")["WPFObject"]("JobListDialogWindow", "*", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Button", "Cancel", 2).ClickButton();
                            return flag;
                       }
                 } 
         }
         catch (e)
         {
                 return lib_err.err_FUNC_EXCEPTION;
         } 
          
}

 

function Test10()
{
//  aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", "DL.CODE 1.4.1.33").WPFObject("Shell", "DL.CODE 1.4.1.33", 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, "Layout Type :  Alone ;  Internal Network Role :  Master ;  Configuration : ");
//  aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", "DL.CODE 1.4.1.33").WPFObject("Shell", "DL.CODE 1.4.1.33", 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, "Layout Type :  Alone ;  Internal Network Role :  Master ;  Configuration : ");

 
      var stringMaster = "Layout Type :  "+"Alone"+" ;  Internal Network Role :  "+"Slave"+" "+"0"+" ;  Configuration : ";
            
      var path =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1);
                  
          aqObject.CheckProperty(path.WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, stringMaster);
}

function Test1()
{
  aqObject.CheckProperty(Aliases.DL_CODE.HwndSource_Shell9.Shell.Border.DockPanel.Grid.ContentPlaceholder.UserControl.LayoutRoot.Border2.CollapsedExpander.Grid.StackPanel.JcmExpanderUserControl.Grid.StepsPanelScrollViewer.Grid.border.Grid.ItemsControl.ContentPresenter.ExpanderStepSubItemButton.TextblockQuickSetup, "WPFControlText", cmpEqual, "Quick Setup");
}

function Test2()
{
  var dl_code;
  var grid;
  var accordion;
  var accordionItem;
  var treeViewItem;
  var checkBox;
  var accordionItem2;
  var listBoxItem;
  dl_code = Aliases.DL_CODE;
  grid = dl_code.HwndSource_Shell13.Shell.Border.DockPanel.Grid2.ContentPlaceholder.UserControl.LayoutRoot;
  accordion = grid.Border.uxAccordion;
  accordionItem = accordion.SimulatorsAccordionItem;
  treeViewItem = accordionItem.ScrollViewer.DeviceTreeView.TreeViewItem;
  treeViewItem.Drag(273, 22, 380, 7);
  treeViewItem.Drag(245, 44, 419, -4);
  checkBox = treeViewItem.Grid.Box;
  checkBox.Click(7, 16);
  accordionItem2 = accordion.OnlineDevicesAccordionItem;
  accordionItem2.Click(230, 12);
  accordionItem2.DeviceTreeView.Drag(135, 526, 17, 282);
  accordionItem.Click(147, 27);
  checkBox.Click(11, 5);
  treeViewItem.Drag(290, 32, 275, -6);
  listBoxItem = grid.Border3.Grid.Border1.Grid.ListBox.Bd.ScrollViewer.ItemsPresenter.ListBoxItem;
  listBoxItem.Drag(264, 1, 2, 6);
  listBoxItem.Bd.ContentPresenter.Button.ClickButton();
  dl_code.HwndSource_JobListDialogWindow.JobListDialogWindow.Grid.Grid.Grid.ButtonOk.ClickButton();
  grid.Border4.CollapsedExpander.Grid.StackPanel.JcmExpanderUserControl.Grid.StepsPanelScrollViewer.Grid.border.Grid.ItemsControl.ContentPresenter.ExpanderStepSubItemButton.Click(177, 6);
  aqObject.CheckProperty(Aliases.DL_CODE.HwndSource_Shell13.Shell.Border.DockPanel.Grid2.ContentPlaceholder.UserControl.LayoutRoot.Border2.Grid.TabControl.StackPanel.Grid.Border.Grid.ScrollViewer.PropertiesPresenter.UserControl.StackPanel.ContentexpanderCodeSymbologySetup.StackPanel.GenericPropertiesViewControl.ContentPresenter.ParamControl.Grid.TextblockGreyLevelCalibration.HyperlinkGreyLevelCalibration, "WPFControlText", cmpEqual, "Grey Level Calibration");
  grid.Border2.Grid.TabControl.StackPanel.Grid.Border.Grid.ScrollViewer.PropertiesPresenter.UserControl.StackPanel.ContentexpanderCodeSymbologySetup.StackPanel.GenericPropertiesViewControl.ContentPresenter.ParamControl.Grid.TextblockGreyLevelCalibration.HyperlinkGreyLevelCalibration.Click(57, 9);
}

function Test3()
{
  
}

function Test4()
{
  var btnOK;
  var mainForm;
  var IPAddressControl;
  var fieldControl;
  TestedApps.DL_CODE.Run();
  btnOK = Aliases.DL_CODE.dlg.btnOK;
  btnOK.Drag(76, 12, -36, 2);
  btnOK.Drag(22, 13, 54, -1);
  btnOK.Drag(40, 14, -18, -1);
  Aliases.explorer.wndShell_TrayWnd.ReBarWindow32.MSTaskSwWClass.MSTaskListWClass.Click(343, 24);
  mainForm = Aliases.TestMatrix.MainForm;
  IPAddressControl = mainForm.ipAddressControl_deviceIPAddress;
  IPAddressControl.Drag(129, 12, -77, 2);
  IPAddressControl.Drag(29, 14, -79, -6);
  mainForm.Click(163, 69);
  fieldControl = IPAddressControl.FieldControl0;
  fieldControl.DblClick(16, 8);
  fieldControl.Drag(16, 8, -61, -8);
  fieldControl.SetText("192");
  fieldControl = IPAddressControl.FieldControl1;
  fieldControl.SetText("625");
  fieldControl.SetText("168");
  fieldControl = IPAddressControl.FieldControl2;
  fieldControl.SetText("2");
  fieldControl.Keys("[Tab]");
  IPAddressControl.Click(104, 9);
  IPAddressControl.Click(20, 18);
}