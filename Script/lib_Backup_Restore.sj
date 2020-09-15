//USEUNIT lib_ChangeIP
//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_DeviceSelectedDetail
//USEUNIT lib_JobList
//USEUNIT lib_OpenJob
 

/*
  *@function
  *@param path{String}
  *@param fileName{String}
*/
function restoreCluster (path, fileName)
{
    var flag = false;		
//		try
//		{
            var IvsMenu =Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 2)["WPFObject"]("Grid", "", 1)["WPFObject"]("IvsMenu"); 
           	IvsMenu["WPFObject"]("MenuItem",lib_label.const_lb_Device, 3).Click();	  			           
            IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Backup_Restore + "|" + lib_label.const_lb_InternalNetworkReplacement);
            Delay(lib_const.const_delay_3000);            
            if (Objects.dlgOpen.Check(Sys.Process("DL.CODE").Window("#32770", "Open", 1)))
            {
                      //input path    
                      var editBar =    Sys.Process("DL.CODE").Window("#32770", "Open", 1).Window("ComboBoxEx32", "", 1).Window("ComboBox", "", 1).Window("Edit", "", 1)   ;  
                      editBar.setText(path + "\\" + fileName );
                      editBar.Keys("[Enter]");
                      if (Sys.Process("DL.CODE").WaitWindow("#32770", "Open", 1, 1000).Exists)
                      {
                               aqObject.CheckProperty(Sys.Process("DL.CODE").Window("#32770", "Open", 1).Window("Static", "*", 2), "WndCaption", cmpContains, "Verify that the file name is correct.");                              
                               Sys.Process("DL.CODE").Window("#32770", "Open", 1).Window("Button", "OK", 1).ClickButton();
                               Sys.Process("DL.CODE").Window("#32770", "Open", 1).Window("Button", "Cancel", 2).ClickButton();
                               return flag;
                      }
                           
            }
            
            Delay(lib_const.const_delay_3000);
            if (lib_validate.isUnExpectedWindow() == true)
                  return flag;
                  
            if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", lib_const.const_delay_1000).Exists)
            {                   
                   var resultTxt = Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText").Text;
                   //backup success 
                   if ( resultTxt == "Internal Network Replacement failed. ")
                    {
                         aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "Text", cmpEqual,"Internal Network Replacement failed. ");
                         Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton(); 
                         return flag;
                    }       
                   
                    if ( resultTxt == lib_label.const_Restore_BM100_SUCCESS )
                    {
                         aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Restore_BM100_SUCCESS);
                         delay (10000);
                         Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();
//                         while (findDeviceInGettingStarted()== false)
//                              delay (3000);
                         if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
                                  aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_ProgressBar_Comminicating);
             
                         flag = true;
                         
//                         aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual,"Do you want to save this configuration?");
//                         delay (40000);
                    }
                    if ( resultTxt == lib_label.const_Device_Attention )
                    {
                         if (aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Device_Attention ))
                               Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();                        
                         flag = true; 
                    }
                    
             } 
           
  		
//		}catch(e)
//		{
//		   return lib_err.err_FUNC_EXCEPTION;
//		}			
    Log.Message("singleReaderRestore:" + flag);
    if (flag == true)
          //return backup File to ""
          lib_deviceInfo.backupFile = "";
		return flag; 
}

/*
  *@function
  *@param path{String}
  *@param fileName{String}
*/

function backupCluster (path, fileName)
{
    var flag = false;		
//		try
//		{
            var IvsMenu =Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 2)["WPFObject"]("Grid", "", 1)["WPFObject"]("IvsMenu"); 
           	IvsMenu["WPFObject"]("MenuItem",lib_label.const_lb_Device, 3).Click();	  			           
            IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Backup_Restore + "|" + lib_label.const_lb_BackupCurrentInternalNetworkConfigurations);
            Delay(lib_const.const_delay_2000);
            
            if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window",1000).Exists)
            {
               var txt = Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText").WPFControlText;
               if (txt == const_Confirm_Backup) 
                    Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton();
            }
            
            if (Objects.dlgSaveAs.Check(Sys.Process("DL.CODE").Window("#32770", "Save As", 1)))
            {
                      //input path    
                        
                      var editBar =  Sys.Process("DL.CODE").Window("#32770", "Save As", 1).Window("DUIViewWndClassName", "", 1).UIAObject("Explorer_Pane").Window("FloatNotifySink", "", 1).Window("ComboBox", "", 1).Window("Edit", "", 1);                           
                      editBar.setText(path + "\\" + fileName);
                      editBar.Keys("[Enter]");
                      if (Sys.Process("DL.CODE").WaitWindow("#32770", "Save As", 1, 1000).Exists)
                      {
                               aqObject.CheckProperty(Sys.Process("DL.CODE").Window("#32770", "Save As", 1).Window("Static", "*", 2), "WndCaption", cmpContains, "Do you want to replace it?");                              
                               Sys.Process("DL.CODE").Window("#32770", "Save As", 1).Window("Button", "&Yes", 1).ClickButton();
                      }
                           
            }
            
            Delay(lib_const.const_delay_3000);
            if (lib_validate.isUnExpectedWindow() == true)
                  return flag;
            
            if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window",1000).Exists) 
             {
                    var resultTxt = Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText").Text;
                    //backup success 
                    if ( resultTxt == lib_label.const_Backup_SUCCESS )
                    {
                         aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Backup_SUCCESS);
                         Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                         flag = true;
                    }
                    else // 
                    {
                         if (aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Device_Attention ))
                         {
                               Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();                        
                               flag = true; 
                         }
                    }
                    
             } 
           
  		
//		}catch(e)
//		{
//		   return lib_err.err_FUNC_EXCEPTION;
//		}			
    Log.Message("singleReaderRestore:" + flag);
    if (flag == true)
          //return backup File to ""
          lib_deviceInfo.backupFile = "";
		return flag; 
}

/*
  *@function
  *@param path{String}
  *@param fileName{String}
*/
function singleReaderRestore (path, fileName)
{
    var flag = false;		
		try
		{
            var IvsMenu =Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 2)["WPFObject"]("Grid", "", 1)["WPFObject"]("IvsMenu"); 
           	IvsMenu["WPFObject"]("MenuItem",lib_label.const_lb_Device, 3).Click();	  			           
            IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Backup_Restore + "|" + lib_label.const_lb_SingleReaderRestore);
            Delay(lib_const.const_delay_3000);
         
            var editBar = Sys.Process("DL.CODE").Window("#32770", "Open", "1").Window("ComboBoxEx32", "", 1).Window("ComboBox", "", 1).Window("Edit", "", 1);                            
            editBar.setText(path + "\\" + fileName );
            Log.Message( fileName);
            editBar.Keys("[Enter]");
            
            Delay(lib_const.const_delay_3000);
            if (lib_validate.isUnExpectedWindow() == true)
                  return flag;
            if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
            {                   
                   var resultTxt = Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText").Text;
                    //backup success 
                   if ( resultTxt == lib_label.const_IncompatibleModel )
                    {
                         aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_IncompatibleModel);
                         Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                         Log.Warning(lib_label.const_IncompatibleModel) ; 
                         flag = true;
                         return flag;
                    }                                                      
            } 
            if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
            {
                    aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_Restore_ProgressBar);
                    Log.Message("BR_12");
            }
            while (!Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
                    lib_const.const_delay_3000;
             if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
             {
                    var resultTxt = Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText").Text;
                    //backup success 
                    if ( resultTxt == lib_label.const_Restore_SingleReader_SUCCESS )
                    {
                         aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Restore_SingleReader_SUCCESS);
                         Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                         if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
                                  aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_ProgressBar_Comminicating);
             
                         flag = true;
                    }
                    else // 
                    {
                         if (aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Device_Attention ))
                          {
                               Log.Error(lib_label.const_Device_Attention);
                               Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                          }                         
                         flag =  false;
                    }
                    
             } 
           
  		
		}catch(e)
		{
		   return lib_err.err_FUNC_EXCEPTION;
		}			
    Log.Message("singleReaderRestore:" + flag);
    if (flag == true) 
          lib_deviceInfo.backupFile = "";
		return flag; 
}



/*
  *@function 
*/
function restoreFromExternalStorageDevice ()
{
		var flag = false;		
		try
		{
            var IvsMenu =Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 2)["WPFObject"]("Grid", "", 1)["WPFObject"]("IvsMenu"); 
           	IvsMenu["WPFObject"]("MenuItem",lib_label.const_lb_Device, 3).Click();	 
            IvsMenu.WPFMenu.Click(lib_label.const_lb_Device  +"|"+lib_label.const_lb_Backup_Restore +"|" + lib_label.const_lb_RestoreFromExternalStorageDevice);
            if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
            {        if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText").WPFControlText ==lib_label.const_BM100_NOTCONNECTED )
                     {
                           aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_BM100_NOTCONNECTED )
                           Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                           Log.Warning(lib_label.const_BM100_NOTCONNECTED) ; 
                           return lib_label.const_BM100_NOTCONNECTED;                           
                      }
             }             
             if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
                  aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Restore_BM100_ProgressBar);
             while (!Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
                        lib_const.const_delay_3000;
             if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
             {
                    var resultTxt = Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText").Text;
                    //backup success 
                    if ( resultTxt == lib_label.const_Restore_BM100_SUCCESS )
                    {
                         aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Restore_BM100_SUCCESS);
                         Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                         if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
                                  aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_ProgressBar_Comminicating);
             
                         flag = true;
                    }
                    else // 
                    {
                         if (aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Device_Attention ))
                               Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();                        
                         flag = true; 
                    }
                    
             } 
		}catch(e)
		{
		   return lib_err.err_FUNC_EXCEPTION;
		}			
		return flag; 
}


/*
  *@function
  *@param type{String} 
*/
function restoreDefault (type)
{

		var flag = false;		
		try
		{		
      var IvsMenu =Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 2)["WPFObject"]("Grid", "", 1)["WPFObject"]("IvsMenu"); 
     	IvsMenu["WPFObject"]("MenuItem",lib_label.const_lb_Device, 3).Click();	  			   
      
			if (type == lib_label.const_lb_RestoreDefaultEnvironment)
			{
             IvsMenu.WPFMenu.Click(lib_label.const_lb_Device  +"|"+lib_label.const_lb_Backup_Restore +"|" + lib_label.const_lb_RestoreDefaults+"|" + lib_label.const_lb_RestoreDefaultEnvironment);
             aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Restore_DefaultEnvironment );
             Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnYes").ClickButton();
             //verify progress bar
//             if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
//                  aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_ProgressBar_Comminicating);
             while (!Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
                        lib_const.const_delay_3000;
             if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
             {            
                      var resultTxt = Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText").Text;
                      //backup success 
                      if ( resultTxt == lib_label.const_Restore_SUCCESS )
                      {
                           aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Restore_SUCCESS);
                           Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton(); 
                           if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
                                  aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_ProgressBar_Comminicating);
            
                           flag = true;
                           while (findDeviceInGettingStarted()== false)
                              delay (3000);
                      }
                      else // 
                      {
                           if (aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Device_Attention ))
                                 Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                        
                           flag = true; 
                      }
              }
                  
			}

			if (type == lib_label.const_lb_RestoreDefaultStartupConfiguration)
			{
             IvsMenu.WPFMenu.Click(lib_label.const_lb_Device  +"|"+lib_label.const_lb_Backup_Restore +"|" + lib_label.const_lb_RestoreDefaults+"|" + lib_label.const_lb_RestoreDefaultStartupConfiguration);
             aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Restore_DefaultStartupConfiguration );
             Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnYes").ClickButton();
             //verify progress bar
             if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
                  aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_ProgressBar_Comminicating);
             while (!Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
                        lib_const.const_delay_3000;
             if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
             {            
                      var resultTxt = Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText").Text;
                      //backup success 
                      if ( resultTxt == lib_label.const_Restore_SUCCESS )
                      {
                           aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Restore_SUCCESS);
                           Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                           
                           if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
                                  aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_ProgressBar_Comminicating);
             
                           flag = true;
                          while (findDeviceInGettingStarted()== false)
                              delay (3000);
                      }
                      else // 
                      {
                           if (aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Device_Attention ))
                                 Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                          
                           flag = true; 
                      }
              }
			}
      
      if (type == lib_label.const_lb_RestoreFactoryDefaults)
			{
      
             IvsMenu.WPFMenu.Click(lib_label.const_lb_Device  +"|"+lib_label.const_lb_Backup_Restore +"|" + lib_label.const_lb_RestoreDefaults+"|" + lib_label.const_lb_RestoreFactoryDefaults);
             aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Restore_FactoryDefaults );
             Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnYes").ClickButton();
             //verify progress bar
             if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
                  aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_ProgressBar_Comminicating);
             while (!Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
                        lib_const.const_delay_3000;
             if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
             {            
                      var resultTxt = Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText").Text;
                      //backup success 
                      if ( resultTxt == lib_label.const_Restore_SUCCESS )
                      {
                           aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Restore_SUCCESS);
                           Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                           delay(10000);
                           if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
                                  aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_ProgressBar_Comminicating);             
                           flag = true;
                           while (findDeviceInGettingStarted()== false)
                              delay (3000);
                      }
                      else // 
                      {
                           if (aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Device_Attention ))
                                 Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                          
                           flag = true; 
                      }
              }
			}  
		}catch(e)
		{
		   return lib_err.err_FUNC_EXCEPTION;
		}	
    Log.Message("restore default : " + flag);		
		return flag; 
}


/*
  *@function
*/
function backupToExternalStorageDevice ()
{
		    var flag = false;		 
        var IvsMenu =Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 2)["WPFObject"]("Grid", "", 1)["WPFObject"]("IvsMenu"); 
       	IvsMenu["WPFObject"]("MenuItem",lib_label.const_lb_Device, 3).Click();	  			   
        IvsMenu.WPFMenu.Click(lib_label.const_lb_Device  +"|"+lib_label.const_lb_Backup_Restore +"|" + lib_label.const_lb_BackupToExternalStorageDevice); 
        
        aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Confirm_Backup );
        if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
        {
            //confirm 
            aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Confirm_Backup );
            Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnYes").Click();
            if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WaitWPFObject"]("BusyIndicator", "", lib_const.const_delay_1000).Exists)
            {
                  //verify progress bar
                  if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
                        aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_Backup_ProgressBar_EXT);
                  while (!Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
                        lib_const.const_delay_3000;
                  if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
                  {            
                          var resultTxt = Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText").Text;
                          //backup success 
                          if ( resultTxt == lib_label.const_Backup_SUCCESS )
                          {
                               aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Backup_SUCCESS);
                               Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton(); 
                               flag = true;
                          }
                          else // CB500 hasn't BM100
                          {
                               if (aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_BM100_NOTCONNECTED ))
                               Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                               Log.Warning(lib_label.const_BM100_NOTCONNECTED) ;
                               return false;
                          }
                  }
            }               
        }  
        Log.Message("backupToExternalStorageDevice: " + flag);
    		return flag; 
}


/*
  *@function
  *@param path{String}
  *@param fileName{String}
  *@param isIncludeFirmware{boolean}
*/
function singleReaderBackup ( path, fileName , isIncludeFirmware)
{
		var flag = false;		
		try
		{
            var IvsMenu =Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 2)["WPFObject"]("Grid", "", 1)["WPFObject"]("IvsMenu"); 
           	IvsMenu["WPFObject"]("MenuItem",lib_label.const_lb_Device, 3).Click();	  			           
            IvsMenu.WPFMenu.Click(lib_label.const_lb_Device +"|" + lib_label.const_lb_Backup_Restore + "|" + lib_label.const_lb_SingleReaderBackup);
            if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
            {
                //confirm
                aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Confirm_Backup );
                Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnYes").Click();
                if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
                {
                    aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Confirm_Backup_IncludeFirmware );
                    //include firmware
                    if (isIncludeFirmware == true)
                        Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton();
                    else
                        Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnNo").ClickButton();
                    //progress bar
//                    if (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
//                        aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1)["WPFObject"]("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.const_Device_Backup_ProgressBar);
                    //input path                    
//                    var fileName_random =  Sys.Process("DL.CODE").Window("#32770", "*", 1).Window("DUIViewWndClassName", "", 1)["UIAObject"]("Explorer_Pane").Window("FloatNotifySink", "", 1).Window("ComboBox", "", 1).Window("Edit", "", 1).wText;
                    //BR_11
                    while (Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Shell", const_firmware)["WPFObject"]("Shell", const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("BusyIndicator", "", 1).Visible == true)
                    {
                          delay (lib_const.const_delay_1000);
                          Log.Message("BR_11");
                    }
 
                    var time = lib_common.getDateTimeStr()
                    
                    var editBar = Sys.Process("DL.CODE").Window("#32770", "*", 1).Window("DUIViewWndClassName", "", 1)["UIAObject"]("Explorer_Pane").Window("FloatNotifySink", "", 1).Window("ComboBox", "", 1).Window("Edit", "", 1);  
                    editBar.setText(path + "\\" + fileName  +  time);
                    Log.Message(path + "\\" + fileName   +  time);
                    editBar.Keys("[Enter]");   
                    
                    lib_deviceInfo.backupFile = fileName  +  time; 
                    //update value to parameter
                    if (isIncludeFirmware == true)
                        lib_deviceInfo.const_BACKUP_fileName = lib_deviceInfo.backupFile;
                    else
                        lib_deviceInfo.const_BACKUP_fileName_noFW = lib_deviceInfo.backupFile;
                     
                 
                    var txtReplace = "\'"+ path + "\\" + fileName   + ".zip\' already exists.\r\nDo you want to replace it?";
                   
                    
                    if (Sys.Process("DL.CODE").WaitWindow("#32770", "Save As" , 1, lib_const.const_delay_1000).Exists)
                    {
                          if (Sys.Process("DL.CODE").Window("#32770", "Save As", 1).Window("Static", "*", 2).WndCaption == txtReplace)
                          {
                                Sys.Process("DL.CODE").Window("#32770", "Save As", 1).Window("Button", "&Yes", 1).ClickButton();
                          }
                    }
                    
                     
                    if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: Window", lib_const.const_delay_1000).Exists)
                    {
                          var resultTxt = Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText").Text;
                          //backup success 
                          if ( resultTxt == lib_label.const_Backup_SUCCESS )
                          {
                               aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Backup_SUCCESS);
                               Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton(); 
                               flag = true;
                          }
                          else // 
                          {
                               if (aqObject.CheckProperty(Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("MessageText"), "WPFControlText", cmpEqual,lib_label.const_Device_Attention ))
                               Sys.Process("DL.CODE")["WPFObject"]("HwndSource: Window")["WPFObject"]("Window")["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ButtonPanel")["WPFObject"]("btnOK").ClickButton();
                               Log.Warning(lib_label.const_Device_Attention) ;
                               flag = true; 
                          }
                    }                
                }
            } 
  		
		}catch(e)
		{
		   return lib_err.err_FUNC_EXCEPTION;
		}			
    Log.Message("singleReaderBackup:" + flag);
		return flag; 
}


/*
  *@function
  *@param jobListBefore{Array}
  *@param jobListAfter{Array} 
*/
function verifyRestoreDefaultStartupConfiguration (jobListBefore, jobListAfter)
{
      var flag = true;
      if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress)== lib_err.err_FUNC_SUCCESS)
      {        //verify startup job          
               var startupJob = lib_DeviceSelectedDetail.getNameStartUpJob();
               if (startupJob != lib_const.const_DefaultJob)
               {
                    flag = false;
                    Log.Warning(lib_messageLog.msg_JOB_NOT_DEFAULT);
               }else
                    Log.Message( "1. DefaultJob : OK "  );
               //verify JobList before & after
               if (lib_JobList.compare2JobList( jobListBefore, jobListAfter) ==false)
               {
                    flag = false;
                    Log.Warning(lib_messageLog.msg_COMPARE_JOBLIST_FAILED);
               }else
                    Log.Message( "2. Job List : OK "  );
      }
      return flag;
}

/*
  *@function
  *@param jobListBefore{Array} 
*/
function verifyRestoreDefaultEnvironment  (jobListBefore)
{
      var flag = true;
      var ip = lib_ChangeIP.getIP(lib_deviceInfo.const_Device_SerialNumber);
//      Log.Warning(ip);
      var array2 = new Array(); 
      if (ip != "" )
      {
              //verify IP    
              if (ip != lib_const.const_IPDefault )
                      Log.Warning(lib_messageLog.msg_NOT_IPDEFAULT);    
              else
                      Log.Message( "1. IP : OK "  );  
              delay(lib_const.const_delay_6000);
              //change ip to connect device
              if (lib_ChangeIP.changeStaticIP(lib_common.getDeviceIndex(lib_deviceInfo.const_Device_SerialNumber), lib_deviceInfo.const_Device_IP_Adress)== lib_err.err_FUNC_SUCCESS) 
              {
                     if (lib_ChangeIP.verifyChangeIP(lib_deviceInfo.const_Device_SerialNumber, lib_deviceInfo.const_Device_IP_Adress))
                     {
                            if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress)== lib_err.err_FUNC_SUCCESS)
                            {        //verify startup job     
                                     var startupJob = lib_DeviceSelectedDetail.getNameStartUpJob();
                                     if (startupJob != lib_const.const_DefaultJob)
                                     {
                                          flag = false;
                                          Log.Warning(lib_messageLog.msg_JOB_NOT_DEFAULT);
                                     }else
                                          Log.Message( "2. DefaultJob : OK "  );
                            }
                     }
              }
              
              // get job list after performing restore      
              if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
              {    
                      lib_button.clickOpenJobOnDevice();
                      array2 = lib_JobList.getJobList(); 
              } 
              //verify JobList before & after
               if (lib_JobList.compare2JobList( jobListBefore, array2) == false)
               {
                    flag = false;
                    Log.Warning(lib_messageLog.msg_COMPARE_JOBLIST_FAILED);
               }else
                      Log.Message( "3. Job List : OK "  );
      } else 
      {
              Log.Warning(lib_messageLog.msg_DEVICE_NOTFOUND);
              flag = false;
      }
      return flag;
} 

/*
  *@function 
*/
function verifyRestoreFactoryDefaults ()
{
      var flag = true;
      var ip = lib_ChangeIP.getIP(lib_deviceInfo.const_Device_SerialNumber);
      var array2 = new Array(); 
      if (ip != "" )
      {
              //verify IP    
              if (ip != lib_const.const_IPDefault )
                      Log.Warning(lib_messageLog.msg_NOT_IPDEFAULT);      
              else
                      Log.Message( "1. IP : OK "  );
              //change ip to connect device
              var index = lib_common.getDeviceIndex(lib_deviceInfo.const_Device_SerialNumber);
              if (lib_ChangeIP.changeStaticIP(index, lib_deviceInfo.const_Device_IP_Adress)== lib_err.err_FUNC_SUCCESS) 
              {
                     if (lib_ChangeIP.verifyChangeIP(lib_deviceInfo.const_Device_SerialNumber, lib_deviceInfo.const_Device_IP_Adress))
                     {
                            if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress)== lib_err.err_FUNC_SUCCESS)
                            {        //verify startup job     
                                     var startupJob = lib_DeviceSelectedDetail.getNameStartUpJob();
                                     if (startupJob != lib_const.const_DefaultJob)
                                     {
                                          flag = false;
                                          Log.Warning(lib_messageLog.msg_JOB_NOT_DEFAULT);
                                     }
                                     else
                                          Log.Message( "2. DefaultJob : OK "  );
                            } 
                     }
              }
              //verify job list
              if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress)=== lib_err.err_FUNC_SUCCESS)
              {    
                      lib_button.clickOpenJobOnDevice();
                      array2 = lib_JobList.getJobList();
              }
              if (array2.length > 1)// only default job
              {
                      flag = false;
                      Log.Warning(lib_messageLog.msg_COMPARE_JOBLIST_FAILED);
              }else
                      Log.Message( "3. Job List : OK "  );
      }  else 
      {
              Log.Warning(lib_messageLog.msg_DEVICE_NOTFOUND);
              flag = false;
      }
      return flag;
}