//USEUNIT lib_Backup_Restore
//USEUNIT lib_common
//USEUNIT lib_deviceInfo
//USEUNIT lib_validate
//USEUNIT TC_ChangeIP
//USEUNIT TC_Backup_Restore


/*
 *function
*/
function RestoreDefault()
{
      aqTestCase.Begin("Restore");
       Indicator.PushText("Launch UI"); 
       lib_common["launchUI"]();  
       Indicator.PopText(); 
//       BACKUP DATA CAUSE DATA IS EREASED AFTER RESTORE FACTORY   
       Indicator.PushText("Step 1: Perform Singlhe reader backup");        
       TC_Backup_Restore.singleReaderBackupNoFW_2();
       Indicator.PopText();         
       /*************************/
       Indicator.PushText("Step 2: Perform Restore Default Startup Configuration");   
       Log.Message("RES_01-RestoreDefaultStartupConfiguration");
       TC_Backup_Restore.RestoreDefaultStartupConfiguration();    
       Indicator.PopText();     
       /*************************/
       Indicator.PushText("Step 3: Perform Restore Default Environment");
       Log.Message("RES_02-RestoreDefaultEnvironment");             
       TC_Backup_Restore.RestoreDefaultEnvironment();// reset ip to 192.168.3.100
       Indicator.PopText();     
        /*************************/
       Indicator.PushText("Step 4: Perform Restore Factory Defaults");
       Log.Message("RES_03-RestoreFactoryDefaults");
       TC_Backup_Restore.RestoreFactoryDefaults();// reset ip to 192.168.3.100
       Indicator.PopText();     
//       RESTORE DATA CAUSE DATA IS EREASED AFTER RESTORE FACTORY  
       Indicator.PushText("Step 5: Perform single Reader Restore");
       TC_Backup_Restore.singleReaderRestoreNoFW_2();
       Indicator.PopText();     
       Indicator.PushText("End Preccess DL.CODE");
       lib_common.terminateUI();
       Indicator.PopText();
       aqTestCase.End();
}