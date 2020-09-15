//USEUNIT lib_common
//USEUNIT lib_UserRole
//USEUNIT lib_validate
//USEUNIT Device
//USEUNIT lib_Action
//USEUNIT lib_SaveIMG


/*
  *@function 
*/
function verifyUserBasic() 
{
  aqTestCase.Begin("verifyUserBasic");
        changeToUserBasic();
        userBasic();
        aqTestCase.End();

}

//edit 1.5.0a7
/*
  *@function 
*/
function changeToUserBasic()
{
//         if ( ! lib_validate["isDLCODERunning"]())
         lib_common["launchUI"]();  
         lib_UserRole.changeUserRole(lib_label.const_lb_UserBasic,false);
//         terminateUI();
}

/*
  *@function 
*/
function userBasic ()
{
//        if ( ! lib_validate["isDLCODERunning"]())
        lib_common["launchUI"]();  

        //US_135,US_136,US_137,US_138,US_139  
        Device.MenuBar_Device_UserBasic(false);        
        if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
        { 
                
                
               var path =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1);    
                //DEVICE IS M300||M410||M450|M220               
               if(  
                    
                    (lib_deviceInfo.const_Device_Model == lib_const.const_M300 )|| 
                    (lib_deviceInfo.const_Device_Model == lib_const.const_M410 )||
                    (lib_deviceInfo.const_Device_Model == lib_const.const_M450 )||
                    lib_deviceInfo.const_Device_Model == lib_const.const_M320 )
               {
                    //edit path from 1.4.1                     
                     path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1).Click(); 
               }
               //DEVICE IS M210      
               if( (lib_deviceInfo.const_Device_Model == lib_const.const_M220 )||   // add new 1.6.0 
                    lib_deviceInfo.const_Device_Model == lib_const.const_M210 )
               {
                    //edit path from 1.4.1
                     path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1).Click();
               }
               //DEVICE IS M210    
               if(  lib_deviceInfo.const_Device_Model == lib_const.const_M120 )
               {
                   //edit path from 1.4.1
                    path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor -  2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1).Click();
               }
                Delay(2000);
                lib_button.clickPause(true);
                //aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("ToolTip", "Save on Device", 1000), "Enabled", cmpEqual, false);
                aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("ToolTip", "Save Configuration in Temporary Memory", 1000), "Enabled", cmpEqual, false);             
                
                //US_158 &145
                lib_button.clickPlay(true);
                //US_164
                lib_Action.chooseImageResolution();
                //US_167
                lib_button.clickDisplay_Chart_TableView();
                Delay(lib_const.const_delay_3000);
                lib_button.clickDisplay_Chart_TableView();
                //US_140,141,US_168
                lib_Action.chooseViewType();
                Delay(lib_const.const_delay_6000);
                lib_button.clickPause(true);
                             
                //US_159,160,161
                lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn, true);
                lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn, true);
                lib_button.clickToolbarButton(lib_const.const_bbt_ZoomOut, true);
                lib_button.clickToolbarButton(lib_const.const_bbt_ZoomToFit, true);
                //US_169,US_170, US_171, US_172
                lib_button.clickResetStatistics();
                lib_button.clickRefresh_Diagnostics_Statistics();
                lib_button.clickRefresh_Diagnostics_Statistics_2();
                //US_154,155,156
                //1.4.1 add UserRole and RestoreUI  
                var ivsToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar");               
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_RestoreUI).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                //1.4.1 add UserRole and RestoreUI 
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                //US_162
                //linhtnguyen comment
                // lhoang add while
                while(!Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Button", "", const_bbt_SaveImage - 2).WPFObject("Image", "", 1).Enabled)
                {
                lib_button.clickPlay(true);
                lib_button.clickPause(true);
                }
                //
                aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Button", "", const_bbt_SaveImage - 2).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                
                if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Grid", "", 1).WPFObject("Button", "Control", 1).IsFocused == false)
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Grid", "", 1).WPFObject("Button", "Control", 1).Click();
                      
                if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Grid", "", 1).WPFObject("Button", "Control", 1).IsFocused == true)
                {
                      //US_142,143
                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("Button", "Image Auto-Setup", 1), "Enabled", cmpEqual, false);
                      //device has Focus autolearn
                      if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Reading Distance", 2).ChildCount != 0)
                              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Reading Distance", 2).WPFObject("StackPanel", "", 1).WPFObject("FocusAutolearnCommandButton"), "Enabled", cmpEqual, false);
                       //device has PPI 
                      if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("PPIExpander").ChildCount != 0)
                              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("PPIExpander").WPFObject("StackPanel", "", 1).WPFObject("AcquirePPICommandButton"), "Enabled", cmpEqual, false);      
                  
                }
                //
               
                //save IMG -- US_162
                lib_SaveIMG.clickSaveImageButton_Monitor();
               delay(3000);
               // US_143
              clickPlay(true);
              clickPause(true);
              var arrPro = ["ClrClassName", "WPFControlText"];
              var arrVal = ["TextBlock", "Configuration"];
              Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000).Click();
              arrVal = ["TextBlock", "General Image Settings"];
              
              if(Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000).Exists)
              {
                Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000).Click();
              }
              else
              {
                arrVal = ["TextBlock", "Image Settings "];
                if(Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000).Exists)
                {
                  Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000).Click();
                }
              }
              
              arrVal = ["Button", "Control"];
              Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000).Click();
              if(Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000).Exists)             
              {
                aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000), "Enabled", cmpEqual, false);
              }
              
              //US_126
              
              lib_UserRole.changeUserRole(lib_label.const_lb_InstallerExpert,true);
              lib_UserRole.changeUserRole(lib_label.const_lb_UserBasic,true);
        }
//        terminateUI();
}
