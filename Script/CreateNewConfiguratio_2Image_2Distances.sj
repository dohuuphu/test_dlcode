//USEUNIT lib_button
//USEUNIT lib_common
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo
//USEUNIT lib_ImageSetup
//USEUNIT  lib_SaveJob
function CreateNewConfiguratio_2Image_2Distances()
{
  aqTestCase.Begin("Create configuration with 2 image setttings for next steps");
  if(!lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
  {
    Log.Error("Can not connect to device");
    aqTestCase.End();
    return;
  }
  if(!lib_OpenJob.openOnDevice( lib_const.const_DefaultJob ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
  {
    Log.Error("Can not open job on device");
    aqTestCase.End();
    return;
  }  
  lib_button.clickAdvancedSetup();
  var ArrRet = setUpValuesFor2Distance();
  if(ArrRet == null) return;
  Distance1 = (ArrRet[0] + ArrRet[1])/2;
  Distance2 = (ArrRet[0] + ArrRet[1])/4;
  
  Distance1Str = aqConvert.IntToStr(Distance1) ; 
  Distance2Str = aqConvert.IntToStr(Distance2) ;
  DistanceArr = [Distance1Str, Distance2Str] ;
  Sys.Process("DL.CODE").FindChild("ToolTip", "Add New Image Setup", 1000).Click();
  delay(3000);
  Sys.Refresh();
  tempObj = Sys.Process("DL.CODE").FindChild("WPFControlText", "Code Settings", 1000);
  NumberOfImage = tempObj.Parent.ChildCount - 1;
  for(var i = 1; i <= NumberOfImage;i++)
  {    
    ImageSettingObj = tempObj.Parent.WPFObject("TreeViewItem", "", i);
    
    ImageSettingObj.WPFObject("StackPanel", "", 1).Click();
    ReadingDistanceLabel = Sys.Process("DL.CODE").FindChild("WPFControlText", "Reading Distance (mm)", 1000);
    ReadingDistanceTextBox = ReadingDistanceLabel.Parent.FindChild("WPFControlName", "TextBox", 1000);
    ReadingDistanceTextBox.set_Text(DistanceArr[i-1]);
    ReadingDistanceTextBox.Keys("[Enter]");  
    Sys.Process("DL.CODE").FindChild("WPFControlText", "Image Auto-Setup", 1000) .Click();
    delay(2000);
    ImageAutoSetupWindow = Sys.Process("DL.CODE").WaitWPFObject("HwndSource: PhotometryAutolearnDialogWindow", "Image Auto-Setup", 1000);
    if(ImageAutoSetupWindow.Exists)    
    {
      ImageAutoSetupWindow.FindChild("WPFControlText", "Static", 1000).Click();
      ImageAutoSetupWindow.FindChild("WPFControlText", "Start", 1000).Click();      
      while(!ImageAutoSetupWindow.FindChild("WPFControlText", "Apply", 1000).Enabled) {}
      ImageAutoSetupWindow.FindChild("WPFControlText", "Apply", 1000).Click();
    }
  }
  tempObj = Sys.Process("DL.CODE").FindChild("WPFControlText", "Code Settings", 1000);
  if(tempObj.Exists)
  {
    ImageSetting2Obj = tempObj.Parent.WPFObject("TreeViewItem", "", 2);
    if(!ImageSetting2Obj.get_IsExpanded()) ImageSetting2Obj.ExpandSubtree();
    Add1DCodeObj = Sys.Process("DL.CODE").FindChild("ToolTip", "Add 1D Code", 1000);
    Add1DCodeObj.Click();
    Add1DCodeObj.PopupMenu.Click("CODE128");
  }
  
  lib_button.clickReadingPhase2();
  
  enabledPhaseModeTCPServer();
  enabledExternalImageSequence();
  
  lib_button.clickGoodReadSetup();
  clickDragXOR();
  lib_button.clickDataFortmating2();
  
  lib_button.ConfigNoRead_DataForamtting();
  lib_button.ConfigGoodRead_DataFormatting();
  
  lib_SaveJob.saveJobOnDevice2(lib_deviceInfo.const_firmware_version +  "_2ImageSettings_ImageSequence");
  lib_common.gettingStarted();
  aqTestCase.End();
}

function setUpValuesFor2Distance()
{
  ivsMenu = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
  ivsMenu.WPFMenu.Click("Device|Settings|View Configuration HMP Shortcuts");
  readingDistanceObj  = Sys.Process("DL.CODE").WPFObject("HwndSource: EscapeSequencesPopup", "Escape Sequences").FindChild("WPFControlText", "Reading Distance (mm)", 1000);
  if(readingDistanceObj.Exists)
  {
    readingDistanceObj = readingDistanceObj.Parent;
    boxValuesReadingDistance = readingDistanceObj.WPFObject("Border", "", 1).WPFObject("ContentControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1);
    var str = boxValuesReadingDistance.WPFControlText;
    str = aqString.Replace(str, "..", ";")
    aqString.ListSeparator = ";";
    minValue = aqString.GetListItem(str, 0);
    minValue = aqString.SubString(minValue, 1, minValue.length - 1);
    
    maxValue = aqString.GetListItem(str, 1);
    maxValue = aqString.SubString(maxValue, 0 , maxValue.length - 1);
  }
  else
  {
    Log.Error("Device type is acquire PPI");
    return null;
  }
  minVal = aqConvert.StrToInt(minValue);
  maxVal = aqConvert.StrToInt(maxValue);
  Sys.Process("DL.CODE").WPFObject("HwndSource: EscapeSequencesPopup", "Escape Sequences").Close();
  return [minVal, maxVal];
}

function enabledPhaseModeTCPServer()
{
  Sys.Process("DL.CODE").FindChild("ToolTip", "Phase Mode", 1000).Click();
  leftPanelObj = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1);
  phaseOn = leftPanelObj.FindChild("WPFControlText", "Phase On  ", 1000);
  while(!phaseOn.Enabled) { phaseOn = phaseOn.Parent;}
  phaseOn.Click();
  rightPanel = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3);
  obj = rightPanel.FindChild("WPFControlText", "Input 1 ", 1000);
  var tempObj;
  while(true)
  {
    obj = obj.Parent;
    tempObj = obj.FindChild("ClrClassName", "CheckBox", 1000) ;
    if(tempObj.Exists)
    {
      break;
    }
  }
  tempObj.Click();
  
  obj = rightPanel.FindChild("WPFControlText", "Reader TCP Server ", 1000);
  while(true)
  {
    obj = obj.Parent;
    tempObj = obj.FindChild("ClrClassName", "CheckBox", 1000) ;
    if(tempObj.Exists)
    {
      break;
    }
  }
  tempObj.Click();
  
  arrPro = ["WPFControlName", "Visible"];
  arrVal = ["rtbText", true];
  ReaderTCPServerCommandTextBoxOn = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  ReaderTCPServerCommandTextBoxOn.Click();
  ReaderTCPServerCommandTextBoxOn.Keys("[BS]");
  ReaderTCPServerCommandTextBoxOn.Keys("pOn");
  
  phaseOff = leftPanelObj.FindChild("WPFControlText", "Phase Off  ", 1000);
  while(!phaseOff.Enabled) { phaseOff = phaseOff.Parent;}
  phaseOff.Click();
  
  obj = rightPanel.FindChild("WPFControlText", "Input 1 ", 1000);
  while(true)
  {
    obj = obj.Parent;
    tempObj = obj.FindChild("ClrClassName", "CheckBox", 1000) ;
    if(tempObj.Exists)
    {
      break;
    }
  }
  tempObj.Click();
  
  obj = rightPanel.FindChild("WPFControlText", "Reader TCP Server ", 1000);
  while(true)
  {
    obj = obj.Parent;
    tempObj = obj.FindChild("ClrClassName", "CheckBox", 1000) ;
    if(tempObj.Exists)
    {
      break;
    }
  }
  tempObj.Click();
  
  arrPro = ["WPFControlName", "Visible"];
  arrVal = ["rtbText", true];
  ReaderTCPServerCommandTextBoxOn = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  ReaderTCPServerCommandTextBoxOn.Click();
  ReaderTCPServerCommandTextBoxOn.Keys("[BS]");
  ReaderTCPServerCommandTextBoxOn.Keys("pOff");
  
}

function enabledExternalImageSequence()
{
 leftPanelObj = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1);
 generalSetting =  leftPanelObj.FindChild("WPFControlText", "General Settings", 1000);
 generalSetting.Click();
 arrPro = ["WPFControlText", "ChildCount"];
 arrVal = ["Image Settings Selection", 1];
 imageSettingSelectionLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
 imageSettingSelectionCbx = imageSettingSelectionLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000);
 imageSettingSelectionCbx.ClickItem(1);
 centralPaNEL = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder");
 arrPro = ["WPFControlText", "ClrClassName"];
 arrVal = ["Image Settings ", "TextBlock"];
 
 imageSequenceArr = (new VBArray(centralPaNEL.FindAllChildren(arrPro, arrVal, 1000))).toArray();
 for(var i = 0; i < imageSequenceArr.length;i++)
 {
   imageSequenceArr[i].Click();
   arrPro = ["WPFControlText", "ClrClassName"];
   arrVal = ["Reader TCP Server ","TextBlock"];
   //rightPanel = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", "DL.CODE 1.9.0.3").WPFObject("Shell", "DL.CODE 1.9.0.3", 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Activation Events", 1);  
   rightPanel = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Activation Events", 1);
   tempObj = rightPanel.FindChild(arrPro, arrVal, 1000);
   while(true)
   {
     tempObj = tempObj.Parent;
     reaederTCPRadioBtn = tempObj.FindChild("ClrClassName", "RadioButton", 1000);
     if(reaederTCPRadioBtn.Exists) break;
   }
   reaederTCPRadioBtn.Click();
   arrPro = ["WPFControlName", "Visible"];
   arrVal = ["rtbText", true];
   
   ReaderTCPServerCommandTextBoxOn = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
   ReaderTCPServerCommandTextBoxOn.Click();
   ReaderTCPServerCommandTextBoxOn.Keys("[BS]");
   ReaderTCPServerCommandTextBoxOn.Keys("S" + aqConvert.IntToStr(i));

   
 }
 
}
function clickDragXOR()
{
  
  toX1 = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("ResultAnalysisControl").WPFObject("ListBoxItem", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ResultParcelList", "", 1).WPFObject("Grid", "", 1).WPFObject("outerBorder").WPFObject("listBox").WPFObject("ScrollViewer", "", 1).WPFObject("Border", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 2).WPFObject("SelectableBorder").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("LabelList", "", 1).WPFObject("Grid", "", 1).WPFObject("outerBorder").WPFObject("listBox").WPFObject("ScrollViewer", "", 1).WPFObject("Border", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("Grid", "", 1).WPFObject("contentPresenter").WPFObject("Grid", "", 1).WPFObject("img").WPFObject("Image", "", 1).ScreenLeft;
  toX2 = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell",lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("ResultAnalysisControl").WPFObject("ListBoxItem", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ResultParcelList", "", 1).WPFObject("Grid", "", 1).WPFObject("outerBorder").WPFObject("listBox").WPFObject("ScrollViewer", "", 1).WPFObject("Border", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("SelectableBorder").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("LabelList", "", 1).WPFObject("Grid", "", 1).WPFObject("outerBorder").WPFObject("listBox").WPFObject("ScrollViewer", "", 1).WPFObject("Border", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("Grid", "", 1).WPFObject("contentPresenter").WPFObject("Grid", "", 1).WPFObject("img").WPFObject("Image", "", 1).ScreenLeft;
  toX = toX1 - toX2;
  //Log.Message(toX);
  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("ResultAnalysisControl").WPFObject("ListBoxItem", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ResultParcelList", "", 1).WPFObject("Grid", "", 1).WPFObject("outerBorder").WPFObject("listBox").WPFObject("ScrollViewer", "", 1).WPFObject("Border", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("SelectableBorder").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("LabelList", "", 1).WPFObject("Grid", "", 1).WPFObject("outerBorder").WPFObject("listBox").WPFObject("ScrollViewer", "", 1).WPFObject("Border", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("Grid", "", 1).WPFObject("contentPresenter").WPFObject("Grid", "", 1).WPFObject("Bt").Drag(0,0, toX, 0 );
  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", "DL.CODE 1.9.0.3").WPFObject("Shell", "DL.CODE 1.9.0.3", 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("ResultAnalysisControl").WPFObject("ListBoxItem", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ResultParcelList", "", 1).WPFObject("Grid", "", 1).WPFObject("outerBorder").WPFObject("listBox").WPFObject("ScrollViewer", "", 1).WPFObject("Border", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("SelectableBorder").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("LabelList", "", 1).WPFObject("Grid", "", 1).WPFObject("label").WPFObject("TextBlock", "Expected Code", 1).Click();
   Sys.Desktop.Keys("[Del]");
  
}