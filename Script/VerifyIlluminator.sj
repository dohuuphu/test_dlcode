//USEUNIT lib_button
//USEUNIT lib_common
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo
function VerifyIlluminator()
{
  aqTestCase.Begin("Verify Illuminator all mode");
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
  ExcelSheet = ExcelWorkbookObj.Sheets.Item(SheetNeedToActive);
  
  var RowCount = ExcelSheet.UsedRange.Rows.Count;
  var InternalLightModeCount = 0;
  var tempStr;
  for(var i = 2;i<= RowCount; i++)
  {
    tempStr = (VarToString(ExcelSheet.Cells.Item(i, 1)));
    if(tempStr != "")
    {
      InternalLightModeCount++;
    }
  }
  
  
  lib_button.clickAdvancedSetup();
  // click on Image Settings
  arrPro = ["ClrClassName", "WPFControlText"];
  arrVal = ["TextBlock", "Image Settings "];
  Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000).Click();
  
  var ArrayObj = VerifyDefaultParameter(InternalLightModeCount, ExcelSheet, RowCount);
  var InternalLightingCbx_R = ArrayObj[0];
  var LedGroupCbx_R = ArrayObj[1];
  var tempStr1, tempStr2, tempStr3, tempStr4;
  for(i=2;i<=RowCount;i++)
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
      
      if(tempStr3 != "" && tempStr3 != "None") VerifySector(tempStr3);
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
      if(tempStr4 != "" && tempStr4 != "None") VerifyExternalLighting(tempStr4);
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
                    
  }
  ExcelWorkbookObj.Close();

  ExcelWorkbookObj = null;
  ExcelSheet = null;
  Excel = null; 
  aqTestCase.End(); 
}

function VerifyDefaultParameter(InternalLightModeCount, excelSheet, rowCount)
{
  var InternalLightDefaultValue, LedGroupDefaulValue, SectorDefaultValue;
  var SectorDefaultValue = [], ExternalLightingDefault = [];
  var tempStr1, tempStr2, tempStr3, tempStr4, tempStr5;
  var LedGroupCbx, InternalLightingCbx;
  for(i=2;i<=rowCount;i++)   
  {
    tempStr1 = (VarToString(excelSheet.Cells.Item(i, 1)));
    tempStr2 = (VarToString(excelSheet.Cells.Item(i, 2)));
    tempStr3 = (VarToString(excelSheet.Cells.Item(i, 3)));
    tempStr4 = (VarToString(excelSheet.Cells.Item(i, 4)));
    tempStr5 = (VarToString(excelSheet.Cells.Item(i, 5)));
    if(tempStr5 == "Y" && tempStr1 != "")
    {
      InternalLightDefaultValue = tempStr1;
    }
    if(tempStr5 == "Y" && tempStr2 != "")
    {
      LedGroupDefaulValue = tempStr2;
    }
    if(tempStr5 == "Y" && tempStr3 != "")
    {
      SectorDefaultValue.push(tempStr3);
    }
    if(tempStr5 == "Y" && tempStr4 != "")
    {
      ExternalLightingDefault.push(tempStr4);
    }
  }
  
  // find the Internal Lighting label
  arrPro = ["ClrClassName", "WPFControlText", "Visible"];
  arrVal = ["TextBlock", "Internal Lighting", true];
  InternalLightingLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);  
  // find the combobox HW Acceleration
  InternalLightingCbx = InternalLightingLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000);
  aqObject.CheckProperty(InternalLightingCbx, "wItemCount", cmpEqual, InternalLightModeCount);
  // check default value
  aqObject.CheckProperty(InternalLightingCbx.WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, InternalLightDefaultValue);
  
  if(LedGroupDefaulValue == "None")
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
    // find the LED Group label
    arrPro = ["ClrClassName", "WPFControlText", "Visible"];
    arrVal = ["TextBlock", "Led Group", true];
    LedGroupLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);  
    // find the combobox Led Group
    LedGroupCbx = LedGroupLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000);  
    // check default value
    aqObject.CheckProperty(LedGroupCbx.WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, LedGroupDefaulValue);
  }
  // verify sector default
  if(SectorDefaultValue[0] == "None")
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
    for(var i = 0; i<SectorDefaultValue.length;i++)
    {
      VerifySector(SectorDefaultValue[i]);
    }
  }
   // verify exterl lighting
  if(ExternalLightingDefault[0] == "None")
  {
      // find the external lighting label
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
    for(var i = 0; i<ExternalLightingDefault.length;i++)
    {
      VerifyExternalLighting(ExternalLightingDefault[i]);
    }
  }

  return [InternalLightingCbx, LedGroupCbx];
}

function VerifySector(sectorString)
{
  arrPro = ["ClrClassName", "WPFControlText", "Visible"];
  arrVal = ["TextBlock", "Sectors", true];
  SectorsLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);  
  aqObject.CheckProperty(SectorsLbl.Parent, "Visible", cmpEqual, true);        
        
  arrPro = ["ClrClassName", "WPFControlText", "Visible"];
  arrVal = ["CheckBox", sectorString, true];
  var Sector = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);  
  aqObject.CheckProperty(Sector, "Visible", cmpEqual, true);
  aqObject.CheckProperty(Sector, "IsChecked", cmpEqual, true);
}

function VerifyExternalLighting(externalOutputString)
{
  arrPro = ["ClrClassName", "WPFControlText", "Visible"];
  arrVal = ["TextBlock", externalOutputString, true];
  var Output = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);  
  aqObject.CheckProperty(Output, "Visible", cmpEqual, true);  
  
  var ChecboxOutput;
  while(true)
  {
    Output = Output.Parent;
    ChecboxOutput = Output.FindChild("ClrClassName", "CheckBox", 1000);
    if(ChecboxOutput.Exists)
    {
      break;
    }
    delay(200);
  }
  aqObject.CheckProperty(ChecboxOutput, "IsChecked", cmpEqual, false);
}