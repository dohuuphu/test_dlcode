﻿//USEUNIT lib_button
//USEUNIT lib_common
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo
function VerifyFocusAutolearn()
{
  aqTestCase.Begin("Verify Focus Autolearn: Max/Min/Default/Out of range");
  if(!lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
  {
    Log.Error("Can not connect to device");
    aqTestCase.End();
    ExcelWorkbookObj.Close(false);
    Excel.Quit();
    return;
  }
  var deviceModel = lib_common.getDeviceModel();
  if(!lib_OpenJob.openOnDevice( lib_const.const_DefaultJob ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
  {
    Log.Error("Can not open job on device");
    aqTestCase.End();
    ExcelWorkbookObj.Close(false);
    Excel.Quit();
    return;
  }
  var Excel = Sys.OleObject("Excel.Application");
  var ExcelWorkbookObj = Excel.Workbooks.Open(Project.Path + "Illuminator.xlsx");
  var ExcelSheet = ExcelWorkbookObj.Sheets.Item("Index");
  
  var rowCountSheetIndex = ExcelSheet.UsedRange.Rows.Count;
  var model;
  var SheetNeedToActive;  
  for(var i =2;i<= rowCountSheetIndex;i++)
  {
    model = (VarToString(ExcelSheet.Cells.Item(i, 1)));
    if(model == deviceModel)
    {
      SheetNeedToActive = (VarToString(ExcelSheet.Cells.Item(i, 2)));
      break;
    }
  }
  // get default value of focus reading distance from excel
  ExcelSheet = ExcelWorkbookObj.Sheets.Item(SheetNeedToActive);
  var IsFocusAutoLearnDevice = (VarToString(ExcelSheet.Cells.Item(2, 9)));
  if(IsFocusAutoLearnDevice == "Y")  
  {
    var FocusAutolearnDefaultValueStr =  (VarToString(ExcelSheet.Cells.Item(2, 11)));
    var FocusAutolearnDefaultValue_Excel = aqConvert.StrToInt(FocusAutolearnDefaultValueStr);
    if(FocusAutolearnDefaultValue_Excel == 0)
    {
      Log.Error("Input data having problem, please check data of focus autolearn default value  in file Illuminator.xlsx");
      aqTestCase.End();
      ExcelWorkbookObj.Close(false);
      Excel.Quit();
      return;
    }
  }
  else
  {
    Log.Warning("Excel: Device is not Focus Autolearn Device. Please choose another device or change information in excel");
    aqTestCase.End();
    ExcelWorkbookObj.Close(false);
    Excel.Quit();
    return;
  }
  // get min/max/default from HMP table then compare with excel table
  var DefaultMinMax = GetMaxMinDefaultFocusAutoLearn();
  var DefaultFocusAutoLearnValue_HMPTable = DefaultMinMax[0];
  var MinFocusAutoLearnValue_HMPTable = DefaultMinMax[1];
  var MaxFocusAutoLearnValue_HMPTable = DefaultMinMax[2];
  if(DefaultFocusAutoLearnValue_HMPTable == 0 || MinFocusAutoLearnValue_HMPTable == 0 || MaxFocusAutoLearnValue_HMPTable ==0)
  {
    aqTestCase.End();
    ExcelWorkbookObj.Close(false);    
    Excel.Quit();
    return;
  }
  
  if(FocusAutolearnDefaultValue_Excel != DefaultFocusAutoLearnValue_HMPTable)
  {
    Log.Error("Deviation between default value excel file and from device (" + FocusAutolearnDefaultValue_Excel + "/" + DefaultFocusAutoLearnValue_HMPTable + ")");
  }
  else
  {
    Log.Checkpoint("Default value between excel file and from HMP table on device are SAME");
  }
  
  // get default values of focus reading distance on Image Settings then compare with excel table  
  var DefaultFocusAutoLearnValue_R = ReadDefaultFocusAutoLearnValue();
  if(DefaultFocusAutoLearnValue_R[0] == 0)
  {
    Log.Error("Can not find the Focus Reading Distance value on device");
    aqTestCase.End();
    ExcelWorkbookObj.Close(false);
    Excel.Quit();
    return;
  }
  if(FocusAutolearnDefaultValue_Excel != DefaultFocusAutoLearnValue_R[0])
  {
    Log.Error("Deviation between default value excel file and from device (" + FocusAutolearnDefaultValue_Excel + "/" + DefaultFocusAutoLearnValue_R[0] + ")");
  }
  else
  {
    Log.Checkpoint("Default value between excel file and from device are SAME");
  }
  
  var FocusAutolearnCommandButton, tempObj;
  for(var i = MinFocusAutoLearnValue_HMPTable; i<= MaxFocusAutoLearnValue_HMPTable; i++)
  {
    
    // set text on focus reading distance box
    DefaultFocusAutoLearnValue_R[1].Click();
    FocusAutolearnCommandButton = Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000);
    tempObj = FocusAutolearnCommandButton.Parent;
    tempObj.FindChild("WPFControlName", "TextBox", 1000).set_Text(i);
    tempObj.FindChild("WPFControlName", "TextBox", 1000).Keys("[Enter]");
    
    lib_button.clickPlay(false);
    lib_button.clickPause(false);
        
    lib_button.clickIMG_AutoSetup_Static(true);
    lib_button.clickPlay(false);
    delay(3000);
    lib_button.clickPause(false);
  }
  ExcelWorkbookObj.Close(false);
  Excel.Quit();
  aqTestCase.End();
}
function ReadDefaultFocusAutoLearnValue()
{
  // find on click on Genreal Image Settings\
  var DefaultFocusAutoLearnValue = 0;
  var arrPro = ["WPFControlText", "ClrClassName", "Visible"];
  var arrVal = ["General Image Settings", "TextBlock", true];
  var GeneralImageSettings = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  if(GeneralImageSettings.Exists)
  {
    GeneralImageSettings.Click();
  }
  else
  {
    // find on click on Genreal Image Settings\
    arrPro = ["WPFControlText", "ClrClassName", "Visible"];
    arrVal = ["Image Settings ", "TextBlock", true];
    GeneralImageSettings = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
    if(GeneralImageSettings.Exists)
    {
      GeneralImageSettings.Click();
    }
    else
    {
      return [DefaultFocusAutoLearnValue, GeneralImageSettings];
    }
  }
  // find the Reading Distance Label
  arrPro = ["WPFControlText", "ClrClassName", "Visible"];
  arrVal = ["Reading Distance (mm)", "TextBlock", true];
  ReadingDistanceLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  if(ReadingDistanceLbl.Exists)
  {
    ReadingDistanceTextBox = ReadingDistanceLbl.Parent.FindChild("WPFControlName", "TextBox", 1000);
    if(ReadingDistanceTextBox.Exists)
    {
      DefaultFocusAutoLearnValue = aqConvert.StrToInt(ReadingDistanceTextBox.Text);
    }
    else
    {
      return [DefaultFocusAutoLearnValue, GeneralImageSettings];
    }
  }
  else
  {
    return [DefaultFocusAutoLearnValue, GeneralImageSettings];
  }
  return [DefaultFocusAutoLearnValue, GeneralImageSettings];
}

function GetMaxMinDefaultFocusAutoLearn()
{
  var ivsMenu = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
  ivsMenu.WPFMenu.Click("Device|Settings|View Configuration HMP Shortcuts");
  var readingDistanceObj  = Sys.Process("DL.CODE").WPFObject("HwndSource: EscapeSequencesPopup", "Escape Sequences").FindChild("WPFControlText", "Reading Distance (mm)", 1000);
  var DefaultValue = 0, MinValue = 0, MaxValue = 0;
  if(readingDistanceObj.Exists)
  {
    try
    {
      readingDistanceObj = readingDistanceObj.Parent;
      var BoxMaxMinValuesReadingDistance = readingDistanceObj.WPFObject("Border", "", 1).WPFObject("ContentControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1);
      var str = BoxMaxMinValuesReadingDistance.WPFControlText;
      str = aqString.Replace(str, "..", ";")
      aqString.ListSeparator = ";";
      var MinValueStr = aqString.GetListItem(str, 0);
      MinValueStr = aqString.SubString(MinValueStr, 1, MinValueStr.length - 1);
    
      var MaxValueStr = aqString.GetListItem(str, 1);
      MaxValueStr = aqString.SubString(MaxValueStr, 0 , MaxValueStr.length - 1);
    
      var BoxDefaultValuesReadingDistance = readingDistanceObj.WPFObject("Border", "", 1).WPFObject("ContentControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 2);
      str = BoxDefaultValuesReadingDistance.WPFControlText;
      aqString.ListSeparator = ":";
      var DefaultValueStr = aqString.GetListItem(str, 1);
      DefaultValueStr = aqString.SubString(DefaultValueStr, 1, DefaultValueStr.length - 1);
    
      DefaultValue = aqConvert.StrToInt(DefaultValueStr);
      MinValue = aqConvert.StrToInt(MinValueStr);
      MaxValue = aqConvert.StrToInt(MaxValueStr);
    }
    catch (e)
    {
      Log.Error("Error when finding the max/min/default value on device");
    }
    
  }
  
  Sys.Process("DL.CODE").WPFObject("HwndSource: EscapeSequencesPopup", "Escape Sequences").Close();
  return [DefaultValue, MinValue, MaxValue];
}