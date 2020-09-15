//USEUNIT lib_ChangeIP
 
//USEUNIT lib_common
//USEUNIT lib_connection
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_DeviceSelectedDetail
//USEUNIT lib_OpenJob
//USEUNIT lib_SaveJob
//USEUNIT lib_validate
//USEUNIT lib_UserRole

function benchMark ()
{
    var ip = lib_deviceInfo.const_Device_IP_Adress;   
    var fileName =  lib_deviceInfo.const_fileName_BenchmarkTest;
    var path = lib_deviceInfo.const_fileNameJob_Path;
    var  arrDeviceList = lib_connection.driverXLS (path,fileName, "DeviceList" ,"Device");
    var  arrIPList = lib_connection.driverXLS (path,fileName, "DeviceList" ,"IP");
    if (arrDeviceList.length == arrIPList.length)
    {
          for (var i = 1; i <= arrDeviceList.length ; i++)
          {
               Log.Message(arrDeviceList[i-1] + ":" + arrIPList[i-1]);
               process (arrDeviceList[i-1], arrIPList[i-1]);
          }
    }
}


function process(deviceModel ,ipAdress)
{

   var ip = ipAdress;  
   var fileName =  lib_deviceInfo.const_fileName_BenchmarkTest;
   var path = lib_deviceInfo.const_fileNameJob_Path;
   var sheetName = lib_deviceInfo.const_fileName_BenchmarkTest_Sheet;
   var CaseCol = "Case";
   var SpeedCol = "Speed";
   var CodeResCol = "CodeRes";   
   
   var arrayCase = lib_connection.driverXLS (path,fileName, sheetName ,CaseCol);
   var arraySpeed = lib_connection.driverXLS (path,fileName, sheetName ,SpeedCol);
   var arrayCodeRes = lib_connection.driverXLS (path,fileName, sheetName ,CodeResCol);
   var arrayExposure = new Array();
   Log.Message(arrayCase.length);
   Log.Message(arraySpeed.length);
   Log.Message(arrayCodeRes.length);
   
   if (arrayCase.length == arraySpeed.length && arraySpeed.length == arrayCodeRes.length)
   {
       if ( ! lib_validate["isDLCODERunning"]())
         lib_common["launchUI"]();  
              
        if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS)
        {
           if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_N))
           {
              if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).IsFocused == false)
              {
                Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).Click();
                               
                 for (var i = 1; i <= arrayCase.length ; i++)
                 {
                      //focus on Advanced setup 
                      clickAdvancedSetup();
                      //Click btt Image AutoDetup
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Image Settings ", 1).Click();
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("Button", "Image Auto-Setup", 1).ClickButton();
                      //open Self Turn Window
                      if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: PhotometryAutolearnDialogWindow", "Image Auto-Setup",lib_const.const_delay_1000).Exists)
                      { 
                         var dynamicOpt = Sys.Process("DL.CODE").WPFObject("HwndSource: PhotometryAutolearnDialogWindow", "Image Auto-Setup").WPFObject("PhotometryAutolearnDialogWindow", "Image Auto-Setup", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("DynamicButton");
                         if (dynamicOpt.IsChecked == false)     
                              dynamicOpt.set_IsChecked(true) 
                              var  speed = Sys.Process("DL.CODE").WPFObject("HwndSource: PhotometryAutolearnDialogWindow", "Image Auto-Setup").WPFObject("PhotometryAutolearnDialogWindow", "Image Auto-Setup", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a[Del]" + arraySpeed [i-1]) ;
                              var  codeRes = Sys.Process("DL.CODE").WPFObject("HwndSource: PhotometryAutolearnDialogWindow", "Image Auto-Setup").WPFObject("PhotometryAutolearnDialogWindow", "Image Auto-Setup", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateDoubleUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a[Del]" + arrayCodeRes[i-1]) ;
                              Sys.Process("DL.CODE").WPFObject("HwndSource: PhotometryAutolearnDialogWindow", "Image Auto-Setup").WPFObject("PhotometryAutolearnDialogWindow", "Image Auto-Setup", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 3).WPFObject("Button", "Start", 1).ClickButton();
                        
                              while (Sys.Process("DL.CODE").WPFObject("HwndSource: PhotometryAutolearnDialogWindow", "Image Auto-Setup").WPFObject("PhotometryAutolearnDialogWindow", "Image Auto-Setup", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 3).WPFObject("Button", "Apply", 3).IsEnabled == false)
                              { 
                                     delay (lib_const.const_delay_3000);
                              }
                        
                              if (Sys.Process("DL.CODE").WPFObject("HwndSource: PhotometryAutolearnDialogWindow", "Image Auto-Setup").WPFObject("PhotometryAutolearnDialogWindow", "Image Auto-Setup", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", "*", 1).IsEnabled == true)
                              {
                                  var strDelete = lib_label.const_lb_ExposureTime_Result;
                                  var str = Sys.Process("DL.CODE").WPFObject("HwndSource: PhotometryAutolearnDialogWindow", "Image Auto-Setup").WPFObject("PhotometryAutolearnDialogWindow", "Image Auto-Setup", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", "*", 1).WPFControlText
                                  var exposureTime = lib_common.subString(str, strDelete);
                                  arrayExposure.push (exposureTime); 
                              }
                              Sys.Process("DL.CODE").WPFObject("HwndSource: PhotometryAutolearnDialogWindow", "Image Auto-Setup").WPFObject("PhotometryAutolearnDialogWindow", "Image Auto-Setup", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 3).WPFObject("Button", "Cancel", 4).ClickButton(); 
                   
                      }
                 }
                var arrDevice = ["M120" , "M210" ,"M300" ,"M410" ,"M450"  ];
                for (var j = 1; j<= arrDevice.length; j++)
                {
                     var column ;
                     if (arrDevice[j-1] == deviceModel) 
                     {
                          column = 3 + j;
                          lib_connection.insertColumn(path, fileName, sheetName,column, arrayExposure );
                     }  
                }
                
              }        
           }               
        }   
        //lib_common.terminateUI();
   }  
   
}




 
