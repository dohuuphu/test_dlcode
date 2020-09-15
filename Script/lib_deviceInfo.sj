﻿//DL.CODE VERSION
 var const_firmware                   = "DL.CODE 1.9.0.60";  //right-bottom corner of GUI  
//FIRMWARE VERSION
 var const_firmware_version           = "1.9.0.98-beta04"; // firmware package
 
//SERIAL DEVICE WHICH YOU WANT TO CONNECT
var const_SerialDevice_SerialNumber   = "123456789";


//ONLINE DEVICE WHICH YOU WANT TO CONNECT
var const_arr_DeviceModel = ["M120"  , "M210N" , "M220", "M300N", "M320" , "M410N", "M450N"];
var const_Device_SerialNumber         = "123456789"; //serial number
var const_Device_IP_Adress            = "10.84.30.170";
var const_isPPI_device                = true;
var const_Device_Model                = const_arr_DeviceModel[4]; 


//BACKUP RESTORE
var backupFile = "";
var const_Device_Model_Detail         = "M320 320-020 ";


// VALUE DEFAULT for device
var const_Device_Name                 ="Matrix"; // dont input special character , only -
var const_Device_StartupJob           = "Startup 456";
var const_Device_Role                 = "Slave" ;


// const
 var const_Name_Default                 = const_firmware_version;
 var const_fileNameJob                  = "ConfigList.xls";
 var const_fileNameJob_Path             = "D:\\SVN_TestComplete\\AutomationTestComplete\\Excel"; // lhoang change directory D:|NewSVN to D:\SVN_TestComplete
 var const_fileNameJob_SheetName        = "Sheet1"; // lhoang change to Sheet1 instead of Sheet2
 var const_fileNameJob_ColumnName       = "Configuration";  
 var const_fileNameJob_SavePC           = "D:\\SVN_TestComplete\\AutomationTestComplete\\JobList"; // lhoang change directory D:|NewSVN to D:\SVN_TestComplete
 var const_fileName_SaveIMG             = "D:\\SVN_TestComplete\\AutomationTestComplete\\IMG"; // lhoang change directory D:|NewSVN to D:\SVN_TestComplete
 
 
/**
 *BACKUP & RESTORE
*/
 var const_BACKUP_fileName              = const_firmware+"_"+const_Device_Model+"_"+const_Device_SerialNumber;
 var const_BACKUP_fileName_noFW         = "noFW" + const_firmware+"_"+const_Device_Model+"_"+const_Device_SerialNumber;
 var const_BACKUP_path                  = "D:\\SVN_TestComplete\\AutomationTestComplete\\backup";// lhoang change directory D:|NewSVN to D:\SVN_TestComplete
 
 
 /**
  *BENCHMARK TEST
 */
 var const_fileName_BenchmarkTest       = "Benchmark Test_Self-Tune.xlsx";
 var const_fileName_BenchmarkTest_Sheet = "1.5.1";
 
 /**
  *Load configuration from older version 
 */ 
 var const_Older_JobList_Folder         = "D:\\SVN_TestComplete\\AutomationTestComplete\\Older_JobList"; // lhoang change directory D:|NewSVN to D:\SVN_TestComplete
 var const_Older_JobList_xls            = "Older_JobList.xls";
 var const_Older_JobList_SheetName      = "Sheet1";
 var const_Older_JobList_ColumnName     = "Configuration";  
//END EDIT
 
  
/**
 *Simulators information
 *DL CODE 1.6.0: total 9 simulators
*/
var const_Simulator_Device       = [ "M120",       "M210N",    "M300N" ,   "M410N" ,   "M410N" ,  "M410N" ,   "M450N"  ,  "M220" ,    "M220",    "M300N",   "M300N"     , "M320"];
var const_Simulator_Model        = [ "210-000",    "235-111",  "482-010" , "500-010" , "700-010" ,"XRF-H2x" , "800-030" , "355-040",  "382-010", "772-010", "712-010", "320-020"];
var const_Simulator_Model_Detail = [
                                        "M120 210-000 WVGA SER+USB STD",
                                        "M210N 235-111 WVGA-DPM-LL-ETH-ES",
                                        "M300N 482-010 LQL-9 MLT-DPM STD",
                                        "M410N 500-010 ",
                                        "M410N 700-010 2.0MP-45FPS-ETH",
                                        "M410N XRF-H2x XRF High Performance, Very High Resolution",
                                        "M450N 800-030 5MP GIGE" ,
                                        "M220 355-040 1.2MP STD-W 12MM POE",
                                        "M220 382-010 1.2MP DPM-R 7MM",
                                        "M300N 772-010 2MP LQL-9 R-WD DIF",
                                        "M300N 712-010 2MP LQL-9 R-WD STD",
                                        "M320 320-020 "];
/**
 *Image Resolution for each device
*/                                        
var const_Resolution_Width     = [752   , 752   , 1280  , 1280  , 1600 , 1600 , 2448 , 1280, 1280, 1600, 1600, 1920];
var const_Resolution_Height    = [480   , 480   , 1024  , 1024  , 1200 , 1200 , 2050 , 960 , 960 , 1200, 1200, 1080];
 
 