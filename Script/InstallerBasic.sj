//USEUNIT lib_ChangeIP
//USEUNIT lib_common
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_OpenJob
//USEUNIT lib_UserRole
//USEUNIT lib_validate
//USEUNIT TC_Backup_Restore
//USEUNIT lib_CodeSetup
//USEUNIT lib_CodeAutolearn
//USEUNIT Device
//USEUNIT lib_Action
//USEUNIT lib_SaveIMG
//USEUNIT lib_DPM_IMG_DB


/*
  *@function
*/
function changeInstaller_Basic()
{
//          if ( ! lib_validate.isDLCODERunning())
          lib_common.launchUI();  
          lib_UserRole.changeUserRole(lib_label.const_lb_InstallerBasic,false);
//          terminateUI();
          
}

function installerBasic_MenuBar_Device()
{
  aqTestCase.Begin("installerBasic_MenuBar_Device");
      MenuBar_Device(false, lib_label.const_lb_InstallerBasic);
      aqTestCase.End();
} 

 
/*
  *@function
  * its too difficule to track error cause it include 15 sub-functions
  *=> use other way
*/
function installerBasic()
{
 
           lib_common.launchUI();  
 
          //verify all testcases (on menubar Device)   //US_68,US_69,US_70,US_71,US_72,US_73,US_74,US_75,US_78,US_79         
          Device.MenuBar_Device(false, lib_label.const_lb_InstallerBasic);
          //verifyInstallerBasic_Monitor
          lib_UserRole.verifyMonitorMode();
          //verifyInstallerBasic_ImageSetup
          verifyInstallerBasic_ImageSetup(); 
           
          //US_14, US_33, US_25           
          lib_CodeSetup.addDelete_AllCode1D();
          lib_CodeSetup.addDelete_AllCode2D();         
          //US_15->20
          lib_CodeAutolearn.performCodeAutolearn_Add_Replace_Discard();
           
          //US_23, US_24
          //lib_CodeAutolearn.performDPM();
          // //US_49,50,56,59,57,60
          lib_ReadingPhase.add_delete_Max_All_Channel();
          //US_44,45,46,47,48
          lib_Action.chooseAcquisitionTrigger();  
          //US_52,53,54,55,61,62
          lib_Action.chooseGoodReadSetupMode();      
          //US_58,64
          lib_DataFormating.add_MaxImageSetting();  
          //verifyInstallerBasic_ReadingPhase depend on each device
          //verifyInstallerBasic_GoodReadSetup     
          Log.Message("ddd");   
          // US_63,65,67
          addDiagnostic_Passthrough();
          //verify in Monitor mode
          Log.Message("aaa");
          verifyInstallerBasic_ImageSetup_Monitor();
          //US_97
          Log.Message("nnnn");
          lib_SaveIMG.clickSaveImageButton_Monitor();
          //US_31
          lib_SaveIMG.clickSaveImageButton_Configuration();

 
}

/*
  *@function
*/
function addDiagnostic_Passthrough ()
{
  aqTestCase.Begin("Diagnostics passthrough");
          lib_DataFormating.add_MaxImageSetting();  
          if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
          { 
                if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                {
                          //US_63              
                          lib_DataFormating.addDiagnostics();
                          for (var i =1 ; i<= 11; i++)
                          {
                              //US_65
                              lib_DataFormating.addPasthrough();
                          }
                          //US_67
                          lib_button.clickSaveInTemp();
                             
                          lib_button.clickPlay(false);
                          Delay(lib_const.const_delay_60000);
                          lib_button.clickPause(false); 
                }
          }
          aqTestCase.End();
}

//add 1.5.0
/*
  *@function
*/
function verifyInstallerBasic_ImageSetup()
{
      aqTestCase.Begin("verifyInstallerBasic_ImageSetup");
      //changeInstaller_Basic();
          if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
          { 
                if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                {     
                      lib_button.clickAdvancedSetup();
                       //US_85
                      
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "General Settings - Code Grading", 1).Click();
                      //processing mode && 1D &&2D
                      //var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("GenericPropertiesViewControl", "", 1); 
                      var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1);
                      //edit from 1.5.0 -> always show
                      if (path.WPFObject("ContentPresenter", "", 5).WPFObject("ParamControl", "", 1).WaitWPFObject("Grid", "", lib_const.const_delay_1000).Exists)
                             aqObject.CheckProperty(path.WPFObject("ContentPresenter", "", 5).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "IsVisible", cmpEqual, true);                      
                      if (path.WPFObject("ContentPresenter", "", 6).WPFObject("ParamControl", "", 1).WaitWPFObject("Grid", "",lib_const.const_delay_1000).Exists)
                             aqObject.CheckProperty(path.WPFObject("ContentPresenter", "", 6).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "IsVisible", cmpEqual, true);
                      if (path.WPFObject("ContentPresenter", "", 8).WPFObject("ParamControl", "", 1).WaitWPFObject("Grid", "",lib_const.const_delay_1000).Exists)
                             aqObject.CheckProperty(path.WPFObject("ContentPresenter", "", 8).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "IsVisible", cmpEqual, true);

                      //US_007
                      Log.Message("US_07:"+    lib_button.clickIMG_AutoSetup_Static(true));
                      Log.Message("US_07:"+    lib_button.clickIMG_AutoSetup_Dynamic(true, "2000","0.3"));
                       
                      //US_008
                      if(lib_deviceInfo.const_isPPI_device == false)
                             lib_button.clickIMG_FocusAutolearn(true);
                       
                      //US_06
                      lib_button.clickPlay(false);
                      Delay(lib_const.const_delay_60000);
                      lib_button.clickPause(false);
                      //US_26,US_27
                      lib_button.clickToolbarButton(lib_const.const_bbt_MoveUp ,false );
                      lib_button.clickToolbarButton(lib_const.const_bbt_MoveDown,false);
                      //US_28, US_29, US_30
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomOut,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomToFit,false);
                      //US_11 
                      lib_button.clickEnableCroppingRegion(true);
                      Delay(lib_const.const_delay_1000);
                      //US_13
                      lib_CodeSetup.editCroppingRegion (100,200,300,700);
                      lib_button.clickRemoveCroppingRegion(true);     
                      //US_085
                      Log.Message("Verify that -Processing Mode- must be hidden on Installer-Basic user");
                      var arrPro = ["ClrClassName", "WPFControlText", "ChildCount"];
                      var arrVal = ["TextBlock", "Processing Mode", 1];
                      var ProcessingMode = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
                      if(ProcessingMode.Exists)
                      {
                        aqObject.CheckProperty(ProcessingMode, "Visible", cmpequal, false)                                                
                      }
                      else
                      {
                        aqObject.CheckProperty(ProcessingMode, "Exists", cmpequal, false)
                      }
                      
                      arrPro = ["ClrClassName", "WPFControlText", "ChildCount"];
                      arrVal = ["TextBlock", "1D CQ Standard", 1];
                      var _1DCQStandard = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
                      if(_1DCQStandard.Exists)
                      {
                        aqObject.CheckProperty(_1DCQStandard, "Visible", cmpequal, false)                                                
                      }
                      else
                      {
                        aqObject.CheckProperty(_1DCQStandard, "Exists", cmpequal, false)
                      }
                      
                      arrPro = ["ClrClassName", "WPFControlText", "ChildCount"];
                      arrVal = ["TextBlock", "2D CQ Standard", 1];
                      var _2DCQStandard = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
                      if(_2DCQStandard.Exists)
                      {
                        aqObject.CheckProperty(_2DCQStandard, "Visible", cmpequal, false)                                                
                      }
                      else
                      {
                        aqObject.CheckProperty(_2DCQStandard, "Exists", cmpequal, false)
                      }
                                            
                }
          }
          aqTestCase.End();
}

/*
  *@function
*/
function verifyInstallerBasic_ImageSetup_Monitor()
{
  aqTestCase.Begin("verifyInstallerBasic_ImageSetup_Monitor");
          if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
          { 
                if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                {        
                     
                      lib_button.clickEnableCroppingRegion();                 
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
                      delay (10000);
                      
                      if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Grid", "", 1).WPFObject("Button", "Control", 1).IsFocused == false)
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Grid", "", 1).WPFObject("Button", "Control", 1).Click();
                      
                      if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Grid", "", 1).WPFObject("Button", "Control", 1).IsFocused == true)
                      {
                            //US_84
                            var ivsToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar");               
                            aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_RestoreUI).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                            //1.4.1 add UserRole and RestoreUI 
                            aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                            aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                
                      
                            //US_92
                            
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Configuration", 2).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Image Settings ", 1).Click();
                            //Internal Lighting
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1),"Enabled", cmpEqual,false);
                            //LED group only M300                                 
                                   
//                            if ( Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 3, lib_const.const_delay_1000).Exists)
//                            {
//                                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 3).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1),"Enabled", cmpEqual,false);
//                            }
                            Log.Warning("chua verify led group cho M220"); 
                            
                            //US_092

                            var arrPro = ["WPFControlText", "ClrClassName", "ChildCount"];
                            var arrVal = ["Image Polarity Inversion", "TextBlock", 1];
                            
                            var temp = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
                            var temp1;
                            var count = 20;
                            while(count >0)
                            {
                              temp = temp.Parent;
                              if(temp.FindChild("ClrClassName", "CheckBox", 1000).Exists) 
                              {
                                temp1 = temp.FindChild("ClrClassName", "CheckBox", 1000);
                                break;
                              }
                              delay(1000);
                            }
                            if(count > 0) 
                            {
                              aqObject.CheckProperty(temp, "Visible", cmpEqual, true);
                              aqObject.CheckProperty(temp1, "Enabled", cmpEqual, true);
                            }
                            else Log.Error("Can not focus on Image Polarity Inversion");
                            
                            arrVal = ["Exposure Time (µs)", "TextBlock", 0];
                            temp = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
                            count = 20;
                            while(count >0)
                            {
                              temp = temp.Parent;
                              if(temp.FindChild("ClrClassName", "ExplicitUpdateDoubleUpDown", 1000).Exists) 
                              {
                                temp1 = temp.FindChild("ClrClassName", "ExplicitUpdateDoubleUpDown", 1000);
                                break;
                              }
                              delay(1000);
                            }
                            if(count > 0) 
                            {
                              aqObject.CheckProperty(temp, "Visible", cmpEqual, true);
                              aqObject.CheckProperty(temp1, "Enabled", cmpEqual, true);
                            }
                            else Log.Error("Can not focus on Exposure Time (µs)");
                            
                            
                            arrVal = ["Gain", "TextBlock", 1];
                            temp = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
                            count = 20;
                            while(count >0)
                            {
                              temp = temp.Parent;
                              if(temp.FindChild("ClrClassName", "ExplicitUpdateIntegerUpDown", 1000).Exists) 
                              {
                                temp1 = temp.FindChild("ClrClassName", "ExplicitUpdateIntegerUpDown", 1000);
                                break;
                              }
                              delay(1000);
                            }
                            if(count > 0) 
                            {
                              aqObject.CheckProperty(temp, "Visible", cmpEqual, true);
                              aqObject.CheckProperty(temp1, "Enabled", cmpEqual, true);
                            }
                            else Log.Error("Can not focus on Gain");
                            
                            arrVal = ["Gain Multiplier", "TextBlock", 1];
                            temp = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
                            count = 20;
                            while(count >0)
                            {
                              temp = temp.Parent;
                              if(temp.FindChild("ClrClassName", "ComboBox", 1000).Exists) 
                              {
                                temp1 = temp.FindChild("ClrClassName", "ComboBox", 1000);
                                break;
                              }
                              delay(1000);
                            }
                            if(count > 0) 
                            {
                              aqObject.CheckProperty(temp, "Visible", cmpEqual, true);
                              aqObject.CheckProperty(temp1, "Enabled", cmpEqual, true);
                            }
                            else Log.Error("Can not focus on Gain Multiplier");
                            
                            arrVal = ["Internal Lighting", "TextBlock", 1];
                            temp = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
                            count = 20;
                            while(count >0)
                            {
                              temp = temp.Parent;
                              if(temp.FindChild("ClrClassName", "ComboBox", 1000).Exists) 
                              {
                                temp1 = temp.FindChild("ClrClassName", "ComboBox", 1000);
                                break;
                              }
                              delay(1000);
                            }
                            if(count > 0) 
                            {
                              aqObject.CheckProperty(temp, "Visible", cmpEqual, true);
                              aqObject.CheckProperty(temp1, "Enabled", cmpEqual, false);
                            }
                            else Log.Error("Can not focus on Gain Multiplier");
                            
                            arrVal = ["LED Group", "TextBlock", 1];
                            temp = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
                            count = 20;
                            if(temp.Exists)
                            {
                              while(count >0)
                              {
                                temp = temp.Parent;
                                if(temp.FindChild("ClrClassName", "ComboBox", 1000).Exists) 
                                {
                                  temp1 = temp.FindChild("ClrClassName", "ComboBox", 1000);
                                  break;
                                }
                                delay(1000);
                              }
                              if(count > 0) 
                              {
                                aqObject.CheckProperty(temp, "Visible", cmpEqual, true);
                                aqObject.CheckProperty(temp1, "Enabled", cmpEqual, false);
                              }
                              else Log.Error("Can not focus on LED Group");
                            }
                            
                            // end US_092
                            //US_93,94
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("Button", "Image Auto-Setup", 1), "Enabled", cmpEqual, false);
                            if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Reading Distance", 2).ChildCount != 0)
                                aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Reading Distance", 2).WPFObject("StackPanel", "", 1).WPFObject("FocusAutolearnCommandButton"), "Enabled", cmpEqual, false);
                            //US_95
                            if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Cropping Region Area", 1).IsExpanded == false)
                                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Cropping Region Area", 1).set_IsExpanded(true);
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Cropping Region Area", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ExplicitUpdateDoubleUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Enabled", cmpEqual, false);
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Cropping Region Area", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("StackPanel", "", 1).WPFObject("ExplicitUpdateDoubleUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Enabled", cmpEqual, false);
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Cropping Region Area", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Enabled", cmpEqual, false);
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Cropping Region Area", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4).WPFObject("StackPanel", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Enabled", cmpEqual, false);
                            //US_96
                            //focus DMECC200
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Configuration", 2).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", 2).Click();
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Symbology Setup", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "Enabled", cmpEqual, false);
                            //US_101 
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ImageCheckBox", "", 1), "Enabled", cmpEqual, false);
                            //US_06
                            lib_button.clickPlay(true);
                            //US_102
                            lib_Action.chooseImageResolution();
                            //US_103
                            lib_button.clickDisplay_Chart_TableView();
                            Delay(lib_const.const_delay_3000);
                            lib_button.clickDisplay_Chart_TableView();
                            //US_104
                            lib_Action.chooseViewType();
                            Delay(lib_const.const_delay_6000);
                            lib_button.clickPause(true);
                             
                            //US_98,99,100
                            lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn, true);
                            lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn, true);
                            lib_button.clickToolbarButton(lib_const.const_bbt_ZoomOut, true);
                            lib_button.clickToolbarButton(lib_const.const_bbt_ZoomToFit, true);
                            //US_105,106,107
                            lib_button.clickResetStatistics();
                            lib_button.clickRefresh_Diagnostics_Statistics(); 
                      }else
                      {
                            Log.Warning(lib_err.err_DEVICE_NOT_FOCUSAUTOLEARN);
                      } 
                }
          }
  aqTestCase.End();
}

/*
  *update 20200228
  *@function   
*/
function verifyInstallerBasic_ReadingDistance()
{
          aqTestCase.Begin("verifyInstallerBasic_ReadingDistance");
          var isPPIdev =  existsPPI(lib_deviceInfo.const_Device_IP_Adress, lib_deviceInfo.const_Device_SerialNumber);  
          if (lib_deviceInfo.const_isPPI_device == true || isPPIdev == true)
          {
                  Log.Warning("Can not perform edit Reading Distance cause it's PPI device. Pls select others");
                  return;
          }
          lib_common.launchUI();  
          lib_UserRole.changeUserRole(lib_label.const_lb_InstallerBasic,false);
          
          if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
          { 
                if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                {        
                      //US_010    
                      for (var i = 1; i <10 ; i ++)
                      {                             
                             lib_CodeSetup.editReadingDistance (lib_CodeSetup.randomReadingDistance());
                      }   
                      lib_button.ui_PlayAndPause(  5000, false); 
                }
          }

aqTestCase.End();
}