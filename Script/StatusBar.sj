//USEUNIT lib_ChangeIP
//USEUNIT lib_CodeSetup
//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_DeviceSelectedDetail
//USEUNIT lib_OpenJob
//USEUNIT lib_SaveJob
//USEUNIT lib_UserRole
//USEUNIT lib_validate
//USEUNIT lib_label
 

 /*
  *@function  
*/
function statusBar()
{ 
    var arrUserRole = [""+lib_label.const_lb_InstallerExpert+"",""+lib_label.const_lb_InstallerBasic+"" ,""+lib_label.const_lb_UserBasic+"" ];    
    var ip = lib_deviceInfo.const_Device_IP_Adress;
    var arrInfoDevice = new Array();
    //get Info Device
    arrInfoDevice = getInfoDevice(ip) ;
    //fetch all user role
    for (var i = 1; i <= arrUserRole.length ; i ++)
    {         
          if ( ! lib_validate.isDLCODERunning())
              lib_common.launchUI();
          else 
          {
              lib_common.gettingStarted();
          }   
          var currentUser = lib_UserRole.getUserRoleCurrent(); 
          var result = lib_UserRole.changeUserRole(arrUserRole[i-1], false);
          if (result == true || 
                              (result == false &&(currentUser ==currentUser ))  )
          {
           
               //verify Default UI 
              verifyBottomStatusBar_Default(arrUserRole[i-1]);
              //Expert and Installer Basic  
              
              if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS)
              {
                 
                 if (arrUserRole[i-1]!= lib_label.const_lb_UserBasic)
                 {
                        //verify Configuration mode        
                       if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                       {
//                               verifyTopStatusBar(arrUserRole[i-1],arrInfoDevice);
                               verifyBottomStatusBar_ConfigurationMode( arrUserRole[i-1],arrInfoDevice);
                               //change to Monitor mode
                               Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
                               //verify Monitor mode
                               verifyBottomStatusBar_MonitorMode( arrUserRole[i-1],arrInfoDevice);
                       }  
                 } else
                 {//User Basic    
                         if (aqString.SubString(arrInfoDevice[1], 0 , 4) == "M300" || aqString.SubString(arrInfoDevice[1], 0 , 4) == "M410" ||aqString.SubString(arrInfoDevice[1], 0 , 4) == "M450" )                                      
                             Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Monitor Device", 1).Click();
                        if (aqString.SubString(arrInfoDevice[1], 0 , 4) == "M210" )
                             Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor -1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Monitor Device", 1).Click();
                        if (aqString.SubString(arrInfoDevice[1], 0 , 4) == "M120" )
                             Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor  -2 ).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Monitor Device", 1).Click();verifyBottomStatusBar_MonitorMode( arrUserRole[i-1],arrInfoDevice);
                        verifyBottomStatusBar_MonitorMode( arrUserRole[i-1],arrInfoDevice);
                             
                 } 
              }
          } 
          //change user role to Expert
          if (lib_UserRole.changeUserRole(arrUserRole[0], false))
             lib_common.terminateUI();
    }   
}

/*
  *@function 
  *@param userRole{String}
  *@param arrInfoDevice{Array}
*/
function verifyTopStatusBar (userRole,arrInfoDevice)
{
      var stringSlave  = "Layout Type :  "+arrInfoDevice[2]+" ;  Internal Network Role :  "+arrInfoDevice[3]+" "+arrInfoDevice[4]+" ;  Configuration : ";       
      var stringMaster = "Layout Type :  Alone ;  Internal Network Role :  "+arrInfoDevice[3]+" ;  Configuration : ";
      var path =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1);
      if (arrInfoDevice[3] == "Slave")
          aqObject.CheckProperty(path.WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, stringSlave);
      else
          aqObject.CheckProperty(path.WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, stringMaster);
      aqObject.CheckProperty(path.WPFObject("TextBlock", "Default", 2), "WPFControlText", cmpEqual, "Default");
      aqObject.CheckProperty(path.WPFObject("TextBlock", "", 5), "WPFControlText", cmpEqual, ";  Status :  Halt ;  Reading Phase: Continuous");

}


/*
  *@function 
  *@param userRole{String} 
*/
function verifyBottomStatusBar_Default (userRole)
{
      Log.Message("### start verify BottomStatusBar_Default user--" + userRole);
      var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1);
                 Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("WrapPanel", "", 6).WPFObject("TextBlock", "", 1)
      // right -> left
      aqObject.CheckProperty(path.WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpContains, lib_deviceInfo.const_firmware);
      //update 1.5.0 a5
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 6).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, lib_label.lb_User);      
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 6).WPFObject("TextBlock", ""+userRole+"", 2), "WPFControlText", cmpEqual, userRole);
//      aqObject.CheckProperty(path.WPFObject("TextBlock", "*", 4), "WPFControlText", cmpEqual, lib_label.lb_ConfigurationSchemaRelease  );
//      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, lib_label.lb_DeviceModel);
      Log.Message("### End verify BottomStatusBar_Default user--" + userRole);
}
 
/*
  *@function 
  *@param userRole{String}
  *@param arrInfoDevice{Array}
*/
function verifyBottomStatusBar_ConnectToDevice  ( userRole,arrInfoDevice)
{
      Log.Message("### start verify BottomStatusBar_ConnectToDevice user--" + userRole);     
      var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1);;
      aqObject.CheckProperty(path.WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpContains, lib_deviceInfo.const_firmware);
//      //PaCktrack
//      if (aqString.SubString(arrInfoDevice[1], 0 , 4) == "M300" || aqString.SubString(arrInfoDevice[1], 0 , 4) == "M410" ||aqString.SubString(arrInfoDevice[1], 0 , 4) == "M450" )      
//      {
//            aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, lib_label.lb_PackTrack);
//            if (arrInfoDevice[9] == false)
//                 aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "*", 3), "WPFControlText", cmpEqual, "Not Calibrated");
//            else
//                 aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpEqual, "Calibrated");
//      }
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 6).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, lib_label.lb_User);
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 6).WPFObject("TextBlock", ""+userRole+"", 2), "WPFControlText", cmpEqual, userRole);
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 5).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, lib_label.lb_DeviceSWRelease  );
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 5).WPFObject("TextBlock", "", 2).WPFObject("InlineUIContainer", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_deviceInfo.const_firmware_version );
      aqObject.CheckProperty(path.WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_IPAddress_StatusBar + arrInfoDevice[6]); 
      //Device Model
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, lib_label.lb_DeviceModel); 
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpEqual, arrInfoDevice[1]);
      //Name       
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, "Name : "); 
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "", 2), "WPFControlText", cmpEqual, arrInfoDevice[0]);
        
      Log.Message("### End verify  BottomStatusBar_ConnectToDevice user--" + userRole);
} 

/*
  *@function 
  *@param userRole{String}
  *@param arrInfoDevice{Array}
*/
function verifyBottomStatusBar_ConfigurationMode (  userRole,arrInfoDevice)
{  
        var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1);
                   
        aqObject.CheckProperty(path.WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpContains, lib_deviceInfo.const_firmware);
        aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 6).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, lib_label.lb_User);
        aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 6).WPFObject("TextBlock", ""+userRole+"", 2), "WPFControlText", cmpEqual, userRole);
        aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 5).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, lib_label.lb_DeviceSWRelease  );
        aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 5).WPFObject("TextBlock", "", 2).WPFObject("InlineUIContainer", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_deviceInfo.const_firmware_version );
        aqObject.CheckProperty(path.WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_IPAddress_StatusBar + arrInfoDevice[6]); 
        //Device Model
        aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, lib_label.lb_DeviceModel); 
        aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpEqual, arrInfoDevice[1]);
        //Name       
        aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, "Name : "); 
        /*
        case: length > 17 chars=> string...
        */
        if (arrInfoDevice[0].length <= 17)
              aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpEqual, arrInfoDevice[0]);
        else
              aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpContains, aqString.SubString(arrInfoDevice[0],0,17) );
        
}
/*
  *@function 
  *@param userRole{String}
  *@param arrInfoDevice{Array}
*/
function verifyBottomStatusBar_MonitorMode ( userRole,arrInfoDevice)
{
      var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1);
      aqObject.CheckProperty(path.WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpContains, lib_deviceInfo.const_firmware);
      
      
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 6).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, lib_label.lb_User);
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 6).WPFObject("TextBlock", ""+userRole+"", 2), "WPFControlText", cmpEqual, userRole);
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 5).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, lib_label.lb_DeviceSWRelease  );
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 5).WPFObject("TextBlock", "", 2).WPFObject("InlineUIContainer", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_deviceInfo.const_firmware_version );
      aqObject.CheckProperty(path.WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_IPAddress_StatusBar + arrInfoDevice[6]); 
      //Device Model
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, lib_label.lb_DeviceModel); 
      aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 3).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpEqual, arrInfoDevice[1]);
      //Name
      if (arrInfoDevice[0].length <= 17)
              aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpEqual, arrInfoDevice[0]);
       else
              aqObject.CheckProperty(path.WPFObject("WrapPanel", "", 1).WPFObject("TextBlock", "*", 2), "WPFControlText", cmpContains, aqString.SubString(arrInfoDevice[0],0,17) );
        

}

/*
  *@function  
*/
function getConfigurationSchema()
{
       var schema;
       //: CONNECTING_DEVICE              
       var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");               
       IvsMenu.WPFMenu.Click(lib_label.const_lb_Device + "|" +  lib_label.const_lb_Settings  + "|" +  lib_label.lb_ConfigurationSettings);    
       //check maim menu                  
       // check content expander
       var contentExpander = Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationSettingsWindow", lib_label.lb_ConfigurationSettings  ).WPFObject("ConfigurationSettingsWindow", lib_label.lb_ConfigurationSettings , 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1);
                                     
       aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+lib_label.const_lb_Configuration+"", 1).WPFObject("TextBlock", ""+lib_label.const_lb_Configuration+"", 1), "Enabled", cmpEqual, true);
               
       //**************************************        
       if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Configuration+"", 1).isExpanded == false)
       {
            contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Configuration+"", 1).set_IsExpanded(true);
       }
       if (contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Configuration+"", 1).isExpanded == true)
       {                 
            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Configuration+"", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+lib_label.const_lb_ConfigurationName+"", 2), "Visible", cmpEqual, true);
            aqObject.CheckProperty(contentExpander.WPFObject("ContentExpander", ""+ lib_label.lb_Configuration+"", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("TextBlock", ""+lib_label.const_lb_ConfigurationVersion+"", 2), "Enabled", cmpEqual, true);
            schema = contentExpander.WPFObject("ContentExpander", "Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("RangeTextBox", "", 1).Text;
                                                  
       }
       Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationSettingsWindow", "Configuration Settings").WPFObject("ConfigurationSettingsWindow", "Configuration Settings", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 1).ClickButton();
       return schema();
}

/*
  *@function 
  *@param ip{String} 
*/
function getInfoDevice(ip)
{  
    var arr = new Array();
    if ( ! lib_validate.isDLCODERunning())
              lib_common.launchUI();
    else 
    {
        lib_common.gettingStarted();
    }   
    var currentUser = lib_UserRole.getUserRoleCurrent(); 
    var result = lib_UserRole.changeUserRole(lib_label.const_lb_InstallerExpert, false);
    if (lib_common.connectToDevice(ip)==lib_err.err_FUNC_SUCCESS)
    {        
       arr = lib_common.getDeviceInformation(); 
    }
    Log.Message(arr[4]);
    //lib_common.terminateUI();
    return arr;
}
