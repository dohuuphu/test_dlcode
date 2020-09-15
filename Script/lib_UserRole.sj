//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_DataFormating
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_OpenJob
//USEUNIT lib_OutputSetup
//USEUNIT lib_ReadingPhase
//USEUNIT lib_validate
//USEUNIT lib_button


/**
  *@function
*/
function verifyMonitorMode () //both Installer Basic, Expert and UserBasic//add 1.5.0
{
  aqTestCase.Begin("verifyMonitorMode");
          Log.AppendFolder("func: verifyMonitorMode"); 
          lib_common["launchUI"]();  
          if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
          { 
                   //US_91   
                  // switch to Monitor mode
                  var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu").WPFObject("MenuItem",lib_label.const_lb_File, 1).Click();
                  IvsMenu.WPFMenu.Click(lib_label.const_lb_File +"|" + lib_label.const_lb_File_Monitor);
                            
                  while ( ! Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WaitWPFObject("TextBlock", "",1,lib_const.const_delay_5000).Exists)
                  {
                      Delay(lib_const.const_delay_5000);
                  }            
                  lib_button.ui_PlayAndPause(5000, true); 
                  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Grid", "", 1).WPFObject("Button", "Control", 1).ClickButton();
                  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Configuration", 2).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Image Settings ", 1).Click();
                  //US_93, US_94      
                  Log.Message("US_93, US_94")    ;
                  aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Image Quality", 1).WPFObject("StackPanel", "", 1).WPFObject("Button", "Image Auto-Setup", 1), "Enabled", cmpEqual, false);
                  // device has Focus Autolearn
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
                   aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("WPFControlName", "AcquirePPICommandButton", 1000), "Enabled", cmpEqual, true) ;
                  }
                  if(Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000).Exists)
                  {
                   aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("WPFControlName", "FocusAutolearnCommandButton", 1000), "Enabled", cmpEqual, false) ;
                  }
          var proArr = ["WPFControlText" , "ClrClassName"];
          var valArr = [ "Image Settings ", "TextBlock"];
          var btt = Sys.Process("DL.CODE").FindChild(proArr,valArr, 1000);
                                    
                  var arrPro = ["ClrClassName", "WPFControlText"];
                  var arrVal = ["ContentExpander", "Cropping Region Area"];
                  var CroppingRegionAreaa = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
                  aqObject.CheckProperty(CroppingRegionAreaa, "Visible", cmpEqual, true);
                  var CroppingBoxArray = (new VBArray(CroppingRegionAreaa.FindAllChildren("ClrClassName", "ExplicitUpdateDoubleUpDown", 1000))).toArray();
                  
                  for(var indexCRBox = 0; indexCRBox < CroppingBoxArray.length;indexCRBox ++)
                  {
                    aqObject.CheckProperty(CroppingBoxArray[indexCRBox], "Enabled", cmpEqual, false);
                    
                  }
                  CroppingBoxArray = (new VBArray(CroppingRegionAreaa.FindAllChildren("ClrClassName", "ExplicitUpdateIntegerUpDown", 1000))).toArray();
                  for(indexCRBox = 0; indexCRBox < CroppingBoxArray.length;indexCRBox ++)
                  {
                    aqObject.CheckProperty(CroppingBoxArray[indexCRBox], "Enabled", cmpEqual, false);
                    
                  }
                                    
                  //US_98, US_99,US_100      
                  Log.Message("US_98, US_99,US_100")    ;      
                  lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn,true);
                  lib_button.clickToolbarButton(lib_const.const_bbt_ZoomIn,true);
                  lib_button.clickToolbarButton(lib_const.const_bbt_ZoomOut,true);
                  lib_button.clickToolbarButton(lib_const.const_bbt_ZoomToFit,true);
                  
                  //US_88 
                  //fieldbus                 
                  aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Configuration", 2).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 7), "Visible", cmpEqual, false);
                  //protocol index
                  aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Configuration", 2).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 15), "Visible", cmpEqual, false);      
                  
          }
          Log.PopLogFolder();
          aqTestCase.End();
}

 

/**
  *@function
  *@param {boolean} isConnectingDevice
*/
function changeAllUserRole_NOTCONNECT_Device (isConnectingDevice) /*US_01,US_02,US_03,US_04,US_150,US_151*/// updated 1.5.0
{
              //1 Expert           -> Installer Basic
              //2 Installer Basic   -> Expert
              //3 Expert            -> User Basic
              //4 User Basic        -> Expert
              //5 Instaler Basic    -> User Basic
              //6 User Basic        -> Installer Basic 

              Log.AppendFolder("func: changeAllUserRole_NOTCONNECT_Device");
              Log.Message("Step 1:Expert           -> Installer Basic");
              if (changeUserRole ( lib_label.const_lb_InstallerBasic,isConnectingDevice))             
              {
                     verifyConnectDevice(lib_label.const_lb_InstallerBasic);
                     //OPEN JOB DEFAULT
                     lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);   
                     verifyConnectingDevice(lib_label.const_lb_InstallerBasic);
                     lib_common.gettingStarted();
                     lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);
                     Log.Message("End Step 1");
              }
              Log.Message("Step 2 Installer Basic   -> Expert");
              if( changeUserRole ( lib_label.const_lb_InstallerExpert,isConnectingDevice))
              {
                     verifyConnectDevice(lib_label.const_lb_InstallerExpert);
                     //OPEN JOB DEFAULT
                     lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);   
                     verifyConnectingDevice(lib_label.const_lb_InstallerExpert);
                     lib_common.gettingStarted();
                     lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);
                     Log.Message("End Step 2");
              } 
              Log.Message("Step 3 Expert            -> User Basic");
              if( changeUserRole ( lib_label.const_lb_UserBasic,isConnectingDevice))
              {
                     verifyConnectDevice(lib_label.const_lb_UserBasic);
                     Log.Message("End Step 3");
              }
              Log.Message("Step 4 User Basic        -> Expert");
              if( changeUserRole ( lib_label.const_lb_InstallerExpert,isConnectingDevice))
              {
                     verifyConnectDevice(lib_label.const_lb_InstallerExpert);
                     //OPEN JOB DEFAULT
                     lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);   
                     verifyConnectingDevice(lib_label.const_lb_InstallerExpert);
                     lib_common.gettingStarted();
                     lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);
                     Log.Message("End Step 4");
              }  
             
              if (setUserRoleDefault_Is_InstallerBasic() == lib_err.err_FUNC_SUCCESS)
              {
                    Log.Message("Step 5 Instaler Basic    -> User Basic");
                    if( changeUserRole ( lib_label.const_lb_UserBasic,isConnectingDevice))
                    {                        
                           verifyConnectDevice(lib_label.const_lb_UserBasic);    
                           Log.Message("End Step 5");
                    }
                    Log.Message("Step 6 User Basic        -> Installer Basic");
                    //US_148
                    if( changeUserRole ( lib_label.const_lb_InstallerBasic,isConnectingDevice))
                    {
                             verifyConnectDevice(lib_label.const_lb_InstallerBasic);
                             //OPEN JOB DEFAULT
                             lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);   
                             verifyConnectingDevice(lib_label.const_lb_InstallerBasic);
                             lib_common.gettingStarted();
                             lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);
                             Log.Message("End Step 6");
                     }
              }
              //return user defaut : Expert
              changeUserRole ( lib_label.const_lb_InstallerExpert,false);
              Log.PopLogFolder();
}

/*
function changeAllUserRole_NOTCONNECT_Device (isConnectingDevice)
{
    // set  UserRoleDefault_Is_InstallerBasic
    Log["Message"]( "Step 0 : set  UserRoleDefault_Is_InstallerBasic ")
    if (setUserRoleDefault_Is_InstallerBasic() == lib_err.err_FUNC_FAILED)
          return;         
    for ( var i = 1; i <= 3; i++)
    {
          //const_lb_InstallerBasic          
          if (i == 1)
          {
              Log["Message"]( "Step" + i + " : from InstallerBasic to UserBasic & InstallerExpert");
              if( changeUserRole ( lib_label.const_lb_UserBasic,isConnectingDevice))
              {                        
                     verifyConnectDevice(lib_label.const_lb_UserBasic);                        
//                     Log["Message"]("Step" + i +"-------------------------------------");
                     Log["Message"]("@@@@ 1.1: Installer to UserBasic");
              }
              if (changeUserRole ( lib_label.const_lb_InstallerExpert,isConnectingDevice))
              {
                     verifyConnectDevice(lib_label.const_lb_InstallerExpert);
                     //OPEN JOB DEFAULT
                     lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);   
                     verifyConnectingDevice(lib_label.const_lb_InstallerExpert);
                     lib_common.gettingStarted();
                     lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);
//                     Log["Message"]("Step" + i +"-------------------------------------");
                     Log["Message"]("@@@@ 2.4: UserBasic to Expert");
              }
          }
      
          if (i == 2)
          {
              Log["Message"]( "Step" + i + " : from InstallerExpert to InstallerBasic& UserBasic");
              if (changeUserRole ( lib_label.const_lb_InstallerBasic,isConnectingDevice))             
              {
                     verifyConnectDevice(lib_label.const_lb_InstallerBasic);
                     //OPEN JOB DEFAULT
                     lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);   
                     verifyConnectingDevice(lib_label.const_lb_InstallerBasic);
                     lib_common.gettingStarted();
                     lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);
//                     Log["Message"]("Step" + i +"-------------------------------------");
                     Log["Message"]("@@@@ 3.5: Expert to InstallerBasic");
              }
              if( changeUserRole ( lib_label.const_lb_UserBasic,isConnectingDevice))
              {
                     verifyConnectDevice(lib_label.const_lb_UserBasic);                        
//                     Log["Message"]("Step" + i +"-------------------------------------");
              }         
          }
         if (i == 3)
          {
             Log["Message"]( "Step" + i +"Step" + i + " : from UserBasic to InstallerBasic& InstallerExpert");
             if( changeUserRole ( lib_label.const_lb_InstallerBasic,isConnectingDevice))
             {
                     verifyConnectDevice(lib_label.const_lb_InstallerBasic);
                     //OPEN JOB DEFAULT
                     lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);   
                     verifyConnectingDevice(lib_label.const_lb_InstallerBasic);
                     lib_common.gettingStarted();
                     lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);
                     Log["Message"]("@@@@ 2.3:   UserBasic to InstallerBasic");
//                     Log["Message"]("Step" + i +"-------------------------------------");
                     
              }          
             if( changeUserRole ( lib_label.const_lb_InstallerExpert,isConnectingDevice))
             {
                     verifyConnectDevice(lib_label.const_lb_InstallerExpert);
                     //OPEN JOB DEFAULT
                     lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);   
                     verifyConnectingDevice(lib_label.const_lb_InstallerExpert);
                     lib_common.gettingStarted();
                     lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);
//                     Log["Message"]("Step" + i +"-------------------------------------");
                     Log["Message"]("@@@@ 1.2: InstallerBasic to Expert");
              } 
             if( changeUserRole ( lib_label.const_lb_UserBasic,isConnectingDevice))
             {
                     verifyConnectDevice(lib_label.const_lb_UserBasic);
                     Log["Message"]("@@@@ 3.6: Expert user Basic");
                     
              } 
          }
    }
     
}
*/




/**
  *@function
  *@param {String} userRole
  *@param {boolean} isConnectingDevice
*/
function changeUserRole (userRole, isConnectingDevice)
{
       Log.AppendFolder("func: changeUserRole");
       var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
       IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();   
       if (getUserRoleCurrent() !=  userRole )    
       {      
           IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_User + "|" + userRole);
           Log["Message"]("changeUserRole: " + userRole);
           if (isConnectingDevice == true && userRole == lib_label.const_lb_UserBasic)
           {
           
                if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_2000).Exists)
                {
                     //US_126               
                     aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "Text", cmpEqual, lib_label.const_ChangeUserBasic);
                     Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton();
                } 
           }           
           //verify change user -- US_001
           var proArr = ["ClrClassName", "ToolTip" ];
           var valArr = ["Button" , "Change User"];
           var bttChangeUser = Sys.Process("DL.CODE").FindChild(proArr, valArr, 2000);           
           if (bttChangeUser.Exists)
           {
                 bttChangeUser.ClickButton();
                 var index;
                 if (userRole == lib_label.const_lb_InstallerBasic)
                    index = 1;
                    
                 if (userRole == lib_label.const_lb_InstallerExpert)
                    index = 2;
                 
                 if (userRole == lib_label.const_lb_UserBasic)
                    index = 3; 
                  
                 aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1).WPFObject("MenuItem", userRole, index), "Enabled", cmpEqual, false);
//                 var proLblArr = [ "ClrClassName", "WPFControlText"];
//                 var valLblArr = [ "MenuItem" , userRole];                     
//                 var label = Sys.Process("DL.CODE").FindChild(proArr, valArr, 2000);                      
//                 if (Sys.Process("DL.CODE").FindChild(proArr, valArr, 2000).Exists)
//                       aqObject.CheckProperty(label, "Enabled", cmpEqual, false);
                     
            }
           Log.PopLogFolder();
           return true;
       } 
       else
       {
            Log.PopLogFolder();
            return false;
       }  
}

 
/**
  *@function
  *@param {String} userRole 
*/ 
function verifyConfigurationPanel (userRole)//add 1.5.0
{
        Log.AppendFolder("func: verifyConfigurationPanel");
        //US_05, US_21
        var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("AdvancedSetupJobContent", "", 1);
        if (userRole == lib_label.const_lb_InstallerExpert)
        {
                lib_button.clickAdvancedSetup();
                
                aqObject.CheckProperty(path.WPFObject("AddIarActionButton", "", 1)   ,  "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("Add1DecoderTool", "", 1)   ,  "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("Add2DecoderTool", "", 1)   ,  "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("AddPostalToolDecoder", "", 1)   ,  "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("AddFilterActionButton", "", 1)   ,  "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("DeleteToolActionButton", "", 1)   ,  "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("CodeAutolearnActionButton", "", 1)   ,  "Enabled", cmpEqual, true);   
        }
        if (userRole == lib_label.const_lb_InstallerBasic)
        { 
        
                aqObject.CheckProperty(path.WPFObject("AddIarActionButton", "", 1)   ,  "Enabled", cmpEqual, false);                
                aqObject.CheckProperty(path.WPFObject("Add1DecoderTool", "", 1)   ,  "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("Add2DecoderTool", "", 1)   ,  "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("AddPostalToolDecoder", "", 1)   ,  "Enabled", cmpEqual, true);                
                aqObject.CheckProperty(path.WPFObject("AddFilterActionButton", "", 1)   ,  "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("DeleteToolActionButton", "", 1)   ,  "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("CodeAutolearnActionButton", "", 1)   ,  "Enabled", cmpEqual, true);
                
                aqObject.CheckProperty(path.WPFObject("AddIarActionButton", "", 1)   ,  "Visible", cmpEqual, false);  
                aqObject.CheckProperty(path.WPFObject("AddPostalToolDecoder", "", 1)   ,  "Visible", cmpEqual, false);
        } 
        Log.PopLogFolder();
}




//updated 1.5.0
/**
  *@function
  *@param {String} userRole 
*/
function verifyConnectDevice(userRole)
{
 
        Log.AppendFolder("func: verifyConnectDevice");
        if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl")["WaitWPFObject"]("LayoutRoot", lib_const.const_delay_1000).Exists)  
        {
              var path =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1);
              var ivsToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar");    
              if (userRole == lib_label.const_lb_InstallerExpert)
              {      
        
                     //verify Task Selection 
                     aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_OpenDeviceConfiguration , 1), "Enabled", cmpEqual, true);
              
                     if(  lib_deviceInfo.const_Device_Model == lib_const.const_M300 || 
                          lib_deviceInfo.const_Device_Model == lib_const.const_M410 || 
                          lib_deviceInfo.const_Device_Model == lib_const.const_M450 )
                     {
                          aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork ).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_SetupInternalNetworkConfiguration , 1), "Enabled", cmpEqual, true);               
                          aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PackTrack).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_PackTrackCalibration , 1), "Enabled", cmpEqual, true);
                          aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                     }
                     if(  lib_deviceInfo.const_Device_Model == lib_const.const_M210 )
                     {
                         aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_SetupInternalNetworkConfiguration , 1), "Enabled", cmpEqual, true);
                         aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 1).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                     }

                     if(  lib_deviceInfo.const_Device_Model == lib_const.const_M120 )
                     {
                         aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 2).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                     } 
               
                      //verify iconToolbar
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenFromPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveInTemp).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                      if (lib_deviceInfo.const_Device_Model == lib_const.const_M300 ||
                          lib_deviceInfo.const_Device_Model == lib_const.const_M410 ||
                          lib_deviceInfo.const_Device_Model == lib_const.const_M450    )
                             aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                      //verify icon's Configuration Panel
                
                
              }
              if (userRole == lib_label.const_lb_InstallerBasic)
              {       
                     //verify Task Selection 
                    aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_OpenDeviceConfiguration).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_OpenDeviceConfiguration , 1), "Enabled", cmpEqual, true);
                
                    if(   lib_deviceInfo.const_Device_Model == lib_const.const_M300 || 
                          lib_deviceInfo.const_Device_Model == lib_const.const_M410 || 
                          lib_deviceInfo.const_Device_Model == lib_const.const_M450    )
                     {
                          aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_SetupInternalNetworkConfiguration , 1), "Enabled", cmpEqual, false);
                          aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PackTrack).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_PackTrackCalibration , 1), "Enabled", cmpEqual, true);
                          aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                     }
                
                     if(  lib_deviceInfo.const_Device_Model == lib_const.const_M210 )
                     {
                         aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_SetupInternalNetworkConfiguration , 1), "Enabled", cmpEqual, false);           
                         aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 1).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                     } 
               
                     if(  lib_deviceInfo.const_Device_Model == lib_const.const_M120 )
                     {
                         aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 2).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                     } 
                      //verify iconToolbar
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenFromPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveInTemp).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                      if (lib_deviceInfo.const_Device_Model == lib_const.const_M300 ||
                          lib_deviceInfo.const_Device_Model == lib_const.const_M410 ||
                          lib_deviceInfo.const_Device_Model == lib_const.const_M450 )
                      {
                        aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                      }
               
              }
        
              if (userRole == lib_label.const_lb_UserBasic)
              {     
                    Log.Message("US_126,US_127,US_128,US_129,US_130,US_131,US_132,US_133,US_134"); 
                    //verify Task Selection 
                    aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", lib_const.const_treeview_OpenDeviceConfiguration).WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_OpenDeviceConfiguration , 1), "Enabled", cmpEqual, false);
               
                    if (  lib_deviceInfo.const_Device_Model == lib_const.const_M300 ||
                          lib_deviceInfo.const_Device_Model == lib_const.const_M410 ||
                          lib_deviceInfo.const_Device_Model == lib_const.const_M450)
                     {
                          //US_129              
                          aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_SetupInternalNetworkConfiguration , 1), "Enabled", cmpEqual, false);
                          aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_PackTrack).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_PackTrackCalibration , 1), "Enabled", cmpEqual, false);
                          //US_127
                          aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                     }
                     if(  lib_deviceInfo.const_Device_Model == lib_const.const_M210 )
                     {
                          aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_SetupInternalNetworkConfiguration , 1), "Enabled", cmpEqual, false);
                          //US_127
                          aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor -1).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                     }

                     if(  lib_deviceInfo.const_Device_Model == lib_const.const_M120 )
                     {
                         //US_127
                         aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor-2).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                     } 
               
                     //verify iconToolbar
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    //US_128 & US_131      
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    //US_133
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    //US_130
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenFromPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    //US_132
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    //US_134
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveInTemp).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    if (lib_deviceInfo.const_Device_Model == lib_const.const_M300 ||lib_deviceInfo.const_Device_Model == lib_const.const_M410 ||lib_deviceInfo.const_Device_Model == lib_const.const_M450)
                    {
                      aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    }   
              }
        } 
        Log.PopLogFolder();
}
 

//updated 1.5.0
/**
  *@function
  *@param {String} userRole 
*/
function verifyConnectingDevice(userRole)
{
    
    Log.AppendFolder( "func: verifyConnectingDevice") ;    
    if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2)["WaitWPFObject"]("CollapsedExpander", lib_const.const_delay_1000).Exists)
    {    
          //focus on Advance Setup  
          lib_button.clickAdvancedSetup();
          var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("AdvancedSetupJobContent", "", 1);
                                                                                                                                                               
          var ivsToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar");
          if (userRole == lib_label.const_lb_InstallerExpert)
          {
                aqObject.CheckProperty(path.WPFObject("AddIarActionButton", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("Add1DecoderTool", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("Add2DecoderTool", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("AddPostalToolDecoder", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("AddFilterActionButton", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("DeleteToolActionButton", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("CodeAutolearnActionButton", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                
                //verify iconToolbar
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenFromPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveInTemp).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                if (lib_deviceInfo.const_Device_Model == lib_const.const_M300)
                  aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                if (lib_deviceInfo.const_Device_Model == lib_const.const_M410)
                  aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                 
                    
                //verify Configuration Panel
                verifyConfigurationPanel (userRole);
                  
                  
                
          }
          if (userRole == lib_label.const_lb_InstallerBasic)//US_152
          {
                //US_05         
                aqObject.CheckProperty(path.WPFObject("AddIarActionButton", "", 1), "Visible", cmpEqual, false);
                aqObject.CheckProperty(path.WPFObject("Add1DecoderTool", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("Add2DecoderTool", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                //US_21
                aqObject.CheckProperty(path.WPFObject("AddPostalToolDecoder", "", 1), "Visible", cmpEqual, false);
                aqObject.CheckProperty(path.WPFObject("DeleteToolActionButton", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(path.WPFObject("CodeAutolearnActionButton", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                
                //verify iconToolbar
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenFromPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveInTemp).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                if (lib_deviceInfo.const_Device_Model == lib_const.const_M300)
                  aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                if (lib_deviceInfo.const_Device_Model == lib_const.const_M410)
                  aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                //verify Configuration Panel
                verifyConfigurationPanel (userRole);
                //US_51           
                 lib_button.clickReadingPhase();
                 if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("OperatingModeJobContent", "", 1).WaitWPFObject("AddFieldbusActionButton", "", lib_const.const_delay_1000).Exists)
                 {
                        var btt = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("OperatingModeJobContent", "", 1).WaitWPFObject("AddFieldbusActionButton", "",1);
                        if (btt.Enabled == true && btt.Visible == true) 
                              Log.Warning("US_51: false");
                 }
                                  
          }     
          //US_06 (both Installer Basic and Expert)
          lib_button.ui_PlayAndPause(2000, false);         
    }
    Log.PopLogFolder();
}




/**
  *@function 
  *@param {boolean} isConnectingDevice
*/
function changeAllUserRole_CONNECTING_Device (isConnectingDevice)//updated 1.5.0
{
  
    Log.AppendFolder("func: changeAllUserRole_CONNECTING_Device");
    if (setUserRoleDefault_Is_InstallerBasic() == lib_err.err_FUNC_FAILED)
            return;     
    for ( var i = 1; i <= 2; i++)
    {
          //const_lb_InstallerBasic 
          if (i == 1)
          {
              Log["Message"]( "Step" + i + " : from InstallerBasic to UserBasic & InstallerExpert");                 
              if (changeUserRole ( lib_label.const_lb_InstallerExpert,isConnectingDevice))
              {                         
                     verifyConnectingDevice(lib_label.const_lb_InstallerExpert); 
              }
              if( changeUserRole ( lib_label.const_lb_UserBasic,isConnectingDevice))
              {
                     lib_common.gettingStarted();
                     lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);                                                  
                     verifyConnectDevice(lib_label.const_lb_UserBasic);
                     setUserRoleDefault_Is_InstallerExpert();
                     lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y); 
              }
          }
         
          if (i == 2)
          {
             Log["Message"]( "Step" + i + " : from InstallerExpert to InstallerBasic& const_lb_UserBasic");
             if( changeUserRole ( lib_label.const_lb_InstallerBasic,isConnectingDevice))
             {
                     verifyConnectingDevice(lib_label.const_lb_InstallerBasic);    
              }          
             if( changeUserRole ( lib_label.const_lb_UserBasic,isConnectingDevice))
             {
                     lib_common.gettingStarted();
                     lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);                                                  
                     verifyConnectDevice(lib_label.const_lb_UserBasic);
                     setUserRoleDefault_Is_InstallerExpert(); 
             }         
          }     
    }
    Log.PopLogFolder(); 
 } 
 
 
 /**
  *@function 
*/
 function verifyInstallerBasic_old()
 {
       Log.AppendFolder("func: verifyInstallerBasic_old");
//       US_12 - US_13 -77  can open job, change to monitor mode and save on device
       if ( !isGettingStartedScreen())
       {
              gettingStarted();
              Sys.Process("DL.CODE").Refresh(); 
       }       
       if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
       {
          if (lib_UserRole.getUserRoleCurrent() != lib_label.const_lb_InstallerBasic)
              changeUserRole(lib_label.const_lb_InstallerBasic , false);      
          if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y, lib_const.const_isOpenViaButton_Y) == true)
          {      
          
                var dlCode = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot");
                //***US_12
                Log.Message(" //***US_12");             
                lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N , lib_SaveJob.randomJobName(), lib_const.const_isDefaultJob_Y , lib_const.isMonitorMode_N);
                //***US_14  
                Log.Message(" //***US_14");           
                dlCode.WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JcmExpanderUserControl").WPFObject("Grid", "", 1).WPFObject("StepsPanelScrollViewer").WPFObject("Grid", "", 1).WPFObject("border").WPFObject("Grid", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("ExpanderStepSubItemButton", "", 1).Click();
                if(dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("ImageParametersJobContent", "", 1).WPFObject("AddIarActionButton", "", 1).WaitWPFObject("Image", "", lib_const.const_delay_1000).Exists)
                    Log.Error(lib_err.msg_ERR_Installer_Basic_Add_IMG_Setting);
                if (dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("ImageParametersJobContent", "", 1).WPFObject("DeleteIarActionButton", "", 1).WaitWPFObject("Image", "", lib_const.const_delay_1000).Exists)     
                    Log.Error(lib_err.msg_ERR_Installer_Basic_Delete_IMG_Setting);
                //***US_15    
                Log.Message(" //***US_15");   
                dlCode.WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JcmExpanderUserControl").WPFObject("Grid", "", 1).WPFObject("StepsPanelScrollViewer").WPFObject("Grid", "", 1).WPFObject("border").WPFObject("Grid", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("ExpanderStepSubItemButton", "", 1).Click();
                dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("ControlJobContent", "", 1).WPFObject("Add1DecoderTool", "", 1).WPFObject("Image", "", 1).Click();
                Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1).WPFObject("MenuItem", "CODE128", 3).Click();               
                aqObject.CheckProperty(dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("ControlJobContent", "", 1).WPFObject("Add1DecoderTool", "", 1), "Enabled", cmpEqual, false);
                aqObject.CheckProperty(dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("ControlJobContent", "", 1).WPFObject("Add2DecoderTool", "", 1), "Enabled", cmpEqual, false);
                // US 18-19-20-21  
                Log.Message(" //***US 18-19-20-21");                 
                dlCode.WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JcmExpanderUserControl").WPFObject("Grid", "", 1).WPFObject("StepsPanelScrollViewer").WPFObject("Grid", "", 1).WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("ExpanderStepSubItemButton", "", 1).Click();                
                aqObject.CheckProperty( dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("ResultAnalysisJobContent", "", 1).WPFObject("AddCollectionActionButton", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty( dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("ResultAnalysisJobContent", "", 1).WPFObject("AddParcelActionButton", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty( dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("ResultAnalysisJobContent", "", 1).WPFObject("AddPresentationActionButton", "", 1), "Enabled", cmpEqual, true);
                aqObject.CheckProperty( dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("ResultAnalysisJobContent", "", 1).WPFObject("AddMatchCodeActionButton", "", 1), "Enabled", cmpEqual, true);
                //US-23
                Log.Message(" //***US_23"); 
                dlCode.WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JcmExpanderUserControl").WPFObject("Grid", "", 1).WPFObject("StepsPanelScrollViewer").WPFObject("Grid", "", 1).WPFObject("Border", "", 4).WPFObject("Grid", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("ExpanderStepSubItemButton", "", 1).Click();
                aqObject.CheckProperty(dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("DataFormattingJobContent", "", 1).WPFObject("AddFieldbusActionButton", "", 1), "Visible", cmpEqual, false);
                //US 22
                Log.Message(" //***US_22"); 
                lib_DataFormating.DF_AddImageSaving(11);
                //US 23
                Log.Message(" //***US_23"); 
                lib_DataFormating.DF_AddAllChannel();
                //US_24
                Log.Message(" //***US_24"); 
                aqObject.CheckProperty(dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("DataFormattingJobContent", "", 1).WPFObject("AddFieldbusActionButton", "", 1), "Visible", cmpEqual, false);
                //US_17
                Log.Message(" //***US_16"); 
                dlCode.WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JcmExpanderUserControl").WPFObject("Grid", "", 1).WPFObject("StepsPanelScrollViewer").WPFObject("Grid", "", 1).WPFObject("Border", "", 4).WPFObject("Grid", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("ExpanderStepSubItemButton", "", 1).Click();
                lib_ReadingPhase.RP_AddAllChannel();
                //US_18      
                Log.Message(" //***US_17");           
                aqObject.CheckProperty(dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("OperatingModeJobContent", "", 1).WPFObject("AddFieldbusActionButton", "", 1), "Visible", cmpEqual, false);
                 //US_25
                Log.Message(" //***US_25");                 
                dlCode.WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JcmExpanderUserControl").WPFObject("Grid", "", 1).WPFObject("StepsPanelScrollViewer").WPFObject("Grid", "", 1).WPFObject("Border", "", 4).WPFObject("Grid", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("ExpanderStepSubItemButton", "", 1).Click();
                lib_OutputSetup.OS_AddAllChannel();
                //US_26     
                Log.Message(" //***US_26");   
                aqObject.CheckProperty(dlCode.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("OutputConfigurationJobContent", "", 1).WPFObject("AddFieldbusActionButton", "", 1), "Visible", cmpEqual, false);
                 
                 //***US_13
                Log.Message(" //***US_15"); 
                lib_common.changeToMonitorMode();
                //***US_77
                Log.Message(" //***US_77"); 
                lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N , lib_SaveJob.randomJobName(), lib_const.const_isDefaultJob_Y , lib_const.isMonitorMode_Y);
            
          } 
 
       }
       Log.PopLogFolder();
 }
 
 function initUISetting_UserRole ()
{
      Log.AppendFolder("func: initUISetting_UserRole");
      if ( ! lib_validate["isDLCODERunning"]() || lib_validate.isUnExpectedWindowExists())
           lib_common["launchUI"]();  
      try
      {
          if (getUserRoleCurrent()!= lib_label.const_lb_InstallerExpert)
          {
              changeUserRole(lib_label.const_lb_InstallerExpert , false ); 
          }
//          lib_common.terminateUI();
          
      }
      catch (e)
      { 
          return lib_err.err_FUNC_EXCEPTION;
      }
      Log.PopLogFolder();
}

/**
  *@function 
*/
function getUserRoleCurrent ()
{
        Log.AppendFolder("func: getUserRoleCurrent"); 
        var userRoleDefault ;
        var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
        IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();              
        IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_User); 
        //var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
          
        if (Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+lib_label.const_lb_InstallerBasic+"", 1).IsChecked == true)
        {
             userRoleDefault = lib_label.const_lb_InstallerBasic;                     
        }
        if (Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+lib_label.const_lb_InstallerExpert+"", 2).IsChecked == true)
        {
             userRoleDefault = lib_label.const_lb_InstallerExpert;  
        }
        if (Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+lib_label.const_lb_UserBasic+"", 3).IsChecked == true)
        {
             userRoleDefault = lib_label.const_lb_UserBasic;    
        }
        Log.PopLogFolder();
        return userRoleDefault;
}

/**
  *@function 
*/
function setUserRoleDefault_Is_InstallerBasic ()
{
        Log.AppendFolder("func: setUserRoleDefault_Is_InstallerBasic");
        var flag = lib_err.err_FUNC_FAILED;
        var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
        IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();      
        IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_User); 
        var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
          
        if (subPath.WPFObject("MenuItem", ""+lib_label.const_lb_InstallerBasic+"", 1).IsChecked != true)
        {
              IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_User  + "|" + lib_label.const_lb_InstallerBasic); 
              flag = lib_err.err_FUNC_SUCCESS;     
        }
        else 
             flag = lib_err.err_FUNC_SUCCESS;   
        Log.PopLogFolder();  
        return flag ;
}


/**
  *@function 
*/
function verifyUserBasic()// add 1.5.0
{
       Log.AppendFolder("func: verifyUserBasic");
       if ( !isGettingStartedScreen())
             gettingStarted();
       if (lib_UserRole.getUserRoleCurrent() != lib_label.const_lb_UserBasic)
             changeUserRole(lib_label.const_lb_UserBasic , false);   
       try
       {
             if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
             {
                   var path =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1);
                   //US_41
                   aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_OpenDeviceConfiguration , 1), "Enabled", cmpEqual, false);
                   //US_42
                   aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 2).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_SetupInternalNetworkConfiguration , 1), "Enabled", cmpEqual, false);
               
                   if(  lib_deviceInfo.const_Device_Model == lib_const.const_M300 )
                   {
                        aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 3).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_PackTrackCalibration , 1), "Enabled", cmpEqual, false);
                        aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 4).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                   }
                   if(  lib_deviceInfo.const_Device_Model == lib_const.const_M410 )
                   {
                        aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 3).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_PackTrackCalibration , 1), "Enabled", cmpEqual, false);
                        aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 4).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                   }
                   if(  lib_deviceInfo.const_Device_Model == lib_const.const_M210 )
                   {
                       aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 3).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                   }

                   if(  lib_deviceInfo.const_Device_Model == lib_const.const_M120 )
                   {
                       aqObject.CheckProperty(path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 3).WPFObject("Bd").WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1), "Enabled", cmpEqual, true);
                   }
                   
                   
                   //US_43_44
                   var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu"); 
                   IvsMenu.WPFObject("MenuItem",lib_label.const_lb_File, 1).Click();                   
                   aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_File_Open +"", 2), "Enabled", cmpEqual, false);              
                   aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("MenuItem", ""+ lib_label.const_lb_File_Save +"", 3), "Enabled", cmpEqual, false);
                   
                   //US_45-46-47                    
                   if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1)["WaitWPFObject"]("IvsToolBar", lib_const.const_delay_1000).Exists)
                   {
                        var ivsToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar");
                        aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_GettingStarted).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, true);
                        aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_FindDevices).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                    
                        aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                        aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                        aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_OpenFromPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                        aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                        aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_SaveInTemp).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                        aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                        if (lib_deviceInfo.const_Device_Model == lib_const.const_M300)
                          aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);
                        if (lib_deviceInfo.const_Device_Model == lib_const.const_M410)
                          aqObject.CheckProperty(ivsToolbar.WPFObject("ContentPresenter", "", lib_const.const_btt_PackTrack).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1), "Enabled", cmpEqual, false);                
                   }    
                   
                   //US_49
//                   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu").WPFObject("MenuItem",lib_label.const_lb_Device, 3).Click();   
//                   var path1 = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);             
//                   aqObject.CheckProperty(path1.WPFObject("MenuItem", ""+ lib_label.const_lb_UpdatePackage+"", 4), "Enabled", cmpEqual, false);
                   //US_50-51-52-53
                   IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Settings);
                   var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
                   aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_Settings +"", 1), "Enabled", cmpEqual, false);
                   aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ConfigurationSettings +"", 2), "Enabled", cmpEqual, false);
                   aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ResetStatistics +"", 3), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(subPath.WPFObject("MenuItem", ""+ lib_label.const_lb_ResetDiagnostics +"", 4), "Enabled", cmpEqual, true);
                   //US_54-55
                   IvsMenu.WPFObject("MenuItem",lib_label.const_lb_File, 1).Click();
                   IvsMenu.WPFMenu.Click(lib_label.const_lb_File +"|" + lib_label.const_lb_File_Monitor);
                   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("TabItem", "Statistics", 2).Click();
                   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StatisticsModeButton", "", 1).WPFObject("Image", "", 1).Click();                   
                   aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1).WPFObject("MenuItem", "Session", 1), "Enabled", cmpEqual, true);
                   aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1).WPFObject("MenuItem", "Absolute", 2), "Enabled", cmpEqual, true);        
               
                           
               
             }              
       }
       catch(e)
       {
               return lib_err.err_FUNC_EXCEPTION;
       }
       Log.PopLogFolder();
}

/**
  *@function 
*/
function setUserRoleDefault_Is_InstallerExpert ()
{
        Log.AppendFolder("func: setUserRoleDefault_Is_InstallerExpert");
        var flag = lib_err.err_FUNC_FAILED;
        var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");
        IvsMenu.WPFObject("MenuItem", lib_label.const_lb_Options  , 2).Click();      
        IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_User); 
        var subPath = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1);
          
        if (subPath.WPFObject("MenuItem", ""+lib_label.const_lb_InstallerExpert+"", 2).IsChecked != true)
        {
              IvsMenu.WPFMenu.Click(lib_label.const_lb_Options + "|" + lib_label.const_lb_Options_Change_User  + "|" + lib_label.const_lb_InstallerExpert); 
              flag = lib_err.err_FUNC_SUCCESS;     
        }
        else 
             flag = lib_err.err_FUNC_SUCCESS;     
        Log.PopLogFolder();
        return flag ;
} 

function testcaseChangeUserRoleToExpert()
{
  aqTestCase.Begin("testcaseChangeUserRoleToExpert");
  lib_common.launchUI();
  changeUserRole(lib_label.const_lb_InstallerExpert, false);
  aqTestCase.End();
}