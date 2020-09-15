//USEUNIT lib_button
//USEUNIT lib_common
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo
function VerifyExposureTime()
{
  aqTestCase.Begin("Verify Exp Gain, Gain Mul: Min, Max, Out of range, default");
  if(!lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
  {
    Log.Error("Can not connect to device");
    aqTestCase.End();
    return;
  }
  var deviceModel = lib_common.getDeviceModel();
  if(!lib_OpenJob.openOnDevice( lib_const.const_DefaultJob ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
  {
    Log.Error("Can not open job on device");
    aqTestCase.End();
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
  var RowCount = ExcelSheet.UsedRange.Rows.Count;
  
  var ExposureTimeDefaultStr = (VarToString(ExcelSheet.Cells.Item(2, 6)));
  var GainDefaultStr = (VarToString(ExcelSheet.Cells.Item(2, 7)));
  var GainMultiplierDefaultStr = (VarToString(ExcelSheet.Cells.Item(2, 8)));
  
  var ExposureTimeDefault_Excel = aqConvert.StrToInt(ExposureTimeDefaultStr);
  var GainDefault_Excel = aqConvert.StrToInt(GainDefaultStr);
  var GainMultiplierDefault_Excel = GainMultiplierDefaultStr
  
  var Exp_DefaultMinMax_Arr = GetMaxMinDefaultExp_HMPTable();
  var Gain_DefaultMinMax_Arr = GetMaxMinDefaultGain_HMPTable()
  var GainMultiplier_Arr = GetMaxMinDefaultGainMultiplier_HMPTable();
  // check consistent between excel file and HMP Table
  if(ExposureTimeDefault_Excel == Exp_DefaultMinMax_Arr[0])
  {
    Log.Checkpoint("Exposure time between Excel file and HMP Table are same");
  }
  else
  {
    Log.Error("Exposure time between Excel file and HMP Table are NOT same. Please check again HMP Table and Excel file");
  }
  
  if(GainDefault_Excel == Gain_DefaultMinMax_Arr[0])
  {
    Log.Checkpoint("Gain between Excel file and HMP Table are same");
  }
  else
  {
    Log.Error("Gain between Excel file and HMP Table are NOT same. Please check again HMP Table and Excel file");
  }
  
  if(GainMultiplierDefault_Excel == GainMultiplier_Arr[0])
  {
    Log.Checkpoint("Gain Multiplier between Excel file and HMP Table are same");
  }
  else
  {
    Log.Error("Gain Multiplier between Excel file and HMP Table are NOT same. Please check again HMP Table and Excel file");
  }
  // check consistence between excel file and value in Image SEttigs
  DefaultExpGainGainMulArr = ReadDefaultExp_Gain_GainMultipler();
  if(DefaultExpGainGainMulArr[0] == 0  || DefaultExpGainGainMulArr[2] == "")
  {
    Log.Error("Can not read value in Image Settings. Please check");
    ExcelWorkbookObj.Close();
    ExcelWorkbookObj = null;
    ExcelSheet = null;
    Excel = null;  
    aqTestCase.End();
    
    return;
  }
  if(DefaultExpGainGainMulArr[4] == null || DefaultExpGainGainMulArr[5] == null || DefaultExpGainGainMulArr[6] == null)
  {
    Log.Error("Can not read value in Image Settings. Please check");
    ExcelWorkbookObj.Close();
    ExcelWorkbookObj = null;
    ExcelSheet = null;
    Excel = null;  
    aqTestCase.End();
    return;
  }
  
  if(DefaultExpGainGainMulArr[0] == ExposureTimeDefault_Excel)
  {
    Log.Checkpoint("Exposure time between Excel file and in Image Settings are same");
  }
  else
  {
    Log.Error("Exposure time between Excel file and in Image Settings are NOT same. Please check again in Image Settings and Excel file");
  }
  
  if(DefaultExpGainGainMulArr[1] == GainDefault_Excel)
  {
    Log.Checkpoint("Gain between Excel file and in Image Settings are same");
  }
  else
  {
    Log.Error("Gain between Excel file and in Image Settings are NOT same. Please check again in Image Settings and Excel file");
  }
  
  if(DefaultExpGainGainMulArr[2] == GainMultiplierDefault_Excel)
  {
    Log.Checkpoint("Gain Multilplier between Excel file and in Image Settings are same");
  }
  else
  {
    Log.Error("Gain Multilplier between Excel file and in Image Settings are NOT same. Please check again in Image Settings and Excel file");
  }
  
  // declare value exposure time, gain, gain Multilpler select to test
  var ExposureTimeSelectedItemsList = [];

  var GainSelectedItemsList = [];
  
  var GainMultiplierSelectedItemsList = [];
  
  var ExposureTimeSelectedItemsList_Expected = [];

  var GainSelectedItemsList_Expected = [];
  
  
  
  
  // object text box, combo box for exposure time, gain, gain multiplier
  var ExposureTimeTextBox , GainTextBox, GainMultiplierComboBox;
  ExposureTimeTextBox = DefaultExpGainGainMulArr[4];
  GainTextBox = DefaultExpGainGainMulArr[5];
  GainMultiplierComboBox = DefaultExpGainGainMulArr[6];
  
  
  // internla lighting combo box object, led group combobox object (null if no led group)
  var arrPro = ["ClrClassName", "WPFControlText", "Visible"];
  var arrVal = ["TextBlock", "Internal Lighting", true];
  var InternalLightingLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);    
  var InternalLightingCbx_R = InternalLightingLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000);
  
  // find the LED Group label
  arrPro = ["ClrClassName", "WPFControlText"];
  arrVal = ["TextBlock", "Led Group"];
  var LedGroupLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  var LedGroupCbx; 
  if(LedGroupLbl.Exists)
  {
    aqObject.CheckProperty(LedGroupLbl, "Visible", cmpEqual, false) ;
    LedGroupCbx = LedGroupLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000); 
  }        
  var LedGroupCbx_R = LedGroupCbx;
  var tempStr1, tempStr2, tempStr3, tempStr4;
  // loop for all ilumniator mode
  // insdie verify values of exposure time, gain and gain multiplier above
  for(var i=2;i<=RowCount;i++)
  {
      tempStr1 = (VarToString(ExcelSheet.Cells.Item(i, 1)));
      tempStr2 = (VarToString(ExcelSheet.Cells.Item(i, 2)));
      tempStr3 = (VarToString(ExcelSheet.Cells.Item(i, 3)));
      tempStr4 = (VarToString(ExcelSheet.Cells.Item(i, 4)));
      
      if(tempStr1 != "") lib_common.cbb_NonLogicalAdornerDecorator(InternalLightingCbx_R,tempStr1);
      
      if(tempStr2 != "" && tempStr2 != "None") lib_common.cbb_NonLogicalAdornerDecorator(LedGroupCbx_R,tempStr2);
      else if(tempStr2 == "None")
      {
        // find the LED Group label
        arrPro = ["ClrClassName", "WPFControlText"];
        arrVal = ["TextBlock", "Led Group"];
        LedGroupLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);  
        if(LedGroupLbl.Exists)
        {
        aqObject.CheckProperty(LedGroupLbl, "Visible", cmpEqual, false) ;
        LedGroupCbx = LedGroupLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000);  
          if(LedGroupCbx.Exists)
          {
            Log.Message("Verify LED Group combobox not appear");
            aqObject.CheckProperty(LedGroupCbx, "Visible", cmpEqual, false);
          }
          else
          {
            Log.Message("Verify LED Group combobox not appear");
            aqObject.CheckProperty(LedGroupCbx, "Exists", cmpEqual, false);
          }
        }
        else
        {
          Log.Message("Verify LED Group combobox not appear");
          aqObject.CheckProperty(LedGroupLbl, "Exists", cmpEqual, false);
        }
      }
      else
      {
        // do nothing
      }
      
      if(tempStr3 != "" && tempStr3 != "None") ;//VerifySector(tempStr3);
      else if(tempStr3 == "None")
      {
          // find the Sector label
        arrPro = ["ClrClassName", "WPFControlText"];
        arrVal = ["TextBlock", "Sectors"];
        SectorspLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);  
        if(SectorspLbl.Exists)
        {
          Log.Message("Verify Sectors not appear");
          aqObject.CheckProperty(SectorspLbl, "Visible", cmpEqual, false) ;      
        }
        else
        {
          Log.Message("Verify Sectors not appear");
          aqObject.CheckProperty(SectorspLbl, "Exists", cmpEqual, false);
        }
                
      }
      else
      {
        // do nothing
      }
      if(tempStr4 != "" && tempStr4 != "None") ;//VerifyExternalLighting(tempStr4);
      else if(tempStr3 == "None")
      {
              // find the Sector label
        arrPro = ["ClrClassName", "WPFControlText"];
        arrVal = ["TextBlock", "External Lighting"];
        ExternalLightingLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);  
        if(ExternalLightingLbl.Exists)
        {
          Log.Message("Verify External Lighting not appear");
          aqObject.CheckProperty(ExternalLightingLbl, "Visible", cmpEqual, false) ;      
        }
        else
        {
          Log.Message("Verify External Lighting not appear");
          aqObject.CheckProperty(ExternalLightingLbl, "Exists", cmpEqual, false);
        }
      }
      else
      {
        
      }
      if(tempStr1 == "") { continue;}
      var tempArr = ReInitExpGain_Value_ExpectedValue();
      ExposureTimeSelectedItemsList = tempArr[0];
      GainSelectedItemsList = tempArr[1];
      GainMultiplierSelectedItemsList = tempArr[2];
      ExposureTimeSelectedItemsList_Expected = tempArr[3];
      GainSelectedItemsList_Expected = tempArr[4];
      
      for(var j=0;j<ExposureTimeSelectedItemsList.length;j++)              
      {
         ExposureTimeTextBox.set_Text(ExposureTimeSelectedItemsList[j]);
         ExposureTimeTextBox.Keys("[Enter]");
         lib_button.clickPlay2();
         lib_button.clickPause2();
         aqObject.CheckProperty(ExposureTimeTextBox, "Text", cmpEqual, ExposureTimeSelectedItemsList_Expected[j]);
      }
      for(var j=0;j<GainSelectedItemsList.length;j++)              
      {
         GainTextBox.set_Text(GainSelectedItemsList[j]);
         GainTextBox.Keys("[Enter]");
         lib_button.clickPlay2();
         lib_button.clickPause2();
         aqObject.CheckProperty(GainTextBox, "Text", cmpEqual, GainSelectedItemsList_Expected[j]);
      }
      for(var j=0;j<GainMultiplierSelectedItemsList.length;j++)              
      {
         
         lib_common.cbb_NonLogicalAdornerDecorator(GainMultiplierComboBox, GainMultiplierSelectedItemsList[j])   ;
         lib_button.clickPlay2();
         lib_button.clickPause2();
      }
  }
  
  ExcelWorkbookObj.Close();
  ExcelWorkbookObj = null;
  ExcelSheet = null;
  Excel = null;  
  aqTestCase.End();
}

function ReadDefaultExp_Gain_GainMultipler()
{
  // find on click on Genreal Image Settings\
  var DefaultExposeTimeValue = 0, DefaultGainValue = 0, DefaultGainMulValue = "";
  var ExposeTimeTextBox = null, GainTextBox = null, GainMulTextBox = null;
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
      return [DefaultExposeTimeValue, DefaultGainValue, DefaultGainMulValue, GeneralImageSettings, ExposeTimeTextBox, GainTextBox, GainMulTextBox];
    }
  }
  // find the Exposure Time Label
  arrPro = ["WPFControlText", "ClrClassName", "Visible"];
  arrVal = ["Exposure Time (µs)", "TextBlock", true];
  ExposeTimeLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  count = 20;
  if(ExposeTimeLbl.Exists)
  {
    while(count > 0)
    {
      ExposeTimeLbl = ExposeTimeLbl.Parent;
      ExposeTimeTextBox = ExposeTimeLbl.Parent.FindChild("WPFControlName", "TextBox", 1000);
      if(ExposeTimeTextBox.Exists)
      {
        DefaultExposeTimeValue = aqConvert.StrToInt(ExposeTimeTextBox.Text);
        break;
      }
      count --;
    }
    ExposeTimeTextBox = ExposeTimeLbl.Parent.FindChild("WPFControlName", "TextBox", 1000);
    if(count == 0)
    {
      return [DefaultExposeTimeValue, DefaultGainValue, DefaultGainMulValue, GeneralImageSettings, ExposeTimeTextBox, GainTextBox, GainMulTextBox];
    } 
  }
  else
  {
    return [DefaultExposeTimeValue, DefaultGainValue, DefaultGainMulValue, GeneralImageSettings, ExposeTimeTextBox, GainTextBox, GainMulTextBox];
  }
  
   // find the Gain Label
  arrPro = ["WPFControlText", "ClrClassName", "Visible"];
  arrVal = ["Gain", "TextBlock", true];
  GainLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  if(GainLbl.Exists)
  {
    GainTextBox = GainLbl.Parent.FindChild("WPFControlName", "TextBox", 1000);
    if(GainTextBox.Exists)
    {
      DefaultGainValue = aqConvert.StrToInt(GainTextBox.Text);
    }
    else
    {
      return [DefaultExposeTimeValue, DefaultGainValue, DefaultGainMulValue, GeneralImageSettings, ExposeTimeTextBox, GainTextBox, GainMulTextBox];
    }
  }
  else
  {
    return [DefaultExposeTimeValue, DefaultGainValue, DefaultGainMulValue, GeneralImageSettings, ExposeTimeTextBox, GainTextBox, GainMulTextBox];
  }
  
   // find the Gain Multiplier Label
  arrPro = ["WPFControlText", "ClrClassName", "Visible"];
  arrVal = ["Gain Multiplier", "TextBlock", true];
  GainMulLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  if(GainMulLbl.Exists)
  {
    GainMulTextBox = GainMulLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000);
    if(GainMulTextBox.Exists)
    {
      DefaultGainMulValue = GainMulTextBox.WPFObject("TextBlock", "*", 1).WPFControlText;
    }
    else
    {
      return [DefaultExposeTimeValue, DefaultGainValue, DefaultGainMulValue, GeneralImageSettings, ExposeTimeTextBox, GainTextBox, GainMulTextBox];
    }
  }
  else
  {
    return [DefaultExposeTimeValue, DefaultGainValue, DefaultGainMulValue, GeneralImageSettings, ExposeTimeTextBox, GainTextBox, GainMulTextBox];
  }
  
  
  return [DefaultExposeTimeValue, DefaultGainValue, DefaultGainMulValue, GeneralImageSettings, ExposeTimeTextBox, GainTextBox, GainMulTextBox];
}

function GetMaxMinDefaultExp_HMPTable()
{
  var ivsMenu = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
  ivsMenu.WPFMenu.Click("Device|Settings|View Configuration HMP Shortcuts");
  delay(3000);
  var Exp_Obj  = Sys.Process("DL.CODE").WPFObject("HwndSource: EscapeSequencesPopup", "Escape Sequences").FindChild("WPFControlText", "Exposure Time (µs)", 1000);
  var DefaultValue = 0, MinValue = 0, MaxValue = 0;
  if(Exp_Obj.Exists)
  {
    try
    {
      Exp_Obj = Exp_Obj.Parent;
      var BoxMaxMinValuesExp = Exp_Obj.WPFObject("Border", "", 1).WPFObject("ContentControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1);
      var str = BoxMaxMinValuesExp.WPFControlText;
      str = aqString.Replace(str, "..", ";")
      aqString.ListSeparator = ";";
      var MinValueStr = aqString.GetListItem(str, 0);
      MinValueStr = aqString.SubString(MinValueStr, 1, MinValueStr.length - 1);
    
      var MaxValueStr = aqString.GetListItem(str, 1);
      MaxValueStr = aqString.SubString(MaxValueStr, 0 , MaxValueStr.length - 1);
    
      var BoxDefaultValuesExp = Exp_Obj.WPFObject("Border", "", 1).WPFObject("ContentControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 2);
      str = BoxDefaultValuesExp.WPFControlText;
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
  delay(1000);
  return [DefaultValue, MinValue, MaxValue];
}

function GetMaxMinDefaultGain_HMPTable()
{
  var ivsMenu = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
  ivsMenu.WPFMenu.Click("Device|Settings|View Configuration HMP Shortcuts");
  delay(3000);
  var Gain_Obj  = Sys.Process("DL.CODE").WPFObject("HwndSource: EscapeSequencesPopup", "Escape Sequences").FindChild("WPFControlText", "Gain", 1000);
  var DefaultValue = 0, MinValue = 0, MaxValue = 0;
  if(Gain_Obj.Exists)
  {
    try
    {
      Gain_Obj = Gain_Obj.Parent;
      var BoxMaxMinValuesGain = Gain_Obj.WPFObject("Border", "", 1).WPFObject("ContentControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1);
      var str = BoxMaxMinValuesGain.WPFControlText;
      str = aqString.Replace(str, "..", ";")
      aqString.ListSeparator = ";";
      var MinValueStr = aqString.GetListItem(str, 0);
      MinValueStr = aqString.SubString(MinValueStr, 1, MinValueStr.length - 1);
    
      var MaxValueStr = aqString.GetListItem(str, 1);
      MaxValueStr = aqString.SubString(MaxValueStr, 0 , MaxValueStr.length - 1);
    
      var BoxDefaultValuesGain = Gain_Obj.WPFObject("Border", "", 1).WPFObject("ContentControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 2);
      str = BoxDefaultValuesGain.WPFControlText;
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
  delay(1000);
  return [DefaultValue, MinValue, MaxValue];
}

function GetMaxMinDefaultGainMultiplier_HMPTable()
{
  var ivsMenu = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
  ivsMenu.WPFMenu.Click("Device|Settings|View Configuration HMP Shortcuts");
  delay(3000);
  var GainMul_Obj  = Sys.Process("DL.CODE").WPFObject("HwndSource: EscapeSequencesPopup", "Escape Sequences").FindChild("WPFControlText", "Gain Multiplier", 1000);
  var DefaultGainMulValue = "";
  var GainMulArr = [];
  if(GainMul_Obj.Exists)
  {
    try
    {
      GainMul_Obj = GainMul_Obj.Parent;
      GainMulMainObj = GainMul_Obj.WPFObject("Border", "", 1).WPFObject("ContentControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1);
      var GainMulCount = GainMul_Obj.WPFObject("Border", "", 1).WPFObject("ContentControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ItemsControl", "", 1).ChildCount;
      var str = "";
      for(var k = 1; k<= GainMulCount; k++)
      {
        str = GainMulMainObj.WPFObject("ContentPresenter", "", k).WPFObject("TextBlock", "", 1).WPFControlText;        
        aqString.ListSeparator = ":";
        str = aqString.GetListItem(str, 1);
        str = aqString.SubString(str, 2, str.length - 1);
        GainMulArr.push(str);
      }
      
    
      var BoxDefaultValuesGainMul = GainMul_Obj.WPFObject("Border", "", 1).WPFObject("ContentControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "", 1);
      str = BoxDefaultValuesGainMul.WPFControlText;
      aqString.ListSeparator = ":";
      var DefaultValueStr = aqString.GetListItem(str, 1);
      DefaultValueStr = aqString.SubString(DefaultValueStr, 7, DefaultValueStr.length - 9);
    
      
    }
    catch (e)
    {
      Log.Error("Error when finding the max/min/default value on device");
    }
    
  }
  
  Sys.Process("DL.CODE").WPFObject("HwndSource: EscapeSequencesPopup", "Escape Sequences").Close();
  delay(1000);
  return [DefaultValueStr, GainMulArr];
}

function ReInitExpGain_Value_ExpectedValue()
{
  delay(1000);
  var Exp_DefaultMinMax_Arr = GetMaxMinDefaultExp_HMPTable();
  delay(1000);
  var Gain_DefaultMinMax_Arr = GetMaxMinDefaultGain_HMPTable()
  delay(1000);
  var GainMultiplier_Arr = GetMaxMinDefaultGainMultiplier_HMPTable();
  delay(1000);
  var ExposureTimeSelectedItemsList = [
        -1,
        0, 
        Exp_DefaultMinMax_Arr[1] - 1, 
        Exp_DefaultMinMax_Arr[1], 
        Exp_DefaultMinMax_Arr[1] + 1, 
        2*Exp_DefaultMinMax_Arr[1],
        4*Exp_DefaultMinMax_Arr[1] + 1,
        Math.round(Exp_DefaultMinMax_Arr[2]/2),
        Math.round(Exp_DefaultMinMax_Arr[2]/2 + Exp_DefaultMinMax_Arr[2]/4),
        Exp_DefaultMinMax_Arr[2] - 1,
        Exp_DefaultMinMax_Arr[2],
        Exp_DefaultMinMax_Arr[2] + 1
        ];
  
  var GainSelectedItemsList = [
      -1,
      0,
      Gain_DefaultMinMax_Arr[1] -1,
      Gain_DefaultMinMax_Arr[1],
      Gain_DefaultMinMax_Arr[1] + 1,
      2*Gain_DefaultMinMax_Arr[1],
      4*Gain_DefaultMinMax_Arr[1] +1,
      Math.round(Gain_DefaultMinMax_Arr[2]/2),
      Math.round(Gain_DefaultMinMax_Arr[2]/ 2 + Gain_DefaultMinMax_Arr[2] /4),
      Gain_DefaultMinMax_Arr[2] - 1,
      Gain_DefaultMinMax_Arr[2],
      Gain_DefaultMinMax_Arr[2] + 1
  ];

  var GainMultiplierSelectedItemsList = GainMultiplier_Arr[1];
  
  var ExposureTimeSelectedItemsList_Expected = [
        Exp_DefaultMinMax_Arr[1],
        Exp_DefaultMinMax_Arr[1], 
        Exp_DefaultMinMax_Arr[1], 
        Exp_DefaultMinMax_Arr[1], 
        Exp_DefaultMinMax_Arr[1] + 1, 
        2*Exp_DefaultMinMax_Arr[1],
        4*Exp_DefaultMinMax_Arr[1] + 1,
        Math.round(Exp_DefaultMinMax_Arr[2]/2),
        Math.round(Exp_DefaultMinMax_Arr[2]/2 + Exp_DefaultMinMax_Arr[2]/4),
        Exp_DefaultMinMax_Arr[2] - 1,
        Exp_DefaultMinMax_Arr[2],
        Exp_DefaultMinMax_Arr[2]
        ];

  var GainSelectedItemsList_Expected = [
      Gain_DefaultMinMax_Arr[1],
      Gain_DefaultMinMax_Arr[1],
      Gain_DefaultMinMax_Arr[1],
      Gain_DefaultMinMax_Arr[1],
      Gain_DefaultMinMax_Arr[1] + 1,
      2*Gain_DefaultMinMax_Arr[1],
      4*Gain_DefaultMinMax_Arr[1] +1,
      Math.round(Gain_DefaultMinMax_Arr[2]/2),
      Math.round(Gain_DefaultMinMax_Arr[2]/ 2 + Gain_DefaultMinMax_Arr[2] /4),
      Gain_DefaultMinMax_Arr[2] - 1,
      Gain_DefaultMinMax_Arr[2],
      Gain_DefaultMinMax_Arr[2]
  ]
  return [
      ExposureTimeSelectedItemsList, 
      GainSelectedItemsList, 
      GainMultiplierSelectedItemsList, 
      ExposureTimeSelectedItemsList_Expected, 
      GainSelectedItemsList_Expected
      ]       ;
}