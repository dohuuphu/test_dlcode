//USEUNIT lib_const
//USEUNIT lib_DeviceSelectedDetail
//USEUNIT lib_err

/*
 *@function 
 *@param ip{String}
 *@param jobName{String}
*/
function verifyDeleteJob (ip, jobName)
{
       var flag = false;
       if (lib_common.connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
       {    
                 Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", 3).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
                 if (lib_validate.isJobExist(jobName))
                        Log.Warning(lib_err.msg_ERR_VERIFY_DELETE);
                 else 
                        flag = true;
                 Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Open Configuration from Device").WPFObject("JobListDialogWindow", "Open Configuration from Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
       } 
       Log.Message("verifyDeleteJob: " + flag);
       return flag;
}


//updated 1.5.0
/*
 *@function 
 *@param ip{String}
 *@param jobName{String}
*/
function deleteOnDevice (jobName)
{
  
         var flag = lib_err.err_FUNC_FAILED;   
         try 
         {
                //get name of Startup Job
//                var isStartUpJob = lib_DeviceSelectedDetail.isStartUpJob(jobName);
                //click open job
                Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_OpenOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
 
                 // waiting Job List Dialog
                 if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: JobListDialogWindow", "*", 2000).Exists)
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
                              if (name == jobName)
                              {
                                     isInputNameExits = true;
                                     jobList.WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", j).WPFObject("Border").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();         
                                     //confirm to change tmp job if the deleted job is start up                                                                 
                                     if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", lib_const.const_delay_1000).Exists ) 
                                     {
                                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual,lib_label.const_confirm_DELETE_DEFAULT_JOB);                                   
                                             Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton();
                                     }
                                     //closed window
                                     Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "*").WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
                                     flag = lib_err.err_FUNC_SUCCESS;
                                     Log["Message"]("##->Delete job : " + jobName +" --- " + flag);
                                     return flag;                      
                              }
                           }
                       }    
                       if ( isInputNameExits == false)
                       {
                            flag = lib_err.err_NO_EXIST;
                            Log.Warning(lib_err.err_NO_EXIST);
                            Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "*").WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
                            return flag;
                       }
                 } 
         }
         catch (e)
         {
                 return lib_err.err_FUNC_EXCEPTION;
         } 
          
}
