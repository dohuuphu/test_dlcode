//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_validate
//USEUNIT lib_common
//USEUNIT lib_OpenJob
//USEUNIT lib_QuickSetup
//USEUNIT lib_button


 

/*
  *@function 
*/
function testSuite_658_setParamHMP_M220()
{

        lib_common.launchUI();     
        var ip = lib_deviceInfo.const_Device_IP_Adress;    
        
        if (lib_common.connectToDevice(ip))
        {    
                if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                { 
                             lib_validate.isImageQuality_M220 ( lib_const.const_M220_DEFAULT_GLOBAL_READING_DISTANCE,
                                                    lib_const.const_M220_DEFAULT_IMAGE_POLARITY,
                                                    lib_const.const_M220_DEFAULT_EXPOSURE_TIME,
                                                    lib_const.const_M220_DEFAULT_GAIN,
                                                    lib_const.const_M220_DEFAULT_GAINMULTIPLIER) ;
                                                    
                              lib_common.gettingStarted();
                              
                              var arrayHMP = [lib_const.const_HMP_GLOBAL_READING_DISTANCE,
                                              lib_const.const_HMP_IMAGE_POLARITY,
                                              lib_const.const_HMP_EXPOSURE_TIME,
                                              lib_const.const_HMP_GAIN,
                                              lib_const.const_HMP_GAINMULTIPLIER           ];
                                              
                              var arrayHMPValue = [lib_const.const_HMP_VALUE_GLOBAL_READING_DISTANCE,
                                              lib_const.const_HMP_VALUE_IMAGE_POLARITY,
                                              lib_const.const_HMP_VALUE_EXPOSURE_TIME,
                                              lib_const.const_HMP_VALUE_GAIN,
                                              lib_const.const_HMP_VALUE_GAINMULTIPLIER]; 
                                              
                                              
                               if( launch_Config_Array_HMPAutoTest(arrayHMP, arrayHMPValue) == true)
                               {
                                       if (lib_common.connectToDevice(ip))
                                       {    
                                                if (lib_OpenJob.openOnDevice( lib_const.const_TempJob ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                                                { 
                                                             lib_validate.isImageQuality_M220 ( lib_const.const_HMP_VALUE_GLOBAL_READING_DISTANCE,
                                                                                    lib_const.const_HMP_VALUE_IMAGE_POLARITY,
                                                                                    lib_const.const_HMP_VALUE_EXPOSURE_TIME,
                                                                                    lib_const.const_HMP_VALUE_GAIN,
                                                                                    lib_const.const_HMP_VALUE_GAINMULTIPLIER) ;
                                                               }   
                                                }                
                                }     
                    }

        }
}


/*
  *@function 
*/
function tc_30931_Expected_ExcludeContent_HMP ()
 {       
          /* Expected Content and EXPECTED_CONTENT
             Expected content is found from Automatic Setup             
          */
          tc_30931_1_Expected_ExcludeContent_HMP (true , lib_const.const_EXPECTED_CONTENT);

          /* EXCLUDED_CONTENT and EXCLUDED_CONTENT
             EXCLUDED_CONTENT is found from Automatic Setup
          */
         tc_30931_1_Expected_ExcludeContent_HMP (false, lib_const.const_EXCLUDED_CONTENT); 
          /* Expected Content and EXPECTED_CONTENT
             Expected content is found from Automatic Setup  +AAAA           
          */
         tc_30931_2_Expected_ExcludeContent_HMP (true , lib_const.const_EXPECTED_CONTENT);
         
         /*  Excluded Content and EXPECTED_CONTENT
             Excluded content is found from Automatic Setup  +AAAA           
          */
         tc_30931_2_Expected_ExcludeContent_HMP (false, lib_const.const_EXCLUDED_CONTENT); 
 }
 
 
 
 /*
  *@function
  *@param isExpectedContent{boolean}
  *@param dataExpected {String} 
*/
function tc_30931_2_Expected_ExcludeContent_HMP(isExpectedContent, dataExpected)// always true 
{ 
//        if ( ! lib_validate.isDLCODERunning())
        lib_common.launchUI();     
        var ip = lib_deviceInfo.const_Device_IP_Adress;    
        var index = 0;
        if (isExpectedContent == true)
              index = 1;//Expected Content
        else
              index = 2;//Excluded Content
        if (lib_common.connectToDevice(ip))
        {         
                if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                { 
                       if (lib_QuickSetup.quickSetup(true,true,true , true , false) == true)//Static
                       {                             
                             var dataResult = getDataFromResult();
                             Log.Message(dataResult);
                             lib_button.clickAdvancedSetup();
                             if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).IsExpanded == false)
                                        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).set_IsExpanded(true);
                              /*
                                 Enter data to Expected data
                                 have to enter this data to have param HMP control
                              */
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
                              
                              var paraHMP = "";
                              if (isExpectedContent == true)
                                  paraHMP = "2D_EXPECTED_CONTENT1";
                              else 
                                  paraHMP = "2D_NOT_EXPECTED_CONTENT1";
                              
                              //getting Started screen
                              lib_common.gettingStarted();
                              var valueHMP =  dataResult + "AAAA";//data at Step 1 + AAAA from code infront of the device (right value to have No Read)
                              launch_Config_HMPAutoTest (paraHMP,valueHMP);
                              Sys.Process("HMPAutoTest").WinFormsObject("Form1").WinFormsObject("startbut").ClickButton();
                              while (Sys.Process("HMPAutoTest").WaitWindow("#32770", "", 1, 3000).Exists == false)
                              {
                                    delay (2000);
                              }  
                              if (Sys.Process("HMPAutoTest").WaitWindow("#32770", "", 1, 1000).Exists)
                              {
                                  var result = Sys.Process("HMPAutoTest").Window("#32770", "", 1).Window("Static", "*", 1).WndCaption;
                                  if ( result == "Finish")
                                  {
                                             Sys.Process("HMPAutoTest").Window("#32770", "", 1).Window("Button", "OK", 1).ClickButton ();
                                             Sys.Process("HMPAutoTest").WinFormsObject("Form1").WinFormsObject("exitbut").ClickButton ();
                                             if ( verifyData(valueHMP, index ) == true)
                                             {
                                                     lib_button.clickAdvancedSetup();
                                                     lib_button.ui_PlayAndPause(3000,false);
                                                     var flag = verifyDataExpected(dataResult);
                                                     if (isExpectedContent == true && index == 1 && flag == false)
                                                     {
                                                                 Log.Warning("It's OK.isExpectedCode:" + dataResult + ""+ flag); 
                                                                 return flag;
                                                     }
                                                   
                                                    if (isExpectedContent == true && index == 2 && flag == false)
                                                    {
                                                                 Log.Warning("It's OK.isExpectedCode:" + dataResult + ""+ flag); 
                                                                 return flag;
                                                    }
                                               }     
                                     }                                        
                              }    
                       }      
                }
        }   
}

 

function verifyData (valueHMP, index)
{
         var flag = true;
         if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
         {                                                
                 if (lib_OpenJob.openOnDevice( lib_const.const_TempJob,lib_const.const_isDefaultJob_N,lib_const.const_isOpenViaButton_Y))
                 {                                                   
                          //expand Code Filter
                          if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).IsExpanded == false)
                                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).set_IsExpanded(true);
                              
                          //verify value enter
                          var numSpace = lib_common.countSpace(valueHMP);
                          var tmpText="" ;
                          var listb = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("listb");
                          listb.Refresh();
                          if (listb.ChildCount > 0)
                          {        
                                   var listItem =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", index).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("listb").WPFObject("ContentPresenter", "", 1).WPFObject("listboxItem");                      
                                   for (var i = 1 ; i <= listItem.ChildCount - 1 - numSpace ; i ++)
                                   {
                                       var tmp =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", index).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("listb").WPFObject("ContentPresenter", "", 1).WPFObject("listboxItem").WPFObject("ContentPresenter", "", i).WPFObject("TextBlock", "*", 1).WPFControlText; 
                                       tmpText = tmpText + tmp;
                                   }
                                   if (valueHMP != tmpText)
                                   {
                                       Log.Error("can not add data");
                                       Log.Error(valueHMP);
                                       Log.Error(tmpText);
                                       flag = false;  
                                                                                                                
                                   }
                          }                          
               }
         }   
         return flag;                                         
}
 
  
 /*expected code is input from user*/
 /*
  *@function
  *@param isExpectedContent{boolean}
  *@param dataExpected {String} get from parameter : not from code data
  *value input to HMP Control is data code in front of the device
*/
function tc_30931_1_Expected_ExcludeContent_HMP(isExpectedContent, dataExpected)// always true 
{ 
        if ( ! lib_validate.isDLCODERunning())
        lib_common.launchUI();     
        var ip = lib_deviceInfo.const_Device_IP_Adress;    
        var index = 0;
        var flag = false;
        if (isExpectedContent == true)
              index = 1;//Expected Code
        else
              index = 2;// Excluded Code
        if (lib_common.connectToDevice(ip))
        {         
                if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                { 
                       if (lib_QuickSetup.quickSetup(true,true,true , true , false) == true)//Static
                       {                             
                             //1. get DataCode in front of the device
                             var dataResult = getDataFromResult();
                             Log.Message(dataResult);
                             lib_button.clickAdvancedSetup();
                             if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).IsExpanded == false)
                                        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).set_IsExpanded(true);
                              //2. enter data to Expected/Excluded Content
                              var editExpectedControl = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", index).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("newDelay").WPFObject("Grid", "", 1).WPFObject("rtbText");
                              editExpectedControl.Keys(dataExpected); 
                              //add to control
                              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Filters", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", index).WPFObject("EditableListControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1).Click();
                              
                              //3.verify Expected/Excluded Content value at step 2
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
                              //get HMP Control
                              var paraHMP = "";
                              if (isExpectedContent == true)
                                  paraHMP = "2D_EXPECTED_CONTENT1";
                              else 
                                  paraHMP = "2D_NOT_EXPECTED_CONTENT1";
                              
                              //getting Started screen
                              lib_common.gettingStarted();
                              //process on HMP Tool
                              var valueHMP =  dataResult; // data at Step 1 from code infront of the device (right value to have Good Read)
                              launch_Config_HMPAutoTest (paraHMP,valueHMP);
                              Sys.Process("HMPAutoTest").WinFormsObject("Form1").WinFormsObject("startbut").ClickButton();
                              while (Sys.Process("HMPAutoTest").WaitWindow("#32770", "", 1, 3000).Exists == false)
                              {
                                    delay (2000);
                              }  
                              if (Sys.Process("HMPAutoTest").WaitWindow("#32770", "", 1, 1000).Exists)
                              {
                                  var result = Sys.Process("HMPAutoTest").Window("#32770", "", 1).Window("Static", "*", 1).WndCaption;
                                  if ( result == "Finish")
                                  {
                                             Sys.Process("HMPAutoTest").Window("#32770", "", 1).Window("Button", "OK", 1).ClickButton ();
                                             Sys.Process("HMPAutoTest").WinFormsObject("Form1").WinFormsObject("exitbut").ClickButton ();
                                             //verify HMP Control work correctly
                                             if (verifyData(valueHMP, index) == true)                                             
                                             { 
                                                    lib_button.clickAdvancedSetup();
                                                    lib_button.ui_PlayAndPause(3000,false);
                                                    //Verify dataExpected and console
                                                    var flag = verifyDataExpected(dataResult);
                                                    if (isExpectedContent == true && index == 1 && flag == true)
                                                    {
                                                                 Log.Warning("It's OK.isExpectedCode:" + dataResult + ""+ flag); 
                                                                 return flag;
                                                    }if (isExpectedContent == true && index == 2 && flag == false)
                                                    {
                                                                 Log.Warning("It's OK.isExpectedCode:" + dataResult + ""+ flag); 
                                                                 return flag;
                                                    }
                                               }
                                  }
                              }
                              
//                              
                       }      
                }
        }   
//        lib_common.terminateUI();
}



//add new from 1.5.1 Beta 02
/*
  *@function
  *@param arrParaHMP{Array}
  *@param arrValue {Array}
*/
function launch_Config_Array_HMPAutoTest(arrParaHMP, arrValue)
{
      var flag = false;
      launchHMPAutoTest();
      delay (1000);
      var ipAddress =Sys.Process("HMPAutoTest").WinFormsObject("Form1").WinFormsObject("txtboxIPAdrr");
      ipAddress.Keys("^a");
      ipAddress.SetText("");
      ipAddress.Keys(lib_deviceInfo.const_Device_IP_Adress);      
      Sys.Process("HMPAutoTest").WinFormsObject("Form1").WinFormsObject("radioCheckHMP").ClickButton(); 
      for (var i = 0; i <= arrParaHMP.length - 1; i++ )
      {
              Sys.Process("HMPAutoTest").WinFormsObject("Form1").WinFormsObject("butAdd").ClickButton();
              if (Sys.Process("HMPAutoTest").WaitWinFormsObject("Form2", 1000).Exists)
              { 
                    Sys.Process("HMPAutoTest").WinFormsObject("Form2").WinFormsObject("txtcmd").Keys("SET");
                    Sys.Process("HMPAutoTest").WinFormsObject("Form2").WinFormsObject("txtpara").Keys(arrParaHMP[i]);
                    if (arrValue[i] == true || arrValue[i] == false)
                    {
                              if (arrValue[i] == true)
                                      Sys.Process("HMPAutoTest").WinFormsObject("Form2").WinFormsObject("txtvalue").Keys("True");
                              if (arrValue[i] == false )
                                      Sys.Process("HMPAutoTest").WinFormsObject("Form2").WinFormsObject("txtvalue").Keys("False");
                                   
                    }else
                              Sys.Process("HMPAutoTest").WinFormsObject("Form2").WinFormsObject("txtvalue").Keys(arrValue[i]);
                    Sys.Process("HMPAutoTest").WinFormsObject("Form2").WinFormsObject("okbut").ClickButton();
              }              
      }
      Sys.Process("HMPAutoTest").WinFormsObject("Form1").WinFormsObject("startbut").ClickButton();
      while (Sys.Process("HMPAutoTest").WaitWindow("#32770", "", 1, 3000).Exists == false)
      {
            delay (2000);
      }  
      if (Sys.Process("HMPAutoTest").WaitWindow("#32770", "", 1, 1000).Exists)
      {
          var result = Sys.Process("HMPAutoTest").Window("#32770", "", 1).Window("Static", "*", 1).WndCaption;
          if ( result == "Finish")
          {      Sys.Process("HMPAutoTest").Window("#32770", "", 1).Window("Button", "OK", 1).ClickButton ();
                 Log.Message("Test Tool: OK");
                 flag = true;
          }
      }
      terminateHMPAutoTest();
      return flag;
      
}

//add new from 1.5.1 Beta 02
/*
  *@function
  *@param paraHMP{String}
  *@param value {String}
*/
function launch_Config_HMPAutoTest(paraHMP, value)
{
      launchHMPAutoTest();
      delay (1000);
      var ipAddress =Sys.Process("HMPAutoTest").WinFormsObject("Form1").WinFormsObject("txtboxIPAdrr");
      ipAddress.Keys("^a");
      ipAddress.SetText("");
      ipAddress.Keys(lib_deviceInfo.const_Device_IP_Adress);
      
      Sys.Process("HMPAutoTest").WinFormsObject("Form1").WinFormsObject("radioCheckHMP").ClickButton();
      Sys.Process("HMPAutoTest").WinFormsObject("Form1").WinFormsObject("butAdd").ClickButton();
      if (Sys.Process("HMPAutoTest").WaitWinFormsObject("Form2", 1000).Exists)
      {     
              Sys.Process("HMPAutoTest").WinFormsObject("Form2").WinFormsObject("txtcmd").Keys("SET");
              Sys.Process("HMPAutoTest").WinFormsObject("Form2").WinFormsObject("txtpara").Keys(paraHMP);
              Sys.Process("HMPAutoTest").WinFormsObject("Form2").WinFormsObject("txtvalue").Keys(value);
              Sys.Process("HMPAutoTest").WinFormsObject("Form2").WinFormsObject("okbut").ClickButton();              
      }
//      terminateHMPAutoTest();
}

/*
  *@function
*/
function launchHMPAutoTest ()
{   
    // Launch the application    
    var flag = lib_err.err_FUNC_FAILED;       
    if ( !Sys.WaitProcess("HMPAutoTest", lib_const.const_delay_1000, true).Exists)//TestMatrix doesn't exist
    {
          Indicator.PushText("Launch new HMPAutoTest");	     
          TestedApps.Items(2).Run(); 
          delay (lib_const.const_delay_3000);
          Indicator.PopText();        
    }else// existed
    { 
                  Indicator.PushText("HMPAutoTest is running -> Close and Re-launch ");	     
                  terminateHMPAutoTest() ;
                  delay (lib_const.const_delay_3000);
                  TestedApps.Items(2).Run(); 
                  delay (lib_const.const_delay_3000);
                  Indicator.PopText();
                  if ( Sys.WaitProcess("HMPAutoTest", lib_const.const_delay_1000, true).Exists)     
                        flag = lib_err.err_FUNC_SUCCESS;
    } 
    return flag;    
}


/*
  *@function
*/
function terminateHMPAutoTest()
{
      // Obtains the notepad.exe process
      var p = Sys["FindChild"]("ProcessName", "HMPAutoTest");
      // Iterates through all the instances of the notepad.exe process
      // until all of them are closed
      while (p["Exists"])
      {
          p["Close"]();
          // Waits until the process is closed
          var isClosed = p["WaitProperty"]("Exists", false);
          // Checks whether the process has been closed successfully
          if (! isClosed)
            // Terminates the process
             {
             p.Terminate();
             //break;
             }

          // Obtains another instance of the notepad.exe process
          p = Sys["FindChild"]("ProcessName", "HMPAutoTest");
     }
} 