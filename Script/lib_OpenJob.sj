//USEUNIT lib_common
//USEUNIT lib_connection
//USEUNIT lib_const
//USEUNIT lib_DeviceSelectedDetail
//USEUNIT lib_SaveJob
//USEUNIT lib_button



/**
   *@function
   *@param {String} jobName
   *@param {String} path 
*/
function openLoadFromPC ( jobName,path)
{
        Log.AppendFolder("func: openLoadFromPC");
        //default : open failed        
        var flag = true; 
       //click button load from PC
        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_OpenFromPC).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
  
        while (!Sys.Process("DL.CODE").WaitWindow("#32770", "*",-1, lib_const.const_delay_1000).Exists){
              Delay(lib_const.const_delay_1000);
              Sys.Process("DL.CODE").Refresh();
        }     
        //open folder contain job
        var editBar =Sys.Process("DL.CODE")["Window"]("#32770", "*", 1)["Window"]("ComboBoxEx32", "", 1)["Window"]("ComboBox", "", 1)["Window"]("Edit", "", 1);
        editBar.Keys(path  + "\\"+ jobName +".dlcfg");
        editBar.Keys("[Enter]"); 
        Log.Message( path  + "\\"+ jobName +".dlcfg");
  
        if  (Sys.Process("DL.CODE").WaitWindow("#32770", "*",-1, lib_const.const_delay_1000).Exists)
        {
              Sys.Process("DL.CODE").Window("#32770", "Open", 1).Window("Button", "OK", 1).ClickButton();    
              Sys.Process("DL.CODE").Window("#32770", "Open", 1).Window("Button", "Cancel", 2).ClickButton();    
              flag = lib_err.err_FILE_NOFOUND;       
        }  
        while (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", lib_const.const_delay_1000).Exists)
        {      
              var txt =      Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText").WPFControlText;
              if (txt != lib_label.const_TmpConfigLost && txt != lib_label.const_RunningConfigChange)
              {
                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpContains, "Configuration was created for device model");                         
                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpContains, "Do you want to proceed?");          
              }
              if (txt == lib_label.const_RunningConfigChange)//Running job default const_RunningConfigChange
              {
                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpContains, lib_label.const_RunningConfigChange);
              } 
              if (txt == lib_label.const_TmpConfigLost)//running job tmp
              {
                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpContains, lib_label.const_TmpConfigLost);
              }
                                  
              Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton();
              //wait
              for (var i = 1; i <= 2; i ++)
              {      
                    var result = Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware,1,  1000).Exists;            
                    if (result == false)
                    {      
                          lib_common.waitDelay(3000, 10); //linhtnguyen changed waitDelay to 3000         
                          Sys.Process("DL.CODE").Refresh();
                    }
              }                       
        }
          
        if (lib_validate.isConfigurationMode()== false)
              return false;
         //validate UnExpectedWindow
        while (lib_validate.isUnExpectedWindow() == true)
        {
              lib_common.proccessUnexpectedWindow();               
              return false;
        } 
        Delay(5000);
        //if UI is playing (Automatic Setup) -> Pause               
        var playButt = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("controlToolBar").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", 2);
        if (playButt.Visible)
        {
                playButt.ClickButton();               
        }  
        //and focus on Advance Setup   
        lib_button.clickAdvancedSetup(); 
        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "[Temp]", 3),"WPFControlText", cmpEqual,"[Temp]"); 
        Log.PopLogFolder();
        return flag;
}


/**
   *Last updated: 1.6.0 rc2
   *@function
   *@param {String} jobName
   *@param {String} isDefaultJob
   *@param {String} isViaButton 
*/
function openOnDevice ( jobName,  isDefaultJob, isViaButton)
{
     Log.AppendFolder("func: openOnDevice: "+ jobName);
     //default : open failed
     var flag = false; 
     //open Dialog popup
     if (isViaButton == lib_const.const_isOpenViaButton_Y)
     {
            // open via button on Toolbar
            var proArr = ["ToolTip", "ClrClassName", "Enabled"];
            var valArr = ["Open Device Configuration", "Button" , true];
            var openBtt = Sys.Process("DL.CODE").FindChild(proArr, valArr, 2000);
            if (openBtt.Exists)
                 openBtt.ClickButton();
            else return flag;
//            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
            
 
     }else 
     {
            var optionGrid = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox");
            // choose Open Device Configuration
            optionGrid.WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").ClickButton();
     }       
     while (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).Enabled == true)
     {   
            Delay(1000);
            Sys.Refresh();
     }
     // waiting Job List Dialog
     if (Sys.Process("DL.CODE")["WaitWPFObject"]("HwndSource: JobListDialogWindow", "*",lib_const.const_delay_1000).Exists)
     {
             //get jobList Name             
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
                 var itemPresenter =Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Open Device Configuration").WPFObject("JobListDialogWindow", "Open Device Configuration", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JobListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1);
                 var childCount = itemPresenter.ChildCount;
                 for (var j = 1 ; j <= childCount; j ++ )
                 { 
                    //get name of every item   
                    var name = jobList.WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", j).WPFObject("Border").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                    //find job name need open
                    if (name  == jobName)
                    {
                        isInputNameExits = true;
                        jobList.WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", j).WPFObject("Border").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).Click();
                        //is Startup job = N
                        if (isDefaultJob == lib_const.const_isDefaultJob_N )
                        {
                            Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Open Device Configuration").WPFObject("JobListDialogWindow", "Open Device Configuration", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "Set as Startup Configuration", 1).set_IsChecked(false);  
                        }
                        // click button OK to open job  
                        Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "*").WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 1).ClickButton();
                        // solve other warning window if there are                  
                        if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", lib_const.const_delay_1000).Exists)
                        {      
                              var txt =      Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText").WPFControlText;
                              if (txt != lib_label.const_TmpConfigLost && txt != lib_label.const_RunningConfigChange)
                              {
                                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpContains, "Configuration was created for device model");                         
                                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpContains, "Do you want to proceed?");          
                              }
                              if (txt == lib_label.const_RunningConfigChange)//Running job default
                              {
                                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpContains, lib_label.const_RunningConfigChange);
                              } 
                              if (txt == lib_label.const_TmpConfigLost)//running job tmp
                              {
                                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpContains, lib_label.const_TmpConfigLost);
                              }
                                  
                              Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton();
                              //wait
                              
                              for (var i = 1; i <= 2; i ++)
                              {      
                                    var result = Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware,1,  1000).Exists;            
                                    if (result == false)
                                    {      
                                          lib_common.waitDelay(1000, 10);            
                                          Sys.Process("DL.CODE").Refresh();
                                    }
                              }                       
                        }   
                        if (lib_validate.isConfigurationMode()== false)
                              return false;                   

                        //validate UnExpectedWindow
                        if (lib_validate.isUnExpectedWindow() == true)
                        {
                              lib_common.proccessUnexpectedWindow();
                              return false;
                        }
                        //if UI is playing -> Pause
                        //and focus on Advance Setup        
                        var controlToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("controlToolBar");   
                        if (controlToolbar.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "", 2).Visible)
                        {
                                controlToolbar.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "", 2).ClickButton();
                                flag = true;
                        }
                        
                        lib_button.clickAdvancedSetup();
                        //verify Job Default 
                        if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WaitWPFObject("Grid", "", 2, lib_const.const_delay_2000).Exists )       
                        {
                                  if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2)["WaitWPFObject"]("CollapsedExpander", lib_const.const_delay_2000).Exists )                           
                                  {
                                    var editor =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("CollapsedExpander");
                                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2)["WaitWPFObject"]("CollapsedExpander",5000);
                                    // check open name is right
                                    if( editor.Exists== true)
                                    {     
                                           var index = 0;
                                           if (jobName == lib_const.const_DefaultJob)
                                                  index = 2;
                                           if (jobName == lib_const.const_TempJob)
                                                  index = 3;
                                           else
                                                  index = 4;        
                        
                                           //flag = aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("CollapsedExpander").WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", index), "WPFControlText", cmpEqual, jobName);
                                             flag = true;                            
//                                           var text =   editor.WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", index); 
//                                           flag = aqObject.CheckProperty(text, "Name", cmpEqual, "WPFObject(\"TextBlock\", \""+jobName+"\", index)"); 
                                    }   
                                    return flag;
                                  }
                        } 
                        else
                                Log.Error("ERR");
                    }
                 }
             }
     }   
     if ( isInputNameExits == false)
     {
          flag = lib_err.err_NO_EXIST;
          Log.Warning(lib_err.err_NO_EXIST);
          Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "*").WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
     } 
     Log.PopLogFolder();
     return flag;
}



