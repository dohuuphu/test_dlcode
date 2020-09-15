//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_DataFormating
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_OpenJob
//USEUNIT lib_OutputSetup
//USEUNIT lib_ReadingPhase
//USEUNIT lib_validate
//USEUNIT lib_button


/*
  *@function
*/
function chooseViewType()
  { 
        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("TabItem", "Statistics", 2).WPFObject("TextBlock", "Statistics", 1).Click();
        var btt = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StatisticsModeButton", "", 1).WPFObject("Image", "", 1);
        
        btt.Click();
        delay (3000);
        Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1).WPFObject("MenuItem", "Session", 1).Click();
        delay (lib_const.const_delay_3000);
        btt.Click();
        delay(3000);
        Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1).WPFObject("MenuItem", "Absolute", 2).Click();
        
}

/*
  *@function
*/
function chooseImageResolution()
{ 

        for (var i = 1 ; i<= 4; i++)
        {
              var value = 100 - 25*(i -1);//100-75-50-25
              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ImageScalingButton", "", 1).Click();
              delay (1000);               
              Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1).WPFObject("MenuItem", value +"%" , i).Click();
              delay (lib_const.const_delay_20000);
        }
}

/*
  *@function
*/
function chooseGoodReadSetupMode ()
{ 
  aqTestCase.Begin("GoodReadSetup");
//      if ( ! lib_validate.isDLCODERunning())
       lib_common.launchUI();  
      var arr_Mode = [ lib_const.const_AddCollectionActionButton ,lib_const.const_AddParcelActionButton, lib_const.const_AddPresentationActionButton ,lib_const.const_AddMatchCodeActionButton ];
      var arr_labelMode = [lib_label.lb_CodeCollection,  lib_label.lb_CodeCombination , lib_label.lb_CodePresentation, lib_label.lb_MatchCode];
 
      if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      {           
           if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
            { 
                  lib_button.clickGoodReadSetup();
                  for (var i = arr_Mode.length; i >= 1 ; i--)
                  {
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_GoodRead, "", 1).WPFObject(arr_Mode[i-1], "", 1).Click();
                            
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 12).WPFObject("TreeViewItem", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*" , 1), "WPFControlText", cmpContains, arr_labelMode[i-1]);
//                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TextBlock", "*" , 1), "WPFControlText", cmpContains, arr_labelMode[i-1]);
                             
                            if (arr_labelMode[i-1] ==  lib_label.lb_CodeCombination ||arr_labelMode[i-1] ==  lib_label.lb_MatchCode ) 
                            {
                                   if (lib_button.clickAddCodetoExpectedCode() == false)
                                          Log.Warning("US61 , US_62: false");
                                   else
                                   {  
                                          lib_button.clickPlay(false);
                                          Delay(lib_const.const_delay_2000);
                                          lib_button.clickPause(false); 
                                           
                                   } 
                            }  
                                 
                  }
            }
      }
//      terminateUI(); 
aqTestCase.End();
}

/*
  *@function
*/
function chooseAcquisitionTrigger ()
{ 
  aqTestCase.Begin("AcquisitionTrigger");
//      if ( ! lib_validate.isDLCODERunning())
      lib_common.launchUI();  
      var arr_Mode  ;
      var arr_Label ;
      if (lib_deviceInfo.const_Device_Model == lib_const.const_M120 ||lib_deviceInfo.const_Device_Model == lib_const.const_M210 ||lib_deviceInfo.const_Device_Model == lib_const.const_M220)
      {
            arr_Mode= [ lib_const.const_Continuous ,lib_const.const_OneShot  , lib_const.const_PhaseMode   ];
            arr_Label = [ lib_label.lb_Continuous    , lib_label.lb_OneShot    ,lib_label.lb_PhaseMode  ]
      }
      else
      {
            arr_Mode= [ lib_const.const_Continuous ,lib_const.const_OneShot  , lib_const.const_PhaseMode   ,lib_const.const_Packtrack ];
            arr_Label = [ lib_label.lb_Continuous    , lib_label.lb_OneShot    ,lib_label.lb_PhaseMode       ,lib_label.lb_PackTrackMode]
      }if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      {           
           if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
            { 
                  lib_button.clickReadingPhase();
                  for (var i = arr_Mode.length; i >= 1 ; i--)
                  {
                            //click btt to change mode
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_ReadingPhase_Channel, "", 1).WPFObject(arr_Mode[i-1], "", 1).Click();
                            //verify status bar on top
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 5), "WPFControlText", cmpContains, arr_Label[i-1]);
                            var result =  lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, randomJobName()+arr_Mode[i-1] , lib_const.const_isDefaultJob_Y, lib_const.isMonitorMode_N);
                            
                            if (result == lib_err.err_FUNC_SUCCESS)
                            {
                                  lib_button.clickPlay(false);
                                  Delay(lib_const.const_delay_2000);
                                  lib_button.clickPause(false); 
                            }
                            //play & pause
                            lib_button.clickPlay(false);
                            Delay(lib_const.const_delay_2000);
                            lib_button.clickPause(false); 
                            
                            if (i == 1)// choose Periodics
                            {
                                    //Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Trigger Type", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("RadioButton", "", 1).ClickButton();
                                    //Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Trigger Type", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("RadioButton", "", 1).wChecked = true;
                                    var arrPro = ["WPFControlText", "ClrClassName", "ChildCount"];
                                    var arrVal = ["Periodic (ms)", "TextBlock", 0];
                                    var temp = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
                                    var count = 20;
                                    while(count>0)
                                    {
                                      temp = temp.Parent;
                                      if(temp.FindChild("ClrClassName", "RadioButton", 1).Exists) break;
                                      delay(1000);
                                      count --;
                                    }
                                    if(count > 0) temp.FindChild("ClrClassName", "RadioButton", 1).IsChecked = true;
                                    //play & pause
                                    var result =  lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, randomJobName()+arr_Mode[i-1]+"Periodics" , lib_const.const_isDefaultJob_Y, lib_const.isMonitorMode_N);
                            
                                    if (result == lib_err.err_FUNC_SUCCESS)
                                    {
                                          lib_button.clickPlay(false);
                                          Delay(lib_const.const_delay_2000);
                                          lib_button.clickPause(false); 
                                    }
                            }           
                  }
            }
      }
//        terminateUI(); 
aqTestCase.End();
}


