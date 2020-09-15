/**
   Labels exist on DL.CODE
*/



var const_lb_File = "File";
var const_lb_Options = "Options";
var const_lb_Open = "Open";
var const_lb_Save = "Save";
//***********Message text ********************
var const_DoubleClick_Drag          = "Double-click or drag a Device here to select it";
var const_ChangeUserBasic           = "Current task will be closed. Do you want to proceed?";
var const_TmpConfigLost             = "Current device temporary configuration will be lost. Do you want to proceed?";
var const_Confirm_Reset             = "Do you want to restart the device?";
var const_Confirm_GettingStarted    = "Last changes haven\'t been saved. Are you sure you want to continue?";
var const_Confirm_GettingStartedCluster    ="Last changes haven't been saved on Cluster. Are you sure you want to continue?";
var const_DeviceIsConnected         = "This device is already connected.";
var const_Device_Attention          = "Attention: an Error occurred while attempting to connect to device! Please, make sure device is connected to your PC.";
var const_Device_ConnectionLost     = "Connection to remote device lost. Please, make sure device Ethernet port is connected to your LAN. Would you like to attempt a new  connection?";                                         
var const_Confirm_Backup            = "Temporary configuration will be not included in the backup. Do you want to proceed?";
var const_OperationFailed           = " Attention: operation Failed. Please, open  Log file available on C";                                      
var const_Unrecoverable             = "Unrecoverable error. Restart the application. (Description: A critical error occurred, see log for more details. Application will be closed.\n(C:\\ProgramData\\Datalogic\\DL.CODE 1.4\\Log))";
var const_CannotSaveConfiguration   = "Cannot save configuration.";
var const_UpdatingFirmware          = "Firmware upgrade in progress: Do not turn off or unplug the device!";
var const_DeviceRestart             = "Attention: device is being restarted and changes will be applied at next boot!";
var const_RunningConfigChange       = "Running configuration will be changed. Proceed?";
var const_IP_INVALID                = "Attention: IP Address isn\'t valid; please enter a valid IP Address!";
var const_SAVECONFIG_ERR            = "Warning: the present configuration can't be saved on Device. Please check your settings and see log for more information.";
var const_NEW_ENVIROMENT            = "New environment settings will be active at next device reset. Do you want to reset the device now?";
var const_SAVECONFIG_CONF           ="Are you sure you want to overwrite existing configuration?";
var const_DPM_CANNOTFOUND           ="Autolearn didn't find any result. Please be sure selected image includes at least one code.";

var const_Device_Backup_ProgressBar        = "Device backup. Please wait...";
var const_Device_Restore_ProgressBar       = "Firmware restore in progress: Do not turn off or unplug the device!";
var const_Device_ProgressBar_Comminicating = "Communicating with device. Please wait…";
var const_Device_Backup_ProgressBar_EXT    = "Backup to external storage device. Please wait...";
var const_Restore_BM100_ProgressBar        = "Restore from external storage device. Please wait...";


var const_Backup_SUCCESS                  = "Operation completed successfully!";
var const_Restore_SUCCESS                 = "Restore defaults procedure completed successfully. The device will restart in order to apply changes!";
var const_Restore_BM100_SUCCESS           = "Restore from external storage device completed successfully. The device will restart in order to apply changes!";
var const_Restore_SingleReader_SUCCESS    = "Restore procedure completed successfully. The device will restart in order to apply changes!";
var const_Confirm_Backup_IncludeFirmware  = "Do you want to include firmware?";


var const_Restore_DefaultEnvironment              = "Restore to default Environment. Are you sure to proceed?";
var const_Restore_DefaultStartupConfiguration     = "Restore default Startup Configuration. Are you sure to proceed?";
var const_Restore_FactoryDefaults                 = "Restore Factory Defaults. Are you sure to proceed?";

var const_BM100_NOTCONNECTED            = "External storage device is not connected.";
var const_IncompatibleModel             ="Restore procedure failed. Incompatible Model!";
var const_confirm_DELETE_DEFAULT_JOB    ="You're attempting to delete the current device startup configuration. Do you want to proceed and change it to Default?";
var const_Restore_FAIL                  = "failed"; 


var const_msg_GoodRead = "Good Read";
var const_msg_NoRead = "No Read";
var const_msg_MatchCode = "Match Code";
var const_msg_NoMatchRead = "No Match Code";


var lb_DeviceEnvironmentConfiguration = "Device Environment Configuration";   
var lb_DeviceIsRestarting = "Devices is restarting and applying changes...";                                   
//********************
//Menu bar - File
var const_lb_File_GettingStarted = "Getting Started";
var const_lb_File_Open = "Open";
var const_lb_File_Save = "Save";
var const_lb_File_Setup_Internal_Network = "Setup Internal Network";
var const_lb_File_Monitor = "Monitor";
var const_lb_File_Exit= "Exit";
var const_lb_File_Open_Config_PC = "Open Configuration from PC";
var const_lb_File_Open_Config_Device = "Open Device Configuration";
var const_lb_File_Save_Config_PC = "Save Configuration on PC";
var const_lb_File_Save_Config_Device = "Save Configuration on Device";
var const_lb_SaveNewConfiguration = "Save New Configuration";
var const_lb_OverwriteConfig = "Overwrite an existing configuration";
var const_lb_SetStartupConfig = "Set as Startup Configuration";
var const_lb_ExposureTime_Result = "Exposure Time (µs) :  ";



//*********************
//Menu bar - Options

var const_lb_Options_Change_Language = "Change Language";
var const_lb_Options_UI_Settings = "UI Settings";
//var const_lb_Options_Change_Log_Level = "Change Log Level";
//linhtnguyen comment 
var const_lb_Options_Log = "Log";
var const_lb_Options_Change_Log_Level = "Change Log Level";
//
var const_lb_Options_Change_User = "Change User"
var const_lb_Options_Restore_To_Default = "Restore UI Layout to Default";


//Options change language
lb_Italian		= "Italian (Italiano)";	
lb_English		= "English";	
lb_Chinese		= "Chinese (??)";		// wildcard ? - chacracter
lb_German		= "German (Deutsch)";	
lb_Japanese		= "Japanese (???)";	// wildcard * - all
lb_English_Default		= "English";	

// Options Change Log Level
var const_lb_Verbose = "Verbose";
var const_lb_Information = "Information";
var const_lb_Error = "Error";

// Options Log Level (new) -- linhtnguyen comment
var const_lb_SaveAllLogs = "Save All Logs";
var const_lb_ResetLog = "Reset Log";

//Options User
var const_lb_InstallerBasic	 = "Installer-Basic";
var const_lb_InstallerExpert = "Installer-Expert";
var const_lb_UserBasic	 = "User-Basic";

const_lb_Device  = "Device";
const_lb_ConnectToDevice  = "Connect to Device";
const_lb_FindDevices  = "Find Devices";
const_lb_Settings  = "Settings";
    const_lb_ConfigurationSettings  = "Configuration Settings";
    const_lb_ResetStatistics  = "Reset Statistics";
    const_lb_ResetDiagnostics  = "Reset Diagnostics";
    const_lb_ViewConfigurationHMPShortcuts  = "View Configuration HMP Shortcuts";
    const_lb_WebMonitorSecuritySettings  = "Security Settings";
const_lb_UpdatePackage  = "Update Package";
const_lb_MultiDevicePackageUpdate="Multi-Device Package Update";
const_lb_ChangeCurrentConfiguration  = "Change Current Configuration";
const_lb_RestartDevice  = "Restart Device";
const_lb_Backup_Restore  = "Backup / Restore";
    //******
    const_lb_SingleReaderBackup  = "Single Reader Backup???";
    const_lb_SingleReaderRestore  = "Single Reader Restore???";
    const_lb_BackupCurrentInternalNetworkConfigurations  = "Backup current Internal Network configurations???";
    const_lb_InternalNetworkReplacement  = "Internal Network replacement???";
    const_lb_BackupToExternalStorageDevice  = "Backup to external storage device";
    const_lb_RestoreFromExternalStorageDevice  = "Restore from external storage device";
    const_lb_RestoreDefaults  = "Restore Defaults...";
        //*************
        const_lb_RestoreDefaultEnvironment  = "Restore Default Environment";
        const_lb_RestoreDefaultStartupConfiguration= "Restore Default Startup Configuration";
        const_lb_RestoreFactoryDefaults  = "Restore Factory Defaults";
        
const_lb_RAMImageBufferSettings  = "RAM Image Buffer Settings";
const_lb_Maintenance  = "Maintenance";
const_lb_DeviceRecalibration  = "Device Recalibration";
const_lb_PacktrackCalibration  = "Packtrack Calibration";
//**************
const_lb_Help = "Help";
const_lb_About = "About";
const_lb_UserGuide = "DL.CODE User's Guide";
//*****************
//icons on tool bar 

const_lb_GettingStarted = "Getting Started";
const_lb_FindDevices = "Find Devices";
const_lb_OpenDeviceConfiguration = "Open Device Configuration";
const_lb_SaveDevice = "Save on Device";
const_lb_LoadPC = "Load from PC";
const_lb_SavePC = "Save on PC";
const_lb_SaveTemporyMemory = "Save Configuration in Tempory Memory";
const_lb_SwitchConfiguration_Monitor = "Switch to Configuration/Monitor";
//*****************


const_lb_HelpRightPanel ="Help right panel";
const_lb_DeviceSelection  = "Selected Device Details";
const_lb_DeviceListArea  = "Device List Area";
lb_Name = "Name";
lb_Model = "Model";
lb_LayoutType = "Layout Type";
//lb_InternalNetworkRole = "Internal Network Role";
lb_Status_1 = "Status";
lb_StartupInfo = "Startup Info";
lb_ApplicationSWVersion = "Application SW Version";                           
lb_LoaderVersion = "Loader Version";


const_lb_SelectedDeviceInformationArea  = "Selected Device Information Area";
const_lb_Tasks  = "Tasks Selection";
const_lb_OpenDeviceConfiguration  = "Open Device Configuration";
const_lb_SetupInternalNetworkConfiguration  = "Setup Internal Network Configuration";
const_lb_PackTrackCalibration  = "Packtrack Calibration";
const_lb_MonitorDevice  = "Monitor Device";
const_lb_webMonitor  = "Web Monitor";
const_lb_PresentationMode  = "Presentation Mode";
//***********************
//Device Environment Configuration

const_lb_DeviceEnvironmentConfiguration = "Device Environment Configuration";
const_lb_DeviceName  = "Device Name";
const_lb_StartupConfiguration  = "Startup Configuration";
const_lb_AboutDevice  = "About Device...";
const_lb_DeviceModel  = "Device Model";		
const_lb_ApplicationSWVersion  = "Application SW Version";
const_lb_BootSWVersion  = "Boot SW Version";
const_lb_LoaderSWVersion  = "Loader SW Version";
const_lb_RecoverySWVersion  = "Recovery SW Version";	
const_lb_VLVersion  = "VL Version";
const_lb_MVLVersion  = "MVL Version";
const_lb_EthernetSettings  = "Ethernet Settings";
const_lb_UseDHCP  = "Use DHCP";	
const_lb_IPAddress  = "IP Address";	
const_lb_SubnetMask  = "Subnet Mask";	
const_lb_GatewayAddress  = "Gateway Address";	
const_lb_DNS1Address  = "DNS 1 Address";	
const_lb_KeepAliveTimeout  = "Keep Alive Timeout (ms)";	
const_lb_InternalNetworkSettings  = "Internal Network Settings";	
const_lb_ReadingPointAddress  = "Reading Point Address";	
const_lb_InternalNetworkRole  = "Internal Network Role";	
const_lb_Master  = "Master";	
const_lb_Slave  = "Slave";	
const_lb_InternalNetworkBaudRate  = "Internal Network Baud Rate";
const_lb_MasterDeviceType ="Master Device Type";
const_lb_19200 = "19200";
const_lb_38400 = "38400";
const_lb_57600 = "57600";
const_lb_125Kb = "125Kb";
const_lb_250Kb = "250Kb";
const_lb_500Kb = "500Kb";
const_lb_1Mb   = "1Mb";

const_lb_XPRESSConfiguration  = "X-PRESS Configuration";	
const_lb_ConfigurationStatus  = "Configuration Status";	
const_lb_X_PRESSFunction1  = "X-PRESS Function 1";	
const_lb_X_PRESSFunction2  = "X-PRESS Function 2";	
const_lb_X_PRESSFunction3  = "X-PRESS Function 3";	
const_lb_X_PRESSFunction4  = "X-PRESS Function 4";	
const_lb_NumberOfSamples  = "Number of Samples";	
const_lb_TestTimeout   = "Test Timeout (s)";	
const_lb_AimTimeout   = "Aim Timeout (s)";	
const_lb_SavingOptions  = "Saving Options";	
const_lb_Temporary  = "Temporary";	
const_lb_Permanent  = "Permanent";	
const_lb_ConfigurationName  = "Configuration Name";
const_lb_AutolearnTimeout  = "Autolearn Timeout (s)";	
const_lb_DevicePosition  = "Device Position";	
const_lb_NearPlaneDistance  = "Near Plane Distance (mm)";	
const_lb_FarPlaneDistance   = "Far Plane Distance (mm)";	
const_lb_MinPackDistance   = "Min Pack Distance (mm)";	
const_lb_LEDConfiguration  = "LED Configuration";	
const_lb_SelectCOMLEDFunction  = "COM LED Function";
const_lb_MainSerialPortRX  = "Main Serial Port RX";	
const_lb_MainSerialPortTX  = "Main Serial Port TX";	
const_lb_EnableBeeperStatus  = "Beeper Status";	
const_lb_EnableBeeperActiveEvents  = "Beeper Activation Events";	
const_lb_GoodRead_Success_CodeMatch  = "Good Read / Success / Code Match";	
const_lb_MultipleRead  = "Multiple Read";
const_lb_NoRead_Failure_NoMatch= "No Read / Failure / No Match";	
const_lb_BeeperDeactivationTimeout  = "Beeper Deactivation Timeout (ms)";
const_lb_LEDsDeactivationTimeout  = "LEDs Deactivation Timeout (s)";	
const_lb_FocusingPointerStatus  = "Focusing Pointer Status";	
const_lb_Disabled  = "Disabled";	
const_lb_AlwaysOn  = "Always On";	
const_lb_CalibrationOnly  = "Calibration Only";	
const_lb_MultipleReadTreatedAs  = "Multiple Read Treated As";
const_lb_NoRead  = "No Read";
const_lb_CompleteRead  = "Complete Read";	
const_lb_MaintenanceSettings  = "Maintenance Settings";
const_lb_CurrentIlluminatorModel  = "Current Illuminator Model";	
const_lb_PPI  = "PPI";	
const_lb_EnableBM100Detection  = "Enable BM100 Detection";	
const_lb_BM150DisplayLayout = "BM150 Display Layout";

const_lb_Keyboard_Layout =  "Keyboard Layout";

//**************
const_lb_ConfigurationSettings = "Configuration Settings";


const_lb_Configuration  = "Configuration";	
const_lb_ConfigurationName  = "Configuration Name";	
const_lb_ConfigurationVersion  = "Configuration Version";
const_lb_Statistics  = "Statistics";	
const_lb_Session  = "Session (Num. Reading Phases)";	
const_lb_EnabledCounters  = "Enabled Counters";
const_lb_EnableElapseTime  = "Enable Elapse Time..";	
const_lb_ProtocolIndexErrors  = "Protocol Index Errors";	
const_lb_WebsentinelConfiguration  = "Websentinel Configuration";
const_lb_WebsentinelMonitorStatus  = "Websentinel Monitor Status";	
const_lb_Disabled  = "Disabled";	
const_lb_Enabled  = "Enabled";
const_lb_MasterDiagnosticCheckPeriod   = "Master Diagnostics Check Period (sec.)";	


//************
//
//Connect to device


const_lb_ConnectDevice  = "Connect to device";
const_lb_IpAddress  = "Ip Address";	
const_lb_IpAddressWarning  = "Attention: before pressing Connect check Gateway settings on PC";

//*******************
//Save Configuration on Device (Cluster) 

const_lb_SaveNewConfiguration = "Save New Configuration (Enter Configuration name)";	
const_lb_OverwriteExistingConfiguration  = "Overwrite an existing Configuration";
const_lb_SetStartupConfiguration  = "Set as Startup Configuration";	
const_lb_CloneMasterConfigurationSlaves  = "Clone Master Configuration on Slaves";
const_lb_SaveOnSlaveDevice=  "Save on Slave Device";
 	
//***********************************
//label UI Settings

//UI Settings	
//Configuration Tab
lb_UISettingsConfigTab = "Configuration";
lb_ConfigConsoleSettings = "Console Settings";		
lb_CharacterFormat = "Character Format";			
lb_Dec		= "Dec";
lb_Hex	= "Hex";	
lb_Symbol	= "Symbol";		
lb_DisplayTimestamp = "Display Timestamp";	
lb_Timestamp = "Timestamp"	
lb_Default	= "Default";	
lb_Short	= "Short";	
lb_DontShowSpecialCharacter = "Don\'t show Special Characters";
lb_ConsoleOutputFolder  = "Console Output Folder";
lb_UseDefaultConsoleOutputFolder  = "Use Default Console Output Folder";
lb_AutomaticallyStartConsoleLog  = "Automatically Start Console Log";
lb_ResetConsoleLogAtStartup  = "Reset Console Log at Startup";
lb_UIImageBuffer  = "UI Image Buffer";
lb_BufferSize  = "Buffer size";
lb_LocalImagesFolderSettings = "Local Images Folder Settings";		
lb_MaxDownloadedImagesFolderSize  = "Max. Downloaded Images folder size (MB)";
lb_DPMImagesDatabase = "DPM Images Database";
lb_ImagesDatabaseBufferSize = "Images Database Buffer size";
lb_ViewWindow = "View Window";
lb_UIImageBuffer = "UI Image Buffer";
lb_Console = "Console";
lb_SimulatorWindow = "Simulator window";
lb_Result = "Result";
lb_Events = "Events";
lb_EnableCodeLocalizationMap = "Enable Code Localization Map";
lb_FocusCalibration = "Focus Calibration";
lb_DPMImagesDatabase = "DPM Images Database";
lb_DisplayPhaseOnImage = "Display Phase on Image";
lb_AutoStartRunModeConfiguration = "Automatically start Run Mode in Configuration";
lb_DisplayImageResolution = "Display Image Resolution";
lb_DisplayImageName = "Display Image Name";
lb_PackTrackCalibration = "Packtrack Calibration";
lb_ShowOverlay = "Show Overlay";
lb_DeviceRecalibration = "Device Recalibration";
lb_ShowRecalibrationResults = "Show Recalibration Results";


//add new 1.5.0a5
lb_MACAddress = "MAC Address";
 //Monitor Tab
lb_UISettingsMonitorTab ="Monitor";
lb_MonitorImagesOptions = "Monitor Images Options";
lb_EnableImageAndResultsTransfer = "Enable Image And Results Transfer";
lb_DisplayROI = "Display ROI on Image";
lb_DisplayPhaseOnImage = "Display Phase on Image";
lb_ImagesScalingFactor = "Image Scaling Factor (%)";
//lb_ViewWindow = "View Window";
//lb_Console = "Console";
lb_Configuration = "Configuration";
lb_EnableStatistics_Diagnostics = "Enable Statistics/Diagnostics Refresh";
lb_Statistics_DiagnosticsRefreshRate = "Statistics/Diagnostics Refresh Rate (ms)";
lb_AutoStartRunModeMonitor = "Automatically start Run Mode in Monitor";
 
//Global Settings tab
lb_LogOptions = "Log Options";
lb_SimulatorSettings = "Simulator Settings"; 
lb_FindDevices ="Find Devices";
lb_UISettingsGlobalSettingsTab = "Global Settings";


lb_MaxNumberOfFiles = "Max. Number Of Files";
lb_MaxFileSize = "Max. File Size"; 

lb_SimulatorImagesFolder = "Simulator Images Folder";
lb_UseDefaultFolder = "Use Default Folder";

lb_M120_210_000 = "M120-210-000";
lb_M210N_235_111 = "M210N-235-111";


lb_M300N_482_010 = "M300N-482-010";
lb_M300N_712_010 = "M300N-712-010";
lb_M300N_772_010 = "M300N-772-010";
lb_M320_320_020  = "M320-320-020";
lb_M410N_500_010 = "M410N-500-010";
lb_M410N_700_010 = "M410N-700-010";
lb_M410N_XRF_H2x = "M410N-XRF-H2x";

//add from 1.6.0
lb_M220_355_040 = "M220-355-040";
lb_M220_382_010 = "M220-382-010";
lb_M420_420_003 = "M420-420-003";
lb_M420_420_005 = "M420-420-005";
lb_M420_420_009 = "M420-420-009";
lb_M420_420_012 = "M420-420-012";

lb_M450N_800_030 = "M450N-800-030";
lb_StartSimulator = "Start Simulator with DL.CODE";
lb_FindDevices = "Find Devices";
lb_EnableAutomaticDeviceDiscovery = "Enable Automatic Device Discovery"; 	
lb_EnableSerialDevicesDiscovery ="Enable Serial Devices Discovery";

lb_IPAddress = "IP Address";	
lb_Attention_ConnectToDevice = "Attention: before pressing Connect check Gateway settings on PC";


lb_ConfigurationSettings = "Configuration Settings";
lb_Configuration = "Configuration";
lb_ConfigurationName = "Configuration Name";
lb_ConfigurationVersion = "Configuration Version";
lb_Statistics = "Statistics";
lb_Session = "Session (Num. Reading Phases)";
lb_EnabledCounters = "Enabled Counters";
lb_WebsentinelConfiguration = "Websentinel Configuration";
lb_WebsentinelMonitorStatus = "Websentinel Monitor Status";
lb_Disabled = "Disabled";
lb_Enabled = "Enabled";

lb_M120210_000 = "M120 210-000";
lb_M210N235_111 = "M210N 235-111";
lb_M300N482_010 = "M300N 482-010";
lb_M410N500_010 = "M410N 500-010";
lb_M410N700_010 = "M410N 700-010";
lb_M410NXRF_H2x = "M410N XRF-H2x";
lb_M450N800_030 = "M450N 800-030";

//add from 1.7.0 -- linhtnguyen comment
lb_M300N712_010 = "M300N 712-010";
lb_M300N772_010 = "M300N 772-010";

//add from 1.5.0
 
lb_M220355_040 = "M220 355-040";
lb_M220382_010 = "M220 382-010";
lb_M420420_003 = "M420 420-003";
lb_M420420_005 = "M420 420-005";
lb_M420420_009 = "M420 420-009";
lb_M420420_012 = "M420 420-012";


lb_Image = "Image";
lb_Load = "Load";
//lb_SaveCurrentImage = "Save Current Image";
lb_SaveCurrentImage = "Save Image";
lb_SaveImageBuffer = "Save Image Buffer";
lb_Clean = "Clean";
lb_AddToImagesDataBase = "Add to Images Database";
lb_AddToSimulatorFolder = "Add to Simulator Folder";
lb_Rotate180degrees = "Rotate 180°";
lb_CodeOptions = "Code Options";
lb_DisplayResultsOnImage = "Display Results on Image"; 

var const_lb_ImagesSaving = "Images Saving";
var const_lb_MatrixTCPClient = "Reader TCP Client";
var const_lb_MatrixTCPServer = "Reader TCP Server";
var const_lb_MatrixUDPClient = "Reader UDP Channel";
var const_lb_MatrixFTPClient = "Reader FTP Client";
var const_lbID_Net = "ID-Net";
var const_lb_Main = "Main";
var const_lb_AUX = "AUX";

///*********************************************************************
var const_lb_ConfigurationTestRunning = "Configuration Test Running..";

var lb_SerialParity = "Serial Parity";
var lb_SerialDataBits = "Serial Data Bits";
var lb_SerialStopBits = "Serial Stop Bits";
var lb_BaudRate_921600 = "Baud Rate 921600";
var lb_BaudRate_460800 = "Baud Rate 460800";
var lb_BaudRate_230400 = "Baud Rate 230400";
var lb_BaudRate_115200 = "Baud Rate 115200";
var lb_BaudRate_57600  = "Baud Rate 57600";
var lb_BaudRate_38400  = "Baud Rate 38400";
var lb_BaudRate_19200  = "Baud Rate 19200";
var lb_BaudRate_9600   = "Baud Rate 9600";
var lb_BaudRate_4800   = "Baud Rate 4800";
var lb_BaudRate_2400   = "Baud Rate 2400";
var lb_BaudRate_1200   = "Baud Rate 1200";

///Image Setting
var lb_M120N_InteralLighting = ["Disabled" , "Very High-Power Strobed", "High-Power Strobed"];// default "Very High-Power Strobed"
var lb_M210N_InteralLighting = ["Disabled" , "Always On" , "Very High-Power Strobed", "High-Power Strobed"];// default "Very High-Power Strobed"
var lb_M300N_InteralLighting = ["Disabled" , "Always On" , "Very High-Power Strobed", "High-Power Strobed"];// default "Very High-Power Strobed"
var lb_M410N_InteralLighting = ["Disabled" , "Always On" , "Very High-Power Strobed", "High-Power Strobed", "Medium-Power Strobed", "Continuos-Power Strobed"];// default "Very High-Power Strobed"
var lb_M450N_InteralLighting = ["Disabled" , "Very High-Power Strobed", "High-Power Strobed", "Continuos-Power Strobed"];// default "Very High-Power Strobed"

//STATUS BAR
var lb_DeviceModel = "Model : ";
var lb_ConfigurationSchemaRelease = "Configuration Schema Release";
var lb_DeviceSWRelease = "Device SW Release : "
var lb_User = "User : ";
var lb_IPAddress_StatusBar = "IP Address :  ";
//var lb_ConfigurationSchemaRelease = "Configuration Schema Release :  ";
var lb_Monitor = "Monitor";
var lb_PackTrack = "Packtrack Calibration : ";

//Symbology code
//POSTAL
var lb_CodeTypePostal = "Postal";

var lb_AustraliaPost      = "Australia Post";
var lb_RoyalMail          = "Royal Mail 45 State";
var lb_KIXCode            = "KIX Code";
var lb_JapanPost          = "Japan Post";
var lb_PLANET             = "PLANET";
var lb_POSTNET            = "POSTNET";
var lb_IntelligentMail    = "Intelligent Mail";
var lb_SwedishPostal      = "Swedish Postal";
var lb_FinnishPost        = "Finnish Post";

//2D
var lb_CodeType2D   = "2D";

var lb_DMECC200     = "DMECC200";
var lb_QR           = "QR";
var lb_MICROQR      = "MICROQR";
var lb_AZTEC        = "AZTEC";
var lb_MAXICODE     = "MAXICODE";
var lb_DOTCODE      = "DOTCODE";
//1D
var lb_CodeType1D   = "1D";

var lb_PDF417     = "PDF417";
var lb_MICROPDF   = "MICROPDF";
var lb_CODE128    = "CODE128";
var lb_GS1_128    = "GS1-128";
var lb_CODE39     = "CODE39";
var lb_INT2OF5    = "INT2OF5";
var lb_PHARMA     = "PHARMA";
var lb_MSI        = "MSI";
var lb_PLESSEY    = "PLESSEY";
var lb_STD2OF5    = "STD2OF5";
var lb_MTX2OF5    = "MTX2OF5";
var lb_CODABAR    = "CODABAR";
var lb_GS1EXP     = "GS1 DATABAR EXPANDED";
var lb_GS1EXPSTK  = "GS1 DATABAR EXPANDED STACKED";
var lb_GS1LIM     = "GS1 DATABAR LIMITED";
var lb_GS1        = "GS1 DATABAR";
var lb_GS1STK     = "GS1 DATABAR STACKED";
var lb_CODE93     = "CODE93";
var lb_EAN13      = "EAN13";
var lb_EAN8       = "EAN8";
var lb_UPCA       = "UPCA";
var lb_UPCE       = "UPCE";



var lb_FocusAutolearn = "This procedure will perform Device Calibration.";


var lb_CodeAutolearn_Add = "Add";
var lb_CodeAutolearn_Replace = "Replace";
var lb_CodeAutolearn_Discard = "Discard";


var lb_CodeCombination = "Code Combination";
var lb_CodeCollection = "Code Collection";
var lb_CodePresentation = "Code Presentation";
var lb_MatchCode = "Match Code";


var lb_Continuous = "Continuous";
var lb_OneShot = "One Shot";
var lb_PhaseMode = "Phase Mode";
var lb_PackTrackMode = "Packtrack Mode";
var lb_ConfigurationTestRunning = "Configuration Test Running..";

var lb_AddIMGDB = "Add Failure images to DB";
var lb_SaveIMGonLocalDB = "Save Failure Images on Local DB";

var lb_MasterDeviceType = "Master Device Type";
var lb_arr_Statistics = [
                    "Elapsed Time (sec)",
                    "Phase On Count",
                    "Pack Count",
                    "Valid Code Count",
                    "Reading Phase Count",
                    "Trigger Overrun Count",
                    "Number of Decoded Codes",
                    "Encoder Errors Count",
                    "Number of Spurious Phases",
                    "Good Read Count",
                    "Partial Read Count",
                    "No Read Count",
                    "Multiple Read Count",
                    "Successful Collection Count",
                    "Failed Collection Count",
                    "Match Code Count",
                    "No Match Code Count",
                    "VL Filtered Codes",
                    "Phase Overrun Count",
                    "Unexpected Phase On Count",
                    "Multiple Phase On Count",
                    "Valid Packs",
                    "Pack Too Short",
                    "Pack Too Close",
                    "Pack Too Long",
                    "Average Pack Size (mm)",
                    "Average Pack Distance (mm)",
                    "Already Transmitted Parcel's Codes",
                    "Discarded Codes",
                    "Codes In Parcel",
                    "Codes Out of Parcel",
                    "Frame Rate",
                    "Conveyor Speed (mm/s)",
                    "Encoder Frequency (Hz)",
                    "Filtered Codes Count",
                    "Average Codes or Labels Found",
                    "Average Decoding Time (ms)",
                    "Image Acquisition Counter",
                    "Received Protocol Index",
                    "Protocol Index Errors",
                    "Good Protocol Index",
                    "Code Overrun Counter",
                    "Average Code Overrun",
                    "Average Image Acquisition Time",
                    "Average Image Processing Time"
                  ];
                  
//Quick Setup                  
var lb_quicksetup_note_1 = "This procedure will perform Automatic Setup on current Image Setting parameters.";
var lb_quicksetup_note_2 = "Choose between Static and Dynamic Tuning options:";
var lb_quicksetup_note_3 = "Select the type of code symbology to search for. \nIf you’re not sure select all. Only one code symbology will be found.";
var lb_quicksetup_note_4 = "Include or exclude the use of image filtering. \nNote: This can increase the time necessary to complete Automatic Setup.";
var lb_quicksetup_note_5 ="Choose the type of illumination to use for your application:";

var lb_Static = "Static";
var lb_Dynamic = "Dynamic"; 
var lb_Digimarc = "DWCODE™";
var lb_2DCode = "2D Codes";
var lb_1DCode = "1D Codes";
var lb_CodeReadingOptions = "Code Reading";
var lb_CodeGradingOptions = "Code Grading";
var lb_Polarized = "Polarized";
var lb_NonPolarized = "Non Polarized";


var lb_QuickSetup_Completed = "Status: Completed.";
var lb_QuickSetup_Failure = "Failure: no codes found inside image!";
var lb_QuickSetup_Failure2 = "Failure: inconsistent data returned by device. Please, restart procedure!";

var lb_SerialPort = "Serial Port";
var lb_SerialParity = "Serial Parity";
var lb_SerialDataBits = "Serial Data Bits";
var lb_SerialStopBits= "Serial Stop Bits";


var lb_SC5000Status = "SC5000 Status";
var lb_SC5000Configuration = "SC5000 Configuration";
var lb_CrisplantConfiguration = "Crisplant Configuration";

var lb_SC5000IPAddress = "SC5000 IP Address";
var lb_SC5000Port = "SC5000 Port";
var lb_SC5000StartPosition = "SC5000 Start Position";
var lb_SC5000HeartbitTimeout = "SC5000 Heartbeat Timeout";
var lb_SC5000DiagnosticTimeout = "SC5000 Diagnostic Timeout";
var lb_Version = "Version";
var lb_Length = "Length";
var lb_HeartbeatTimeout = "Heartbeat Timeout";
var lb_Channels = "Channels";



var lb_Default_SC5000IPAddress = "172.27.101.220";
var lb_Default_SC5000Port = "5100";
var lb_Default_SC5000StartPosition = "32";
var lb_Default_SC5000HeartbitTimeout = "60";
var lb_Default_SC5000DiagnosticTimeout = "2";
var lb_Default_Version = "P10";
var lb_Default_HeartbeatTimeout = "60";
var lb_Default_Channels = "Channels";
var lb_MatrixDevice = "Matrix Device";
var lb_ControllerSC4000 = "Controller SC4000";
var lb_StartAutomaticSetup = "Start Automatic Setup";
var lb_QuickSetup = "Automatic Setup";
var lb_CombinationMode = "Code Combination";
var lb_CollectionMode = "Code Collection";
var lb_PresentationMode = "Code Presentation";
var lb_MatchCode = "Match Code";
var lb_SetupInternalNetwork = "Current device role is set to Slave. By pressing OK, device role will be changed to Master. Make sure the selected device isn't installed on a Network where another Master device is running." 
var lb_RightClickAddDevice = "Right Click to add a Device";
var lb_StartNetAutoset = "Start Net Autoset";
var lb_ManageConfiguration = "Manage Configuration";
var lb_SetDefaultMultidata = "Set Default Multidata Configuration";
var lb_SetDefaultSynchronizedPhaseMode = "Set Default Synchronized Phase Mode Configuration";
var lb_SetDefaultSynchronizedPackTrack = "Set Default Synchronized PackTrack Configuration";
var lb_Status = "Status :  ";
var lb_Type = "Type :  ";
var lb_InternalNetworkRole = "Internal Network Role :  ";
var lb_IPAddress_2 = "IP Address :  ";
var lb_SerialNumber = "Serial Number :  ";
var lb_DeviceDescription = "Device Description :  ";
var lb_PleaseSelect = "Please, select one of the following options:";
var lb_CloneMasterConfiguration = "Clone Master Configuration";
var lb_AcquirePPI_success = "PPI acquired";
var lb_AcquirePPI_failure =  "Test Chart not found. Please place the Grade A Barcode Test Chart in front of the reader!";

var lb_Waring_Add_FB_Channel = "Cannot add or number is greater than the maximum allowable";
var lb_Waring_HMS_BF         = "Attention: By enabling an HMS Fieldbus channel, the Serial Main channel is no longer available. If you are currently configuring via Serial Main channel, connection with remote device will be lost. To avoid this, click No and use any other available device channel to make this configuration. If you are already using a different channel, click Yes to proceed.";
