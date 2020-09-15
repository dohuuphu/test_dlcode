﻿//USEUNIT lib_button
//USEUNIT lib_common
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo
function stressTestFocusAutolearn()
{
  aqTestCase.Begin("Stress test with Focus Autolearn/Acquire PPI");
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
  var ppi = false;
  for(var i = 0; i< 100; i++)
  {
    lib_button.clickIMG_AutoSetup_Static(true);
    
    var tempObj = Sys.Process("DL.CODE").FindChild("WPFControlText", "General Image Settings", 1000);
                  if(tempObj.Exists)
      {
                  // focus on general image settings                
        if(tempObj.Visible)
        {
          delay(1000);
          var proArr = ["WPFControlText" , "ClrClassName"];
          var valArr = [ "General Image Settings", "TextBlock"];
          Sys.Process("DL.CODE").FindChild(proArr, valArr, 1000).Click();
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
    
    // click on focus auto learn
      if(Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000).Exists)
      {
        Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000).Click();  
      }
      else if(Sys.Process("DL.CODE").FindChild("WPFControlName", "AcquirePPICommandButton", 1000).Exists)
      {
        Indicator.PushText("Acquire PPI, require Grade A Test chart");
        Sys.Process("DL.CODE").FindChild("WPFControlName", "AcquirePPICommandButton", 1000).Click();  
        ppi = true;
      }
      else
      {
        
      }
    if(!ppi)  
    {
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
    }
    else
    {
      delay(1000);
      while(true)
      {
        if(Sys.Process("DL.CODE").FindChild("WPFControlText", "PPI acquired", 1000).Exists)
        {
          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window"), "Visible", cmpEqual, true);
          Sys.Process("DL.CODE").WPFObject("HwndSource: Window").FindChild("WPFControlName", "btnOK", 1000).Click();
          break;
        }
        else
        {
          messageObj = Sys.Process("DL.CODE").FindChild("WPFControlText", "Test Chart not found. Please place the Grade A Barcode Test Chart in front of the reader!", 1000);
          if(messageObj.Exists)
          {
            Log.Error(messageObj.Text);
            Sys.Process("DL.CODE").WPFObject("HwndSource: Window").FindChild("WPFControlName", "btnOK", 1000).Click();
            break;
          }
        }
        
      }
    }
  }
  aqTestCase.End();
}