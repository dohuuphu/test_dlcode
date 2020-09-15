

/*Installation*/
var pathPrgData = "C:\\ProgramData\\Datalogic";
var pathPrgFile = "C:\\Program Files (x86)\\Datalogic";
var pathUsrConfig = "C:\\Users\\Administrator\\AppData\\Local\\Datalogic_SpA";


//current build
var pathCurrGUIsetup = "D:\\Builds\\tags\\release\\IVS UI 1.8\\DL.CODE 1.8.0";
var versionCurrBuild = "DL_CODE_1_8_0-7-ALPHA02" ;
var guiCurrVersion = "DL.CODE 1.8.0";
var exeCurrBuild = guiCurrVersion +  "_Setup.exe";

//last official build
var pathLstUIsetup = "D:\\Builds\\tags\\release\\IVS UI 1.7";  
var versionLstBuild = "DL_CODE_1_7_0-95-RC2" ;
var guiLstVersion = "DL.CODE 1.7.0";
var exeLstBuild = guiLstVersion +  "_Setup.exe";



var pathCCleaner = "C:\\Program Files\\CCleaner\\CCleaner64.exe";


/*upgrade*/
var const_lastVersionNo = "1.7.0";
var const_currVersionNo = "1.8.0";

var const_currLoaderNo =  "4.4.2.99";  
var const_currVLlibrary  = "VL5.12.13U.50331646.10";
                            
  

 var const_lastPATH_Firmware                = "C:\\ProgramData\\Datalogic\\DL.CODE " + const_lastVersionNo + "\\DevicePackages"; 
 var const_currPATH_Firmware                = "C:\\ProgramData\\Datalogic\\DL.CODE " + const_currVersionNo + "\\DevicePackages";
 
 
 var lastListPgks = [ "MatrixN_M120_"              +  const_lastVersionNo+ ".package",
                      "MatrixN_M220_"              +  const_lastVersionNo+ ".package",
                      "MatrixN_M300N_M410N_M210N_" +  const_lastVersionNo+ ".package",
                      "MatrixN_M450N_"             +  const_lastVersionNo+ ".package" ];
                     
                     
 var currListPgks = [ "MatrixN_M120_"             +  const_currVersionNo+ ".package" ,
                     "MatrixN_M220_"              +  const_currVersionNo+ ".package",
                     "MatrixN_M300N_M410N_M210N_" +  const_currVersionNo+ ".package",
                     "MatrixN_M450N_"             +  const_currVersionNo+ ".package" ];
 
 var const_FILENAME_Firmware            = "MatrixN_M300N_M410N_M210N_"+ const_currVersionNo+ ".package";
 var const_timeRestart = 30;
