//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_messageLog


//new 1.6.0 RC2
/**
 *@function 
 *@param {String} READING_DISTANCE
 *@param {String} POLARITY
 *@param {String} EXPOSURE_TIME
 *@param {String} GAIN
 *@param {String} GAINMULTIPLIER
*/
function isImageQuality_M220 (READING_DISTANCE, POLARITY, EXPOSURE_TIME, GAIN,GAINMULTIPLIER )
{
        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JcmExpanderUserControl").WPFObject("Grid", "", 1).WPFObject("StepsPanelScrollViewer").WPFObject("Grid", "", 1).WPFObject("border").WPFObject("Grid", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("ExpanderStepSubItemButton", "", 1).Click();
        //verify Reading Distance
        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 2).Click();
        var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1);
        aqObject.CheckProperty(path.WPFObject("ContentExpander", "Reading Distance", 1).WPFObject("StackPanel", "", 1).WPFObject("Focuslevel").WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"),"Text",cmpEqual, READING_DISTANCE);
        //verify Image Quality
        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Image Settings ", 1).Click();
        aqObject.CheckProperty(path.WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 4).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("CheckBox", "", 1),"IsChecked",cmpEqual,  POLARITY);
        aqObject.CheckProperty(path.WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ExplicitUpdateDoubleUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"),"Text",cmpEqual,  EXPOSURE_TIME);
        aqObject.CheckProperty(path.WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"),"Text",cmpEqual,  GAIN);
        aqObject.CheckProperty(path.WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1),"wSelectedItem",cmpEqual,  GAINMULTIPLIER);
}


//new 1.6.0 B1
/**
  *@function
*/
function isConfigurationMode ()
{       
        //Log.AppendFolder("func: isConfigurationMode");
        var flag = false ;
        delay(5000);
        if ( Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WaitWPFObject("CollapsedExpander", 1000).Exists)
        {      
              flag = true;
        }
//        Log.Message(flag);
//        Log.PopLogFolder();
        return flag; 
}

//new 1.6.0 B1
/**
  *@function
*/
function isMonitorMode ()
{       //Log.AppendFolder("func: isMonitorMode");
        var flag = false ;
        if ( Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WaitWPFObject("Grid", "", 1, 3000).Exists)
        {
                if ( Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WaitWPFObject("StackPanel", "", 1, 1000).Exists)
                {    
                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1)  , "WPFControlText", cmpContains, "Monitor:");
                      flag = true;
                }
        }
        Log.Message(flag);
//        Log.PopLogFolder();
        return flag;
}
//new 1.5.0
/**
  *@function
*/
function isExistedInArray(str, arr)// str  
{
      var flag = false;
      for (var i = 1; i <= arr.length ; i++)
      {
            if (str == arr[i-1])
            {      
                    flag = true;
                    return flag ;
            }
      }
      return flag;

}

//update 1.5.0
/**
  *@function
  *@param {String} jobName
*/
function isJobExist (jobName)
{
      
      //Log.AppendFolder("func: isJobExist");
      var flag = false;      
      if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: JobListDialogWindow", "*",lib_const.const_delay_1000).Exists)
      {
             var jobList =  Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "*").WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JobListBox");
             //scroll
             var Vscroll = jobList.VScroll;
             var max = Vscroll.Max;
             // Vscroll.Pos = max;  
             var itemCount = jobList.wItemCount;
   
             var isInputNameExits = false;
             for ( var k = 0; k <= max; k++)
             {                    
                     Vscroll.Pos = k;
                     jobList.Refresh();
                     var itemPresenter =Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Open Device Configuration").WPFObject("JobListDialogWindow", "Open Device Configuration", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JobListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1);
                     var childCount = itemPresenter.ChildCount;
                     for (var j = 1 ; j <= childCount; j ++ )
                     { 
                        var name = jobList.WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", j).WPFObject("Border").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                        if (name  == jobName)
                        {
                               flag = true;
                               return flag;
                        }
                     }
             }
       }
//       Log.PopLogFolder();
       return flag;
}
//update 1.5.0
/**
  *@function
  *@param {String} combobox
  *@param {String} value 
*/
function verifyCodeType (combobox, value)
{
     var selectedItem = combobox.wSelectedItem;
     combobox.Click();
     aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", selectedItem+1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual,value);
     combobox.Click();
}



//update 1.5.0
/**
  *@function
  *@param {String} code
*/
function isDigimarc (code)
{ 
    
      var flag = false;
      if (code == "" || code == null)
      {
           Log.Message(lib_err.msg_ERR_CODE_IS_NULL);
           return flag;
      }
       
      if (lib_label.lb_Digimarc == code)
      {
            flag = true;
            return flag;
      }
          
//      Log.PopLogFolder();
      return flag;
}

//update 1.5.0
/**
  *@function
  *@param {String} code
*/
function is1DCode (code)
{ 
      //Log.AppendFolder("func: is1DCode");
      var flag = false;
      if (code == "" || code == null)
      {
           Log.Message(lib_err.msg_ERR_CODE_IS_NULL);
           return flag;
      }
      for (var i = 1 ; i <= lib_const.arr_1D.length ; i ++)
      { 
          if (lib_const.arr_1D[i-1] == code)
          {
                flag = true;
                return flag;
          }
      }   
//      Log.PopLogFolder();
      return flag;
}
//update 1.5.0
/**
  *@function
  *@param {String} code
*/
function is2DCode (code)
{ 
      //Log.AppendFolder("func: is2DCode");
      var flag = false;
      if (code == "" || code == null)
      {
           Log.Message(lib_err.msg_ERR_CODE_IS_NULL);
           return flag;
      }
      
      for (var i = 1 ; i <= lib_const.arr_2D.length ; i ++)
      { 
          if (lib_const.arr_2D[i-1] == code)
          {
                flag = true;
                return flag;
          }
      }
//      Log.PopLogFolder();
      return flag;
}
//update 1.5.0
/**
  *@function
  *@param {String} code
*/
function isPostal (code)
{ 
      //Log.AppendFolder("func: isPostal");
      var flag = false;
      if (code == "" || code == null)
      {
           Log.Message(lib_err.msg_ERR_CODE_IS_NULL);
           return flag;
      }
      for (var i = 1 ; i <= lib_const.arr_Postal.length ; i ++)
      { 
          if (lib_const.arr_Postal[i-1] == code)
          {
                flag = true;
                return flag;
          }
      }
//      Log.PopLogFolder();
      return flag;
}

/**
  *@function 
*/
function isUnExpectedWindowExists ()
{
        //Log.AppendFolder("func: isUnExpectedWindowExists");        
        var flag = false;
        if (   isDLCODERunning()  )
        {   
              if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window",lib_const.const_delay_1000).Exists )
                      flag = true;
              if  (Sys.Process("DL.CODE").WaitWindow("#32770", "*",1, lib_const.const_delay_1000).Exists)
                      flag = true;
              if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: UserControl",lib_const.const_delay_1000).Exists )
                      flag = true;
        }
//        Log.PopLogFolder();
        return flag;
}


/**
  *@function 
*/
function isUnExpectedWindow ()
{
      //Log.AppendFolder("func: isUnExpectedWindow");
      var flag = false;
      try
      {
          if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", lib_const.const_delay_1000).Exists)
          {
          
                var txt = Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText").WPFControlText;
                        
                if ( txt == lib_label.const_ChangeUserBasic)
                {
                
                      Log.Error(lib_label.const_ChangeUserBasic);
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton();                      
                      return true;
                }
                if ( txt == lib_label.const_Device_Attention)
                {
          
                      Log.Error(lib_label.const_Device_Attention);
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();
                      return true;
                }
                
                if ( txt == lib_label.const_Device_ConnectionLost)
                {
                      Log.Error(lib_label.const_Device_ConnectionLost);
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnNo").ClickButton();
                      return true;
                }
              
                 
                if (  aqString.Contains(txt, const_OperationFailed, 0, true) >=0)
                {
                
                      Log.Error(txt);
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();
                      return true;
                }
                
                if ( txt == lib_label.const_CannotSaveConfiguration)
                {
                
                      Log.Error(lib_label.const_CannotSaveConfiguration);
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();                      
                      return true;
                }
                if ( txt == lib_label.const_SAVECONFIG_ERR)
                {
                
                      Log.Error(lib_label.const_SAVECONFIG_ERR);                      
                      return true;
                }
                if ( txt == lib_label.const_SAVECONFIG_ERR)
                {
                
                      Log.Error(lib_label.const_SAVECONFIG_ERR);                      
                      return true;
                }
                
                
          }
          if (Sys.Process("DL.CODE").WaitWindow("#32770", "", 1, lib_const.const_delay_1000).Exists)
          {
          
                var txt = Sys.Process("DL.CODE").Window("#32770", "", 1).Window("Static", "*", 1).WndCaption;               
                if ( txt == lib_label.const_Unrecoverable)
                {
                      Log.Message(lib_label.const_Unrecoverable);
                      Sys.Process("DL.CODE").Window("#32770", "", 1).Window("Button", "OK", 1).ClickButton();
                      return true;
                }
          }
          
      }
      catch (e)
      {
              return lib_err.err_FUNC_EXCEPTION;
      }
//      Log.PopLogFolder();
      return flag;
}




/**
  *@function 
*/
function isDLCODERunning ()
{ 
       var flag = true;
       if ( !Sys.WaitProcess("DL.CODE", lib_const.const_delay_1000, true).Exists)
       {       
            flag = false;
       }       
       return flag;
}


/**
  *@function 
*/
function isConnectedDevice()
{
      
        //Log.AppendFolder("func: isConnectedDevice");
        if (!lib_validate.isDLCODERunning()){   
              Log.Message(lib_err.err_DLCODE_NOFOUND) ;
              return lib_err.err_DLCODE_NOFOUND;
        }else
        {      
              if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell",lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WaitWPFObject("CollapsedExpander",lib_const.const_delay_1000).Exists )     
                return true;
              else
                return false;
        }
//        Log.PopLogFolder();
}

//updated 1.5.0 Alpha 5
/**
  *@function 
*/
function isUIReady ()
{  
      //Log.AppendFolder("func: isUIReady");
      var flag = false;   
      while (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware, 2000).Exists == false)
      {  
            delay (3000);
            Sys.Process("DL.CODE").Refresh(); 
      } 
      if ( Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WaitWPFObject("UserControl",1000).Exists) 
      {   
      
            if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ) .WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WaitWPFObject("uxAccordion", lib_const.const_delay_1000).Exists)
            {
                //if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WPFObject("OnlineDevicesAccordionItem").WPFObject("DeviceTreeView", "", 1).ChildCount > 1) 
                      flag = true;
            }             
      } 
//      Log.PopLogFolder();
      return flag;
}
/**
  *@function 
*/
function isGettingStartedScreen ()
{ 
           
          if (!lib_validate.isDLCODERunning())
          {                
                return false; 
          }
          //VERIFY left panel Device Online
          if (isUIReady() == false)
                return false;
                  
          //verify middle panel
          var proArr = ["WPFControlText", "VisibleOnScreen"];
          var valArr = ["Double-click or drag a Device here to select it" , true ];
          var label = Sys.Process("DL.CODE").FindChild(proArr, valArr, 2000);
          if (label.Exists == false)
             return false;
          else
              return true;
      
}



/**
  *@function 
*/
function validateValue (value1 , value2)
{
      var flag = false;
      if (value1 == value2)
            flag = true;
      return flag;
}

/*
    giang.ha add new 1.9.0A4

*/
function existsPPI (device, serNumber)
{
          var flag = false;
          if (device == lib_const.const_M120 || device == lib_const.const_M410 || device == lib_const.const_M450)
              flag = true; //exists
          if (device ==lib_const.const_M300 && serNumber == "C14A03122")
              flag = true; //exists
          return flag;
}



/*
     giang.ha add 20200305 1.9.0 A4
*/
function existsScalingFactor (device)
{
        var flag = true; // exists Scaling Factor
          
        if (device ==lib_const.const_M320)
            flag = false;// no exists Scalling Factor -> Pixel Sub...
        return flag; 
}


/*
     giang.ha add 20200305 1.9.0 A4
*/
function existsGeneralImageSettings  (device)
{
        var flag = true; // exists Scaling Factor          
        if (device !=lib_const.const_M220)
            flag = false;// no exists Scalling Factor -> Pixel Sub...
        return flag; 
}

function existOPCUA(device)
{
     var flag = false;
     if (device ==   lib_const.const_M220) 
          flag = true;
     if (device ==   lib_const.const_M320)
          flag = true;
     return flag;
}

// add new 1.9.0 B1
function existPackTrackMode (device)
{
        var flag = true; // exists PAckTrack       
        if (device == lib_const.const_M120 || 
            device == lib_const.const_M210 || 
            device == lib_const.const_M220)
            flag = false;// no exists PAck Track
        return flag; 
}