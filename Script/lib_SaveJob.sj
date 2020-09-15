//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_validate
//USEUNIT lib_button

/**
   *Last updated: 1.6.0 rc2
   *@function
   *@param {String} type
   *@param {String} nameJob
   *@param {String} isDefaultJob
   *@param {String} isMonitorMode 
*/
function saveOnDevice (type , nameJob, isDefaultJob , isMonitorMode )
{
        Log.AppendFolder("func: saveOnDevice: " + nameJob);
        var flag = lib_err.err_FUNC_SUCCESS ;
        //save Job
        if (saveJobOnDevice (type , nameJob, isDefaultJob , isMonitorMode) )
        {
                //verify job Name exists
                if ( verify_SaveOnDevice (nameJob) == false)
                {
                      flag = lib_err.err_FUNC_FAILED;
                      Log.Warning(lib_messageLog.msg_ERR_SAVEJOB );
                }
        }
//        Log.Message("##->saveOnDevice : " + flag);
        Log.PopLogFolder();
        return flag;
}
/**
   *Last updated: 1.6.0 rc2
   *@function
   *@param {String} nameJob
*/
function verify_SaveOnDevice ( nameJob)
{
        Log.AppendFolder("func: verify_SaveOnDevice");
        var flag = true;
        if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WaitWPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice, lib_const.const_delay_1000).Exists)
        {
              var btt = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1);
              if (btt.Enabled && btt.Visible)
              {
                  btt.ClickButton();
                  if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: JobListDialogWindow", "*" , lib_const.const_delay_1000).Exists)
                  {
                    if (lib_validate.isJobExist(nameJob) == false)
                        flag = false;
                    Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "*").WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
                  }
              } 
         }
//         Log.Message("##->verify_SaveOnDevice : " + flag);
         Log.PopLogFolder();
         return flag;
}
/**
   *Last updated: 1.6.0 rc2
   *@function
   *@param {String} type
   *@param {String} nameJob
   *@param {String} isDefaultJob
   *@param {String} isMonitorMode 
*/
function saveJobOnDevice (type , nameJob, isDefaultJob , isMonitorMode )
{
      var flag = false;
      //validate data
      if (lib_validate.validateValue(type,lib_const.const_typeSaveOnDevice_N) == false && lib_validate.validateValue(type, lib_const.const_typeSaveOnDevice_O)== false)
      {
            Log.Error("Type add new job must be N/O (New/Overwrite)");
            return flag;
      }
      if (lib_validate.validateValue(isDefaultJob,lib_const.const_isDefaultJob_Y) == false && lib_validate.validateValue(isDefaultJob, lib_const.cots_isDefaultJob_N))
      {
            Log.Error("isDefautJob must be Y/N (Yes/No)");
            return flag;
      } 
      if ( nameJob == null || nameJob =="")
      {
            Log.Error(lib_err.err_NOT_NULL);
            return flag;
      }  
 
      if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware , 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar")["WaitWPFObject"]("ContentPresenter", "", 6, lib_const.const_delay_1000).Exists)
      {
//              lib_button.clickPause(false);
              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware , 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", 6).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
              //wait the popup window
              
              var count = 100;
              while (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).Enabled == true && count >0)
              {   
                      Delay(1000);
                      Sys.Refresh();
                      count--;
              }
              if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device", lib_const.const_delay_1000).Exists)
              {
                      var jobListDialogWindow = Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "*");      
                      //unchecked Default job
                      if( isDefaultJob == "N" )
                            jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).ClickButton(cbUnchecked);
                      //input nameJob       
                      if (type == "N")// add new config
                      {
                            //if radio button is not focus
                            if (jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("RadioButton", "*)", 1).IsChecked == false)
                                jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("RadioButton", "*)", 1).set_IsChecked(true);
                            // delete the suggest name
                            while (Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "*").WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("SaveFileNameTextBox").Text.Length > 0)
                            {
                                 jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBox", "", 1).Keys("^a");
                                 jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBox", "", 1).Keys("[Del]");
                            }
                            //input nameJob
                            // lhoang change to SetText to faster
                            jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBox", "", 1).SetText(nameJob);
                            // wait to OK button enabled
                            var count = 100;
                            while(count > 0)
                            {
                              Sys.Process("DL.CODE").FindChild("WPFControlText", "Save New Configuration (Enter Configuration Name)", 1000).Click();
                              if(jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 1).Enabled) break;
                              delay(1000);
                              count --;
                            }
                    
                            if (jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WaitWPFObject("Button","OK" , lib_const.const_delay_3000).Exists)
                                    jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 1).ClickButton();
                            else
                                    return flag;
                            //confirm id name exist
                            if ( Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window",lib_const.const_delay_3000).Exists)
                            {
                                 aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, "Are you sure you want to overwrite existing configuration?");
                                 Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton();
                            }
              
//                            while (!Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1)["WaitWPFObject"]("Border", "", 1, lib_const.const_delay_4000).Exists)
//                            {
                             Delay(lib_const.const_delay_3000);
//                                Sys.Process("DL.CODE").Refresh();                
//                            }
                             //validate UnExpectedWindow
                            if (lib_validate.isUnExpectedWindow() == true)
                            {
                                  lib_common.proccessUnexpectedWindow();
                                  flag = false;
                            } 
                            else
                            {
                                  if (isMonitorMode == lib_const.isMonitorMode_Y)
                                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "", 1).WPFObject("InlineUIContainer", "", 3).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, nameJob);
                                  else 
                                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 4), "WPFControlText", cmpEqual, nameJob);
                                  flag = true;
                                  return flag;
                            }          
                 
                      }  else // overwrite config
                      {
                            jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("RadioButton", "*", 1).Click();
                            //check nameJob exists   
                            jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WaitWPFObject("ListBox", "", 1);; 
                            var jobList =  Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "*").WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JobListBox");    
                             //scroll
                             var Vscroll = jobList.VScroll;
                             var max = Vscroll.Max;
                            // Vscroll.Pos = max;  
                             var itemCount = jobList.wItemCount;
   
                             var isInputNameExits = false;
                             for ( var k = 0; k <= max; k++)
                             {
                                // Log.Message("k:"+k);
                                 Vscroll.Pos = k; 
                                 jobList.Refresh();
                                 var itemPresenter =Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "*").WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JobListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1);
                                 var childCount = itemPresenter.ChildCount;
                                 for (var j = 1 ; j <= childCount; j ++ )
                                 { 
                                     var name =  jobList.WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", j).WPFObject("Border").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                                     if (nameJob == name)
                                     {
                                     
                                        //confirm overwrite
                                       jobList.WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", j).Click();
                                       //unchecked Default job
                                       if( isDefaultJob == "N" )
                                              jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).ClickButton(cbUnchecked);
                     
                                       jobListDialogWindow.WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "*", 1).ClickButton();
                                       aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, "Are you sure you want to overwrite existing configuration?");
                                       Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton();
                           
                                       while (!Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1)["WaitWPFObject"]("Border", "", 1, lib_const.const_delay_1000).Exists)
                                       {
                                            Delay(lib_const.const_delay_3000);
                                            Sys.Process("DL.CODE").Refresh();                
                                       }
                                         //validate UnExpectedWindow
                                       if (lib_validate.isUnExpectedWindow() == true)
                                       {
                                              lib_common.proccessUnexpectedWindow();
                                              flag = false;
                                              return flag;
                                       } 
                                       else
                                       {
                                               if (isMonitorMode == lib_const.isMonitorMode_Y)
                                                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "", 1).WPFObject("InlineUIContainer", "", 3).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, nameJob);
                                               else 
                                                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 4), "WPFControlText", cmpEqual, nameJob);
                                                flag = true;
                                                return flag;
                                       }  
                                    }
                                 }
                             } 
                      }
          }
      }        
//      Log.Message("saveJobOnDevice: "+ flag);         
      return flag;
    }

/**
   *Last updated: 1.6.0 rc2
   *@function 
   *@param {String} nameJob
   *@param {String} path
   *@param {String} isIncludeImage 
*/
function saveOnPC (nameJob, path, isIncludeImage )
{
      Log.AppendFolder("func: saveOnPC");
      var flag = lib_err.err_FUNC_FAILED;
      //validate
      if ( nameJob == null || nameJob =="")
      {
            Log.Error(lib_err.err_NOT_NULL);
            return flag;
      }
  
      if ( ! lib_validate.isDLCODERunning())
            return lib_err.err_DLCODE_NOFOUND;  
  
      try
      {
        aqFileSystem.CreateFolder(path);
        // Obtains information on the folder
        var FolderInfo = aqFileSystem.GetFolderInfo(path);
   
        // Checks whether the folder still exists
        if (FolderInfo.Exists)
        {
              // Save job
              //click button open on PC
              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell",lib_deviceInfo.const_firmware).WPFObject("Shell",lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
              //wait popup window
              while (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).Enabled == true)
              {   
                    Delay(1000);
                    Sys.Refresh();
              }              
              //include image? 
              if ( isIncludeImage == lib_const.const_saveIncludeImage_Y )
              {
                  Sys.Process("DL.CODE").Window("#32770", "Save As", 1).WPFObject("HwndSource: SaveFileDialogHelpControl", "WPFDlgControl").WPFObject("SaveFileDialogHelpControl", "", 1).WPFObject("CheckBox", "*", 1).ClickButton(cbChecked);
                  aqObject.CheckProperty(Sys.Process("DL.CODE").Window("#32770", "Save As", 1).WPFObject("HwndSource: SaveFileDialogHelpControl", "WPFDlgControl").WPFObject("SaveFileDialogHelpControl", "", 1).WPFObject("CheckBox", "*", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual," Include current displayed image");
             }
              var editBar =Sys.Process("DL.CODE")["Window"]("#32770", "*", 1)["Window"]("ComboBoxEx32", "", 1)["Window"]("ComboBox", "", 1)["Window"]("Edit", "", 1);  
              editBar.Keys(path + "\\" + nameJob + ".dlcfg");
              editBar.Keys("[Enter]");
      
              //confirm replace 
              var  txtReplace = "Do you want to overwite"; 
              if ( Sys.Process("DL.CODE").WaitWindow("#32770", "*", 1 , lib_const.const_delay_1000).Exists)
              { 
                       var str =   Sys.Process("DL.CODE").Window("#32770", "*", 1).Window("Static", "*", 2).WndCaption;
                      if (aqString.Find(str, txtReplace) == 0)
                      {
                            Sys.Process("DL.CODE").Window("#32770", "*", 1).Window("Button", "&Yes", 1).ClickButton();
                            
                      }                   
              }     
             Delay(lib_const.const_delay_1000);   
             while (!Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1)["WaitWPFObject"]("Border", "", 1, lib_const.const_delay_1000).Exists)
             {
                  Delay(lib_const.const_delay_3000);
                  Sys.Process("DL.CODE").Refresh();                
             }
               //validate UnExpectedWindow
             if (lib_validate.isUnExpectedWindow() == true)
             {
                    lib_common.proccessUnexpectedWindow();
                    flag = false;
                    return flag;
             } else
                   flag = lib_err.err_FUNC_SUCCESS;
        }
        else// folder can not found
        {
              Log.Error(lib_err.err_FILE_NOFOUND);
              flag = lib_err.err_FILE_NOFOUND;
        }
      }
      catch (e)
      {
            Log.Error(lib_err.err_FUNC_EXCEPTION);   
      }
      Log.Message("saveOnPC:"+flag);
      Log.PopLogFolder();
      return flag;

}

/**
  *@function
*/
function randomJobName()
{
        var today = new Date();
      // hour, minute, second current
        var h = today.getHours();
        var m = today.getMinutes();
        var s = today.getSeconds();
 
        // change to format 01, 02, 03
        h = checkTime(h);
        m = checkTime(m);
        s = checkTime(s);
        // format yyyyMMddHHmmss
        var newDate = today.getFullYear()  +  checkTime((today.getMonth() + 1)) +   checkTime(today.getDate())   +  h  + m  + s;        
        return (lib_deviceInfo.const_Name_Default + newDate);    
}

/**
  *@function
*/
function checkTime(i) 
{
        if (i < 10) {
            i = "0" + i;
        }
        return i;
}


//author : lhoang
// simple function
function saveJobOnDevice2 ( nameJob)
{
 arrPro = ["ToolTip", "ClrClassName"];
 arrVal = ["Save on Device", "Button"];
  var saveOnDeviceObj = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  saveOnDeviceObj.Click();
  while(true)
  {
    saveOnDevicePopup = Sys.Process("DL.CODE").FindChild("ClrFullClassName", "IVS_UI.Views.Popups.JobListDialogWindow", 1000);
    if(saveOnDevicePopup.Exists) 
    {
      break;
    }
  }
  saveTextBoxOb = saveOnDevicePopup.FindChild("WPFControlName", "SaveFileNameTextBox", 1000);
  if(saveTextBoxOb.Exists)
  {
    saveOnDevicePopup.FindChild("WPFControlText", "Save New Configuration (Enter Configuration Name)", 1000).Click();
    saveTextBoxOb.SelectAll();
    saveTextBoxOb.Keys("[Del]");
    saveTextBoxOb.SetText(nameJob);
  }
  else
  {
    saveTextBoxOb = saveOnDevicePopup.FindChild("WPFControlText", "Save New Configuration (Enter Configuration Name)", 1000);
    saveTextBoxOb = saveTextBoxOb.Parent;
    saveTextBoxOb = saveTextBoxOb.WPFObject("TextBox", "", 1);
    saveTextBoxOb.SetText(nameJob);
  }
  
  delay(5000);
  okBtn = saveOnDevicePopup.FindChild("WPFControlText", "OK", 1000);
  while(!okBtn.Enabled) 
  {
    Sys.Process("DL.CODE").FindChild("WPFControlText", "Save New Configuration (Enter Configuration Name)", 1000).Click();
    delay(1000);
  }
  okBtn.Click();
  delay(2000);
  
  messagePopup = Sys.Process("DL.CODE").FindChild("ClrFullClassName", "UIController.Controls.MessageBox", 1000);
  if(messagePopup.Exists)
  {
    messagePopup.FindChild("WPFControlName", "btnYes", 1000).Click()    
  } 
  count = 50;
  while(saveOnDevicePopup.Exists && count > 0)
  {
    delay(1000);
    count--;
  }
  delay(5000);
  if(count<1)
  {
    return false;
  }
  return true;
}