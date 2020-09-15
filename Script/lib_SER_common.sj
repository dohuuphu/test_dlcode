//USEUNIT lib_CodeSetup
//USEUNIT lib_common
//USEUNIT lib_connection
//USEUNIT lib_const
//USEUNIT lib_DeleteJob
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_OpenJob
//USEUNIT lib_validate 

/*
 *@update 19-0-2019 (only update on 1.7.0 A5)
 *@function
 *@param mySerialDevice{String}
*/
function connectToSerialDevice(mySerialDevice)
{

    var flag = lib_err.err_FUNC_FAILED; 
    if (lib_validate.isDLCODERunning() == false)
          lib_common.launchUI();
    
    try {
  
        while ( !lib_validate.isGettingStartedScreen())
        {
              lib_common.gettingStarted();
        } 
         var serialDevices = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 3)["WPFObject"]("uxAccordion")["WPFObject"]("SerialPortAccordionItem");
                                                                                                                                                                               
        if (serialDevices.IsSelected == false)
        {
                  serialDevices.set_IsSelected (true);
                  delay (lib_const.const_delay_2000);
        }
         
        if (  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WaitWPFObject("SerialPortAccordionItem", lib_const.const_delay_1000).Exists)
        {                    
                  var SerialPortAccordionItem = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 4).WPFObject("uxAccordion").WPFObject("SerialPortAccordionItem")
               
                  if (SerialPortAccordionItem.WaitWPFObject("DeviceTreeView", "", 1 , lib_const.const_timeOut).Exists  )
                  {
                          var onlineDeviceTree =  SerialPortAccordionItem.WPFObject("DeviceTreeView", "", 1);
                          //get ["WPFObject"] of TreeView
                          while (onlineDeviceTree.ChildCount == 1 )
                          {     
                                Delay(lib_const.const_delay_4000);
                                Sys["Process"]("DL.CODE").Refresh();    
                          }  
                          if  (onlineDeviceTree.ChildCount > 1 )
                          { 
                                  //In TreeView Online Device, there is 1 item - last index - AdornerLayer - is not a TreeListItem of Device
                                  for (var i = 1; i < onlineDeviceTree.ChildCount ; i++)
                                  {
                                           //current device has index i
                                          var currentDevice = onlineDeviceTree["WPFObject"]("TreeViewItem", "", i);
                                          //get serial number of current device
                                          var serialNumber = currentDevice.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("WrapPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 2).WPFObject("TextBlock", "*", 3).WPFControlText;                                           
                                          //compare current device with my device
                                          if ( serialNumber == mySerialDevice)   
                                          {           
                                                       currentDevice.DblClick( currentDevice.ActualWidth/2, currentDevice.ActualHeight/2 , 0); 
                                                       //lhoang start to modify
                                                       //lhoang change condition: wait if the pop up panel not display, do nothing 
                                                       while ( Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == false) {}
                                                       // lhoang: the pop up now display, check the pop up
                                                       // lhoang: change variable const_firmware to lib_deviceInfo.const_firmware, comment the old line code below
                                                       if(!aqObject.CheckProperty(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_ProgressBar_Comminicating))
                                                       {  
                                                          aqObject.CheckProperty(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_ProgressBar_Comminicating);
                                                       }
                                                      //aqObject.CheckProperty(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_ProgressBar_Comminicating); // lhoang comment this
                                                      // lhoang: after check pop up window, wait to close the pop up, do nothing
                                                      while ( Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true) {}
                                                      // end of modify                                                                 
                                                       if (Sys["Process"]("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
                                                       {
              
                                                                 if (aqObject.CheckProperty(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Device_Attention ))
                                                                          Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();                                           
                                                      }
                                                       else
                                                       {
                                                                 if (lib_common.verifyConnectToDevice(false)  ) 
                                                                 {
                                                                      flag = lib_err.err_FUNC_SUCCESS;
                                                                      return flag;
                                                                 }
                                                       }
                                          } else Log.Message("recheck ser number");  
                                  }                                 
                          }  
                  }  
          }      
    }catch (e)
    { 
         Log["Message"](lib_err.err_FUNC_EXCEPTION);        
    }
    Log["Message"]("connectToDeviceByIndex:" + false);     
    return flag; 
} 
 



function test1()
{
var obj = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", "DL.CODE 1.8.0.33").WPFObject("Shell", "DL.CODE 1.8.0.33", 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("AdvancedSetupJobContent", "", 1).WPFObject("DeleteToolActionButton", "", 1).WPFObject("Image", "", 1);
//LLPlayer.MouseMove(obj.ScreenLeft+obj.Width/2,obj.ScreenTop + obj.Height/2, -1);

obj.HoverMouse();
Delay(3000);

//var a = System.obj.get_ToolTip();
var a = obj.ToolTip.Text;
Log.Message(a);
}
