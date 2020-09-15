//USEUNIT lib_ChangeIP
//USEUNIT lib_CodeSetup
//USEUNIT lib_common
//USEUNIT lib_connection
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_DeviceSelectedDetail
//USEUNIT lib_OpenJob
//USEUNIT lib_SaveIMG
//USEUNIT lib_SaveJob
//USEUNIT lib_validate
//USEUNIT lib_UserRole
//USEUNIT lib_label
//USEUNIT lib_SaveIMG
//USEUNIT simulator_common

/**
  *@function
*/ 
function tc_Expected_Exclude_Content ()
{ 
       //expected content
       tc_CodeFilter_Default(true);
       tc_CodeFilter (true, lib_const.const_EXPECTED_CONTENT);
       // excluded content
       tc_CodeFilter_Default(false);
       tc_CodeFilter (false, lib_const.const_EXCLUDED_CONTENT);       
 }
  
  
 /**
  *@function expected code is input from user
*/ 
function tc_CodeFilter(isExpectedContent, dataExpected) 
{ 
        if ( ! lib_validate.isDLCODERunning())
                lib_common.launchUI();     
        var ip = lib_deviceInfo.const_Device_IP_Adress;    
        //get correct control is Expected or Excluded Content
        var index = 0;
        if (isExpectedContent == true)
              index = 1;// 
        else
              index = 2;
        //1. connect and enter Default job      
        if (lib_common.connectToDevice(ip))
        {         
                if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                { 
                       if (quickSetup(true,true,true , true , false) == true)//Static
                       {                             
                             lib_button.clickAdvancedSetup();
                             if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).IsExpanded == false)
                                        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).set_IsExpanded(true);
                              //enter data to Expected data
                              var editExpectedControl = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", index).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("newDelay").WPFObject("Grid", "", 1).WPFObject("rtbText");
                              editExpectedControl.Keys(dataExpected); 
                              //add to control
                              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", index).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1).Click();
                              
                              //verify value enter to Expected or Excluded Content
                              //every <space> is displays as a letter
                              var numSpace = lib_common.countSpace(dataExpected);
                              var tmpText="" ;                              
                              var listb = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("listb");
                              if (listb.ChildCount > 0)
                              {        
                                       var listItem =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", index).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("listb").WPFObject("ContentPresenter", "", 1).WPFObject("listboxItem");                      
                                       for (var i = 1 ; i <= listItem.ChildCount - 1 - numSpace ; i ++)
                                       {
                                           var tmp =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", index).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("listb").WPFObject("ContentPresenter", "", 1).WPFObject("listboxItem").WPFObject("ContentPresenter", "", i).WPFObject("TextBlock", "*", 1).WPFControlText; 
                                           tmpText = tmpText + tmp;
                                       }
                                       if (dataExpected != tmpText)
                                           Log.Error(lib_err.err_EXPECTED_EXCLUDED_CONTENT);
                              }
                              //verify Console and Expected code                               
                              lib_button.ui_PlayAndPause(3000,false);
                              var flag = verifyDataExpected(dataExpected);
                              if (isExpectedContent == true)
                              {
                                  if (flag == false)
                                           Log.Warning("isExpectedCode:" + dataExpected + ""+ flag);
                                    else
                                           Log.Message("isExpectedCode:" + dataExpected + ""+ flag);
                              }else
                              {  
                                   if (flag == true)
                                           Log.Warning("isExpectedCode:" + dataExpected + ""+ flag);
                                    else
                                           Log.Message("isExpectedCode:" + dataExpected + ""+ flag);
                              }
                       }      
                }
        }   
        //lib_common.terminateUI();
}
/*expected code is output from Quick Setup
isExpectedContent = TRUE  => Expected Content
isExpectedContent = FALSE => Excluded Content
*/
function tc_CodeFilter_Default(isExpectedContent) 
{ 
//        if ( ! lib_validate.isDLCODERunning())
                lib_common.launchUI();     
        var ip = lib_deviceInfo.const_Device_IP_Adress;    
        var index = 0;
        if (isExpectedContent == true)
              index = 1;
        else
              index = 2;
        if (lib_common.connectToDevice(ip))
        {         
                if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                { 
                       if (quickSetup(true,true,true , true , false) == true)//Static
                       {
                             var dataExpected = getDataFromResult();
                             Log.Message(dataExpected);
                             lib_button.clickAdvancedSetup();
                             if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).IsExpanded == false)
                                        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).set_IsExpanded(true);
                              //enter data to Expected data
                              var editExpectedControl = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", index).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("newDelay").WPFObject("Grid", "", 1).WPFObject("rtbText");
                              editExpectedControl.Keys(dataExpected); 
                              //add to control
                              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", index).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1).Click();
                              
                              //verify value enter
                              var numSpace = lib_common.countSpace(dataExpected);
                              var tmpText="" ;
                              var listb = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("listb");
                              if (listb.ChildCount > 0)
                              {        
                                       var listItem =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", index).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("listb").WPFObject("ContentPresenter", "", 1).WPFObject("listboxItem");                      
                                       for (var i = 1 ; i <= listItem.ChildCount - 1 - numSpace ; i ++)
                                       {
                                           var tmp =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", index).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("listb").WPFObject("ContentPresenter", "", 1).WPFObject("listboxItem").WPFObject("ContentPresenter", "", i).WPFObject("TextBlock", "*", 1).WPFControlText; 
                                           tmpText = tmpText + tmp;
                                       }
                                       if (dataExpected != tmpText)
                                           Log.Error(lib_err.err_EXPECTED_EXCLUDED_CONTENT);
                              }
                                
                              
                              lib_button.ui_PlayAndPause(3000,false);
                              var flag = verifyDataExpected(dataExpected);
                              if (isExpectedContent == true)
                              {
                                  if (flag == false)
                                           Log.Warning("isExpectedCode:" + dataExpected + ""+ flag);
                                    else
                                           Log.Message("isExpectedCode:" + dataExpected + ""+ flag);
                              }else
                              {  
                                   if (flag == true)
                                           Log.Warning("isExpectedCode:" + dataExpected + ""+ flag);
                                    else
                                           Log.Message("isExpectedCode:" + dataExpected + ""+ flag);
                              }
                       }      
                }
        }   
        //lib_common.terminateUI();
}
  
 



/*add new 1.6.0 RC02*/ 
/**
  *@function 
*/
function validate_M220_LEDGroup ()
{
       try
       {
              Log.AppendFolder("func: validate_M220_LEDGroup");
//              if ( ! lib_validate.isDLCODERunning () || lib_validate.isUnExpectedWindowExists())
                          lib_common.launchUI();  
                     
               var flag = lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);
               if (flag == lib_err.err_FUNC_SUCCESS)
               {
                        //open job               
                        if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                        { 
                                //open job               
                                  if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                                  { 
                                          if (lib_deviceInfo.const_Device_Model == lib_const.const_M220 )
                                          {    
                                                  var deviceName = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "*", 2).WPFControlText;
                                                  
                                                  //if (  deviceName.charAt(6) == 8)// e.g, M220 382-040
                                                  if(aqString.Contains(lib_deviceInfo.const_Device_Model_Detail, "DPM"))                                            
                                                  {
                                                         Log.Message(deviceName);
                                                         simulator_common.verify_M220_Polarized();
                                                          Log.Message(deviceName);
                                                  }
                                                  else
                                                  {
                                                         Log.Message(deviceName);
                                                         simulator_common.verify_M220_NonPolarized();
                                                  }
                                          } 
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


//updated 1.5.0  
/**
  *@function 
*/
function tc_quickSetup_M220()
{
         //add new from 1.6.0 RC02
         validate_M220_LEDGroup();
         //
//         if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI(); 
         var ip = lib_deviceInfo.const_Device_IP_Adress;
         if (lib_common.connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
         {                       
                if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
                {
                      Indicator.PushText("enable - remove CR at Advance Setup");
                      Indicator.PopText();
                      lib_button.clickEnableCroppingRegion(true);
                      Delay(lib_const.const_delay_1000);                      
                      lib_button.clickRemoveCroppingRegion(true); 
                      Indicator.PushText("perform Smart Quick Setup 1D & 2D : WHITE + BLACK");
                      Indicator.PopText();
                      //QSU_30, QSU_32, QSU_76
                      //quickSetup  (isStatic, is1D ,is2D, isFilter)   
                      if (lib_deviceInfo.const_Device_Model == lib_const.const_M220 )
                      {    
                              var deviceName = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "*", 2).WPFControlText;
                              var flagPolarized = false;
                              if (  deviceName.charAt(6) == 8)// e.g, M220 382-040
                                     flagPolarized =true;
                              if (flagPolarized == true)
                              {
                                      Log.Message("Non-Polarized");                                      
                                      // (isStatic, is1D ,is2D, isFilter, isNonPolarized)
                                      Log.Message(quickSetup(true,true,true , true , true));//Static 1D
                                      //QSU_76, QSU_33
                                      Log.Message(quickSetup(false,true,true, false, true));//Dynamic 2D                              
                              }
                      }                      
                      Log.Message("Polarized");
                      // (isStatic, is1D ,is2D, isFilter, isNonPolarized)
                      Log.Message(quickSetup(true,true,true , true , false));//Static
                      //QSU_76, QSU_33
                      Log.Message(quickSetup(false,true,true, false, false));//Dynamic
                      
                      
                      //QSU_01 -> 07
                      Indicator.PushText("move up/down; zoom in - out - fit");
                      Indicator.PopText();
                      lib_button.clickToolbarButton(lib_const.const_bbt_MoveUp ,false );
                      lib_button.clickToolbarButton(lib_const.const_bbt_MoveDown,false); 
                      clickStartContMode();
                      Delay(lib_const.const_delay_2000);
                      clickStopContMode();
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomOut,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomToFit,false);                     
                      
                      Indicator.PushText("enable - remove CR at Advance Setup");
                      Indicator.PopText();
                      lib_button.clickEnableCroppingRegion(false);
                      Delay(lib_const.const_delay_1000);
                      lib_button.clickRemoveCroppingRegion(false);                      
                }  
        }  
        //lib_common.terminateUI();
}


//updated 1.5.0  
/**
  *@function validate_M220_LEDGroup
*/
function tc_quickSetup()
{
  aqTestCase.Begin("tc_quickSetup");
         if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI(); 
         var ip = lib_deviceInfo.const_Device_IP_Adress;
         if (lib_common.connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
         {                       
                if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
                {
                      Indicator.PushText("enable - remove CR at Advance Setup");
                      lib_button.clickEnableCroppingRegion(true);
                      Delay(lib_const.const_delay_1000);                      
                      lib_button.clickRemoveCroppingRegion(true);
                      Indicator.PopText();
                      
                      Indicator.PushText("perform Smart Quick Setup 1D & 2D : WHITE + BLACK");
                      Indicator.PopText();
                      //QSU_30, QSU_32, QSU_76
                      //1D  & 2D : only M220 has Polarized
                      Log.Message(quickSetup(true,true,false , true , false));//Static
                      Log.Message(quickSetup(false,false,true, false, false));//Dynamic 
                      //QSU_01 -> 07
                      Indicator.PushText("move up/down; zoom in - out - fit");
                      Indicator.PopText();
                      lib_button.clickToolbarButton(lib_const.const_bbt_MoveUp ,false );
                      lib_button.clickToolbarButton(lib_const.const_bbt_MoveDown,false); 
                      clickStartContMode();
                      Delay(lib_const.const_delay_2000);
                      clickStopContMode();
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomOut,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomToFit,false); 
                      lib_button.clickCapture();
                      Indicator.PushText("enable - remove CR at Advance Setup");
                      Indicator.PopText();
                      lib_button.clickEnableCroppingRegion(false);
                      Delay(lib_const.const_delay_1000);
                      
                      var ext = [ lib_const.const_BMP  ,lib_const.const_JPEG  ,lib_const.const_GIF   ,lib_const.const_TIF    ];
                      for (var i = ext.length ; i >= 1 ; i --)
                      { 
                               lib_SaveIMG.clickSaveImageButton(lib_SaveJob.randomJobName()  , ext[i-1] ,lib_deviceInfo.const_fileName_SaveIMG, false);
                      }  
                      lib_button.clickRemoveCroppingRegion(false); 
                      Log.Message("capture");
                      lib_button.clickCapture(); 
                      lib_button.clickCapture();
                }  
        }  
        //lib_common.terminateUI();
        aqTestCase.End();
}
/**
  *@function 
*/
function tc_quickSetup1D()
{
        aqTestCase.Begin("TC_quickSetup1D");
         if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI();  
         var ip = lib_deviceInfo.const_Device_IP_Adress;         
         if (lib_common.connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
         {                       
                if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
                {
                      Indicator.PushText("enable - remove CR at Advance Setup");
                      lib_button.clickEnableCroppingRegion(true);
                      Delay(lib_const.const_delay_1000);                      
                      lib_button.clickRemoveCroppingRegion(true);
                      Indicator.PopText();
                      
                      Indicator.PushText("perform Smart Quick Setup 1D: WHITE AND BLACK COLOR");
                      //QSU_34, QSU_37    
                      //quickSetup  (isStatic, is1D ,is2D, isFilter)                    
                      Log.Message(quickSetup(true ,true,false , true,  false));//Static - 1D - NonPolarized
                      Log.Message(quickSetup(false,true,false , false, false));//dynamic - 2D - NonPolarized
                      Indicator.PopText();
                      //QSU_01 -> 07
                      Indicator.PushText("move up/down; zoom in - out - fit");
                      clickStartContMode();
                      Delay(lib_const.const_delay_2000);
                      clickStopContMode();
                      lib_button.clickToolbarButton(lib_const.const_bbt_MoveUp ,false );
                      lib_button.clickToolbarButton(lib_const.const_bbt_MoveDown,false);
                      // 
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomOut,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomToFit,false);
                      Indicator.PopText();
                       
                      Indicator.PushText("enable - remove CR at Advance Setup");
                      lib_button.clickEnableCroppingRegion(false);
                      Delay(lib_const.const_delay_1000);
                      lib_button.clickRemoveCroppingRegion(false);
                      
                      var ext = [ lib_const.const_BMP  ,lib_const.const_JPEG  ,lib_const.const_GIF   ,lib_const.const_TIF    ];
                      for (var i = ext.length ; i >= 1 ; i --)
                      { 
                               lib_SaveIMG.clickSaveImageButton(lib_SaveJob.randomJobName()  , ext[i-1] ,lib_deviceInfo.const_fileName_SaveIMG, false);
                      }  
                      Log.Message("capture");
                      lib_button.clickCapture(); 
                      lib_button.clickCapture();
                      Indicator.PopText();
                }  
        }  
        //lib_common.terminateUI();
        aqTestCase.End();
}

/**
  *@function 
*/
function tc_quickSetup2D()
{
           aqTestCase.Begin("tc_quickSetup2D");
//         if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI();  
         var ip = lib_deviceInfo.const_Device_IP_Adress;
         if (lib_common.connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
         {                       
                if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
                {
                      Indicator.PushText("enable - remove CR at Advance Setup");
                      lib_button.clickEnableCroppingRegion(true);
                      Delay(lib_const.const_delay_1000);                      
                      lib_button.clickRemoveCroppingRegion(true);
                      Indicator.PopText();
                      
                      Indicator.PushText("perform Smart Quick Setup 2D: WHITE , BLACK , DPM, GS1");
                      //QSU_35 , QSU_38, QSU_39
                      //quickSetup  (isStatic, is1D ,is2D, isFilter)        
                      Log.Message(quickSetup(true ,false,true, true, false ));
                      Log.Message(quickSetup(false,false,true, false,false ));
                      Indicator.PopText();                      
                      //QSU_01 -> 07
                      Indicator.PushText("move up/down; zoom in - out - fit");
                      lib_button.clickToolbarButton(lib_const.const_bbt_MoveUp ,false );
                      lib_button.clickToolbarButton(lib_const.const_bbt_MoveDown,false);
                      // 
                      clickStartContMode();
                      Delay(lib_const.const_delay_2000);
                      clickStopContMode();
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomOut,false);
                      lib_button.clickToolbarButton(lib_const.const_bbt_ZoomToFit,false);
                      Indicator.PopText();
                      
                      Indicator.PushText("enable - remove CR at Advance Setup");
                      lib_button.clickEnableCroppingRegion(false);
                      Delay(lib_const.const_delay_1000);
                      lib_button.clickRemoveCroppingRegion(false);
                      var ext = [ lib_const.const_BMP  ,lib_const.const_JPEG  ,lib_const.const_GIF   ,lib_const.const_TIF    ];
                      for (var i = ext.length ; i >= 1 ; i --)
                      { 
                               lib_SaveIMG.clickSaveImageButton(lib_SaveJob.randomJobName()  , ext[i-1] ,lib_deviceInfo.const_fileName_SaveIMG, false);
                      }  
                      Log.Message("capture");
                      lib_button.clickCapture(); 
                      lib_button.clickCapture();
                      Indicator.PopText();                
                }  
        }  
        //lib_common.terminateUI();
        aqTestCase.End();
} 

 
/**
  *@function 
  *@param {boolean} isStatic
  *@param {boolean} is1D
  *@param {boolean} is2D
  *@param {boolean} isFilter
  *@param {boolean} isNonPolarized 
*/
function quickSetup  (isStatic, is1D ,is2D, isFilter, isNonPolarized)// isNonPolarized default: false
{
        var flag = false; 
        lib_button.clickQuickSetup();
        delay(2000);
        lib_button.clickSmartSetupActionButton();         
        //wait
        for (var i = 1; i <= 2; i ++)
        {      
              var result = Sys.Process("DL.CODE").WaitWPFObject("HwndSource: QuickSetupDpmAutolearnDialogWindow", lib_label.lb_QuickSetup, lib_const.const_delay_1000).Exists;            
              if (result == false)
              {      
                    lib_common.waitDelay(1000, 10);            
                    Sys.Process("DL.CODE").Refresh();
              }
        }        
        //QuickSetupDpmAutolearnDialogWindow existed
        if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: QuickSetupDpmAutolearnDialogWindow", lib_label.lb_QuickSetup, lib_const.const_delay_1000).Exists)
        {
              //verify init window     
              verifyInitQuickSetupDpmAutolearnDialogWindow();
              var path = Sys.Process("DL.CODE").WPFObject("HwndSource: QuickSetupDpmAutolearnDialogWindow", lib_label.lb_QuickSetup).WPFObject("QuickSetupDpmAutolearnDialogWindow", lib_label.lb_QuickSetup, 1).WPFObject("Grid", "", 1);
               //input variable
              //process Static
              if (isStatic ==  true)
                    path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("RadioButton", lib_label.lb_Static, 1).ClickButton();
              else
                    path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("DynamicButton").ClickButton(); 
              //1D
              if (is1D == true)
                  path.WPFObject("Grid", "", 1).WPFObject("CheckBox", lib_label.lb_1DCode, 1).ClickButton(cbChecked);
              else
                  path.WPFObject("Grid", "", 1).WPFObject("CheckBox", lib_label.lb_1DCode, 1).ClickButton(cbUnchecked);
                  //1D
              if (is2D == true)
                  path.WPFObject("Grid", "", 1).WPFObject("CheckBox", lib_label.lb_2DCode, 2).ClickButton(cbChecked);
              else
                  path.WPFObject("Grid", "", 1).WPFObject("CheckBox", lib_label.lb_2DCode, 2).ClickButton(cbUnchecked);
              
              if (lib_deviceInfo.const_Device_Model == lib_const.const_M220 )                   
              {
                    //isNonPolarized
                    if (isNonPolarized == true)                  
                        path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("RadioButton", "Non Polarized", 2).ClickButton();   
                   
              } 
              //apply this checkbox to all devices  -- giang.ha comment 1.9.0A3 20200224              
              if (isFilter == true)
                        path.WPFObject("Grid", "", 1).WPFObject("CheckBox", "Include Image Filtering", 4).ClickButton(cbChecked);
                        
                        
              //click on <Start> btt              
              if (path.WPFObject("Grid", "", 2).WPFObject("Button", "Start", 1).IsEnabled == true)
              {
                  path.WPFObject("Grid", "", 2).WPFObject("Button", "Start", 1).ClickButton();
                  //progress bar 
                  while (path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WaitWPFObject("BusyIndicator", "", 100).Exists == true)
                  { 
                      Delay(500);
                      Sys.Process("DL.CODE").Refresh();
                  }
                   
              }
              if(lib_validate.isUnExpectedWindow() == true)
                          return false; 
              // wait till end of the process
              while (path.WPFObject("Grid", "", 2).WPFObject("Button", "Start", 1).IsEnabled == false)
              {
                      if(lib_validate.isUnExpectedWindow() == true)
                          return false; 
                      Delay(lib_const.const_delay_3000);
                    
              }
              //end of the process 
              if (path.WPFObject("Grid", "", 2).WPFObject("Button", "Start", 1).IsEnabled == true)
              {
                      var result = path.WPFObject("TextBlock", "*", 2).WPFControlText;
                      if ( result == lib_label.lb_QuickSetup_Failure || result == lib_label.lb_QuickSetup_Failure2)
                      {
                            Log.Warning(result);
                            aqObject.CheckProperty(path.WPFObject("Grid", "", 2).WPFObject("Button", "*", 3), "WPFControlText", cmpEqual, "Close");
                            path.WPFObject("Grid", "", 2).WPFObject("Button", "Close", 3).ClickButton();                             
                            return true;
                      }
                      if (result == lib_label.lb_QuickSetup_Completed)
                      {     
                            //QSU_051
                            aqObject.CheckProperty(path.WPFObject("Grid", "", 2).WPFObject("Button", "*", 3), "WPFControlText", cmpEqual, "Close");
                            path.WPFObject("Grid", "", 2).WPFObject("Button", "Close", 3).ClickButton();  
                            //verify expected code
                            var pathTree = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3);
                            if (pathTree.WPFObject("TreeViewItem", "", 1).IsExpanded == false)
                                  pathTree.WPFObject("TreeViewItem", "", 1).set_IsExpanded(true); 
                            
                            var resultCode = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", 2).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                            Log.Message(" Quick Setup:"+ result +"-"+ resultCode);
                            //verify Good Read msg
                            var is_GoodRead = isGoodRead(resultCode);
                            if (is_GoodRead == false)
                            {
                                Log.Warning("But Quick Setup: No Read");
                            }
                            else
                            {
                                    //verify 1D
                                    if (is1D == true && is2D == false)
                                    { 
                                          if (lib_validate.is1DCode(resultCode)== true)
                                                return true; 
                                    }
                                    //verify 2D
                                    if (is1D == false && is2D == true)
                                    {     if (lib_validate.is2DCode(resultCode)== true)
                                                return true; 
                                    }
                                    //verify 1D && 2D
                                    if (is1D == true && is2D == true)
                                    {      
                                          if (lib_validate.is1DCode(resultCode)== true || lib_validate.is2DCode(resultCode)== true)
                                                return true; 
                                    }
                            }                            
                      }
              }  
        }
}

//for all of devices
/**
  *@function
*/
function verifyInitQuickSetupDpmAutolearnDialogWindow()
{
              var path = Sys.Process("DL.CODE").WPFObject("HwndSource: QuickSetupDpmAutolearnDialogWindow", lib_label.lb_QuickSetup).WPFObject("QuickSetupDpmAutolearnDialogWindow", lib_label.lb_QuickSetup, 1).WPFObject("Grid", "", 1);
                         
              //verify Polarized (M220 if have )   
              if (lib_deviceInfo.const_Device_Model == lib_const.const_M220 )
              {    
                      var deviceName = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "*", 2).WPFControlText;
                                      
                      var flagPolarized = false;
                      if (  deviceName.charAt(6) == 8)// e.g, M220 382-040
                             flagPolarized =true;
                      if (flagPolarized == true)
                      {                                 
                              aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", "*", 1), "Visible", cmpEqual, true);
                              aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_quicksetup_note_5);                                                         
                      
                              aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("RadioButton", "*", 1),"WPFControlText", cmpEqual, lib_label.lb_Polarized);
                              aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("RadioButton", "*", 1),"Visible", cmpEqual, true);
                              aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("RadioButton", "*", 1),"IsChecked", cmpEqual, true);
                      
                              aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("RadioButton", "*", 2),"WPFControlText", cmpEqual, lib_label.lb_NonPolarized);
                              aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("RadioButton", "*", 2),"Visible", cmpEqual, true);
                      }             
                  
              }
               //QSU_027
               //verify checkpoint
               aqObject.CheckProperty(path.WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_quicksetup_note_1);
               aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_quicksetup_note_2);
               aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 3), "WPFControlText", cmpEqual, lib_label.lb_quicksetup_note_3);
               aqObject.CheckProperty(path.WPFObject("Grid", "", 1) .WPFObject("TextBlock", "*", 4), "WPFControlText", cmpEqual, lib_label.lb_quicksetup_note_4);

               //verify checkbox Static      
               //default check Static   
              
              aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("RadioButton", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_Static);
              aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("RadioButton", "*", 1), "IsChecked", cmpEqual, true);
              //verify checkbox Static
              aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("DynamicButton"), "WPFControlText", cmpEqual, lib_label.lb_Dynamic);                         
             
              //verify 1D
              aqObject.CheckProperty(path.WPFObject("Grid", "", 1) .WPFObject("CheckBox", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_1DCode);
              aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 2), "WPFControlText", cmpEqual, lib_label.lb_2DCode);
              //verify 2D
              //default check 2D or Digimarc
              
              //get model 
              var model_Digimarc = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "*", 2).WPFControlText;
              var isDigimarc = aqString.GetChar(model_Digimarc,11);
              if (isDigimarc != "A")
              { 
                    aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 2), "IsChecked", cmpEqual, true);             
              }else
              {
                    aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 3), "WPFControlText", cmpEqual, lb_Digimarc);
                    
                    aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 3), "IsChecked", cmpEqual, true);             
                    aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 2), "IsChecked", cmpEqual, false);                  
              }
              //check Include Image Filtering
              aqObject.CheckProperty(path.WPFObject("Grid", "", 1).WPFObject("CheckBox", "Include Image Filtering", 4), "IsChecked", cmpEqual, false);
              //verify button
              aqObject.CheckProperty(path.WPFObject("Grid", "", 2).WPFObject("Button", "Start", 1), "IsEnabled", cmpEqual, true); 
              aqObject.CheckProperty(path.WPFObject("Grid", "", 2).WPFObject("Button", "Stop", 2), "IsEnabled", cmpEqual, false);
              aqObject.CheckProperty(path.WPFObject("Grid", "", 2).WPFObject("Button", "Close", 3), "IsEnabled", cmpEqual, true); 
}

//get data of codeType from Result tab 
/**
  *@function
*/
function getDataFromResult()
{
      var data = "";         
      Indicator.PushText("Open Result Tab"); 
      Indicator.PopText(); 
      lib_button.clickOpenResultTab();           
      delay (lib_const.const_delay_1000);     
      if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("StatisticResult", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Expander", "Code Settings", 2).WPFObject("Border", "", 1).WaitWPFObject("DataGrid", "", lib_const.const_delay_1000).Exists)
      {
          delay (3000);
          var dataGrid = lib_deviceInfo.const_firmware;
          for (var k = 1; k <= dataGrid.wRowCount; k ++)
          {
                 var row = lib_deviceInfo.const_firmware.WPFObject("DataGridRow", "", k);
                 var code = row.WPFObject("DataGridCell", "*", 2).WPFObject("TextBlock", "*", 1).WPFControlText;
                 var numChar = row.WPFObject("DataGridCell", "*", 4).WPFObject("TextBlock", "*", 1).WPFControlText;
             
                 for (var l = 1; l <= numChar ; l ++)
                 {
                        data = data + row.WPFObject("DataGridCell", "*", 3).WPFObject("ContentPresenter", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", l).WPFObject("TextBlock", "*", 1).WPFControlText;
                 }                          
           } 
      }        
      return data;
}
//Compare 2 strings equal: expectedCode and Console 
/**
  *@function
  *@param {String} expectedCode
*/
function isGoodRead(expectedCode)
{  
      var data = "";  
      var flag = true;      
      Indicator.PushText("Open Result Tab"); 
      Indicator.PopText();
      lib_button.clickOpenResultTab();      
      delay (lib_const.const_delay_1000);     
      if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("StatisticResult", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Expander", "Code Settings", 2).WPFObject("Border", "", 1).WaitWPFObject("DataGrid", "", lib_const.const_delay_1000).Exists)
      {
          delay (3000);
          var dataGrid = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("StatisticResult", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Expander", "Code Settings", 2).WPFObject("Border", "", 1).WPFObject("DataGrid", "", 1);;
          
          for (var k = 1; k <= dataGrid.wRowCount; k ++)
          {
             var row = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("StatisticResult", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Expander", "Code Settings", 2).WPFObject("Border", "", 1).WPFObject("DataGrid", "", 1).WPFObject("DataGridRow", "", k);
             var code = row.WPFObject("DataGridCell", "*", 2).WPFObject("TextBlock", "*", 1).WPFControlText;
             var numChar = row.WPFObject("DataGridCell", "*", 4).WPFObject("TextBlock", "*", 1).WPFControlText;
             if (expectedCode == code || (expectedCode == "DMECC200" && code == "DATAMATRIX GS1")  || (expectedCode == "QR" && code == "QR GS1"))
             {
                   for (var l = 1; l <= numChar ; l ++)
                   {
                          data = data + row.WPFObject("DataGridCell", "*", 3).WPFObject("ContentPresenter", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", l).WPFObject("TextBlock", "*", 1).WPFControlText;
                   }
             }                         
          } 
      }
      //focus on Console Tab
      lib_button.clickAdvancedSetup();
      delay(100);      
      Indicator.PushText("open Console Tab");
      Indicator.PopText();
      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("StrechTabPanel", "", 1).WPFObject("Button", "Console", 4).WPFObject("TextBlock", "Console", 1).Click(); 
      
      
      //click on Play butt 
      lib_button.ui_PlayAndPause(2000, false) ;
      Sys.Process("DL.CODE").Refresh();
      //verify transmitted message
      var consoleTab =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1);
      var numMsg = consoleTab.ChildCount; 
      var txt = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "",  numMsg - 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
               
      if ( "<STX>" + data  + "\n" != txt)
      {
            flag = false;  
            Log.Message("result data :"+data);
            Log.Message("console:"+txt);
                    
      } 
//      Log.Message("is Good REad:"+ flag);   
      return flag;      
}


//add new from 1.6.0 RC2
/**
  *@function verify 2 Strings are equal
  *@param {String} dataExpected
*/
function verifyDataExpected (dataExpected)
{

      var flag = true;
      Indicator.PushText("open Console Tab");       
      Indicator.PopText();
      lib_button.clickOpenConsoleTab();
      //click on Play butt 
      lib_button.ui_PlayAndPause(2000, false) ;
      Sys.Process("DL.CODE").Refresh();
      //verify transmitted message
      var consoleTab =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1);
      var numMsg = consoleTab.ChildCount; 
      var txt = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "",  numMsg - 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
      if ( "<STX>" + dataExpected  + "\n" != txt)
      {
            flag = false;  
//            Log.Message("result data :"+dataExpected);
            Log.Message("console:"+txt);
                    
      }        
      return flag;
}

/**
  *@function  
*/
function clickSaveImageButton_QuickSetup()// add all 4 types: bmp, jpeg, jpg,tiff
{
         if ( ! lib_validate.isDLCODERunning())
                 lib_common.launchUI(); 
         var ext = [ lib_const.const_BMP  ,lib_const.const_JPEG  ,lib_const.const_GIF   ,lib_const.const_TIF    ];           
         if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress ) ==lib_err.err_FUNC_SUCCESS)
         { 
                 if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                 {        
                          lib_button.clickQuickSetup();
                          lib_button.clickStartContMode();
                          Delay(lib_const.const_delay_2000);
                          lib_button.clickStopContMode(false);                   
                          for (var i = ext.length ; i >= 1 ; i --)
                          { 
                                   lib_SaveIMG.clickSaveImageButton(lib_SaveJob.randomJobName()  , ext[i-1] ,lib_deviceInfo.const_fileName_SaveIMG, false);
                          }          
                 }    
        }  
        //lib_common.terminateUI();
}