
function serialConnectByConnectTo(port, parity, databits, stopbits)
{
  
}
function connecToDeviceClick()
{
  var ivsMneu = Sys.Process("DL.CODE").FindChild("WPFControlName", "IvsMenu", 1000);
  if(!ivsMneu.Exists) 
  {
    Log.Error("Can not found IVS Meneubar");
    return;
  }
  ivsMneu.WPFMenu.Click("Device|Connect to Device");
}
function ChangeConnectionTypeToSerial_ConnectTo()
{
  var connectToDevicePopuObj = Sys.Process("DL.CODE").WPFObject("HwndSource: ConnectToWindow", "Connect to Device");
  if(!connectToDevicePopuObj.Exists)
  {
    Log.Error("Can not found Connect To Device Window");
    return;
  }
  var mainCBX = connectToDevicePopuObj.FindChild("WPFControlName", "MainComboBox", 1000);
  if(!mainCBX.Exists)
  {
    Log.Error("Can not found main combobox for serial or ethernet option");
    return;
  }
  mainCBX.ClickItem(1);
}

function selectCOMPORTConfiguration(port, parity, databits, stopbits)
{
  
}