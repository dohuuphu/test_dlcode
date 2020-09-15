//USEUNIT lib_common
//USEUNIT lib_deviceInfo
//USEUNIT lib_OpenJob
//USEUNIT lib_JobList
//USEUNIT lib_button
//USEUNIT lib_CodeAutolearn
function getDevicInformationforWebPage1D()
{
  getDeviceInfomationForWEBPAGE("1D CQ Standard", "ISO/IEC 15416")
}
function getDevicInformationforWebPage2D_15415()
{
  getDeviceInfomationForWEBPAGE("2D CQ Standard", "ISO/IEC 15415")
}
function getDevicInformationforWebPage2D_16022_18004()
{
  getDeviceInfomationForWEBPAGE("2D CQ Standard", "ISO/IEC 16022 / 18004")
}
function getDevicInformationforWebPage2D_29158()
{
  getDeviceInfomationForWEBPAGE("2D CQ Standard", "ISO/IEC 29158 (AIM-DPM)")
}
function getDeviceInfomationForWEBPAGE(Grading_type_1D_2D, Grading_value_1D_2D)
{
  aqTestCase.Begin("getDeviceInfomationAndEnabledAllStatisticsInConfigurationSettings");
  var array = new Array();
  var deviceName = "", model = "", serialNumber = "", softwareVersion = "", runningJob = "", startupJob = "";
  var dhcpValue = "", ipaddr = "", subnetMask = "", gateWay = "", macAddr = "";
  
  lib_common.launchUI();
  lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);
  EnalbedAllStatistics();
  //return [deviceName,  model, serialNumber, softwareVersion, runningJob, startupJob, dhcpValue, ipaddr, subnetMask, gateWay, macAddr];
  
  SaveInfoToExcel(Grading_type_1D_2D, Grading_value_1D_2D);
  
  
  lib_common.gettingStarted();
  aqTestCase.End();
}
function SaveInfoToExcel(Grading_type_1D_2D, Grading_value_1D_2D)
{
 var ExcelPath = aqFileSystem.GetFolderInfo(Project.Path).ParentFolder;
 ExcelPath = aqFileSystem.GetFolderInfo(ExcelPath.Path).ParentFolder;
 ExcelPath = aqFileSystem.GetFolderInfo(ExcelPath.Path).ParentFolder;
 ExcelPath = ExcelPath.Path + "automationtestmatrixwebpage_python\\SeleniumProject\\ExcelFile\\";
 if(lib_deviceInfo.const_Device_Model == "M120")
 {
   ExcelPath = ExcelPath + "M120.xlsx";
 }
 else if(lib_deviceInfo.const_Device_Model == "M210N")
 {
   ExcelPath = ExcelPath + "M210N.xlsx";
 }
 else if(lib_deviceInfo.const_Device_Model == "M220")
 {
   ExcelPath = ExcelPath + "M220.xlsx";
 }
 else if(lib_deviceInfo.const_Device_Model == "M300N")
 {
   ExcelPath = ExcelPath + "M300N.xlsx";
 }
 else if(lib_deviceInfo.const_Device_Model == "M320")
 {
   ExcelPath = ExcelPath + "M320.xlsx";
 }
 else if(lib_deviceInfo.const_Device_Model == "M410N")
 {
   ExcelPath = ExcelPath + "M410N.xlsx";
 }
 else if(lib_deviceInfo.const_Device_Model == "M450N")
 {
   ExcelPath = ExcelPath + "M450N.xlsx";
 }
 else
 {
   
 }
 
// 
 var app = Sys.OleObject("Excel.Application");
 var book = app.Workbooks.Open(ExcelPath);
 var sheet = book.Sheets.Item("Configurator");
 
 
 lib_button.clickIMG_AutoSetup_Static(true);
 if(!lib_deviceInfo.const_isPPI_device) lib_button.clickIMG_FocusAutolearn(true);
 if(Grading_type_1D_2D == "1D CQ Standard") lib_CodeAutolearn.performCodeAutolearn(lib_label.lb_CodeAutolearn_Replace);
 
 var codeGradingsItems = EnabledCodeGrading(Grading_type_1D_2D, Grading_value_1D_2D);
 lib_SaveJob.saveJobOnDevice2(lib_deviceInfo.const_firmware_version + "_" + lib_deviceInfo.const_Device_Model+ "_Enalbed_AllStatistics_WEB");
 lib_common.gettingStarted();
 
 
 
 
 if(lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
  {
    delay(3000);
     var arrPro = ["ClrFullClassName", "WPFControlText"];
     var arrVal = ["IVSControls.Controls.CustomExpander.ContentExpander" ,"Selected Device Details"]
     var selectedDevice = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
     if(!selectedDevice.Exists) 
     {
       Log.Error("Please check connection with device. Seleted devices is not found");
       return;
     }
     deviceName = selectedDevice.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "Matrix", 2).WPFControlText;
     model = selectedDevice.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
     softwareVersion = selectedDevice.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 9).WPFObject("TextBlock", "*", 2).WPFControlText;
     var temp = selectedDevice.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1);
     if(temp.Visible != false)
     {
       runningJob = temp.WPFControlText;
     }
     else
     {
       temp = selectedDevice.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 2);
       if(temp.Visible != false)
       {
          runningJob = temp.WPFControlText;
       }
       else
       {
         runningJob = selectedDevice.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 3).WPFControlText;
       }
     }
     serialNumber = lib_deviceInfo.const_Device_SerialNumber;
     ipaddr = lib_deviceInfo.const_Device_IP_Adress;
     
    
     ivsMenu = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
     
     ivsMenu.WPFObject("MenuItem", "Device", 3).Click();
     ivsMenu.WPFMenu.Click("Device|Settings|Settings");
     
     
     delay(1000);
     var deviceSettingPopup = Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", "Device Environment Configuration").WPFObject("DeviceEnvironmentConfigurationPopup", "Device Environment Configuration", 1);
     startupJob = deviceSettingPopup.WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ComboBox", "", 1).Text.OleValue;
     checkboxDHCP = deviceSettingPopup.WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("CheckBox", "", 1);
     if(checkboxDHCP.IsChecked.OleValue)
     {
       dhcpValue = "Enabled";
     }
     else
     {
       dhcpValue = "Disabled";
     }
     subnetMask = deviceSettingPopup.WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("IpAddress").IpAddress.OleValue;
     gateWay = deviceSettingPopup.WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4).WPFObject("IpAddressControl", "", 1).IpAddress.OleValue;
     macAddr = deviceSettingPopup.WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Ethernet Settings", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBox", "", 1).Text.OleValue;
     Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", "Device Environment Configuration").Close();
  }
  
  model = aqString.SubString(model, 0, 13);
  sheet = book.Sheets.Item("HomePage");
  var homeinfoArray =  [deviceName,  model, serialNumber, softwareVersion, runningJob, startupJob, dhcpValue, ipaddr, subnetMask, gateWay, macAddr];
  
  for (var i = 0 ; i < homeinfoArray.length; i++)
 {
   sheet.Cells.Item(i+1, 2).Value2 = aqConvert.VarToStr(homeinfoArray[i]);
   
 }
 
 
 sheet = book.Sheets.Item("CodeGrading");
 sheet.Cells.Clear;
 for(var i =0; i < codeGradingsItems.length; i++)
 {
   aqString.ListSeparator = ";"
   sheet.Cells.Item(i+1, 1).Value = aqString.GetListItem(codeGradingsItems[i], 0);
   sheet.Cells.Item(i+1, 2).Value = aqString.GetListItem(codeGradingsItems[i], 1);
 }
 
 sheet = book.Sheets.Item("Configurator");
 sheet.Cells.Clear;
 sheet.Cells.Item(1,1) = book.Sheets.Item("HomePage").Cells.Item(5,1)
 sheet.Cells.Item(1,2) = book.Sheets.Item("HomePage").Cells.Item(5,2)
 sheet.Cells.Item(2,1) = book.Sheets.Item("HomePage").Cells.Item(6,1)
 sheet.Cells.Item(2,2) = book.Sheets.Item("HomePage").Cells.Item(6,2)
 sheet.Cells.Item(3,1) = "Default";
 sheet.Cells.Item(4,1) = "PresentationDefault"
 sheet.Cells.Item(3,2) = book.Sheets.Item("temp").Cells.Item(1,1)
 sheet.Cells.Item(4,2) = book.Sheets.Item("temp").Cells.Item(2,1)
 
 var proArr = ["ToolTip", "ClrClassName", "Enabled"];
 var valArr = ["Open Device Configuration", "Button" , true];
 Sys.Process("DL.CODE").FindChild(proArr, valArr, 2000).Click();
 
 var joblist = lib_JobList.getJobList();
 for(var i = 0; i < joblist.length;i++)
 {
   if(aqString.Contains(joblist[i], "  ") != -1)
   {
     joblist[i] = aqString.Replace(joblist[i], "  ", " ");
   }
   sheet.Cells.Item(i+5, 1).Value = joblist[i];
 }
 
  
 book.Save();
 app.Quit();

}
function EnalbedAllStatistics()
{
  lib_OpenJob.openOnDevice("Default", true, true);
  ivsMenu = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
     
  ivsMenu.WPFObject("MenuItem", "Device", 3).Click();
  ivsMenu.WPFMenu.Click("Device|Settings|Configuration Settings");
  var statisticsTab = Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationSettingsWindow", "Configuration Settings").WPFObject("ConfigurationSettingsWindow", "Configuration Settings", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Statistics", 2);
  if(!statisticsTab.get_IsExpanded)
  {
    statisticsTab.set_IsExpanded(true);
  }
  var AlStatisticsFrame = Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationSettingsWindow", "Configuration Settings").WPFObject("ConfigurationSettingsWindow", "Configuration Settings", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Statistics", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1);
  AlStatisticsArr = (new VBArray(AlStatisticsFrame.FindAllChildren("ClrClassName", "CheckBox", 1000))).toArray();
  for(var i = 0; i < AlStatisticsArr.length;i++)
  {
    AlStatisticsArr[i].IsChecked = true;
    delay(300)
  }
  delay(1000);
  statisticsTab.set_IsExpanded(false);
  delay(1000);
  Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationSettingsWindow", "Configuration Settings").WPFObject("ConfigurationSettingsWindow", "Configuration Settings", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 2).ClickButton();
  delay(5000);
  Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();
  saveInfomationForPythonWEBPAGE();
  
}
function saveInfomationForPythonWEBPAGE()
{
  var txtPath = aqFileSystem.GetFolderInfo(Project.Path).ParentFolder;
 txtPath = aqFileSystem.GetFolderInfo(txtPath.Path).ParentFolder;
 txtPath = aqFileSystem.GetFolderInfo(txtPath.Path).ParentFolder;
 txtPath = txtPath.Path + "automationtestmatrixwebpage_python\\SeleniumProject\\ExcelFile\\info.txt";
 aqFile.WriteToTextFile(txtPath, "Device model:" + lib_deviceInfo.const_Device_Model + "\r\n", aqFile.ctANSI, true);
 aqFile.WriteToTextFile(txtPath, "Device IP:" + lib_deviceInfo.const_Device_IP_Adress, aqFile.ctANSI);
 
}
function EnabledCodeGrading(type_1D_2D, value)
{
  lib_button.clickAdvancedSetup();
  // focus on code grading
  var arrPro = ["ClrClassName", "WPFControlText"];
  var arrVal = ["TextBlock", "General Settings - Code Grading"];
  Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000).Click();
  // Enabled code grading
  var _1D_2D_CQ_Standard_Lbl = Sys.Process("DL.CODE").FindChild("WPFControlText", type_1D_2D, 1000);
  var count = 5;
  var _1D_2D_CQ_Standard_Cbx
  while(count>0)
  {
    _1D_2D_CQ_Standard_Lbl = _1D_2D_CQ_Standard_Lbl.Parent;
    _1D_2D_CQ_Standard_Cbx = _1D_2D_CQ_Standard_Lbl.FindChild("ClrClassName", "ComboBox", 1000);
    if(_1D_2D_CQ_Standard_Cbx.Exists)
    {
      break;
    }
    delay(500);
    count = count - 1;
  }
  if(_1D_2D_CQ_Standard_Cbx.Exists)
  {
    lib_common.cbb_NonLogicalAdornerDecorator(_1D_2D_CQ_Standard_Cbx, value)
  } // done enabled code grading
  var overralSettingsLbl;
  if(type_1D_2D == "1D CQ Standard")
  {
    overralSettingsLbl = "Overall 1D CQ Settings";
  }
  else if(type_1D_2D = "2D CQ Standard")
  {
    overralSettingsLbl = "Overall 2D CQ Settings";
  }
  else
  {
    overralSettingsLbl = ""
  }
 arrVal = ["TextBlock", overralSettingsLbl]
 overralSettingsObj = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
 count = 5;
 var settingsItemsArr;
 while(count>0)
 {
   overralSettingsObj = overralSettingsObj.Parent;
   settingsItemsArr = (new VBArray(overralSettingsObj.FindAllChildren("ClrClassName", "ContentPresenter", 1000))).toArray();
   if(settingsItemsArr.length > 0)
   {
     break;
   }
   delay(500);
   count = count - 1;
 }
 var enabledGradingItems = [];
 for(var i = 0; i< settingsItemsArr.length;i++)
 {
   checkboxItem = settingsItemsArr[i].WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1);
   if(checkboxItem.IsChecked.OleValue)
   {
     enabledGradingItems.push("1;" + checkboxItem.WPFControlText)
   }
   else
   {
     enabledGradingItems.push("0;" + checkboxItem.WPFControlText);
   }
 }
 return enabledGradingItems;
}