//USEUNIT lib_common
//USEUNIT lib_deviceInfo
//USEUNIT lib_SaveJob

 
/*
 *@function change the name + role + startup job
 *@param device_Before{String}
 *@param device_Expected{String}
*/
function changeDeviceInformation (device_Before, device_Expected)
{
//      if (lib_validate.isDLCODERunning())
//          lib_common.gettingStarted();
//      else
      lib_common.launchUI();           
      var flag = false;
      try
      {
            if (lib_common.connectToDevice(device_Before.IP) ==  lib_err.err_FUNC_SUCCESS)
            {
                     //get info from Device-> Setting
                      var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
                      IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click(); 
                      IvsMenu.WPFMenu.Click(lib_label.const_lb_Device + "|" +  lib_label.const_lb_Settings  + "|" +  lib_label.const_lb_Settings);
                      
                      if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: DeviceEnvironmentConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration, lib_const.const_delay_1000).Exists)
                      {
                               var contentExpander = Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration  ).WPFObject("DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration , 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1);                                                                                                                           
                              
                               //update name
                               contentExpander.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("RangeTextBox", "", 1).Keys("^a[Del]");
                               contentExpander.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("RangeTextBox", "", 1).Keys(device_Expected.name);
//                                Log.Warning("name: OK");
                               //update Startup Job                               
                               var cbbJobList = contentExpander.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ComboBox", "", 1);
                               var valueExpected= device_Expected.startupJob;
                               if ( lib_common.cbb_selectedItem (cbbJobList, valueExpected));
                                       aqObject.CheckProperty(contentExpander.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ComboBox", "", 1), "wText", cmpEqual,  valueExpected);                         
                                         
                               if (lib_deviceInfo.const_Device_Model != lib_const.const_M120)// only change Role for device != M120
                               {
                                    if (contentExpander.WaitWPFObject("ContentExpander", "", 3, lib_const.const_delay_1000).Exists && contentExpander.WPFObject("ContentExpander", "", 3).Visible == true)//M120 no has Role
                                    { 
                                           if (contentExpander.WPFObject("ContentExpander", "", 3).isExpanded == false)
                                           {
                                                contentExpander.WPFObject("ContentExpander", "", 3).Click();
                                           }
                                           if (contentExpander.WPFObject("ContentExpander", "", 3).isExpanded == true)
                                           { 
                                                   var cbbRole = contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1)    ;                                  
                                                   var valueExpected= device_Expected.role; 
                                                   //update role
                                                   if (device_Expected.role == lib_label.const_lb_Slave)  
                                                   {         
                                                          cbbRole.set_SelectedIndex(1);                                                                     
                                                          aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1),"wText", cmpEqual, "[2, " + lib_label.const_lb_Slave +"]");
                                                   }
                                                   else                                       
                                                   {
                                                          cbbRole.set_SelectedIndex(0);        
                                                          aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1),"wText", cmpEqual, "[1, " + lib_label.const_lb_Master +"]");
                                                   }                               
                                           }
                                   }
                               }
                               Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", "Device Environment Configuration").WPFObject("DeviceEnvironmentConfigurationPopup", "Device Environment Configuration", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("OkButton").ClickButton();
                               flag = true;                               
                               if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", lib_const.const_delay_1000).Exists)
                               { 
                                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, lib_label.const_NEW_ENVIROMENT);
                                        Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton();
                                        Delay (120000);//wait 2' cause M220 restart too long
                               }  
                      }  
            }
      }
      catch (e)
      {
        Log.Message(lib_err.err_FUNC_EXCEPTION);
      } 
      return flag;
}

/*
 *@function  
 *@param dev_1{String}
 *@param dev_2{String}
*/
function compareDevice (dev_1, dev_2)
{
      var flag = true;
      
      if (dev_1.name != dev_2.name)
      {
            Log.Warning(dev_1.name + "---" + dev_2.name);
            return false;
      }
            
      if (dev_1.startupJob != dev_2.startupJob)
      {
            Log.Warning(dev_1.startupJob + "---" + dev_2.startupJob);
            return false;
      }
            
      if (dev_1.role != dev_2.role)
      {
            Log.Warning(dev_1.role + "---" + dev_2.role);
            return false;
      }
            
      if (dev_1.IP != dev_2.IP)
      {
            Log.Warning(dev_1.IP + "---" + dev_2.IP);
            return false;
      }
            
      if (dev_1.serialNumber != dev_2.serialNumber)
      {
            Log.Warning(dev_1.serialNumber + "---" + dev_2.serialNumber);
            return false;
      }
            
      if (dev_1.model != dev_2.model)
      {
            Log.Warning(dev_1.model + "---" + dev_2.model);
            return false;
      }
       
            
      return flag;
      
}

/*
 *@function  
 *@param Device{String} 
*/
function dislayDeviceInfo (Device)
{
       Log.Message("****dislay DeviceInfo ********************************************************" );
       Log.Message(Device.name );                           
       Log.Message(Device.startupJob);  
       Log.Message(Device.role);  
       Log.Message(Device.IP);  
       Log.Message(Device.serialNumber);  
       Log.Message(Device.model);
       Log.Message(Device.loaderVersion);
       Log.Message(Device.vlLibrary);
       Log.Message(Device.frmware);
       Log.Message("************************************************************" ); 
         
}

function dfd ()
{
getDeviceCurrent ("10.84.30.140");
} 


/*
 *@function  
 *@param ip{String} 
*/
function getDeviceCurrent(ip)
{
      // init
      var Device = new Object();        
    
      try
      {

          if (lib_common.connectToDevice(ip) ==  lib_err.err_FUNC_SUCCESS)
          {
                //path of grid list                 
                if (aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1), "Enabled", cmpEqual, true))
                {
                        //get info from Device Selected Detail
                        var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1);  
                        txtDeviceName = gridList.WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
                        txtDeviceModel = gridList.WPFObject("Grid", "", 2).WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                        txtRole= gridList.WPFObject("Grid", "", 4).WPFObject("TextBlock", "*", 2).WPFControlText;
                        txtLoaderVersion= gridList.WPFObject("Grid", "", 10).WPFObject("TextBlock", "*", 2).WPFControlText;
                        txtFirmware = gridList.WPFObject("Grid", "", 9).WPFObject("TextBlock", "*", 2).WPFControlText;
                        //job is running              
                        txtIP = gridList.WPFObject("Grid", "", 7).WPFObject("TextBlock", "*", 2).WPFControlText; 
                        
                        //get startup job in Environment setting 
                        var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
                        IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click(); 
                        IvsMenu.WPFMenu.Click(lib_label.const_lb_Device + "|" +  lib_label.const_lb_Settings  + "|" +  lib_label.const_lb_Settings);
                        txtStartUpJob = Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", "Device Environment Configuration").WPFObject("DeviceEnvironmentConfigurationPopup", "Device Environment Configuration", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ComboBox", "", 1).wText;
                        txtVL         = Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", "Device Environment Configuration").WPFObject("DeviceEnvironmentConfigurationPopup", "Device Environment Configuration", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "About Device...", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 7).WPFObject("TextBox", "", 1).wText;
                        Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", "Device Environment Configuration").WPFObject("DeviceEnvironmentConfigurationPopup", "Device Environment Configuration", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 1).ClickButton();
                        
                        
                        // parse to device
                        Device.name         =  aqString.Trim(txtDeviceName, aqString.stAll) ;
                        Device.startupJob   =  aqString.Trim(txtStartUpJob, aqString.stAll);
                        Device.role         =  txtRole ;
                        Device.IP           =  txtIP ;
                        Device.serialNumber = lib_deviceInfo.const_Device_SerialNumber ;
                        Device.model        = lib_deviceInfo.const_Device_Model ;   
                        Device.loaderVersion = txtLoaderVersion;
                        Device.vlLibrary = txtVL;
                        Device.frmware = txtFirmware;
                }
            }
        }
        catch (e)
        {
          Log.Message(lib_err.err_FUNC_EXCEPTION);
        } 
        return Device;
}

 
/*
 *@function get info from lib_deviceInfo
 *@param ip{String} 
*/
function getDeviceFromDeviceInfo()
{
      // init
      var Device = new Object(); 
      // add properties
      Device.name         = aqString.Replace(lib_deviceInfo.const_Device_Name, " ", "") ;// device name dont have space
      Device.startupJob   = lib_deviceInfo.const_Device_StartupJob;
      Device.role         = lib_deviceInfo.const_Device_Role ;
      Device.IP           = lib_deviceInfo.const_Device_IP_Adress;
      Device.serialNumber = lib_deviceInfo.const_Device_SerialNumber ;
      Device.model        = lib_deviceInfo.const_Device_Model ;
//      Device.loaderVersion = txtLoaderVersion;
//      Device.vl = txtVL;
      return Device;
}

/*
 *@function  
*/
function setDeviceDefault ()
{
      var device = new Object(); 
      // add properties
      device.name           = ""; 
      device.startupJob     = ""; 
      device.role           = ""; 
      device.IP             = ""; 
      device.serialNumber   = ""; 
      device.model          = ""; 
      device.loaderVersion  = ""; 
      device.vlLibrary             = ""; 
      return Device;
}

/*
 *@function  
 *@param obj{Object} 
*/
function setDevice (obj)
{
      var Device = new Object(); 
      // add properties
      Device.name           =  obj.name ;
      Device.startupJob     =  obj.startupJob  ;
      Device.role           =  obj.role  ;
      Device.IP             =  obj.IP   ;
      Device.serialNumber   =  obj.serialNumber;
      Device.model          =  obj.model   ;
      return Device;
}

/*
 *@function  
 *@param nameJob{String} 
*/
function isStartUpJob( nameJob)
{
       var flag = false;
       var startupJob = getNameStartUpJob();
       if (nameJob == startupJob)
          flag = true;
       return flag;
}

/*
 *@function   
*/
function getNameStartUpJob()
{
    if ( ! lib_validate.isDLCODERunning())
          return lib_err.err_DLCODE_NOFOUND;
          
    var txtStartUpJob = "";      
    try
    {
       //path of grid list
      if (aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1), "Enabled", cmpEqual, true))
       {       
              var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1);  
              txtDeviceName = gridList.WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;;    
              txtStartUpJob = gridList.WPFObject("Grid", "", 5).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 3).WPFControlText; 
       }      
    }
    catch (e)
    {
      return lib_err.err_FUNC_EXCEPTION;
    } 
    // show information by Log     
    Log["Message"]("##->txtStartUpJob:" + txtStartUpJob, txtStartUpJob);
    return txtStartUpJob;
}

/*
 *@function   
*/
function getDeviceRole()
{
    if ( ! lib_validate.isDLCODERunning())
          return lib_err.err_DLCODE_NOFOUND;
          
    var role = "";      
 
     //path of grid list
    if (aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1), "Enabled", cmpEqual, true))
                               Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1)
     {       
            var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1);  
            role= gridList.WPFObject("Grid", "", 4).WPFObject("TextBlock", "*", 2).WPFControlText;               
     }      
 
    return role;
}

/*
 *@function   
 *@param ip{String}
*/
function verifyDeviceSelectedDetail(ip)
{
    /*variable*/
    var txtDeviceName ,txtDeviceModel ,txtLayoutType,txtRole;
    var txtStartUpJob ;
    var txtStatus;
    var txtStartUpInfo ;
    var txtIP;
    var txtFirmware;
    var txtLoaderVersion ;  
    lib_common.launchUI();
 
        if (lib_common.connectToDevice(ip) ==  lib_err.err_FUNC_SUCCESS)
        {
              //path of grid list  
                             
              if (aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1), "Enabled", cmpEqual, true))
              {
                      //get info from Device Selected Detail
                      var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1);  
                      txtDeviceName = gridList.WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
                      txtDeviceModel = gridList.WPFObject("Grid", "", 2).WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                      txtLayoutType = gridList.WPFObject("Grid", "", 3).WPFObject("TextBlock", "*", 2).WPFControlText;
                      txtRole= gridList.WPFObject("Grid", "", 4).WPFObject("TextBlock", "*", 2).WPFControlText;
                      txtStartUpJob = gridList.WPFObject("Grid", "", 5).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 3).WPFControlText;     
                      txtStatus = gridList.WPFObject("Grid", "", 5).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
                      txtStartUpInfo = gridList.WPFObject("Grid", "", 6).WPFObject("TextBlock", "*", 2).WPFControlText;
                      txtIP = gridList.WPFObject("Grid", "", 7).WPFObject("TextBlock", "*", 2).WPFControlText;
                      txtFirmware= gridList.WPFObject("Grid", "", 9).WPFObject("TextBlock", "*", 2).WPFControlText;
                      txtLoaderVersion= gridList.WPFObject("Grid", "", 10).WPFObject("TextBlock", "*", 2).WPFControlText;

                      //get info from Device-> Settings
                      var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
                     IvsMenu.WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click(); 
                      IvsMenu.WPFMenu.Click(lib_label.const_lb_Device + "|" +  lib_label.const_lb_Settings  + "|" +  lib_label.const_lb_Settings);
                      
                      if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: DeviceEnvironmentConfigurationPopup", lib_label.lb_DeviceEnvironmentConfiguration, lib_const.const_delay_1000).Exists)
                      {
                               var contentExpander = Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration  ).WPFObject("DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration , 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1);
                               aqObject.CheckProperty(contentExpander.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("RangeTextBox", "", 1), "Text", cmpEqual, txtDeviceName);
                               aqObject.CheckProperty(contentExpander.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ComboBox", "", 1), "wText", cmpEqual, txtStartUpJob);
                                                                                             
                               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).isExpanded == false)
                               {
                                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).Click();
                               }
                               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).isExpanded == true)
                               {
                                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBox", "", 1),  "wText", cmpEqual, txtDeviceModel);
                                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBox", "", 1),  "wText", cmpEqual, txtFirmware);
                                   aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_AboutDevice+"", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 5).WPFObject("TextBox", "", 1) , "wText", cmpEqual, txtLoaderVersion);
                               }
                               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).isExpanded == false)
                               {
                                    contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).Click();
                               }
                               if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).isExpanded == true)
                               {                                         
                                   if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("CheckBox", "", 1).IsChecked == false)
                                   {                                           
                                   // 1.8.0 changed interface -- linhtnguyen comment
                                   //        aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("IpAddress"), "IP Address", cmpEqual, txtIP);
                                              
                                             Delay(1000);
                                             aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.const_lb_EthernetSettings+"", 2).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("IpAddressControl", "", 1), "IpAddress", cmpEqual, txtIP);
                                                                                        
                                   } 
                               } 
                               if (contentExpander.WaitWPFObject("ContentExpander", "", 3, lib_const.const_delay_1000).Exists && contentExpander.WPFObject("ContentExpander", "", 3).Visible == true)//M120 no has Role
                               {              
                                   if (contentExpander.WPFObject("ContentExpander", "", 3).isExpanded == false)
                                   {
                                        contentExpander.WPFObject("ContentExpander", "", 3).Click();
                                   }
                                   if (contentExpander.WPFObject("ContentExpander", "", 3).isExpanded == true)
                                   {
                                          if (txtRole == lib_label.const_lb_Slave)                                               
                                                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1),"wText", cmpEqual, "[2, " + lib_label.const_lb_Slave +"]");
                                          else
                                                  aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1),"wText", cmpEqual, "[1, " + lib_label.const_lb_Master +"]");                                                 
                                   }
                               }
                               Sys.Process("DL.CODE").WPFObject("HwndSource: DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration ).WPFObject("DeviceEnvironmentConfigurationPopup", lib_label.const_lb_DeviceEnvironmentConfiguration , 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 1).ClickButton();
                                
                      }
                      //verify Task Selection
                      if (lib_deviceInfo.const_Device_Model == lib_const.const_M120 )
                      {
                      
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_OpenDeviceConfiguration).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PresentationMode).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true );
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true );
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_WebMonitor - 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true );
                             
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_OpenDeviceConfiguration).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual, lib_label.const_lb_OpenDeviceConfiguration);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PresentationMode).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual, lib_label.const_lb_PresentationMode);
                             //lib_const.const_treeview_Monitor - 2 (linhtnguyen comment)
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual,  lib_label.const_lb_MonitorDevice);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_WebMonitor - 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual,  lib_label.const_lb_webMonitor);
                             
                             var packTrackListItem = Sys.Process("DL.CODE").FindChild("WPFControlText", "Packtrack Calibration",2000);                             
                             var proArr = ["ClrClassName", "ToolTip"];
                             var valArr = ["Button", "Packtrack Calibration"];
                             var packTrackButton = Sys.Process("DL.CODE").FindChild(proArr,valArr,2000);
                             
                             if (packTrackListItem.Exists == false && packTrackButton.Exists == false)
                                  Log.Message( "This device doesnt support PackTrack mode");
                      }
                      
                      if ( lib_deviceInfo.const_Device_Model == lib_const.const_M210 ||
                           lib_deviceInfo.const_Device_Model == lib_const.const_M220)
                      {
                      
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_OpenDeviceConfiguration).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PresentationMode).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true );
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true );
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true );
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_WebMonitor - 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true );
                             
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_OpenDeviceConfiguration).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual, lib_label.const_lb_OpenDeviceConfiguration);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PresentationMode).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual, lib_label.const_lb_PresentationMode);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual,  lib_label.const_lb_SetupInternalNetworkConfiguration);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual,  lib_label.const_lb_MonitorDevice);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_WebMonitor -1 ).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual,  lib_label.const_lb_webMonitor);
                             
                             var packTrackListItem = Sys.Process("DL.CODE").FindChild("WPFControlText", "Packtrack Calibration",2000);                             
                             var proArr = ["ClrClassName", "ToolTip"];
                             var valArr = ["Button", "Packtrack Calibration"];
                             var packTrackButton = Sys.Process("DL.CODE").FindChild(proArr,valArr,2000);
                             
                             if (packTrackListItem.Exists == false && packTrackButton.Exists == false)
                                  Log.Message( "This device doesnt support PackTrack mode");
                             
                      }
                       if ( lib_deviceInfo.const_Device_Model == lib_const.const_M300 ||
                            lib_deviceInfo.const_Device_Model == lib_const.const_M410 ||
                            lib_deviceInfo.const_Device_Model == lib_const.const_M450 )
                      {
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_OpenDeviceConfiguration).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PresentationMode).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true );
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true );
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PackTrack ).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true );
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true );
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_WebMonitor).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "IsEnabled", cmpEqual, true );
                             
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_OpenDeviceConfiguration).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual, lib_label.const_lb_OpenDeviceConfiguration);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PresentationMode).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual, lib_label.const_lb_PresentationMode);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual,  lib_label.const_lb_SetupInternalNetworkConfiguration);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PackTrack ).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual,  lib_label.const_lb_PackTrackCalibration);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual,  lib_label.const_lb_MonitorDevice);
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_WebMonitor).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1),"WPFControlText", cmpEqual,  lib_label.const_lb_webMonitor);
                             
                   
                      } 
              }              
        }    
}
