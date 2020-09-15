//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_validate 
 
/**
 * @function return amount of space
 * @param {String} str
*/
function countSpace (str)
{
     var count  = 0;
     for (i = 0; i <= str.length - 1 ; i++)
     {
         if (str[i] == " ")
              count ++;         
     }
     return count;
}

//add 1.6.0b1
/**
 * @function  
 * @param {Interger} value
 * @param {Interger} delayValue
 * @param {Interger} maxTime
*/
function waitDelay (value,delayValue,maxTime  )
{             
      var time = 1;
      while (time <= maxTime)
      { 
            Log.Message(time );
            Delay(delayValue);                        
            time ++;
            if (time == maxTime)
                 return;
      }
}
/**
 * @function delete <strDelete> in <str>
 * @param {String} str
 * @param {String} strDelete 
*/
function subString(str, strDelete)
{ 
        var lengthAll = aqString.GetLength(str);
        var lengthDelete = aqString.GetLength(strDelete);  
        var lengthEnd = lengthAll-lengthDelete;
        return aqString.SubString(str, lengthDelete , lengthEnd) ;
}
/**
 * @function convert DateTime(dd/MM/yyyy hh:mm:ss) to format(dd_MM_yyyy hh_mm_ss) 
 * @param {String} str
 * @param {String} strDelete 
*/
function getDateTimeStr()
{    
        var time = aqDateTime.Now();  
        time = aqConvert.DateTimeToStr (time); 
        Log.Message( time);
        time = aqString.Replace(time ,"/", "_")
        time = aqString.Replace(time ,":", "_")
        Log.Message( time);
        return time;
}
/**
 * @function select item<valueExpected> in cbb_NonLogicalAdornerDecorator <cbb>
 * @param {Object} cbb
 * @param {String} valueExpected 
*/
function cbb_NonLogicalAdornerDecorator (cbb, valueExpected)
{
           
//           //Log.AppendFolder("func: cbb_NonLogicalAdornerDecorator");
           var flag = false;                 
           //get info       
           var cbbItemsCount     = cbb.wItemCount;    
           cbb.Click(); 
           for (var i = 0; i < cbbItemsCount ; i ++)
           {
                if (valueExpected == Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", i + 1).WPFObject("TextBlock", "*", 1).WPFControlText  )
                {      
                       cbb.ClickItem(i );
//                       var text = "[" + i +", " +  valueExpected + "]";
                       aqObject.CheckProperty(cbb.WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, valueExpected);
                       flag = true;
                       return flag;                                
                }
           }    
//           Log.PopLogFolder();      
           return flag;
}

/**
 * @function select item<valueExpected> in regular combobox <cbb>
 * @param {Object} cbb
 * @param {String} valueExpected 
*/
function cbb_selectedItem (cbb , valueExpected)
{                  
           //Log.AppendFolder("func: cbb_selectedItem");
           var flag = false;                 
           //get info       
           var cbbItemsCount     = cbb.wItemCount;
           var cbbItemList       = cbb.wItemList;
           var cbbListSeparator  = cbb.wListSeparator;   
           var res = cbbItemList.split(cbbListSeparator);
         
           if (  res.length == cbbItemsCount )
           {
                     for (var i = 0; i < res.length ; i ++)
                     {
                          if (valueExpected == res[i]  )
                          {                              
                                 cbb.set_SelectedIndex(i);
                                 flag = true;
                                 return flag;                                
                          }
                     }
           } 
           Log.PopLogFolder();
           return flag;
}

/**
 * @function connect to device by <Serial Number Device> 
 * @param {String} mySerialDevice 
*/

function connectToDeviceByIndex (mySerialDevice)
{
    //Log.AppendFolder("func: connectToDeviceByIndex");
    var flag = lib_err.err_FUNC_FAILED; 
    if (lib_validate.isDLCODERunning() == false)
          launchUI();    
    try {   
        gettingStarted();
        
        if (  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion")["WaitWPFObject"]("OnlineDevicesAccordionItem", lib_const.const_delay_1000).Exists)
        {                    
                  var onlineDevicesAccordionItem = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WPFObject("OnlineDevicesAccordionItem");
                  if (onlineDevicesAccordionItem["WaitWPFObject"]("DeviceTreeView", "", lib_const.const_timeOut).Exists  )
                  {
                          var onlineDeviceTree = onlineDevicesAccordionItem.WPFObject("DeviceTreeView", "", 1);
                          //get .WPFObject of TreeView
                          while (onlineDeviceTree.ChildCount == 1 )
                          {     
                                Delay(lib_const.const_delay_4000);
                                Sys.Process("DL.CODE").Refresh();    
                          }  
                          if  (onlineDeviceTree.ChildCount > 1 )
                          { 
                                  //In TreeView Online Device, there is 1 item - last index - AdornerLayer - is not a TreeListItem of Device
                                  for (var i = 1; i < onlineDeviceTree.ChildCount ; i++)
                                  {
                                           //current device has index i
                                          var currentDevice = onlineDeviceTree.WPFObject("TreeViewItem", "", i);
                                          //get serial number of current device
                                          //edit 1.5.0 a7
                                          var serialNumber = currentDevice.WPFObject("mastergrid").WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("StackPanel", "", 2).WPFObject("TextBlock", "*", 3).WPFControlText;     
                                          //compare current device with my device
                                          if ( serialNumber == mySerialDevice)   
                                          {           
                                                       currentDevice.DblClick();
                                                       if (verifyConnectToDevice(true) ) 
                                                       {
                                                            flag = lib_err.err_FUNC_SUCCESS;
                                                            return flag;
                                                       }
                                          }   
                                  }                                 
                          }  
                  }  
          }      
    }catch (e)
    { 
         Log["Message"](lib_err.err_FUNC_EXCEPTION);        
    }
//    Log["Message"]("connectToDeviceByIndex:" + false); 
    Log.PopLogFolder();    
    return flag; 
} 


/**
 * @function process when UnexpectedWindow exists 
*/
function proccessUnexpectedWindow ()
{
        //Log.AppendFolder("func: proccessUnexpectedWindow ");
        //end process DL CODE
        lib_common.terminateUI();
        //re-launch UI
        runTestedApp();
        Log.PopLogFolder();
}
/**
 * @function config DL CODE at the begining
 * Configuration mode
*/
function initUI ()
{
       var middle = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("controlToolBar");
       if (middle.ActualWidth < lib_const.const_MinWidth_controlToolbar )             
       {       
            var gridSplitter;
            gridSplitter = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("GridSplitter", "", 1);  
            gridSplitter.Drag(3, 346, 450, 98);
       }
       var left = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1);
       if (left.ActualWidth < 400 )             
       {       
            var leftSplitter;
            leftSplitter = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("GridSplitter", "", 2);  
            leftSplitter.Drag(3, 346, 450, 98);
            
       }     
}
//updated 1.5.0 Alpha 3   
/**
 * @function click on Getting Started button 
*/
function gettingStarted ()
{            
    //Log.AppendFolder("function: gettingStarted");
    var flag = lib_err.err_FUNC_FAILED;// "Failed"
    
    if (!lib_validate.isDLCODERunning())
    { 
          launchUI();
    }  
    //unExpected window exists
    if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: JobListDialogWindow", "*", lib_const.const_delay_1000).Exists ||// open job window
        Sys.Process("DL.CODE").WaitWPFObject("HwndSource: UserControl", lib_const.const_delay_1000).Exists              ||// open UI setting
        Sys.Process("DL.CODE").WaitWPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", "*", lib_const.const_delay_1000).Exists || // open Environment setting
        Sys.Process("DL.CODE").WaitWPFObject("HwndSource: ConfigurationSettingsWindow", "*", lib_const.const_delay_1000).Exists ||//ConfigurationSettingsWindow
        Sys.Process("DL.CODE").WaitWPFObject("HwndSource: EscapeSequencesPopup", "*", lib_const.const_delay_1000).Exists  ||
        Sys.Process("DL.CODE").WaitWPFObject("HwndSource: AboutBox", "*", lib_const.const_delay_1000).Exists   ||  // HMS window
        Sys.Process("DL.CODE").WaitWPFObject("HwndSource: OperationManualPopup","*", lib_const.const_delay_1000).Exists  ||//Help Window
        Sys.Process("DL.CODE").WaitWPFObject("HwndSource: RamImagesBufferPopup","*", lib_const.const_delay_1000).Exists || // RAM buffer
        Sys.Process("DL.CODE").WaitWPFObject("HwndSource: ConnectToWindow","*", lib_const.const_delay_1000).Exists ||// connect to 
        Sys.Process("DL.CODE").WaitWPFObject("HwndSource: PopupWindow", lib_const.const_delay_1000).Exists 
        )
    {          
          proccessUnexpectedWindow();                   
    }
   
    if (Sys.WaitProcess("DL.CODE", lib_const.const_delay_1000,true)["Exists"])
    {
         Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware, lib_const.const_delay_5000); 
         while (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", lib_const.const_btt_GettingStarted ).Enabled == false)
         {
                Delay(lib_const.const_delay_2000);
                Sys.Process("DL.CODE").Refresh();
         }
         if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", lib_const.const_btt_GettingStarted ).Enabled == true )
             
         {      
                var Button = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", 1);
                Button.ClickButton();                
                //case there is Temp job --> confirm 
                if ( Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window",lib_const.const_delay_2000).Exists )
                {
                      Log.Message("Device is connecting on Configuration mode");
                      var txt = Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText").WPFControlText;
                      if (txt ==lib_label.const_Confirm_GettingStarted )
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, lib_label.const_Confirm_GettingStarted);
                      else 
                            aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, lib_label.const_Confirm_GettingStartedCluster);
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton(); 
                }
                Delay(lib_const.const_delay_5000);                
                while (!lib_validate.isUIReady())
                {        
                      Delay(lib_const.const_delay_2000);
                      Sys.Process("DL.CODE").Refresh(); 
                } 
                if (lib_validate.isUIReady() == true && lib_validate.isGettingStartedScreen() == true)
                      flag = lib_err.err_FUNC_SUCCESS;//"Success"
       }     
    }
    Log.PopLogFolder();
    return flag ;
}


/**
 * @function close DL CODE
*/
function closeUI()
{
        //Log.AppendFolder("func: closeUI");
        var flag = lib_err.err_FUNC_SUCCESS;
        if (Sys.WaitProcess("DL.CODE", lib_const.const_delay_1000,true)["Exists"])
        {
              delay (lib_const.const_delay_5000);
              TestedApps["DL_CODE"].Close();
              delay (lib_const.const_delay_5000);
        }else  
             flag = lib_err.err_DLCODE_NOFOUND; 
        Log.PopLogFolder(); 
       return flag ;
    
}

 

/**
 * @function launch new Dl.CODE
*/
function runTestedApp ()
{
        Indicator.PushText("Launch new DL.CODE"); 
        TestedApps.Items(0).Run(); 
        delay (lib_const.const_delay_3000);
        Indicator.PopText(); 
}
function runDLCODELastOfficial ()
{
        Indicator.PushText("Launch DL.CODE last official"); 
        TestedApps.Items(4).Run(); 
        delay (lib_const.const_delay_3000);
        Indicator.PopText(); 
}

/**
 * @function launch new Dl.CODE
*/
function launchUI ()
{
    Indicator.PushText("Launch new DL.CODE");
    Indicator.PopText();    
    if (Sys.WaitProcess("DL.CODE", lib_const.const_delay_1000, true).Exists == true)
    {
         // DL.CODE is ruuning -> click Getting Started button
         var processEnabled = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).Enabled;
         if (processEnabled == true)
              gettingStarted();
         else 
         {  
               proccessUnexpectedWindow(); 
         }     
    }
    else
    { 
         //launch new DL.CODE
         runTestedApp();           
    }
    
     //check version 
    if ( Sys.WaitProcess("DL.CODE", lib_const.const_delay_3000, true).Exists)
    {
            if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", "*").WndCaption != lib_deviceInfo.const_firmware )  
            {
                  Indicator.PushText("DL.CODE version is wrong. Close UI . Pls Recheck");	 
                  Log.Error(lib_err.err_VERSION_NOT_EQUAL);
                  flag = lib_err.err_FUNC_FAILED;   
                  terminateUI();
                  Runner.Stop();
            } 
    }    
}


/*edit 1.5.0a7*/
/**
 * @function launch DL CODE 
*/
/*
function launchUI ()
{   
    // Launch the application
    //Log.AppendFolder("function: launchUI")    ;
    var flag = lib_err.err_FUNC_SUCCESS;       
    if ( !lib_validate.isDLCODERunning())//DL.CODE doesn't exist
    {
          Indicator.PushText("Launch new DL.CODE");
          Log.Message("Launch new DL.CODE");	 	 
          TestedApps.Items(0).Run(); 
          delay (lib_const.const_delay_3000);
          Indicator.PopText();        
    }else//DL.CODE existed
    { 
           Log.Message("DL.CODE is running -> Click Getting Started btt ");	
//           gettingStarted();
          Indicator.PushText("DL.CODE is running -> Close and Re-launch ");
          Log.Message("DL.CODE is running -> Close and Re-launch ");		     
          terminateUI();
          delay (lib_const.const_delay_3000);
          TestedApps.Items(0).Run(); 
          delay (lib_const.const_delay_3000);
          Indicator.PopText();     
    }
    //check version 
    if ( Sys.WaitProcess("DL.CODE", lib_const.const_delay_3000, true).Exists)
    {
            if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", "*").WndCaption != lib_deviceInfo.const_firmware )  
            {
                  Indicator.PushText("DL.CODE version is wrong. Close UI . Pls Recheck");	 
                  Log.Error(lib_err.err_VERSION_NOT_EQUAL);
                  flag = lib_err.err_FUNC_FAILED;   
                  terminateUI();
                  Runner.Stop();
            } 
    }    
    Log.PopLogFolder();
    return flag;    
}
*/
 
/**
 * @function get index of device by Serial Number Device
 * @param {String} mySerialDevice
*/ 
function getDeviceIndex (mySerialDevice)
{ 
    try {
        //Log.AppendFolder("func: getDeviceIndex");
        var myDeviceIndex = 0 ;  
        if (lib_validate.isDLCODERunning() == false)
              return myDeviceIndex;
        while ( !lib_validate.isGettingStartedScreen())
        {
              gettingStarted();
        } 
        if (  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion")["WaitWPFObject"]("OnlineDevicesAccordionItem", lib_const.const_delay_1000).Exists)
        {                    
                  var onlineDevicesAccordionItem = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WPFObject("OnlineDevicesAccordionItem");
                  if (onlineDevicesAccordionItem["WaitWPFObject"]("DeviceTreeView", "", lib_const.const_timeOut).Exists  )
                  {
                          var onlineDeviceTree = onlineDevicesAccordionItem.WPFObject("DeviceTreeView", "", 1);
                          //get .WPFObject of TreeView
                          while (onlineDeviceTree.ChildCount == 1 )
                          {     
                                Delay(lib_const.const_delay_4000);
                                Sys.Process("DL.CODE").Refresh();    
                          }  
                          if  (onlineDeviceTree.ChildCount > 1 )
                          { 
                                  //In TreeView Online Device, there is 1 item - last index - AdornerLayer - is not a TreeListItem of Device
                                  for (var i = 1; i < onlineDeviceTree.ChildCount ; i++)
                                  {
                                           //current device has index i
                                          var currentDevice = onlineDeviceTree.WPFObject("TreeViewItem", "", i);
                                          //get serial number of current device
                                          var serialNumber = currentDevice.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("StackPanel", "", 2).WPFObject("TextBlock", "*", 3).get_Text();
                                                                          
                                          //compare current device with my device
                                          if ( serialNumber.ToString() == mySerialDevice)   
                                          {           
                                                        myDeviceIndex = i;
                                                        return myDeviceIndex;
                                          }   
                                  }                                 
                          }  
                  }  
          }  
          Log.PopLogFolder();
          return myDeviceIndex;     
    }catch (e)
    { 
         Log["Message"](lib_err.err_FUNC_EXCEPTION);        
    }
    
}

/**
 * @function get index of device by IP Address
 * @param {String} my IP
*/ 
function getDeviceIndexByIP (myIP)
{
    //Log.AppendFolder("func: getDeviceIndexByIP");
    var myDeviceIndex = 0 ;  
    if (lib_validate.isDLCODERunning() == false)
          return myDeviceIndex;    
    try {
  
        while ( !lib_validate.isGettingStartedScreen())
        {
              gettingStarted();
        } 
        if (  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion")["WaitWPFObject"]("OnlineDevicesAccordionItem", lib_const.const_delay_1000).Exists)
        {                    
                  var onlineDevicesAccordionItem = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WPFObject("OnlineDevicesAccordionItem");
                  if (onlineDevicesAccordionItem["WaitWPFObject"]("DeviceTreeView", "", lib_const.const_timeOut).Exists  )
                  {
                          var onlineDeviceTree = onlineDevicesAccordionItem.WPFObject("DeviceTreeView", "", 1);
                          //get .WPFObject of TreeView
                          while (onlineDeviceTree.ChildCount == 1 )
                          {     
                                Delay(lib_const.const_delay_4000);
                                Sys.Process("DL.CODE").Refresh();    
                          }  
                          if  (onlineDeviceTree.ChildCount > 1 )
                          { 
                                  //In TreeView Online Device, there is 1 item - last index - AdornerLayer - is not a TreeListItem of Device
                                  for (var i = 1; i < onlineDeviceTree.ChildCount ; i++)
                                  {
                                           //current device has index i
                                          var currentDevice = onlineDeviceTree.WPFObject("TreeViewItem", "", i);
                                          //get serial number of current device                                         
                                          var ip = currentDevice.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 2).get_Text();
                                                                                                   
                                          //compare current device with my device
                                          if (  aqString.Trim(ip.ToString(), aqString.stAll)  == myIP)   
                                          {           
                                                        myDeviceIndex = i;
                                                        return myDeviceIndex;
                                          }   
                                  }                                 
                          }  
                  }  
          }      
    }catch (e)
    { 
         Log["Message"](lib_err.err_FUNC_EXCEPTION);        
    }
    Log.PopLogFolder();
    return myDeviceIndex; 
    
} 
 
/**
 * @function close DL CODE
*/
function terminateUI()
{
      Log.Message("Terminal UI");
      // Obtains the notepad.exe process
      var p = Sys["FindChild"]("ProcessName", "DL.CODE");
      // Iterates through all the instances of the notepad.exe process
      // until all of them are closed
      while (p["Exists"])
      {
          p["Close"]();
          // Waits until the process is closed
          var isClosed = p["WaitProperty"]("Exists", false);
          // Checks whether the process has been closed successfully
          if (! isClosed)
            // Terminates the process
             {
             p["Terminate"]();
             //break;
             }

          // Obtains another instance of the notepad.exe process
          p = Sys["FindChild"]("ProcessName", "DL.CODE");
     }
     delay (2000);
}
 

/**
 * @function connect to device by <Connect to Device> window
 * @param {String} ip
 * return {String} Success/Failed
*/ 
function connectToDevice (ip)
{
      lib_common.launchUI();             
      var flag = lib_err.err_FUNC_SUCCESS;
      try
      {                 
            if( isGettingStartedScreen())
            {   
                //verify that the device is working else waiting in 5 minutes
                var time =0 ;
                while (getDeviceIndexByIP (ip) == 0)
                {    
                    Delay(lib_const.const_timeOut);                     
                    time = time + 1;
                    Sys.Process("DL.CODE").Refresh();
                    if (time == lib_const.const_time_timeOut)
                    {
                           Log.Error(lib_err.msg_ERR_CONNECTTODEVICE_TIMEOUT + ":" +  time*lib_const.const_timeOut + " milliseconds");
                           return lib_err.err_FUNC_FAILED;
                    } 
                } 
                //click menu to open dialog
                if ( Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1)["WaitWPFObject"]("IvsMenu", lib_const.const_delay_2000).Exists)
                {
                        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu").WPFObject("MenuItem", lib_label.const_lb_Device  , 3).Click();    
                        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu").WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_ConnectToDevice);
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: ConnectToWindow",  lib_label.const_lb_ConnectToDevice).WPFObject("ConnectToWindow",  lib_label.const_lb_ConnectToDevice, 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock",  lib_label.lb_IPAddress, 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: ConnectToWindow",  lib_label.const_lb_ConnectToDevice).WPFObject("ConnectToWindow",  lib_label.const_lb_ConnectToDevice, 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock",  lib_label.lb_Attention_ConnectToDevice, 1), "Enabled", cmpEqual, true);
 
                        Sys.Process("DL.CODE").WPFObject("HwndSource: ConnectToWindow", lib_label.const_lb_ConnectToDevice ).WPFObject("ConnectToWindow", lib_label.const_lb_ConnectToDevice , 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ipAddress").set_IpAddress (ip);
                        Sys.Process("DL.CODE").WPFObject("HwndSource: ConnectToWindow", lib_label.const_lb_ConnectToDevice ).WPFObject("ConnectToWindow", lib_label.const_lb_ConnectToDevice , 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "Connect", 1).ClickButton();
                
                        if ( Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window",lib_const.const_delay_1000).Exists )
                        {      
                            var txt = Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText").WPFControlText;
                            if (txt == lib_label.const_IP_INVALID)             
                            {
                                 aqObject.CheckProperty(Aliases.DL_CODE.HwndSource_Window.Window.Grid.Grid2.MessageText, "WPFControlText", cmpEqual, lib_label.const_IP_INVALID);
                                 Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();
                         
                                 Log.Warning(lib_label.const_IP_INVALID);
                                 return lib_err.err_FUNC_FAILED;
                            } 
                        }
                
                        if ( Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window",lib_const.const_delay_6000).Exists )
                        {                   
                            if (lib_validate.isUnExpectedWindow() == true)
                            {
                                  proccessUnexpectedWindow();        
                                  return lib_err.err_FUNC_FAILED;
                            }
                        }
                        if (verifyConnectToDevice(true) == false)
                               return lib_err.err_FUNC_FAILED;
                        }  
                
              }             
 
      }catch (e)
      {
        return lib_err.err_FUNC_EXCEPTION;
      } 

//      Log.PopLogFolder();
      return flag; 
}

/**
 *isETH: is ETH connection 
 *@function  verify Selected Device panel
 * return {boolean}  
*/ 
function verifyConnectToDevice ( isETH )
{
          //Log.AppendFolder("func: verifyConnectToDevice");
          var flag = true;
          var txtDeviceName = "",txtDeviceModel= "" ,txtLayoutType= "",txtRole= "";
          var txtStartUpJob = "";
          var txtStatus= "";
          var txtStartUpInfo= "" ;
          var txtIP= "";
          var txtSerPort = "";
          var txtFirmware= "";
          var txtLoaderVersion = ""; 

          //path of grid list                 
          if (aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1), "Enabled", cmpEqual, true))
          {
                  //get info from Device Selected Detail
                  var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1);  
                  txtDeviceName = gridList.WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtDeviceModel = gridList.WPFObject("Grid", "", 2).WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                  txtLayoutType = gridList.WPFObject("Grid", "", 3).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtRole= gridList.WPFObject("Grid", "", 4).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtStartUpJob = gridList.WPFObject("Grid", "", 5).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                  txtStatus = gridList.WPFObject("Grid", "", 5).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtStartUpInfo = gridList.WPFObject("Grid", "", 6).WPFObject("TextBlock", "*", 2).WPFControlText;
                  if (isETH == true)
                      txtIP = gridList.WPFObject("Grid", "", 7).WPFObject("TextBlock", "*", 2).WPFControlText;
                  else
                      txtSerPort = gridList.WPFObject("Grid", "", 8).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtFirmware= gridList.WPFObject("Grid", "", 9).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtLoaderVersion= gridList.WPFObject("Grid", "", 10).WPFObject("TextBlock", "*", 2).WPFControlText;
                  
                  if (txtDeviceName == "")
                          flag = false;
                  if( txtDeviceModel == "")
                          flag = false;
                  if ( txtLayoutType == "" )
                          flag = false;
                  if( txtRole == "" )
                          flag = false;
                  if(   txtStartUpJob == "" )
                          flag = false;
                  if( txtStatus == ""   )
                          flag = false;
                  if ( txtStartUpInfo == ""     )
                          flag = false;
                  if (isETH == true && txtIP == ""  )
                          flag = false;                       
                 if (isETH == false && aqString.Contains(txtSerPort, "COM", 0, true) == -1 )
                          flag = false;                   
                 if( txtFirmware== ""   )
                          flag = false;
                 if(txtLoaderVersion =="")
                          flag = false;
                          
                 if (txtFirmware != lib_deviceInfo.const_firmware_version)
                 {
//                        flag = false;
                        Log.Warning("Firmware isn't same");
                 }
          } 
          Log.PopLogFolder();
          return flag;
}
/**
 * @function return full model of device
 * return {String}  (e.g, M220 385-010 1.2MP DPM-R 12MM)
*/ 
function getDeviceModel( )
{
          //Log.AppendFolder("func: getDeviceModel");
          var  txtDeviceModel= "" 
          //path of grid list                 
          if (aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1), "Enabled", cmpEqual, true))
          {
                  //get info from Device Selected Detail
                  var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1);
                  txtDeviceModel = gridList.WPFObject("Grid", "", 2).WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
           }  
           Log.Message(txtDeviceModel)  ;
           Log.PopLogFolder();
           return txtDeviceModel;
}

 

/**
 * @function return full model of device
 * @param {String} ip
*/ 
function restartDevice (ip)
{
      //Log.AppendFolder("func: restartDevice");
      if (!lib_validate.isDLCODERunning()){    
            lib_common.launchUI();
      }    
      if ( !isGettingStartedScreen())
      {
            gettingStarted();
            Sys.Process("DL.CODE").Refresh();
      } 
      var flag = lib_err.err_FUNC_FAILED;       
      try
      {
             if ( connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
             {
                  var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 
                  IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click();
                  IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_RestartDevice);
                  
                  if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", lib_const.const_delay_1000).Exists)
                  {
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"),"WPFControlText", cmpEqual, lib_label.const_Confirm_Reset);
                          Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton();
                          flag = lib_err.err_FUNC_SUCCESS;
                  }             
             }
      }
      catch (e)  
      {
          return lib_err.err_FUNC_EXCEPTION;     
      }  
      Log.PopLogFolder();
      return flag;
}


/**
 * @function return array information of device
 * Selected Detail Device screen 
*/  
function getDeviceInformation ( )
{
          //Log.AppendFolder("func: getDeviceInformation");
          var array = new Array();
          var txtDeviceName = "",
          txtDeviceModel= "" ,
          txtLayoutType= "",
          txtRole= "";
          var txtPointAddress = 0; //default          
          var txtStartUpJob = "";
          var txtStatus= "";
          var txtStartUpInfo= "" ;
          var txtIP= "";
          var txtFirmware= "";
          var txtLoaderVersion = ""; 
          var isPackTrack = false;          
          var txtPackTrack ;
          var flag = true;
          //path of grid list                 
          if (aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1), "Enabled", cmpEqual, true))
          {
                  //get info from Device Selected Detail
                  var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1);  
                  txtDeviceName = gridList.WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtDeviceModel = gridList.WPFObject("Grid", "", 2).WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                  txtLayoutType = gridList.WPFObject("Grid", "", 3).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtRole= gridList.WPFObject("Grid", "", 4).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtStartUpJob = gridList.WPFObject("Grid", "", 5).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                  txtStatus = gridList.WPFObject("Grid", "", 5).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtStartUpInfo = gridList.WPFObject("Grid", "", 6).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtIP = gridList.WPFObject("Grid", "", 7).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtFirmware= gridList.WPFObject("Grid", "", 9).WPFObject("TextBlock", "*", 2).WPFControlText;
                  txtLoaderVersion= gridList.WPFObject("Grid", "", 10).WPFObject("TextBlock", "*", 2).WPFControlText;
                  
                  if (txtDeviceName == "")
                          flag = false;
                  if( txtDeviceModel == "")
                          flag = false;
                  if ( txtLayoutType == "" )
                          flag = false;
                  if( txtRole == "" )
                          flag = false;
                  if(   txtStartUpJob == "" )
                          flag = false;
                  if( txtStatus == ""   )
                          flag = false;
                  if ( txtStartUpInfo == ""     )
                          flag = false;
                 if( txtIP == ""  )
                          flag = false; 
                 if( txtFirmware== ""   )
                          flag = false;
                 if(txtLoaderVersion =="")
                          flag = false;
          }
          //get Point Address
          var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
          IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click();                 
          IvsMenu.WPFMenu.Click(lib_label.const_lb_Device + "|" +  lib_label.const_lb_Settings  + "|" +  lib_label.const_lb_Settings);

          var path =Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration ).WPFObject("DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration , 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1);
          var contentExpander = Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration  ).WPFObject("DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration , 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1);
                 
          if (txtRole == "Slave")
          {
                  //M120 doesnt have Internal Nertwork
                  if (lib_deviceInfo.const_Device_Model != lib_const.const_M120)
                  {
                      if (contentExpander.WPFObject("ContentExpander", "", 3).isExpanded == false)
                       {
                            contentExpander.WPFObject("ContentExpander", "", 3).set_IsExpanded(true);
                       }
                       if (contentExpander.WPFObject("ContentExpander", "", 3).isExpanded == true)
                       {
                            //verify label
                             var add = contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").get_Text();
                             txtPointAddress = aqConvert.StrToInt(add.ToString());              
                       }
                  }
          }
          //get PackTrack
          
          if (contentExpander.WPFObject("ContentExpander", "Packtrack Calibration", 5).IsVisible == true)
             isPackTrack = true;
          //input value to Array
          
          if (flag == true)
          {
             array.push (txtDeviceName);
             array.push (txtDeviceModel);
             array.push (txtLayoutType);
             array.push (txtRole);
             array.push (txtPointAddress);
             array.push (txtStartUpJob);
             array.push (txtIP);
             array.push (txtFirmware);
             array.push (txtLoaderVersion);
             array.push (isPackTrack);
          }
          Log.PopLogFolder();
          return array;
}

function getDeviceInfomationForWEBPAGE()
{
  aqTestCase.Begin("getDeviceInfomationAndEnabledAllStatisticsInConfigurationSettings");
  var array = new Array();
  var deviceName = "", model = "", serialNumber = "", softwareVersion = "", runningJob = "", startupJob = "";
  var dhcpValue = "", ipaddr = "", subnetMask = "", gateWay = "", macAddr = "";
  
  lib_common.launchUI();
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
     if(checkboxDHCP.IsChecked)
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
  var homeinfoArray =  [deviceName,  model, serialNumber, softwareVersion, runningJob, startupJob, dhcpValue, ipaddr, subnetMask, gateWay, macAddr];
  SaveInfoToExcel(homeinfoArray);
  //return [deviceName,  model, serialNumber, softwareVersion, runningJob, startupJob, dhcpValue, ipaddr, subnetMask, gateWay, macAddr];
  aqTestCase.End();
}
function SaveInfoToExcel(info)
{
 var ExcelPath = aqFileSystem.GetFolderInfo(Project.Path).ParentFolder;
 ExcelPath = aqFileSystem.GetFolderInfo(ExcelPath.Path).ParentFolder;
 ExcelPath = aqFileSystem.GetFolderInfo(ExcelPath.Path).ParentFolder;
 ExcelPath = ExcelPath.Path + "automationtestmatrixwebpage_python\\SeleniumProject\\ExcelFile\\Database.xlsx";
// 
 var app = Sys.OleObject("Excel.Application");
 var book = app.Workbooks.Open(ExcelPath);
 var sheet = book.Sheets.Item("HomePage");
 for (var i = 0 ; i < info.length; i++)
 {
   sheet.Cells.Item(i+1, 2).Value2 = info[i] ;
 }
// 
// 
 book.Save();
 app.Quit();

}

function WriteDataToExcel()
{
  var app = Sys.OleObject("Excel.Application");
  var book = app.Workbooks.Open("D:\\SVN_TestComplete\\automationtestmatrixwebpage_python\\SeleniumProject\\ExcelFile\\Database.xlsx");
  var sheet = book.Sheets.Item("HomePage");
  sheet.Cells.Item(1, 1).Value2 = "Lino" ;
  book.Save();
  app.Quit();
} 

function clickOnMenu(menu, subMenu)
{
  arrPro = ["ClrClassName", "WPFControlText"]
  arrVal = ["MenuItem", menu];
  
  menuObj = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  if(menuObj.Exists)
  {
    menuObj.Click();
    arrVal = ["MenuItem", subMenu];
    subMenuObj = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).FindChild(arrPro, arrVal, 1000);
    if(subMenuObj.Exists)
    {
      subMenuObj.Click();
    }
    else
    {
      Log.Warning("Submenu " + subMenu + " does not exist");
    }
  }
  else
  {
    Log.Warning("Menu " + menu + " does not exist");
  }
}
function findDeviceInGettingStarted()
{
    var flag = false;
    if (Sys.process("DL.CODE").FindChild("ClrClassName", "DeviceTreeView" ,2000).Exists)
    { 
            var dev = Sys.Process("DL.CODE").FindChild("WPFControlText", const_Device_SerialNumber, 2000);
            if (dev.Exists )
              flag = true;
    }    
    return flag;     
      
}



/*
   *make sure DL.CODE connect to device
   *current screen is Getting Started   
*/

function getFWVersionInGettStarted ()
{
      var version;
      var proArr = ["WPFControlText", "ClrClassName"];
      var valArr = ["Application SW Version" , "TextBlock"];
      var tmpPath = Sys.Process("DL.CODE").FindChild(proArr,valArr, 2000);
      if (tmpPath.Exists)
      {
        var parent = tmpPath.Parent;
        version = parent.WPFObject("TextBlock", "*", 2).WPFControlText;
      }
      return version;
}
 

