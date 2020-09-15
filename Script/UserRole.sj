//USEUNIT lib_UserRole
//USEUNIT lib_common
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_validate
//USEUNIT lib_OpenJob
//USEUNIT lib_CodeAutolearn

//edit 1.5.0a7 
/*
  *@function 
*/
function userRole_notConnectingDevice ()
{
aqTestCase.Begin("userRole_notConnectingDevice");
//      if ( ! lib_validate["isDLCODERunning"]() || lib_validate.isUnExpectedWindowExists())
      lib_common["launchUI"]();  
     
      while ( !isGettingStartedScreen())
      {
            lib_common.gettingStarted();
            Sys["Process"]("DL.CODE").Refresh(); 
      }
      if (isGettingStartedScreen())
      {
             var _mySerialDevice = lib_deviceInfo.const_Device_SerialNumber;       
             var ip = lib_deviceInfo.const_Device_IP_Adress;
             if ( lib_common.connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
               lib_UserRole.changeAllUserRole_NOTCONNECT_Device(false);
      } 
      //lib_common.terminateUI();
   aqTestCase.End();     
}

/*
  *@function 
*/
function userRole_ConnectingDevice ()
{
  aqTestCase.Begin("userRole_ConnectingDevice");
  
//       if ( ! lib_validate["isDLCODERunning"]() || lib_validate.isUnExpectedWindowExists())
       lib_common["launchUI"]();       
      
       while( !isGettingStartedScreen())
       {
            lib_common.gettingStarted();
            Sys["Process"]("DL.CODE").Refresh(); 
       }
       if (isGettingStartedScreen())
       {
              
               var _mySerialDevice = lib_deviceInfo.const_Device_SerialNumber;       
               var ip = lib_deviceInfo.const_Device_IP_Adress;
               if ( lib_common.connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
               {
                   lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);   
                   lib_UserRole.changeAllUserRole_CONNECTING_Device(true);
               }
       }
       //lib_common.terminateUI();   
       aqTestCase.End();     
}
function COMMANDLINE_042()
{
  aqTestCase.Begin("UserBasic");
  Log.Message("Verify that User-Basic can change current configuration in Monitor");
  lib_common["launchUI"]();  
  var isConnectingDevice = false;
  changeUserRole ( lib_label.const_lb_UserBasic,isConnectingDevice);
  lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);
  var arrPro = ["ClrClassName", "WPFControlText", "ChildCount"];
  var arrVal = ["TextBlock", "Monitor Device", 0];
  temp = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  var count = 10;
  var ListTaskItemObj;
  if(temp.Exists)
  {
    while(count > 0)
    {
      temp = temp.Parent;
      ListTaskItemObj = temp.FindChild("ClrClassName", "ItemsPresenter", 1000);
      if(ListTaskItemObj.Exists) break;
      delay(1000);
      count --;
    }
  }
  if(ListTaskItemObj.Exists)
  {
    var childCOunt = ListTaskItemObj.ChildCount;    
    var TaskButton;
    for(var index= 1; index <= childCOunt - 2; index++)
    {
      TaskButton = ListTaskItemObj.WPFObject("ListBoxItem", "", index).FindChild("ClrClassName", "RadioButton", 1000);
      aqObject.CheckProperty(TaskButton, "Enabled", cmpEqual, false);      
    }
    TaskButton = ListTaskItemObj.WPFObject("ListBoxItem", "", childCOunt-1).FindChild("ClrClassName", "RadioButton", 1000);
    aqObject.CheckProperty(TaskButton, "Enabled", cmpEqual, true); 
    TaskButton = ListTaskItemObj.WPFObject("ListBoxItem", "", childCOunt).FindChild("ClrClassName", "RadioButton", 1000);     
    aqObject.CheckProperty(TaskButton, "Enabled", cmpEqual, true);  
    
    ListTaskItemObj.WPFObject("ListBoxItem", "", childCOunt - 1).Click();
    delay(5000);
    var IsMonitor = true;
    lib_button.clickPause(IsMonitor);
    
    arrPro = ["ClrClassName", "WPFControlName", "ChildCount"];
    arrVal = ["Menu", "IvsMenu", 4];
    MainMenu = Sys.Process("DL.CODE").FindChild(arrPro, arrVal,1000);
    MainMenu.WPFMenu.Click("Device|Change Current Configuration");
    delay(5000);
    
    var MainPopupObj = Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Change Current Running Configuration");
    var JobListBoxObj = MainPopupObj.FindChild("WPFControlName", "JobListBox", 1000);
    arrPro = ["ClrClassName", "WPFControlText"];
    arrVal = ["TextBlock", "Default"];
    var tempObj = JobListBoxObj.FindChild(arrPro, arrVal, 1000);
    count =10;
    var TaskList;
    while(count >0)
    {
      tempObj = tempObj.Parent;
      TaskList = tempObj.FindChild("ClrClassName", "ItemsPresenter", 2);
      if(TaskList.Exists) break;
      delay(1000);
    }
    if(TaskList.Exists)
    {
      if(TaskList.ChildCount <2)
      {
        aqObject.CheckProperty(MainPopupObj, "Visible", cmpEqual, true);
        Log.Error("No jobs saved on device, please check");
      }
      else
      {
        var JobName = TaskList.WPFObject("ListBoxItem", "", 2).FindChild("ClrClassName", "TextBlock", 100).WPFControlText;
        TaskList.WPFObject("ListBoxItem", "", 2).Click();
        arrPro = ["ClrClassName", "WPFControlText"];
        arrVal = ["Button", "OK"];
        MainPopupObj.FindChild(arrPro, arrVal, 1000).Click();
        delay(5000);
        // verify job name display ok
        aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("WPFControlText", JobName, 1000), "Visible", cmpEqual, true);
      }
    }
  }
  aqTestCase.End();
}

function COMMANDLINE_043_044_045()
{
  // in expert mode Add Postal code button is visible
  // Add New Image Setup is visible
  // Add Fieldbus can be do
  aqTestCase.Begin("Installer Basic");
  lib_common["launchUI"]();  
  var isConnectingDevice = false;
  changeUserRole ( lib_label.const_lb_InstallerExpert,isConnectingDevice);
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
  var AddPostalCodeObj = Sys.Process("DL.CODE").FindChild("ToolTip", "Add Postal Code", 1000);
  var AddNewImageSetupObj = Sys.Process("DL.CODE").FindChild("ToolTip", "Add New Image Setup", 1000);
  aqObject.CheckProperty(AddPostalCodeObj, "Visible", cmpEqual, true);
  aqObject.CheckProperty(AddNewImageSetupObj, "Visible", cmpEqual, true);
  lib_button.clickReadingPhase2();
  
  var addFieldbusObj = Sys.Process("DL.CODE").FindChild("ToolTip", "Add New Fieldbus", 1000);
  addFieldbusObj.Click();  
  addFieldbusObj.PopupMenu.Click("Ethernet/IP");  
  
  // check again in Installer basic and verify
  lib_common.gettingStarted();
  isConnectingDevice = false;
  changeUserRole ( lib_label.const_lb_InstallerBasic,isConnectingDevice);
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
  AddPostalCodeObj = Sys.Process("DL.CODE").FindChild("ToolTip", "Add Postal Code", 1000);
  AddNewImageSetupObj = Sys.Process("DL.CODE").FindChild("ToolTip", "Add New Image Setup", 1000);
  Log.Message("Check again in Installer Basic, button Add Postal Code is invisible");
  if(AddPostalCodeObj.Exists)
  {
    aqObject.CheckProperty(AddPostalCodeObj, "Visible", cmpEqual, false);  
  }
  else
  {
    aqObject.CheckProperty(AddPostalCodeObj, "Exists", cmpEqual, false);  
  }
  Log.Message("Check again  in Installer Basic, button Add New Image Setup is invisible");
  if(AddNewImageSetupObj.Exists)
  {
    aqObject.CheckProperty(AddNewImageSetupObj, "Visible", cmpEqual, false);  
  }
  else
  {
    aqObject.CheckProperty(AddNewImageSetupObjAddNewImageSetupObjAddNewImageSetupObjAddNewImageSetupObjAddNewImageSetupObj, "Exists", cmpEqual, false);  
  }
  Log.Message("Chec again in Installer Basic, button Add New Fieldbus is in visible");
  lib_button.clickReadingPhase2();
  addFieldbusObj = Sys.Process("DL.CODE").FindChild("ToolTip", "Add New Fieldbus", 1000);
  if(addFieldbusObj.Exists)
  {
    aqObject.CheckProperty(addFieldbusObj, "Visible", cmpEqual, false);
  }
  else
  {
    aqObject.CheckProperty(addFieldbusObj, "Exists", cmpEqual, false);
  }
  aqTestCase.End();
}

function COMMANDLINE_047_048()
{
  aqTestCase.Begin("Installer Basic Focus Autolearn");
  Log.Message("Verify that Installer-Basic can perform and apply -Focus Autolearn- results successfully");
  lib_common["launchUI"]();  
  var isConnectingDevice = false;
  changeUserRole ( lib_label.const_lb_InstallerBasic,isConnectingDevice);
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
  lib_button.clickIMG_AutoSetup_Static(true);
  delay(5000);
  var tempObj = Sys.Process("DL.CODE").FindChild("WPFControlText", "General Image Settings", 1000);
  if(tempObj.Exists)
      {
                  // focus on general image settings                
        if(tempObj.Visible)
        {
          delay(1000);
          Sys.Process("DL.CODE").FindChild("WPFControlText", "General Image Settings", 1000).Click();
        }
        else
        {
          delay(2000);
          var proArr = ["WPFControlText" , "ClrClassName"];
          var valArr = [ "Image Settings ", "TextBlock"];
          var btt = Sys.Process("DL.CODE").FindChild(proArr,valArr, 1000);
          aqObject.CheckProperty(btt, "Visible", cmpEqual, true);
          btt.Click();
        }
                  
      }
      else
      {
          delay(2000);
          var proArr = ["WPFControlText" , "ClrClassName"];
          var valArr = [ "Image Settings ", "TextBlock"];
          var btt = Sys.Process("DL.CODE").FindChild(proArr,valArr, 1000);
          aqObject.CheckProperty(btt, "Visible", cmpEqual, true);
          btt.Click();
      }
    
    
    if(Sys.Process("DL.CODE").FindChild("WPFControlName", "AcquirePPICommandButton", 1000).Exists)
    {
      Log.Error("Device is Acquire PPI, can not run test with focus reading distance");
      aqTestCase.End();
      return;
    }
    if(Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000).Exists)
    {
      Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000).Click();  
    }
    else
    {
      Log.Warning("Device is acquire PPI, but in mode installer basic, the button is invisible");
      aqTestCase.End();
      return;
    }
    while(!Sys.Process("DL.CODE").FindChild("ClrClassName", "FocusAutolearnDialogWindow", 1000).Exists) {}
    autoLearn = Sys.Process("DL.CODE").FindChild("ClrClassName", "FocusAutolearnDialogWindow", 1000);
    arrPro = ["ClrClassName", "WPFControlText"];
    
    arrVal = ["Button", "Start"];
    startBtn = autoLearn.FindChild(arrPro, arrVal, 1000);
    
    arrVal = ["Button", "Apply"];
    applyBtn = autoLearn.FindChild(arrPro, arrVal, 1000);
    
    startBtn.Click();
    
    while(!applyBtn.Enabled)
    {
      
    }
    applyBtn.Click();
    delay(500); 
    commandline_048();
    aqTestCase.End();
}

function commandline_048()
{
  Log.Message("Verify that Installer-Basic can enable/disable Cropping Region");
  var ToolTipBtn = Sys.Process("DL.CODE").FindChild("ToolTip", "Add Cropping Region", 1000);
  if(ToolTipBtn.Exists)
  {
    aqObject.CheckProperty(ToolTipBtn, "Visible", cmpEqual, true);
    aqObject.CheckProperty(ToolTipBtn, "Enabled", cmpEqual, true);
    ToolTipBtn.Click();
    // then focus on Image Setttings
    
    Sys.Process("DL.CODE").FindChild("WPFControlText", "Image Settings ", 1000).Click(); 
    var arrPro = ["ClrClassName", "WPFControlText"];
    var arrVal = ["ContentExpander", "Cropping Region Area"];
    var CroppingRegionArea = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
    if(CroppingRegionArea.Exists)
    {
      if(!CroppingRegionArea.isExpanded) CroppingRegionArea.set_IsExpanded(true);
    
      aqObject.CheckProperty(CroppingRegionArea, "Enabled", cmpEqual, true);
      aqObject.CheckProperty(CroppingRegionArea.WPFObject("CroppingRegionDataStackPanel").WPFObject("Grid", "", 1), "Enabled", cmpEqual, true);
      aqObject.CheckProperty(CroppingRegionArea.WPFObject("CroppingRegionDataStackPanel").WPFObject("Grid", "", 2), "Enabled", cmpEqual, true);
      aqObject.CheckProperty(CroppingRegionArea.WPFObject("CroppingRegionDataStackPanel").WPFObject("Grid", "", 3), "Enabled", cmpEqual, true);
      aqObject.CheckProperty(CroppingRegionArea.WPFObject("CroppingRegionDataStackPanel").WPFObject("Grid", "", 4), "Enabled", cmpEqual, true);
    }
    else
    {
      Log.Error("Can not focus on Cropping Region Area");
      return;
    }
    ToolTipBtn.Click();
    CroppingRegionArea = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
        
    aqObject.CheckProperty(CroppingRegionArea, "Enabled", cmpEqual, false);
    aqObject.CheckProperty(CroppingRegionArea.WPFObject("CroppingRegionDataStackPanel").WPFObject("Grid", "", 1), "Enabled", cmpEqual, false);
    aqObject.CheckProperty(CroppingRegionArea.WPFObject("CroppingRegionDataStackPanel").WPFObject("Grid", "", 2), "Enabled", cmpEqual, false);
    aqObject.CheckProperty(CroppingRegionArea.WPFObject("CroppingRegionDataStackPanel").WPFObject("Grid", "", 3), "Enabled", cmpEqual, false);
    aqObject.CheckProperty(CroppingRegionArea.WPFObject("CroppingRegionDataStackPanel").WPFObject("Grid", "", 4), "Enabled", cmpEqual, false);
      
    
  }
  else
  {
    Log.Error("Can not find Add Cropping Region button");
    return;
  }
}

function COMMANDLINE_057()
{
  aqTestCase.Begin("COMMANDLINE_057");
  Log.Message("Verify that Installer-Basic can autolearn and replace new 1D code automatically with existing codes");
  lib_common["launchUI"]();  
  var isConnectingDevice = false;
  changeUserRole ( lib_label.const_lb_InstallerBasic,isConnectingDevice);
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
  lib_button.clickIMG_AutoSetup_Static(true);
  delay(3000);
  var tempObj = Sys.Process("DL.CODE").FindChild("WPFControlText", "General Image Settings", 1000);
      if(tempObj.Exists)
      {
                  // focus on general image settings                
        if(tempObj.Visible)
        {
          delay(1000);
          Sys.Process("DL.CODE").FindChild("WPFControlText", "General Image Settings", 1000).Click();
        }
        else
        {
          delay(2000);
          var proArr = ["WPFControlText" , "ClrClassName"];
          var valArr = [ "Image Settings ", "TextBlock"];
          var btt = Sys.Process("DL.CODE").FindChild(proArr,valArr, 1000);
          aqObject.CheckProperty(btt, "Visible", cmpEqual, true);
          btt.Click();
        }
                  
      }
      else
      {
          delay(2000);
          var proArr = ["WPFControlText" , "ClrClassName"];
          var valArr = [ "Image Settings ", "TextBlock"];
          var btt = Sys.Process("DL.CODE").FindChild(proArr,valArr, 1000);
          aqObject.CheckProperty(btt, "Visible", cmpEqual, true);
          btt.Click();
      }
  if(Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000).Exists)
  {
    // focus autolearn
    Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000).Click();
    while(!Sys.Process("DL.CODE").FindChild("ClrClassName", "FocusAutolearnDialogWindow", 1000).Exists) {}
    var autoLearn = Sys.Process("DL.CODE").FindChild("ClrClassName", "FocusAutolearnDialogWindow", 1000);
    var arrPro = ["ClrClassName", "WPFControlText"];
    var arrVal = ["Button", "Start"];
    var startBtn = autoLearn.FindChild(arrPro, arrVal, 1000);    
    arrVal = ["Button", "Apply"];
    var applyBtn = autoLearn.FindChild(arrPro, arrVal, 1000);    
    startBtn.Click();    
    while(!applyBtn.Enabled)
    {
      
    }
    applyBtn.Click();
    delay(500);  
    // image auto setup again
    lib_button.clickIMG_AutoSetup_Static(true);
  }
  lib_button.clickAddCode (lib_label.lb_CodeType2D, lib_label.lb_DOTCODE);
  
  lib_button.clickCodeAutolearnBtt2("Replace");
  var arrPro = ["ClrClassName", "WPFControlText", "ChildCount"];
  var arrVal = ["TextBlock", "Code Settings", 0];
  var ListCodeTable = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  if(ListCodeTable.Exists)
  {
    ListCodeTable = ListCodeTable.Parent;
    ListCodeTable = ListCodeTable.WPFObject("TreeViewItem", "", 1);
    var CodeAutolearnedName;
    if(ListCodeTable.ChildCount >= 2)
    {
       //total : 21 code
      var _1DCodeString = "PDF417,MICROPDF,CODE128,GS1-128,CODE39,INT2OF5,PHARMA,MSI,PLESSEY,STD2OF5,MTX2OF5,CODABAR,GS1 DATABAR EXPANDED,GS1 DATABAR EXPANDED STACKED,GS1 DATABAR LIMITED,GS1 DATABAR,GS1 DATABAR STACKED,CODE93,EAN13,EAN8,UPCA,UPCE";
      var Check_OK = false;
      for(var index = 2; index <=ListCodeTable.ChildCount-1;index++)
      {
        CodeAutolearnedName = ListCodeTable.WPFObject("TreeViewItem", "", index).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
        if(aqString.Contains(_1DCodeString, CodeAutolearnedName) != -1)
        {
          Log.Checkpoint("Installer-Basic autolearn and replace new 1D code successfully");
          Log.Checkpoint(CodeAutolearnedName);
          Check_OK= true;
          break;
        }
      }
      if(!Check_OK) Log.Error("Can not found 1D code, please put at least 1 1D code in front of device");
    }
    else
    {
      Log.Error("There is no code in Image Setting panel, can not replace");
    }
  }
  else
  {
    Log.Error("Can not focus on list of codes in Image Setting panlel. Please check");
  }
  aqTestCase.End();
}

function COMMANDLINE_058()
{
  aqTestCase.Begin("COMMANDLINE_058");
  Log.Message("Verify that Installer-Basic can autolearn 1D code and discard autolearn result");
  lib_common["launchUI"]();  
  var isConnectingDevice = false;
  changeUserRole ( lib_label.const_lb_InstallerBasic,isConnectingDevice);
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
  lib_button.clickIMG_AutoSetup_Static(true);
  delay(3000);
  var tempObj = Sys.Process("DL.CODE").FindChild("WPFControlText", "General Image Settings", 1000);
  if(tempObj.Exists)
      {
                  // focus on general image settings                
        if(tempObj.Visible)
        {
          delay(1000);
          Sys.Process("DL.CODE").FindChild("WPFControlText", "General Image Settings", 1000).Click();
        }
        else
        {
          delay(2000);
          var proArr = ["WPFControlText" , "ClrClassName"];
          var valArr = [ "Image Settings ", "TextBlock"];
          var btt = Sys.Process("DL.CODE").FindChild(proArr,valArr, 1000);
          aqObject.CheckProperty(btt, "Visible", cmpEqual, true);
          btt.Click();
        }
                  
      }
      else
      {
          delay(2000);
          var proArr = ["WPFControlText" , "ClrClassName"];
          var valArr = [ "Image Settings ", "TextBlock"];
          var btt = Sys.Process("DL.CODE").FindChild(proArr,valArr, 1000);
          aqObject.CheckProperty(btt, "Visible", cmpEqual, true);
          btt.Click();
      }
  if(Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000).Exists)
  {
    // focus autolearn
    Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000).Click();
    while(!Sys.Process("DL.CODE").FindChild("ClrClassName", "FocusAutolearnDialogWindow", 1000).Exists) {}
    var autoLearn = Sys.Process("DL.CODE").FindChild("ClrClassName", "FocusAutolearnDialogWindow", 1000);
    var arrPro = ["ClrClassName", "WPFControlText"];
    var arrVal = ["Button", "Start"];
    var startBtn = autoLearn.FindChild(arrPro, arrVal, 1000);    
    arrVal = ["Button", "Apply"];
    var applyBtn = autoLearn.FindChild(arrPro, arrVal, 1000);    
    startBtn.Click();    
    while(!applyBtn.Enabled)
    {
      
    }
    applyBtn.Click();
    delay(500);  
    // image auto setup again
    lib_button.clickIMG_AutoSetup_Static(true);
  }
  lib_button.clickAddCode (lib_label.lb_CodeType2D, lib_label.lb_DOTCODE);
  
  arrPro = ["ClrClassName", "WPFControlText", "ChildCount"];
  arrVal = ["TextBlock", "Code Settings", 0];
  var ListCodeTable = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  ListCodeTable = ListCodeTable.Parent;
  ListCodeTable = ListCodeTable.WPFObject("TreeViewItem", "", 1);
  var CurrentNumberOfCode = ListCodeTable.ChildCount - 2;
  lib_button.clickCodeAutolearnBtt2("Discard");
  
  ListCodeTable = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  ListCodeTable = ListCodeTable.Parent;
  ListCodeTable = ListCodeTable.WPFObject("TreeViewItem", "", 1);
  
  aqObject.CheckProperty(ListCodeTable, "ChildCount", cmpEqual, CurrentNumberOfCode + 2);
  aqTestCase.End();
}
function ChangeUserRoleToInstallerBasic()
{
  aqTestCase.Begin("ChangeUserRoleToInstallerBasic");
  lib_common["launchUI"]();  
  changeUserRole ( lib_label.const_lb_InstallerBasic,false);
  aqTestCase.End();
}
function ss()
{
  Log.Message(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", "DL.CODE 1.9.0.3").WPFObject("Shell", "DL.CODE 1.9.0.3", 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", 2).GetPlainText());
}
