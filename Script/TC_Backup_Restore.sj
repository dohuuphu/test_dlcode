//USEUNIT lib_Backup_Restore
//USEUNIT lib_button
//USEUNIT lib_CodeSetup
//USEUNIT lib_common
//USEUNIT lib_deviceInfo
//USEUNIT lib_JobList
//USEUNIT lib_SaveJob
//USEUNIT lib_validate
//USEUNIT TC_ChangeIP
//USEUNIT Device
//USEUNIT setupInternalNetwork
//USEUNIT upgrade
 


function backup_restoreCluster_withWarning ()
{  
  aqTestCase.Begin("backup_restoreCluster_withWarning");
  lib_common.launchUI();
  changeUserRole(lib_label.const_lb_InstallerExpert, false);
   //setup init environment
   RestoreDefaultEnvironment ();
   Device.MenuBar_Device ( false, "Installer-Expert");
   setupInternalNetwork.verifySetupInteralNetworkWindow();
   //device is Master at this time
   if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress )== lib_err.err_FUNC_SUCCESS)
   { 
        var restore = lib_Backup_Restore.restoreCluster(lib_deviceInfo.const_BACKUP_path,"DL.CODE 1.5.0.29_M300_C14H01217");
        var restore = lib_Backup_Restore.restoreCluster(lib_deviceInfo.const_BACKUP_path,"DL.CODE 1.5.0.29_M300_C14H01217jdhfd");                       
   } 
   aqTestCase.End();
} 

/*
  *reviewed by giang.ha 1.9.0A7 20200220
  @function 
  @For Expert: verify jobList
  @Step 1: Enter and Save Mutidat job
  @Step 2: Backup cluster
  @Step 3: Delete the saved job at step 1
  @Step 4: Restore cluster
  @Step 5: Repeat the sequence to Sync & Packtrack
  @For Installer Basic -> restore .zip from Expert => dont verify jobList
*/
function backup_restoreCluster ()
{
  aqTestCase.Begin("Testcase backup restore cluster");
         Log.AppendFolder("backup_restoreCluster for USER EXPERT");
         Log.PopLogFolder();
         lib_common.launchUI();
         lib_UserRole.initUISetting_UserRole();
         
         var startupJob = "";
         var jobListBefore = new Array();
         var jobListAfter = new Array();
         
         //this array saved name of backup Cluster zip
         var backupClusterArr = new Array();
         
         //for User Expert  
         var ip = lib_deviceInfo.const_Device_IP_Adress;         
         var length = 0;
         if (lib_deviceInfo.const_Device_Model == lib_const.const_M120)
              return;
         if (lib_deviceInfo.const_Device_Model == lib_const.const_M210 ||
             lib_deviceInfo.const_Device_Model == lib_const.const_M220) 
             length = 2 ;// multi + sync
         else
             length = 3 ;// multi + syn + packtrack 
         for (var i= 1; i<= length; i ++)// 
         {
                 if (lib_common.connectToDevice(ip))
                 {         
                        //get role
                        var role = lib_DeviceSelectedDetail.getDeviceRole();                         
//                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").ClickButton();
                       //to make sure GUI Enter Cluster View 
                        var setupIntNerBtt = Sys.Process("DL.CODE").FindChild("WPFControlText", "Setup Internal Network Configuration", 2000);
                        if  (setupIntNerBtt.Exists  )
                        {
                              setupIntNerBtt.Click();
                        }    
                       //Slave => Master
                        if (role == lib_label.const_lb_Slave )
                        {            
                                var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1); 
              
                                if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", 1000).Exists)
                                { 
                                   aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, lib_label.lb_SetupInternalNetwork);
                                   Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();                                    
                                } 
                        }
                        delay (3000);
                        
                        if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                        {
                                while (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                                {
                                         Delay(4000);
                                }
                        }
                        var path =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1);
                              
                        var configName = path.WPFObject("ListBoxItem", "",i+ 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                        path.WPFObject("ListBoxItem", "",i+ 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").ClickButton();
                        delay (2000);
                        // wait Progress bar is collapsed
                        while (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("BusyIndicator", "", 1).Visibility == "Visible")
                        { 
                             delay (5000);
                             Sys.Process("DL.CODE").Refresh();
                        }
                              
                        while (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WaitWPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice, 1000).Exists == false)
                        {
                             delay (3000);
                             Sys.Process("DL.CODE").Refresh();
                        }
                        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
                        if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device", 2000).Exists)
                        {
                              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 2), "WPFControlText", cmpEqual, lib_label.const_lb_SaveOnSlaveDevice);
                              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 3), "WPFControlText", cmpEqual, lib_label.const_lb_CloneMasterConfigurationSlaves);
                              Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
                        }
                        //save job Startup
                        var saveResult = lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, configName , lib_const.const_isDefaultJob_Y, lib_const.isMonitorMode_N);                                           
                        Log.Message(configName)   ;
                        if (saveResult == err_FUNC_SUCCESS)
                        {
                                startupJob = configName;
                                backupClusterArr.push (startupJob);
                        }
                        //get job list Before  
                        lib_button.clickOpenJobOnDevice();
                        jobListBefore = lib_JobList.getJobList();              
                        //perform Backup Cluster
                        var backup = lib_Backup_Restore.backupCluster(lib_deviceInfo.const_BACKUP_path, "Cluser" + configName  + lib_deviceInfo.const_BACKUP_fileName);  
                        if (backup == false)
                        {
                            Log.Message("backup:" + backup);
                            return ;
                        }    
                        // perform delete Startup job               
                        var resultDelete = lib_DeleteJob.deleteOnDevice(configName);                        
                        if(resultDelete != lib_err.err_FUNC_SUCCESS)                         
                        {
                            Log.Message("resultDelete:" + resultDelete);
                            return ;
                        } 
                        
                        lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y);                         
                        var restore = lib_Backup_Restore.restoreCluster(lib_deviceInfo.const_BACKUP_path,"Cluser" + configName  + lib_deviceInfo.const_BACKUP_fileName );
                        if (restore == false)
                        { 
                            Log.Message("restore:" + restore);
                            return ;
                           
                        }   
                        
                        //verify Startup job and Job List
                        if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress)== lib_err.err_FUNC_SUCCESS)
                        {        //verify startup job     
                                 var startupJob = lib_DeviceSelectedDetail.getNameStartUpJob();
                                 if (startupJob != configName)
                                 {
                                      flag = false;
                                      Log.Error("Wrong Startup");
                                      Log.Warning("startupJob:" + startupJob);
                                      Log.Warning("configName:" + configName);
                                 }
                                 else Log.Message( "startup : OK "  );
                                 // get JobList After
                                 lib_button.clickOpenJobOnDevice();
                                 jobListAfter = lib_JobList.getJobList();  
                                  //verify Job List
                                 if (  jobListAfter.length <= jobListBefore.length && 
                                       jobListAfter.length == 2 
                                     )
                                 {
                                       Log.Message( "job List : OK "  );
                                 } else     Log.Warning("Wrong job list");
                                 Log.Message("startupJob:" + startupJob);
                                 Log.Message("configName:" + configName);
                                 Log.Message("jobListBefore:" + jobListBefore.length);
                        }                                    
                  }
         }  
         //FOR INSTALLER BASIC
         Log.AppendFolder("backup_restoreCluster for USER INSTALLER BASIC");
         Log.PopLogFolder();   
         lib_common.gettingStarted();      
         lib_UserRole.changeUserRole(const_lb_InstallerBasic);

         var backupClusterArr = ["CluserSet Default Multidata ConfigurationDL.CODE 1.9.0.14_M410N_C14P00582", "CluserSet Default Synchronized PackTrack ConfigurationDL.CODE 1.9.0.14_M410N_C14P00582", "CluserSet Default Synchronized Phase Mode ConfigurationDL.CODE 1.9.0.14_M410N_C14P00582"];
         for (var k = 0; k < backupClusterArr.length ; k++)
         {
                lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress);
                var restore = lib_Backup_Restore.restoreCluster(lib_deviceInfo.const_BACKUP_path,backupClusterArr [k] );
                if (restore == false)
                { 
                    Log.Message("restore:" + restore);
                    return ;                           
                } 
         } 
     aqTestCase.End();   
}

/*
  *@function  
*/
function singleReader_BACKUP_RESTORE()
{
     aqTestCase.Begin("singleReader_BACKUP_RESTORE");
      lib_common.launchUI();  
      var oldBackUpFW, newRestoreFW, downGradeFW;
      var arrJobList1, arrJobList2;
      var defaultJob1, defaultJob2;
      if ( lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      {
            Indicator.PushText("Step 1: Perform Singlhe reader backup");           
            oldBackUpFW  = lib_common.getFWVersionInGettStarted();
            defaultJob1 = lib_DeviceSelectedDetail.getNameStartUpJob ();
            lib_button.clickOpenJobOnDevice();
            arrJobList1 = lib_JobList.getJobList();
            
            lib_Backup_Restore.singleReaderBackup ( lib_deviceInfo.const_BACKUP_path, lib_deviceInfo.const_BACKUP_fileName, true);
            Indicator.PopText();  
            //downgrade 
            Indicator.PushText("Step 2: Downgrade FW");             
            upgrade.mainDownGrade();
            Indicator.PopText();  
            
             
      }
      lib_common.launchUI();  
      if ( lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      {     
            
            downGradeFW = lib_common.getFWVersionInGettStarted();
            Indicator.PushText("Step 3: Perform single Reader Restore");
            lib_Backup_Restore.singleReaderRestore( lib_deviceInfo.const_BACKUP_path, lib_deviceInfo.const_BACKUP_fileName);           
            
            Indicator.PopText();  
      }
      if (lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      {     
            newRestoreFW  = lib_common.getFWVersionInGettStarted();
            defaultJob2 = lib_DeviceSelectedDetail.getNameStartUpJob ();
            lib_button.clickOpenJobOnDevice();
            arrJobList2 = lib_JobList.getJobList();
            //verify FW
            if (oldBackUpFW == newRestoreFW && newRestoreFW != downGradeFW)
            {
                 Log.Message("Verify FW:OK");                 
            }
            else 
            {
                 Log.Error("oldBackUpFW:"+ oldBackUpFW);
                 Log.Error("newRestoreFW:"+ newRestoreFW);
                 Log.Error("downGradeFW: "+downGradeFW);
            }
            //verify default job
            if (defaultJob1 != defaultJob2)
            {
                 Log.Error("defaultJob1:"+ defaultJob1);
                 Log.Error("defaultJob2:"+ defaultJob2); 
                 
            }else Log.Message("Verify Default job: OK");   
            
            //verify jobList
            if (arrJobList2.length!= arrJobList1.length)
            {
               Log.Error("arrJobList2.length:"+ arrJobList2.length);
               Log.Error("arrJobList1.length:"+ arrJobList1.length);
               
            }else 
            {
                  Log.Message("Verify Job List : OK");   
                  for (var i = 0; i < arrJobList2.length; i++)
                  {
                    if (arrJobList1[i]!= arrJobList2[i])
                         Log.Error(arrJobList1[i] + "-" + arrJobList2[i]);
                  }
            }
            
      } else return;
      aqTestCase.End();
}


/*
  *@function  
*/
function backup_restore_ToExternalStorageDevice()
{
      aqTestCase.Begin("backup_restore_ToExternalStorageDevice");
      var flag = true;
      if ( ! lib_validate.isDLCODERunning() || lib_validate.isUnExpectedWindowExists())
             lib_common.launchUI();  
             
      var array1 = new Array();
      var array2 = new Array(); 
      var ip = lib_deviceInfo.const_Device_IP_Adress;
      var startupName = lib_SaveJob.randomJobName();
      
      // savea job and set startup job !=  Default
      if (lib_common.connectToDevice(ip)=== lib_err.err_FUNC_SUCCESS)
      {         
          if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                 lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, startupName , lib_const.const_isDefaultJob_Y, lib_const.isMonitorMode_N);   
      }
      // get job list before performing restore           
      if (lib_common.connectToDevice(ip)=== lib_err.err_FUNC_SUCCESS)
      {    
              lib_button.clickOpenJobOnDevice();
              array1 = lib_JobList.getJobList();   
      }
      // perform backup
     
      var backup = lib_Backup_Restore.backupToExternalStorageDevice();
      if (backup!= true)
            return false;
      //restore Factory
      RestoreFactoryDefaults();
     //perform restore
      restoreFromExternalStorageDevice();
              
       // get job list after performing restore      
      if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
      {    
                   
               var startupJob = lib_DeviceSelectedDetail.getNameStartUpJob();
               if (startupJob != startupName)
               {
                    flag = false;
                    Log.Warning("sai Startup");
               }else
                    Log.Message( "2. Startup : OK "  );
                                          
              lib_button.clickOpenJobOnDevice();
              array2 = lib_JobList.getJobList(); 
      }       
                  
      if (lib_JobList.compare2JobList( array1, array2) == false)
      {
          flag = false;
          Log.Warning(lib_messageLog.msg_COMPARE_JOBLIST_FAILED);
      }else
            Log.Message( "3. Job List : OK "  );
      return flag;
      aqTestCase.End();
}

//*********************************************************************************************************************************
/*
  *@function 
*/
function singleReaderBackupNoFW ()
{      
  aqTestCase.Begin("Backup NO FW");
      if ( lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      { 
           
           lib_Backup_Restore.singleReaderBackup ( lib_deviceInfo.const_BACKUP_path, lib_deviceInfo.const_BACKUP_fileName_noFW, false);
 
      }else   return; 
      aqTestCase.End();
}

function singleReaderBackupNoFW_2 ()
{      
  
      if ( lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      { 
           lib_Backup_Restore.singleReaderBackup ( lib_deviceInfo.const_BACKUP_path, lib_deviceInfo.const_BACKUP_fileName_noFW, false);
 
      }else   return; 
 
}

/*
  *@function 
*/
function singleReaderRestoreNoFW ()
{     
      aqTestCase.Begin("Restore NO FW") ;
      singleReaderBackupNoFW_2();
      if ( lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      {          
         lib_Backup_Restore.singleReaderRestore(lib_deviceInfo.const_BACKUP_path, lib_deviceInfo.const_BACKUP_fileName_noFW);
               
      }else    return;
      aqTestCase.End();
}

function singleReaderRestoreNoFW_2 ()
{     
      
      if ( lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      {          
         lib_Backup_Restore.singleReaderRestore(lib_deviceInfo.const_BACKUP_path, lib_deviceInfo.const_BACKUP_fileName_noFW);
               
      }else    return;
      
}

/*
  *@function 
*/
function singleReaderBackup ()
{      
      aqTestCase.Begin("singleReaderBackup");
      var firmwareVersion;      
      if ( lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      {
            var firmwareVersion = lib_common.getFWVersionInGettStarted();
            Log.Message(firmwareVersion);
            var flag = lib_Backup_Restore.singleReaderBackup ( lib_deviceInfo.const_BACKUP_path, lib_deviceInfo.const_BACKUP_fileName, true);
            Log.Message(lib_deviceInfo.const_BACKUP_fileName);
            if (flag == true)
                   return firmwareVersion;
            
    
      }else   return firmwareVersion; 
      aqTestCase.End();
}

function singleReaderBackup_2 ()
{      
      
      var firmwareVersion;      
      if ( lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      {
            var firmwareVersion = lib_common.getFWVersionInGettStarted();
            Log.Message(firmwareVersion);
            var flag = lib_Backup_Restore.singleReaderBackup ( lib_deviceInfo.const_BACKUP_path, lib_deviceInfo.const_BACKUP_fileName, true);
            Log.Message(lib_deviceInfo.const_BACKUP_fileName);
            if (flag == true)
                   return firmwareVersion;
            
    
      }else   return firmwareVersion; 
      
}
/*
  *@function 
*/
function singleReaderRestore ()
{     
      aqTestCase.Begin("singleReaderRestore");
      singleReaderBackup_2();
      var firmwareVersion;
      if ( lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      {
              var firmwareVersion = lib_common.getFWVersionInGettStarted();
              Log.Message(firmwareVersion);
              var flag =    lib_Backup_Restore.singleReaderRestore(lib_deviceInfo.const_BACKUP_path, lib_deviceInfo.const_BACKUP_fileName);
              Log.Message(lib_deviceInfo.const_BACKUP_fileName);
              if (flag == true)
                   return firmwareVersion;
      }else    return firmwareVersion;
      aqTestCase.End();
}

/*
  *@function 
*/
//function backupToExternalStorageDevice ()
//{     
//      
//      if ( lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
//      {
//            return lib_Backup_Restore.backupToExternalStorageDevice();
//      } 
//}
/*
  *@function 
*/
function restoreFromExternalStorageDevice ()
{     
       
      if ( lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      {
              if (lib_deviceInfo.const_Device_Model != lib_const.const_M120 )
                          lib_Backup_Restore.restoreFromExternalStorageDevice();        
                    else
                          Log.Warning(lib_messageLog.msg_M120_BACKUP_RESTORE);   
      }else return;   
}


/*
  *@function 
*/
function RestoreDefaultStartupConfiguration ()
{     
 // aqTestCase.Begin("Restore Default");
      var array1 = new Array();
      var array2 = new Array(); 
      var ip = lib_deviceInfo.const_Device_IP_Adress;
      // savea job and set startup job !=  Default
      if (lib_common.connectToDevice(ip)=== lib_err.err_FUNC_SUCCESS)
      {         
          if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                 lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, lib_SaveJob.randomJobName() , lib_const.const_isDefaultJob_Y, lib_const.isMonitorMode_N);   
      }
      // get job list before performing restore           
      if (lib_common.connectToDevice(ip)=== lib_err.err_FUNC_SUCCESS)
      {    
              lib_button.clickOpenJobOnDevice();
              array1 = lib_JobList.getJobList();   
      }
      // performing restore
      if (lib_common.connectToDevice(ip)=== lib_err.err_FUNC_SUCCESS)
      { 
             lib_Backup_Restore.restoreDefault(lib_label.const_lb_RestoreDefaultStartupConfiguration); 
      }
       
      //verify that the device is working else waiting in 5 minutes
      lib_common.gettingStarted();
      var time =0 ;
      while (lib_common.getDeviceIndex(lib_deviceInfo.const_Device_SerialNumber) == 0)
      {    
          Delay(lib_const.const_timeOut);                     
          time = time + 1;
          Sys.Process("DL.CODE").Refresh();
          if (time == lib_const.const_time_timeOut)
          {
                 Log.Warning(lib_err.msg_ERR_CONNECTTODEVICE_TIMEOUT + ":" +  time*lib_const.const_timeOut + " milliseconds");
                 return false;
          }
      }
      //end waiting
      if( lib_common.getDeviceIndex(lib_deviceInfo.const_Device_SerialNumber) != 0)   
      {
              if (lib_common.connectToDevice(ip)=== lib_err.err_FUNC_SUCCESS)
              {    
                      lib_button.clickOpenJobOnDevice();
                      array2 = lib_JobList.getJobList(); 
              }     
              var verify = lib_Backup_Restore.verifyRestoreDefaultStartupConfiguration(array1, array2);                
              Log.Message("RestoreDefaultStartupConfiguration: " + verify);
      }
     // aqTestCase.End();
}
/*
  *@function 
*/
function RestoreDefaultEnvironment ()
{      
      //aqTestCase.Begin("Restore Default Environment");
      var array1 = new Array(); 
      var ip = lib_deviceInfo.const_Device_IP_Adress;
       // savea job and set startup job !=  Default
      if (lib_common.connectToDevice(ip)=== lib_err.err_FUNC_SUCCESS)
      {         
          if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                 lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, lib_SaveJob.randomJobName() , lib_const.const_isDefaultJob_Y, lib_const.isMonitorMode_N);   
      }   
      // get job list before performing restore              
      if (lib_common.connectToDevice(ip)=== lib_err.err_FUNC_SUCCESS)
      {    
              lib_button.clickOpenJobOnDevice();
              array1 = lib_JobList.getJobList();              
      }
      // performing restore
      if (lib_common.connectToDevice(ip)=== lib_err.err_FUNC_SUCCESS)
      { 
             lib_Backup_Restore.restoreDefault(lib_label.const_lb_RestoreDefaultEnvironment); 
      }

       //verify that the device is working else waiting in 5 minutes
      lib_common.gettingStarted();
      var time =0 ;
      while (lib_common.getDeviceIndex(lib_deviceInfo.const_Device_SerialNumber) == 0)
      {    
          Delay(lib_const.const_timeOut);                     
          time = time + 1;
          Sys.Process("DL.CODE").Refresh();
          if (time == lib_const.const_time_timeOut)
          {
                 Log.Warning(lib_err.msg_ERR_CONNECTTODEVICE_TIMEOUT + ":" +  time*lib_const.const_timeOut + " milliseconds");
                 return false;
          }
      }
      //end waiting
      if( lib_common.getDeviceIndex(lib_deviceInfo.const_Device_SerialNumber) != 0)   
      {
              var verify = lib_Backup_Restore.verifyRestoreDefaultEnvironment (array1);    
              Log.Message("RestoreDefaultEnvironment: " + verify);
              return verify;
      }
       
     // aqTestCase.End();     
}
/*
  *@function 
*/
function RestoreFactoryDefaults ()
{      
  //aqTestCase.Begin("RestoreFactoryDefaults");
      if ( lib_common.connectToDevice (lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_SUCCESS)
      {
              lib_Backup_Restore.restoreDefault(const_lb_RestoreFactoryDefaults);  
      }
      
      //verify that the device is working else waiting in 5 minutes
      lib_common.gettingStarted();
      var time =0 ;
      while (lib_common.getDeviceIndex(lib_deviceInfo.const_Device_SerialNumber) == 0)
      {    
          Delay(lib_const.const_timeOut);                     
          time = time + 1;
          Sys.Process("DL.CODE").Refresh();
          if (time == lib_const.const_time_timeOut)
          {
                 Log.Warning(lib_err.msg_ERR_CONNECTTODEVICE_TIMEOUT + ":" +  time*lib_const.const_timeOut + " milliseconds");
                 return false;
          }
      }
      //end waiting
      if( lib_common.getDeviceIndex(lib_deviceInfo.const_Device_SerialNumber) != 0)   
      {
            var verify = lib_Backup_Restore.verifyRestoreFactoryDefaults();      
            Log.Message("RestoreFactoryDefaults: " + verify);
            return verify;
      } 
      //aqTestCase.End();
}







