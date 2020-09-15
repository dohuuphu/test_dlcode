//USEUNIT lib_label


/**
   params are constant values
*/

/* 
isDefaultJob: set this job is startup job?
isDefaultJob: Y/N 
*/

var const_isDefaultJob_Y = "Y"; // Yes
var const_isDefaultJob_N = "N"; // No

/*
typeSaveOnDevice: add new or overwrite?
typeSaveOnDevice: N/O (New/Overwrite)
*/
var const_typeSaveOnDevice_N = "N"; // add New
var const_typeSaveOnDevice_O = "O"; // overwrite


/*
Default job * [Temp] job
*/
var const_DefaultJob = "Default";
var const_TempJob = "[Temp]";

/*
isOpenViaButton : open via button or grid list
isOpenViaButton : Y/N ( Y: via  Button)
*/
var const_isOpenViaButton_Y = "Y";
var const_isOpenViaButton_N = "N";

var const_saveIncludeImage_Y = "Y";
var const_saveIncludeImage_N = "N";

var isMonitorMode_Y = "Y";
var isMonitorMode_N = "N";


var const_delay_500 = 500;
var const_delay_1000 = 1000;
var const_delay_2000 = 2000;
var const_delay_3000 = 3000;
var const_delay_4000 = 4000;
var const_delay_5000 = 5000;
var const_delay_6000 = 6000;
var const_delay_30000 = 30000;
var const_delay_60000 = 60000;

var const_time_timeOut = 5;
var const_timeOut = 6000;  
var const_record_openConfig = 10;

var const_MAX_DECODINGTIME = 30000;

var const_path = "still not support.";


var const_M300_472_011 = "472-011"; 
var const_M120 = "M120";
var const_M210 = "M210N";
var const_M220 = "M220";
var const_M320 = "M320";
var const_M300 = "M300N";
var const_M410 = "M410N";
var const_M450 = "M450N";

var const_DEFAULT_FOLDER_SIZE = 256;
var const_DEFAULT_BUFFER_SIZE = 20;
var const_MAX_DB_BUFFER_SIZE = 10;
var const_Statistics_DiagnosticsRefreshRate = 1000;

var const_MaxNumberOfFiles = 1;
var const_MaxFileSize = 50000000;

var const_ImageSaving = 10;
var const_Channel = 5;
var const_fielbus = 1;

var const_MatrixFTPClient = 3;

var const_MinWidth_controlToolbar = 700;
var const_DefautWidth_controlToolbar = 1500;

var const_IPDefault = "192.168.3.100";


//index of button
var const_btt_GettingStarted = 1;
var const_btt_FindDevices    = 2; 
var const_btt_UserRole       = 3 ;
var const_btt_RestoreUI      = 4 ;
var const_btt_OpenOnDevice   = 5;
var const_btt_SaveOnDevice   = 6; 
var const_btt_OpenFromPC     = 7; 
var const_btt_SaveOnPC       = 8; 
var const_btt_SaveInTemp     = 9; 
var const_btt_Monitor        = 10; 
var const_btt_PackTrack      = 11 ;

var const_treeview_OpenDeviceConfiguration     = 1 ;
var const_treeview_PresentationMode            = 2; // add from 1.5.0 alpha 05
var const_treeview_InternalNetwork             = 3;
var const_treeview_PackTrack                   = 4;
var const_treeview_Monitor                     = 5;
var const_treeview_WebMonitor                  = 6;

var arr_1D     = [ lib_label.lb_PDF417    ,lib_label.lb_MICROPDF  ,lib_label.lb_CODE128  , lib_label.lb_GS1_128  ,lib_label.lb_CODE39 , lib_label.lb_INT2OF5  ,lib_label.lb_PHARMA  , lib_label.lb_MSI  , lib_label.lb_STD2OF5 , lib_label.lb_MTX2OF5  ,lib_label.lb_CODABAR   ,
                   lib_label.lb_GS1EXP    , lib_label.lb_GS1EXPSTK , lib_label.lb_GS1LIM   , lib_label.lb_GS1 , lib_label.lb_GS1STK   , lib_label.lb_CODE93, lib_label.lb_EAN13  , lib_label.lb_EAN8     ,lib_label.lb_UPCA    ,lib_label.lb_UPCE ];
var arr_2D     = [ lib_label.lb_DMECC200  , lib_label.lb_QR  , lib_label.lb_MICROQR   , lib_label.lb_AZTEC    , lib_label.lb_MAXICODE , lib_label.lb_DOTCODE];   
var arr_Postal = [ lib_label.lb_AustraliaPos, lib_label.lb_RoyalMail, lib_label.lb_KIXCode, lib_label.lb_JapanPost, lib_label.lb_PLANET, lib_label.lb_POSTNET, lib_label.lb_IntelligentMail, lib_label.lb_SwedishPostal      ];
var time_CodeAutolearn = 5;
 


//
///////********* Image setting   **************************                                                                                                                 
//
var const_bbt_MoveUp = 1;
var const_bbt_MoveDown = 2;
var const_bbt_ZoomIn = 3;
var const_bbt_ZoomToFit = 4;
var const_bbt_ZoomOut  =5 ;
var const_bbt_SaveImage = 6;
var const_bbt_TestRecord = 7;
var const_bbt_CroppingRegion = 8;
var const_bbt_Grid = 9;
var const_bbt_ImageResolution = 10;  


//get value from simulator
var const_ReadingDistance_Min = 22;
var const_ReadingDistance_Max = 500;
//

var const_RD_DT_OS_Channel_Index = 6;
var const_RD_DT_OS_Fieldbus_Index = const_RD_DT_OS_Channel_Index + 1;
var const_DF_ImageSavingTab = 12;
var const_DF_PassthroughTab = 13;
var const_DF_DiagnosticsTab = 4;

var const_AdvancedSetup = "AdvancedSetupJobContent";
var const_ReadingPhase_Channel = "OperatingModeJobContent";
var const_DataFormatting_Channel = "DataFormattingJobContent";
var const_OutputSetup_Channel = "OutputConfigurationJobContent";
var const_GoodRead  = "ResultAnalysisJobContent";


var const_Continuous = "SetContinuousOpModeTypeActionButton" ;
var const_OneShot    = "SetContinuousOneShotOpModeTypeActionButton";
var const_PhaseMode  = "SetPhaseOpModeTypeActionButton"
var const_Packtrack  = "SetPackTrackOpModeTypeActionButton"; 

var const_AddCollectionActionButton    = "AddCollectionActionButton";
var const_AddParcelActionButton        = "AddParcelActionButton";
var const_AddPresentationActionButton  = "AddPresentationActionButton";
var const_AddMatchCodeActionButton     = "AddMatchCodeActionButton";


var const_M120_210_000   =1; 
var const_M210N_235_111 = const_M120_210_000 + 1;  
// 1.6.0 add M220; 1.7.0 added two M300N 2MP -- linhtnguyen comment
var const_M220_355_040 = const_M210N_235_111 + 1;
var const_M220_382_010 = const_M220_355_040 + 1;
var const_M300N_482_010 = const_M220_382_010 + 1;
var const_M300N_712_010 = const_M300N_482_010 + 1;
var const_M300N_772_010 = const_M300N_712_010 + 1;
var const_M320_320_020 = const_M300N_772_010 + 1;
var const_M410N_500_010 = const_M320_320_020 + 1;
var const_M410N_700_010 = const_M410N_500_010+ 1;
var const_M410N_XRF_H2x = const_M410N_700_010+ 1;
var const_M450N_800_030 = const_M410N_XRF_H2x+ 1;


//  if add M220 M420
/*
var const_M220_220_001 =3;

var const_M300N_482_010 = 4;
var const_M410N_500_010 = 5;
var const_M410N_700_010 = 6;
var const_M410N_XRF_H2x = 7;
//add from 1.5.0
var const_M420_420_003 = 8;
var const_M420_420_005 = 9;
var const_M420_420_009 = 10;
var const_M420_420_012 = 11;

var const_M450N_800_030 = 12;
*/

var const_BMP    = "BMP Image (*.bmp)";
var const_JPEG   = "JPEG Image (*.jpg)";
var const_GIF    = "GIF Image (*.gif)";
var const_TIF    = "TIF Image (*.tif)";

var const_EventsTab          = 1;
var const_FocusCabblibration = const_EventsTab +1;
var const_ResultTab          = const_FocusCabblibration +1;
var const_ConsoleTab         = const_ResultTab +1;

var const_PeriodicsTime      = 2000 * 1;
var const_SeperateChar      = ";";

var const_EXPECTED_CONTENT = "EXPECTED CONTENT AND DATA IS IMPORTED FROM PARAMETER";
var const_EXCLUDED_CONTENT = "EXCLUDED CONTENT AND DATA IS IMPORTED FROM PARAMETER";
 
var const_HMP_GLOBAL_READING_DISTANCE = "GLOBAL_READING_DISTANCE";
var const_HMP_EXPOSURE_TIME           = "EXPOSURE_TIME";
var const_HMP_GAIN                    = "GAIN";
var const_HMP_GAINMULTIPLIER          = "GAINMULTIPLIER";
var const_HMP_IMAGE_POLARITY          = "IMAGE_POLARITY";


var const_HMP_VALUE_GLOBAL_READING_DISTANCE = "250";
var const_HMP_VALUE_IMAGE_POLARITY          = true;
var const_HMP_VALUE_EXPOSURE_TIME           = "500";
var const_HMP_VALUE_GAIN                    = "32";
var const_HMP_VALUE_GAINMULTIPLIER          = "7";// 0->7

 
var const_M220_DEFAULT_IMAGE_POLARITY          = false;
var const_M220_DEFAULT_GLOBAL_READING_DISTANCE = "100";
var const_M220_DEFAULT_EXPOSURE_TIME           = "300";
var const_M220_DEFAULT_GAIN                    = "8";
var const_M220_DEFAULT_GAINMULTIPLIER          = "0";// 0->7

/*Script Formatting */

var const_btt_SCPT_Open = 1;
var const_btt_SCPT_Save = 2;
var const_btt_SCPT_SaveAs = 3;
var const_btt_SCPT_Cut = 5;
var const_btt_SCPT_Copy = 6;
var const_btt_SCPT_Paste = 7;
var const_btt_SCPT_Delete = 8;
var const_btt_SCPT_Undo = 10;
var const_btt_SCPT_Redo = 11;
var const_btt_SCPT_WordWrap = 13;
var const_btt_SCPT_ShowLineNumber = 14;
var const_btt_SCPT_ShowEndOfLine = 15; 

var const_Gateway_Default = "0.0.0.0";


//////******Code Setup***********************************
//
//var const_CS_MoveUp = const_IS_MoveUp;
//var const_CS_MoveDown = const_IS_MoveDown;
//var const_CS_ZoomIn = const_IS_ZoomIn;
//var const_CS_ZoomOut  = const_IS_ZoomOut;
//var const_CS_ZoomToFit = const_IS_ZoomToFit;
//var const_CS_SaveImage = const_IS_SaveImage;
//var const_CS_ConfigTestRecord = const_IS_CroppingRegion;
//var const_CS_List_Grid= const_IS_List_Grid ;
//var const_CS_Play = const_IS_Play;
//var const_CS_Capture = const_IS_Capture;
////
//////******Reading Phase***********************************
//
//var const_RP_Play = const_IS_Capture;
//var const_GR_Play = const_IS_Capture;
//var const_DF_Play = const_IS_Capture;
//var const_OS_Play = const_IS_Capture;
//
//var const_RP_AddAcquisitionSequence = const_IS_MoveUp;
//var const_RP_ZoomIn = const_IS_MoveDown ;
//var const_RP_ZoomOut  = const_IS_ZoomToFit ;
//var const_RP_ZoomToFit = const_IS_ZoomIn;
//
//
//
//////******Good Read Setup***********************************
//var const_GR_AddCode = const_IS_MoveUp ;
//
//////******Code Relatied Field***********************************
//
//var const_DF_CodeRelatedField = const_IS_MoveUp;
//var const_DF_GlobalStatisticField = const_IS_MoveDown;
//var const_DF_GlobalReadingField= const_IS_ZoomIn;
//var const_DF_CustomField= const_IS_ZoomOut;
//var const_DF_DiagnosticField = const_IS_ZoomToFit;
//var const_DF_CodeGradingField = const_IS_SaveImage;
//var const_DF_Padding = 5
//////******Output Setup**********************************
//
//var const_OS_ZoomIn = const_IS_MoveUp;
//var const_OS_ZoomOut  = const_IS_ZoomIn ;
//var const_OS_ZoomToFit = const_IS_MoveDown;


//var const_
//var const_
//var const_

