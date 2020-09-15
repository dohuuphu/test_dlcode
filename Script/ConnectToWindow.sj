//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_validate
//USEUNIT lib_common


/*
  *@function to open Connect To Device window
  *update 2018 10 17
*/
function connectToDeviceWindow ()
{
  aqTestCase.Begin("Verify Connect to Window ");
      lib_common.launchUI();  
                 
      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu").WPFObject("MenuItem", lib_label.const_lb_Device  , 3).Click();    
      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu").WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_ConnectToDevice);
                 
      var path = Sys.Process("DL.CODE").WPFObject("HwndSource: ConnectToWindow", "Connect to Device").WPFObject("ConnectToWindow", "Connect to Device", 1);
                          
      //labels
      //ETH
      Objects.ConWin_TextblockConnectionType.Check(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "Connection Type", 1));                    
      Objects.ConWin_cbbConType(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("MainComboBox"));
                          
      Objects.ConWin_TextblockIpAddress.Check(path.WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "IP Address", 1));
      Objects.ConWin_ipAddress(path.WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ipAddress"));
                          
      Objects.ConWin_TextblockAttention.Check(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", "Attention: before pressing Connect check Gateway settings on PC", 1));
                           
      //Button
      Objects.ConWin_ButtonConnect(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "Connect", 1));
      Objects.ConWin_ButtonCancel(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "Cancel", 2));
                                    
      path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("MainComboBox").ClickItem(1);
                          
      Objects.ConWin_SER_MainComboBox.Check(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("MainComboBox"));
                          
     // Objects.ConWin_TextblockSerialPort.Check(path.WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", "Serial Port", 1));
      Objects.ConWin_ComboboxSerialPort.Check(path.WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 1).WPFObject("ComboBox", "", 1));
      //Objects.ConWin_ComboboxSerialPort
                         
      Objects.ConWin_TextblockSerialParity.Check(path.WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 2).WPFObject("TextBlock", "Serial Parity", 1));
      Objects.ConWin_ComboboxSerialParity.Check(path.WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 2).WPFObject("ComboBox", "", 1));
                         
      Objects.ConWin_TextblockSerialDataBits.Check(path.WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 3).WPFObject("TextBlock", "Serial Data Bits", 1));
      Objects.ConWin_ComboboxSerialDataBits.Check(path.WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 3).WPFObject("ComboBox", "", 1));
                          
      Objects.ConWin_TextblockSerialStopBits.Check(path.WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 4).WPFObject("TextBlock", "Serial Stop Bits", 1));
      Objects.ConWin_ComboboxSerialStopBits.Check(path.WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Grid", "", 4).WPFObject("ComboBox", "", 1));
                     
      path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "Cancel", 2).ClickButton();
      aqTestCase.End(); 
}