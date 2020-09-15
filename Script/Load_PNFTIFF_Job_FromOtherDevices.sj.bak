//USEUNIT lib_button
//USEUNIT lib_common
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo

function Load_PNFTIFF_Job_FromOtherDevices()
{
  aqTestCase.Begin("Load PNG TIFF job from other devices");
  if(!lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
  {
    Log.Error("Can not connect to device");
    aqTestCase.End();
    return;
  }
  
  ConfigArray = getAllFilesConfigToLoad();
  for(i =0;i<ConfigArray.length;i++)
  {
    // click on Load from PDC
    arrPro = ["ToolTip", "Visible"];
    arrVal = ["Load from PC", true];
    Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000).Click();
    
    
    if(Sys.Process("DL.CODE").WaitWindow("#32770", "Open", 1, 1000).Exists)
    {
      arrPro = ["WndClass", "ChildCount"];
      arrVal = ["ComboBox", 1]      ;
      
      // enter to config path file
      ComboBoxFileName = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      ComboBoxFileName.Window("Edit", "", 1).SetText(ConfigArray[i]);
      
      // click open button
      Sys.Process("DL.CODE").FindChild("WndCaption", "&Open", 1000).Click();
    }
    
    if(Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", 1000).Exists)
    {
      PopUpWindow = Sys.Process("DL.CODE").WPFObject("HwndSource: Window");
      aqObject.CheckProperty(PopUpWindow, "Visible", cmpEqual, true);
      // click on yes button
      PopUpWindow.FindChild("WPFControlName", "btnYes", 1000).Click();
    }
    else
    {
      // do nothing
    }
    if(Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", 1000).Exists)
    {
      PopUpWindow = Sys.Process("DL.CODE").WPFObject("HwndSource: Window");
      aqObject.CheckProperty(PopUpWindow, "Visible", cmpEqual, true);
      // click on yes button
      PopUpWindow.FindChild("WPFControlName", "btnYes", 1000).Click();
    }
    else
    {
      // do nothing
    }
    delay(800);
    while(Sys.Process("DL.CODE").FindChild("WPFControlText", "Communicating with device. Please wait…", 1000).Exists)
    {
        delay(800);
    }
    delay(2000);
    var text = "Attention: an Error occurred while attempting to connect to device! Please, make sure device is connected to your PC.";
    if(Sys.Process("DL.CODE").FindChild("WPFControlText", text, 1000).Exists)
    {
      Log.Error(text);
      aqTestCase.End();
      return;
    }
    
    delay(5000);
    lib_button.clickDataFortmating2();
    VefiyDefaultFormatBMP();
    VeriyAllTabVisible();
    VerifyAllPanelVisbile();
    lib_button.clickPlay2();
    delay(3000);
    lib_button.clickPause2();
    lib_SaveJob.saveJobOnDevice2(lib_deviceInfo.const_firmware_version + "_" + aqFileSystem.GetFileNameWithoutExtension(ConfigArray[i]));
  }
  aqTestCase.End();
}

function getAllFilesConfigToLoad()
{
    
    ConfigFolder = aqFileSystem.GetFolderInfo(Project.Path).ParentFolder.Path + "PNG_TIFF_Jobs";
    ListConfigFile=  aqFileSystem.FindFiles(ConfigFolder, "*.dlcfg", false);
    var ConfigFullPathArray = [];
    if (ListConfigFile != null)
    {
      while (ListConfigFile.HasNext())
      {
          aFolder = ListConfigFile.Next();
          ConfigFullPathArray.push(aFolder.Path);
      }
    }
    else
    {
        Log.Error("No folders were found.");
    }
    return ConfigFullPathArray;
}
function VeriyAllTabVisible()
{
  ParentObj = Sys.Process("DL.CODE").FindChild("WPFControlName", "JcmExpanderUserControl", 1000);
  arrTab = ["Automatic Setup", "Advanced Setup", "Reading Phase", "Good Read Setup", "Data Formatting", "Output Setup"];
  for (j=0; j< arrTab.length;j++)
  {
    TabObj = ParentObj.FindChild("WPFControlText", arrTab[j], 1000);
    aqObject.CheckProperty(TabObj.Parent, "Visible", cmpEqual, true);
    aqObject.CheckProperty(TabObj.Parent, "Enabled",cmpEqual, true);
    //TabObj.Click()
  }
}
function VerifyAllPanelVisbile()
{
  lib_button.clickAdvancedSetup();
  var left_tips = [
  "Add New Image Setup",
  "Add 1D Code",
  "Add 2D Code",
  "Add Postal Code",
  "Add New Filter",
  "Delete Selected Item",
  "Learn Codes"
  ]; 
  var central_tips = [
  "Move Up",
  "Move Down",
  "Zoom In",
  "Zoom To Fit",
  "Zoom Out",
  "Save Image",
  "Configuration Test Record",
  "Add Cropping Region",
  "Show Image Grid",
  "Play",
  "Capture"
  ]; 

  for(k=0;k<left_tips.length;k++)
  {
    aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("ToolTip", left_tips[k], 1000), "Visible", cmpEqual, true);
  }
  for(k=0;k<central_tips.length;k++)
  {
    TempObj = Sys.Process("DL.CODE").FindChild("ToolTip", central_tips[k], 1000);
    if(TempObj.Exists)
    {
      aqObject.CheckProperty(TempObj, "Visible", cmpEqual, true);  
    }
    else
    {
      arrPro = ["ToolTip.Text", "Visible"];
      arrVal = [central_tips[k], true];
      TempObj =Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      if(TempObj.Exists)
      {
        aqObject.CheckProperty(TempObj, "Visible", cmpEqual, true);  
      }
      
    }
  }
  
  lib_button.clickReadingPhase2();
  arrReadingPhasePanel = ["Continuous Mode" , "One Shot Mode", "Phase Mode", "Add New Channel", "Add New Fieldbus", "Add Protocol Index", "Delete Selected Item", "Add Acquisition Sequence", "Zoom In", "Zoom to Fit", "Zoom Out" , "Play"];
  
  for(k=0;k<arrReadingPhasePanel.length;k++)
  {
    arrPro = ["ToolTip", "Visible"];
    arrVal = [arrReadingPhasePanel[k], true];
    TempObj =Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
    if(TempObj.Exists)
    {
      aqObject.CheckProperty(TempObj, "Visible", cmpEqual, true);  
    }
    else
    {
      arrPro = ["ToolTip.Text", "Visible"];
      arrVal = [arrReadingPhasePanel[k], true];
      TempObj =Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      if(TempObj.Exists)
      {
        aqObject.CheckProperty(TempObj, "Visible", cmpEqual, true);  
      }
      
    }
  }
  
  lib_button.clickGoodReadSetup();
  arrGoodReadSetup = ["Code Collection", "Code Combination", "Code Presentation", "Match Code", "Add Code to the Expected Combination", "Play"];
  for(k=0;k<arrGoodReadSetup.length;k++)
  {
    arrPro = ["ToolTip", "Visible"];
    arrVal = [arrGoodReadSetup[k], true];
    TempObj =Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
    if(TempObj.Exists)
    {
      aqObject.CheckProperty(TempObj, "Visible", cmpEqual, true);  
    }
    else
    {
      arrPro = ["ToolTip.Text", "Visible"];
      arrVal = [arrGoodReadSetup[k], true];
      TempObj =Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      if(TempObj.Exists)
      {
        aqObject.CheckProperty(TempObj, "Visible", cmpEqual, true);  
      }
      
    }
  }
  
  lib_button.clickDataFortmating2();
  arrDataFormatting = ["Enable Diagnostic Message", "Add Image Saving Condition", "Add New Channel", "Add New Fieldbus", "Passthrough Configuration", "Delete Selected Channel", "Code Related Field", "Code Quality Grading Field", "Global Statistics Field", "Global Reading Field", "Custom Field", "Diagnostics Field", "Play"];
  for(k=0;k<arrDataFormatting.length;k++)
  {
    arrPro = ["ToolTip", "Visible"];
    arrVal = [arrDataFormatting[k], true];
    TempObj =Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
    if(TempObj.Exists)
    {
      aqObject.CheckProperty(TempObj, "Visible", cmpEqual, true);  
    }
    else
    {
      arrPro = ["ToolTip.Text", "Visible"];
      arrVal = [arrDataFormatting[k], true];
      TempObj =Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      if(TempObj.Exists)
      {
        aqObject.CheckProperty(TempObj, "Visible", cmpEqual, true);  
      }
      
    }
  }
  lib_button.clickOutputSetup();
  arrOutputSEtup = ["Add New Channel", "Add New Fieldbus", "Delete Selected Item", "Zoom In", "Zoom to Fit", "Zoom Out", "Play"];
  for(k=0;k<arrOutputSEtup.length;k++)
  {
    arrPro = ["ToolTip", "Visible"];
    arrVal = [arrOutputSEtup[k], true];
    TempObj =Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
    if(TempObj.Exists)
    {
      aqObject.CheckProperty(TempObj, "Visible", cmpEqual, true);  
    }
    else
    {
      arrPro = ["ToolTip.Text", "Visible"];
      arrVal = [arrOutputSEtup[k], true];
      TempObj =Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      if(TempObj.Exists)
      {
        aqObject.CheckProperty(TempObj, "Visible", cmpEqual, true);  
      }
      
    }
  }
}

function VefiyDefaultFormatBMP()
{
  LeftPanelImageSavingObj = Sys.Process("DL.CODE").FindChild("WPFControlText", "Images Saving Conditions", 1000).Parent;
  NumberOfImageSaving = LeftPanelImageSavingObj.ChildCount -1;
  if(!LeftPanelImageSavingObj.get_IsExpanded())
  {
    LeftPanelImageSavingObj.ExpandSubtree();
  }
  for(i=1;i<=NumberOfImageSaving;i++)
  {
    LeftPanelImageSavingObj.WPFObject("TreeViewItem", "", i).Click();
    arrPro = ["ClrClassName", "WPFControlText", "Visible"];
    arrVal = ["TextBlock", "Image Format", true];
  
    ImageFormatLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
    aqObject.CheckProperty(ImageFormatLbl, "Visible", cmpEqual, true);
    // find the combo box image format
    ImageFormatCbx = ImageFormatLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000);
    aqObject.CheckProperty(ImageFormatCbx.WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, "Bmp");
    aqObject.CheckProperty(ImageFormatCbx, "wItemCount", cmpEqual,3);
    arrFortmatType = ["Raw", "Bmp", "Jpeg"];
    for(var i=0;i<arrFortmatType.length;i++)
    {
      lib_common.cbb_NonLogicalAdornerDecorator(ImageFormatCbx,arrFortmatType[i]);  
    }
  }
}