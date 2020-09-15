//USEUNIT lib_CodeSetup
//USEUNIT lib_common
//USEUNIT lib_connection
//USEUNIT lib_const
//USEUNIT lib_DeleteJob
//USEUNIT lib_deviceInfo
//USEUNIT lib_ImageSetup
//USEUNIT lib_OpenJob
//USEUNIT lib_SaveIMG
//USEUNIT lib_validate
//USEUNIT lib_button

/**
  *@function for all device
*/
function testSuite_661_VerifyStandaloneSimulators()
{    
       Log.AppendFolder("func: testSuite_661_VerifyStandaloneSimulators");
       veriyM220_LedGroup();
       verifyStandaloneSimulators(); 
       Log.PopLogFolder();
}
/**
  *@function
*/
function saveImageForAllSimulator()
{
           Log.AppendFolder("func: saveImageForAllSimulator");
           if ( ! lib_validate["isDLCODERunning"]())
                      lib_common["launchUI"]();  
            var arr_Device  = lib_deviceInfo.const_Simulator_Device;
            var arr_Model   = lib_deviceInfo.const_Simulator_Model;
            var arr_Model_Detail   = lib_deviceInfo.const_Simulator_Model_Detail;     
            //delete and create folder contain image 
            lib_connection.Deleting_AddingFolder (lib_deviceInfo.const_fileName_SaveIMG);                
             for (var i = 0; i < arr_Device.length ; i ++)
            {                      
                     Log.Message(arr_Device[i] + "-" + arr_Model[i] );                  
                     var flag = connectToSimulator(arr_Device[i] , arr_Model[i]);
                     if (flag == lib_err.err_FUNC_SUCCESS)
                     {
                              //open job               
                              if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                              { 
                                     //save IMG & verify resolution
                                     var name =     arr_Device[i-1] +     arr_Model[i-1] +      arr_Model_Detail[i-1];           
                                    lib_SaveIMG.saveCurrentIMG (lib_deviceInfo.const_fileName_SaveIMG, name,arr_Device[i-1] , arr_Model[i-1]);
                              }
                     }
            }  
            //lib_common.terminateUI(); 
            Log.PopLogFolder();
}



/*add new 1.6.0 RC02*/ 
/**
  *@function
*/
function veriyM220_LedGroup ()
{

       try
       {
                Log.AppendFolder("func:") ;
//               if ( ! lib_validate.isDLCODERunning () || lib_validate.isUnExpectedWindowExists())
                lib_common.launchUI();  
                var arr_Device  = lib_deviceInfo.const_Simulator_Device;
                var arr_Model   = lib_deviceInfo.const_Simulator_Model;
                var arr_Model_Detail   = lib_deviceInfo.const_Simulator_Model_Detail;    
                // only for 2 devices M220
                for (var i = 7; i < arr_Device.length ; i ++) 
                {
                         Log.Message(i+ "**********************************************");
                         Log.Message(arr_Device[i] + "-" + arr_Model[i] );                  
                         var flag = connectToSimulator(arr_Device[i] , arr_Model[i]);
                         if (flag == lib_err.err_FUNC_SUCCESS)
                         {
                                  //open job               
                                  if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                                  { 
                                         if (arr_Model[i] == "355-040")
                                               verify_M220_NonPolarized();
                                         if (arr_Model[i] == "382-010") 
                                               verify_M220_Polarized();
                                  }
                         }
                }
                Log.PopLogFolder();
                //lib_common.terminateUI();
      }catch (e)
      {
        return lib_err.err_FUNC_EXCEPTION;
      } 
}
/**
  *@function
*/
function verify_M220_Polarized()
{
        Log.AppendFolder("func: verify_M220_Polarized");
        lib_button.clickAdvancedSetup();
        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Image Settings ", 1).Click();
        if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).IsExpanded == false)
              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).set_IsExpanded(true);
        var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1);
    
        var cbbLEDGroup = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 3).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1); 
        //internal lighting
        Objects.linkInternalLighting.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "", 1).WPFObject("Hyperlink", "", 1));
        Objects.cbb_InternalLighting_Default.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1));

        Objects.linkLedGroup.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 3).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "", 1).WPFObject("Hyperlink", "", 1));
        Objects.cbbLEDGroup_Default.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 3).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1));
    
        var arrLEDGroup =["Polarized" , "NonPolarized"];
        for (var i = 0; i <= 1; i++)
        {
              cbbLEDGroup.Click(); 
              cbbLEDGroup.ClickItem(i);
              if (i == 2)
              {
          
                    aqObject.CheckProperty(cbbLEDGroup, "wText", cmpEqual, "["+ (i+4) +", "+ arrLEDGroup[i]+"]");
                    Objects.Sector_Group_Visible.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 3));   
                    Objects.Polarized_linkSectors_Visible.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "", 1).WPFObject("Hyperlink", "", 1));
                    Objects.Polarized_SectorCheckboxTop.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).WPFObject("TextBlock", "*", 1));
                    Objects.Polarized_SectorCheckboxBottom.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).WPFObject("TextBlock", "*", 1));
                
                    //unchecked
                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "",4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).set_IsChecked (false);
                    lib_button.ui_PlayAndPause(2000,false);
                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).set_IsChecked (false);
                    lib_button.ui_PlayAndPause(2000,false);
                    //checked
                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).set_IsChecked (true);
                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).set_IsChecked( true);
                    lib_button.ui_PlayAndPause(2000,false);
               
              }
              else
              {       
                   aqObject.CheckProperty(cbbLEDGroup, "wText", cmpEqual, "["+ (i+4) +", "+ arrLEDGroup[i]+"]");
                   Objects.Sector_Group_Disabled.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 3));
           
              }
        }
        Log.PopLogFolder();
    
}     

/**
  *@function
*/
function verify_M220_NonPolarized()
{
          Log.AppendFolder("func: verify_M220_NonPolarized");
          lib_button.clickAdvancedSetup();
          Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Image Settings ", 1).Click();
          if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).IsExpanded == false)
                Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).set_IsExpanded(true);
          var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1);
    
          var cbbInternalLighting = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1);
          //internal lighting
          Objects.linkInternalLighting.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "", 1).WPFObject("Hyperlink", "", 1));
          Objects.cbb_InternalLighting_Default.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1));
          Objects.linkSectorVisible.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "", 1).WPFObject("Hyperlink", "", 1)); 
          Objects.SectorCheckboxTop.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).WPFObject("TextBlock", "*", 1));          
          Objects.SectorCheckboxBottom.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).WPFObject("TextBlock", "*", 1));
            
          for (var i = 0; i <= 3; i++)
          {
                cbbInternalLighting.Click(); 
                cbbInternalLighting.ClickItem(i);
                if (i == 0)
                {
                     aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[0, Disabled]");
                     Objects.linkSectorsDisabled.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "", 1).WPFObject("Hyperlink", "", 1));
                     Objects.SectorCheckboxTop_Disabled.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).WPFObject("TextBlock", "*", 1));
                     Objects.SectorCheckboxBottom_Disabled.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).WPFObject("TextBlock", "*", 1));
                }
                else
                {          
                      Objects.linkSectorVisible.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "", 1).WPFObject("Hyperlink", "", 1));
                      Objects.SectorCheckboxTop.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).WPFObject("TextBlock", "*", 1));
                      Objects.SectorCheckboxBottom.Check(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).WPFObject("TextBlock", "*", 1));
                
                       //unchecked
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).set_IsChecked (false);
                      lib_button.ui_PlayAndPause(2000,false);
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).set_IsChecked (false);
                      lib_button.ui_PlayAndPause(2000,false);
                      //checked
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).set_IsChecked (true);
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 4).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).set_IsChecked( true);
                      lib_button.ui_PlayAndPause(2000,false);
                }
          }
          Log.PopLogFolder();
    
}       
/**
  *@function
*/
function verifyStandaloneSimulators()
{
       try
       {
                Log.AppendFolder("func: verifyStandaloneSimulators");                 
                lib_common.launchUI();  
                var arr_Device  = lib_deviceInfo.const_Simulator_Device;
                var arr_Model   = lib_deviceInfo.const_Simulator_Model;
                var arr_Model_Detail   = lib_deviceInfo.const_Simulator_Model_Detail;    
                Log.Message ("Step 1:delete and create folder contain image ");
                //delete and create folder contain image 
                lib_connection.Deleting_AddingFolder (lib_deviceInfo.const_fileName_SaveIMG);
                for (var i = 0; i < arr_Device.length ; i ++)
//                for (var i = 2; i < 3 ; i ++)    
                { 
                         Log.Message(arr_Device[i] + "-" + arr_Model[i] );
                 
                         //verify icon toolbar
                         Log.Message(i+ "******* Step 2: verify Icon Toolbar **********************************************");                 
                         simulator_IconToolbar (arr_Device[i] , arr_Model[i], false );
                         //verify 7 device
                         Log.Message(i + "*******Step 3: open - save - delete - save IMG & verify-------------------");
                         var flag = connectToSimulator(arr_Device[i] , arr_Model[i]);
                         if (flag == lib_err.err_FUNC_SUCCESS)
                         {
                                  //open job               
                                  if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                                  { 
                                        //save IMG & verify resolution                          
                                        lib_SaveIMG.saveCurrentIMG (lib_deviceInfo.const_fileName_SaveIMG, arr_Model_Detail[i],arr_Device[i] , arr_Model[i]); 
                                        clickAdvancedSetup();
                                        var treeViewItemCodes = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1);
                                        var childCount = treeViewItemCodes.ChildCount;
                                        var resultAddFilter = lib_button.clickAddFilter(childCount - 1);
                                        Log.Message(resultAddFilter); 
                                        lib_button.clickEnableCroppingRegion(true);  
                                        simlulator_addDelete_AllCode2D ();                                                                      
                                        var flagSaveJob = lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N,  arr_Model_Detail[i], lib_const.const_isDefaultJob_Y, lib_const.isMonitorMode_N)
                                        lib_button.clickIVSMonitorButton();
                                        lib_button.ui_PlayAndPause(6000, true);
                                        lib_button.clickIVSMonitorButton();                                        
                                        lib_button.clickRemoveCroppingRegion(true);  
                                        Log.Message(lib_DeleteJob.deleteOnDevice( arr_Model_Detail[i]));  
                                  }
                         }
                }
                //lib_common.terminateUI();
                Log.PopLogFolder();
      }catch (e)
      {
        return lib_err.err_FUNC_EXCEPTION;
      } 
}

 
/**
  *@function
*/
function simlulator_addDelete_AllCode2D()
{
         Log.AppendFolder("func: simlulator_addDelete_AllCode2D"); 
         var arr = [    lb_DMECC200  ,  lb_QR        ,  lb_MICROQR    ,  lb_AZTEC     ,  lb_MAXICODE       ]; //total : 21 code
         lib_button.clickDeleteCode(2);                    
         for (var i = 1; i <= arr.length ; i++)
         {
              //US_14                       
              lib_button.clickAddCode (lib_label.lb_CodeType2D, arr[i-1]);
              if (i == arr.length)
              {
                     var childCount = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).ChildCount;
                     for (var j = childCount ; j >2 ; j --)
                     {
                              //US_33                                 
                              lib_CodeSetup.editCodeSize (j-1, 100,100,100,100);
                               //US_25
                              lib_button.clickDeleteCode(j-1);
                     }
              }
                              
         }
         Log.PopLogFolder();
}
/**
  *@function
  *@param{String} device
  *@param{String} model 
  *@param{String} jobName  
*/
function verifyDeleteJobSimulator (device, model, jobName)
{
       Log.AppendFolder("func: verifyDeleteJobSimulator");
       var flag = false;
       if (connectToSimulator(device , model )== lib_err.err_FUNC_SUCCESS)
       {    
                 Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", 3).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
                 Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", 3).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1)
                 if (lib_validate.isJobExist(jobName))
                        Log.Warning(lib_err.msg_ERR_VERIFY_DELETE);
                 else 
                        flag = true;
                 Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Open Configuration from Device").WPFObject("JobListDialogWindow", "Open Configuration from Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
       } 
       Log.Message("verifyDeleteJob: " + flag);
       Log.PopLogFolder();
       return flag;
}


/**
  *@function
  *@param{String} device
  *@param{String} model  
*/
function verifyConnectToSimulator (device , model )
{
          try
          {
          Log.AppendFolder("func: verifyConnectToSimulator");
          var flag = true;
          var txtDeviceName ,txtDeviceModel ,txtLayoutType,txtRole;
          var txtStartUpJob ;
          var txtStatus;
          var txtStartUpInfo ;
          var txtIP;
          var txtFirmware;
          var txtLoaderVersion ; 
          //path of grid list                 
          if (aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1), "Enabled", cmpEqual, true))
          {
                  //get info from Device Selected Detail
                  var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1);  
                  txtDeviceName = gridList.WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).get_Text();
                  txtDeviceModel = gridList.WPFObject("Grid", "", 2).WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 1).get_Text();
                  txtLayoutType = gridList.WPFObject("Grid", "", 3).WPFObject("TextBlock", "*", 2).get_Text();
                  txtRole= gridList.WPFObject("Grid", "", 4).WPFObject("TextBlock", "*", 2).get_Text();
                  txtStartUpJob = gridList.WPFObject("Grid", "", 5).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).get_Text();
                  txtStatus = gridList.WPFObject("Grid", "", 5).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 2).get_Text();
                  txtStartUpInfo = gridList.WPFObject("Grid", "", 6).WPFObject("TextBlock", "*", 2).get_Text();
                  txtIP = gridList.WPFObject("Grid", "", 7).WPFObject("TextBlock", "*", 2).get_Text();
                  txtFirmware= gridList.WPFObject("Grid", "", 9).WPFObject("TextBlock", "*", 2).get_Text();
                  txtLoaderVersion= gridList.WPFObject("Grid", "", 10).WPFObject("TextBlock", "*", 2).get_Text();
                  
                  //verify information
                  if (txtDeviceName != "Matrix")
                          flag = false;
                  else 
                          aqObject.CheckProperty(gridList.WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpEqual, "Matrix");
                  if (txtStartUpInfo != "OK")
                          flag = false;
                  else         
                          aqObject.CheckProperty(gridList.WPFObject("Grid", "", 6).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpEqual, "OK");
                  if (txtIP != "127.0.0.1")
                          flag = false;
                  else 
                          aqObject.CheckProperty(gridList.WPFObject("Grid", "", 7).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpEqual, "127.0.0.1");
                  
                  if (txtFirmware != lib_deviceInfo.const_firmware_version)
                          flag = false;
                  else 
                          aqObject.CheckProperty(gridList.WPFObject("Grid", "", 9).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpEqual, lib_deviceInfo.const_firmware_version);
                 
                  if (txtLoaderVersion != "N/D")
                          flag = false;
                  else  
                          aqObject.CheckProperty(gridList.WPFObject("Grid", "", 10).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpEqual, "N/D");
                  
                  if (txtLayoutType == "" || txtRole == "" || txtStartUpJob == "" || txtStatus == "")
                          flag = false;
                          
                  for ( var i = 0 ; i < lib_deviceInfo.const_Simulator_Model_Detail.length ; i++)
                  {
                          if (lib_deviceInfo.const_Simulator_Device[i] == device && lib_deviceInfo.const_Simulator_Model[i] == model)
                          {
                                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual,lib_deviceInfo.const_Simulator_Model_Detail[i] );
                                                           
                                                                                                                              
                          }
                  }
          }       
          Log.PopLogFolder();
          return flag;
          
    }catch (e)
    { 
         Log.Message(lib_err.err_FUNC_EXCEPTION);        
    }

}

/**
  *@function
  *@param{String} device
  *@param{String} model  
*/
function connectToSimulator (device , model)
{
//    Log.AppendFolder("func: connectToSimulator");
    var flag = lib_err.err_FUNC_FAILED; 
//    if (lib_validate.isDLCODERunning() == false)
    lib_common.launchUI();   
    try {
  
        while ( !lib_validate.isGettingStartedScreen())
        {
              lib_common.gettingStarted();
        } 
        var offlineDevices = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WPFObject("SimulatorsAccordionItem");
        if (offlineDevices.IsSelected == false)
                  offlineDevices.set_IsSelected (true);
        delay (6000);           
        if (  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WaitWPFObject("SimulatorsAccordionItem", lib_const.const_delay_1000).Exists)
        {         
                   
                  var offlineDevicesAccordionItem = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WPFObject("SimulatorsAccordionItem");
                                                   
                  if (offlineDevicesAccordionItem.WaitWPFObject("DeviceTreeView", "", 1, lib_const.const_timeOut).Exists  ) 
                  {
                          var offlineDeviceTree = offlineDevicesAccordionItem.WPFObject("DeviceTreeView", "", 1);
                          //get .WPFObject of TreeView
                          while (offlineDeviceTree.ChildCount == 1 )
                          {     
                                Delay(lib_const.const_delay_4000);
                                Sys.Process("DL.CODE").Refresh();    
                          }  
                          if  (offlineDeviceTree.ChildCount > 1 )
                          { 
                                  //In TreeView Online Device, there is 1 item - last index - AdornerLayer - is not a TreeListItem of Device
                                  for (var i = 1; i < offlineDeviceTree.ChildCount ; i++)
                                  {
                                          var btt = offlineDeviceTree.WPFObject("TreeViewItem", "", i).WPFObject("Grid", "", 1).WPFObject("Box");
                                          btt.set_IsChecked (false);
                                  }
                                  for (var i = 1; i < offlineDeviceTree.ChildCount ; i++)
                                  {
                                           
                                          //get current device
                                          var currDevice = offlineDevices.WPFObject("DeviceTreeView", "", 1).WPFObject("TreeViewItem", "", i).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;

                                          //compare current device with expected device
                                          if ( (device + " "+ model) ==  currDevice )   
                                          {           
                                                       var btt = offlineDeviceTree.WPFObject("TreeViewItem", "", i).WPFObject("Grid", "", 1).WPFObject("Box");
                                                       if (btt.IsChecked == false)
                                                       { 
                                                              btt.set_IsChecked (true);
                                                       }
                                                       if (btt.IsChecked)
                                                       { 
                                                              delay (20000);
                                                              offlineDeviceTree.WPFObject("TreeViewItem", "", i).DblClick();
                                                              //validate UnExpectedWindow
                                                              if (lib_validate.isUnExpectedWindow() == true)
                                                              {
                                                                    lib_common.proccessUnexpectedWindow(); 
                                                                    return lib_err.err_FUNC_FAILED;
                                                              } else
                                                              {
                                                                    flag = lib_err.err_FUNC_SUCCESS;
                                                              }
                                                       } 
                                                       if (verifyConnectToSimulator (device,model) == true)                                                       
                                                       {
                                                              flag = lib_err.err_FUNC_SUCCESS;                                                        
                                                              return flag;
                                                       }
                                         }   
                                  }                                 
                          }  
                  }  
          }
//          Log.PopLogFolder();      
    }catch (e)
    { 
         Log.Message(lib_err.err_FUNC_EXCEPTION);        
    }
    return flag; 
}

/**
  *@function
  *@param{String} device
  *@param{String} model 
  *@param{String} btFindDevices  
*/
function simulator_IconToolbar (device, model , btFindDevices)
{
     if ( ! lib_validate.isDLCODERunning () || lib_validate.isUnExpectedWindowExists())
                          lib_common.launchUI();   
     try
     {
           Log.AppendFolder("func: simulator_IconToolbar");
           //*************************************************************************************************************************
           //Step 1 : NOTCONNECT_DEVICE  
           Log.Message(lib_messageLog.msg_NOTCONNECT_DEVICE);
           while ( !isGettingStartedScreen())
           {
              gettingStarted();
              Sys.Process("DL.CODE").Refresh(); 
           }
           if (isGettingStartedScreen())
           {
                if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WaitWPFObject("IvsToolBar", lib_const.const_delay_1000).Exists)
                {
                    var ivsToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar");
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, btFindDevices);
                }
            
           }
           //validate getting Started when connecting to device
           Log.Message(lib_messageLog.msg_CONNECT_DEVICE);           
           if (connectToSimulator( device , model) == true)
           {    
               //*************************************************************************************************************************
               //Step 2: CONNECT_DEVICE
               if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WaitWPFObject("IvsToolBar", lib_const.const_delay_1000).Exists)
               {
                    var ivsToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar");
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, btFindDevices);
                    
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 3).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 4).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 5).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 6).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 7).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 8).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    if (device == lib_const.const_M300)
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 9).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    if (device == lib_const.const_M410)
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 9).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                
               }
              
               //*************************************************************************************************************************
               //Step 2.1: CONNECTING_DEVICE
               if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == false)
                   return ;
                   
               if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WaitWPFObject("IvsToolBar", lib_const.const_delay_1000).Exists)
               {
                    var ivsToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar");
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 3).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 4).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 5).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 6).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 7).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 8).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                     if (device == lib_const.const_M300)
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 9).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    if (device == lib_const.const_M410)
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 9).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                
               }
               //*************************************************************************************************************************
               //Step 2.1.1: MONITOR_DEVICE    
               Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", 8).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 2).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 3).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 4).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 5).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 6).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 7).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
               aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 8).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               if (device == lib_const.const_M300)
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 9).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
               if (device == lib_const.const_M410)
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", 9).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                
                            
           }
           Log.PopLogFolder();     
   }
   catch (e)
   {
     Log.Warning(lib_err.err_FUNC_EXCEPTION);
   }    
}