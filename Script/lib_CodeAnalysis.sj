//USEUNIT lib_CodeSetup
//USEUNIT lib_common
//USEUNIT lib_connection
//USEUNIT lib_const
//USEUNIT lib_deviceInfo 
//USEUNIT lib_OpenJob 
//USEUNIT lib_label
//USEUNIT lib_QuickSetup
//USEUNIT lib_CodeAutolearn 
//USEUNIT lib_SaveJob

/*require:  
-  set preriodics time
- 1 code is one symbology 
- code data no contain Seperate Character (;)-- lib_button.const_SeperateChar 
- Time Format: Default
- Don't show special characters 
- Presentation mode is correct with only 1 code.
*/


function tc_OperatingMode()
{       
        
        var arr =  [ lib_label.lb_MatchCode  , lib_label.lb_CollectionMode ,lib_label.lb_CombinationMode, lib_label.lb_PresentationMode  ];
        
//        var arr = [lib_label.lb_MatchCode]; 
        for (var i = 0; i < arr.length; i++) 
        {
             if ( ! lib_validate.isDLCODERunning())
               lib_common.launchUI();  
             var ip = lib_deviceInfo.const_Device_IP_Adress;         
             if (lib_common.connectToDevice(ip))
             {         
                 if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                 {       
                        Indicator.PushText(" 1 code is one symbology \n code data no contain Seperate Character \n Time Format: Default \n Don't show special characters" );
                        Indicator.PopText();             
                        //perform Quick Setup
                        var resultQS = lib_QuickSetup.quickSetup(true,true,true , false);
                        Log.Message("Quick Setup:" + resultQS);
                        //perform Code Autolearn
                        var resultCodeAutolearn =  lib_CodeAutolearn.performCodeAutolearn (lib_label.lb_CodeAutolearn_Replace);
                        //go to Reading Phase
                        lib_button.clickReadingPhase();
                        //select Periofics
                        var pathTrigger =    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Trigger Type", 1);
                        pathTrigger.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("RadioButton", "", 1).ClickButton ();
                        //enter periodics time
                        pathTrigger.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Click();
                        pathTrigger.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").set_Text(lib_const.const_PeriodicsTime);
                        lib_button.ui_PlayAndPause(lib_const.const_PeriodicsTime *3, false);
                        //verify Periodic time
                        verifyPeriodicsTime(lib_const.const_PeriodicsTime);      
                        //verify Operating Mode                                        
                        selectOperatingMode (arr[i]);  
                        //save job with name = Operating Mode
                        lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, arr[i]  , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);
                        //switch to Monitor
                        lib_button.clickMenuMonitor();
                        //play and pause in Monitor mode
                        lib_button.ui_PlayAndPause(6000, true); 
                 } 
              }  
        }       
        lib_common.terminateUI();
}

/*
  *@function 
  *@param bttCombination {Object}
  *@param arrCode{Array}
*/
function processCombinationMode(bttCombination, arrCode)
{
    var flag = false;
    Indicator.PushText("Switch to COMBINATION");
    Indicator.PopText();
    bttCombination.Click();  
    //verify default Combination mode
    var pathCombination = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1)
    aqObject.CheckProperty(pathCombination.WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[1, Enabled]");    // No Read      
    aqObject.CheckProperty(pathCombination.WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[1, Treat as No Read]");     //Partial     
    aqObject.CheckProperty(pathCombination.WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[0, Disabled]"); // Multiple
    //verifyCombination_MatchCode
    flag =  verifyCombination_MatchCode (arrCode);              
    return flag;
}

/*
  *@function 
  *@param bttCollection {Object}
  *@param arrCode{Array}
*/
function processCollectionMode(bttCollection, arrCode)
{
     var flag = false;
     Indicator.PushText("Switch to COLLECTION");
     Indicator.PopText();
     //switch to Collection Mode
     bttCollection.Click(); 
     //verify Collection default mode
     var pathCollection =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1);
     aqObject.CheckProperty(pathCollection.WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Text", cmpEqual, "1");
     aqObject.CheckProperty(pathCollection.WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Text", cmpEqual, "1"); 
     aqObject.CheckProperty(pathCollection.WPFObject("ParamControl", "", 3).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[1, Enabled]");
     aqObject.CheckProperty(pathCollection.WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[0, Disabled]");
           
     //set Max Expected Code   
     var maxExpCode =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox");
     maxExpCode.Keys("^a[Del]");
     maxExpCode.Keys(arrCode.length);           
     maxExpCode.Keys("[Tab]"); 
     //verify Collection Mode         
     flag = verifyCollectionMode(arrCode);  
     return flag; 
}


/*
  *@function 
  *@param bttMatchCode {Object}
  *@param arrCode{Array}
*/
function processMatchCode (bttMatchCode, arrCode)
{
          var flag = false;
          Indicator.PushText("Switch to MATCH CODE");
          Indicator.PopText();
          //switch to Match Code
          bttMatchCode.Click(); 
          //verify Default Match code
          var pathMatchCode = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1);
          aqObject.CheckProperty(pathMatchCode.WPFObject("ContentExpander", "Match Code Events", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[1, Enabled]");
          aqObject.CheckProperty(pathMatchCode.WPFObject("MatchCodeDataView", "", 1).WPFObject("ContentExpander", "Match Code Data", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[0, User Defined]");
          aqObject.CheckProperty(pathMatchCode.WPFObject("MatchCodeDataView", "", 1).WPFObject("ContentExpander", "Match Code Data", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "Capture from decoded image", 1), "Enabled", cmpEqual, true);
          aqObject.CheckProperty(pathMatchCode.WPFObject("MatchCodeDataView", "", 1).WPFObject("ContentExpander", "Match Code Data", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("RangeTextBox", "", 1), "Text", cmpEqual, "*");
          aqObject.CheckProperty(pathMatchCode.WPFObject("MatchCodeDataView", "", 1).WPFObject("ContentExpander", "Match Code Data", 1).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("RangeTextBox", "", 1), "Text", cmpEqual, "?"); 
           //Capture data codes
          Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("MatchCodeDataView", "", 1).WPFObject("ContentExpander", "Match Code Data", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "Capture from decoded image", 1).ClickButton();
          //Verify Match Code
          flag =  verifyCombination_MatchCode (arrCode);             
          return flag;  
}

 
/*
  *@function 
  *@param bttPresentation {Object}
  *@param arrCode{Array}
*/
function processPresentation (bttPresentation, arrCode)
{
           var flag = false;
           Indicator.PushText("Switch to PRESENTATION");
           Indicator.PopText();
           bttPresentation.Click(); 
           //verify Default Presentation mode
           var pathPresentation = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1);
           aqObject.CheckProperty(pathPresentation.WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[0, Disabled]");
           aqObject.CheckProperty(pathPresentation.WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Text", cmpEqual, "1");                                                  
           aqObject.CheckProperty(pathPresentation.WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1), "wText", cmpEqual, "[2, Disabled]");
           //enable  Noread
           pathPresentation.WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1).ClickItem(1);
           //enter code Fliter Depth
           var codeFilterDepth = pathPresentation.WPFObject("ParamControl", "", 5).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox");
           codeFilterDepth.Keys("^a[Del]");
           codeFilterDepth.Keys(arrCode.length);           
           codeFilterDepth.Keys("[Tab]"); 
           // select Timeout Threshold
           pathPresentation.WPFObject("ParamControl", "", 6).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1).ClickItem(1);
           //enter Timeout Threshold = num Codes * periodicTime(milisecond)
           var timeoutThres = 3 * (lib_const.const_PeriodicsTime/1000) ;// cause sec = num Codes * periodicTime
           timeThrs = pathPresentation.WPFObject("ParamControl", "", 9).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox");Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 9).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox")
           timeThrs.Keys("^a[Del]");
           timeThrs.Keys(timeoutThres );           
           timeThrs.Keys("[Tab]");  
           Log.Message( verifyPresentationMode(arrCode, timeoutThres));
           Log.Message( verifyPeriodicsTime(lib_const.const_PeriodicsTime)); 
           
           //select Timeout Threshold and enter Timeout threshold
           lib_button.ui_PlayAndPause(3000, false); 
           return flag;
}

/*
  *@function 
  *@param mode {String} 
*/
function selectOperatingMode (mode)
{
    var flag = false;
    var arrCode = codeList();    
    lib_button.clickGoodReadSetup();    
    var pathGR =          Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("ResultAnalysisJobContent", "", 1);
   
    var bttCombination  =    pathGR.WPFObject("AddParcelActionButton", "", 1).WPFObject("image");
    var bttCollection   =    pathGR.WPFObject("AddCollectionActionButton", "", 1).WPFObject("image");
    var bttPresentation =    pathGR.WPFObject("AddPresentationActionButton", "", 1).WPFObject("image") ;
    var bttMatchCode    =    pathGR.WPFObject("AddMatchCodeActionButton", "", 1).WPFObject("image"); 
    
    if (mode == lib_label.lb_CombinationMode)
    {
          flag = processCombinationMode(bttCombination, arrCode);
          return flag;
    }
    if (mode == lib_label.lb_CollectionMode)
    {
          flag = processCollectionMode(bttCollection, arrCode);
          return flag;
    }    
    if (mode == lib_label.lb_PresentationMode)// only put 1 code in front of the device
    {
          flag = processPresentation(bttPresentation, arrCode);
          return flag;
           
    }
    if (mode == lib_label.lb_MatchCode)
    {
          flag = processMatchCode (bttMatchCode, arrCode);
          return flag;
    }
    return flag;

}

 
/*
  *@function 
  *@param arrCode {Array} 
  *@param timeoutThres {interger}
*/ 
function verifyPresentationMode(arrCode,timeoutThres )
{  
       var flag = true;
       var round = 2; 
       var numNoReadMesg = (timeoutThres * 1000) / lib_const.const_PeriodicsTime;
       var playTime  = ((round *   (numNoReadMesg + 1))+1) * lib_const.const_PeriodicsTime; 
       
       // first msg = Good Read =>  3 * numNoReadMesg => goodRead
   
       Indicator.PushText(" VERIFY PRESENTATTION:" + arrCode);
       Indicator.PopText();        
       //play UI and Pause to get messages
       lib_button.clickAdvancedSetup();  
       //play and Pause in configuration
       lib_button.clearConsole();
       lib_button.clickPlay(false);
       delay (playTime); 
       Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("controlToolBar").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "", 2).WPFObject("Image", "", 1).Click();   
       //get datacode
       var arrDataCode = new Array ( );
       arrDataCode = codeDataList( arrCode);       
       // get msgResult and verify transmitted message
        Sys.Process("DL.CODE").Refresh();
        lib_button.clickOpenConsoleTab();
        
        var consoleTab = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1);
        var numMsg = consoleTab.ChildCount;
        
        var  indexGR_First =    1;
        var  indexGR_Next =    indexGR_First +   numNoReadMesg  +1;    
        var  indexNR_First  = indexGR_First + 1;
        for (var r = 1; r <= round ; r ++ )
        {                
               indexNR_First  = indexGR_First - 1;   //               Log.Warning(" indexGR_First:" + indexGR_First +"---" + indexGR_Next);       
                //verify No Read
                for (var j = indexNR_First ; j > indexNR_First+ numNoReadMesg ; j ++)
                { //                       Log.Warning(" NOREAD:" + j);     
                       aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", j).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2), "Text", cmpEqual, "<STX><CAN>\n"); 
                            
                }                
                //verify Good Read
                var msgGR_First = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "",  indexGR_First).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
                var msgGR_Next  = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "",  indexGR_Next).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
                if (msgGR_First == msgGR_Next && msgGR_Next == "<STX><CAN>\n")
                {
                     flag = false;
                     Log.Warning("msgGR_Next = msgGR_First: "+  "<STX><CAN>\n");
                }
                indexGR_First = indexGR_Next;     
                //get msgExpected
                var countSeperateChar = 0;
                 if (arrDataCode.length == arrCode.length)
                 {
                        for (var i = 0;  i < arrCode.length ; i ++)
                        {                  
                           if (arrDataCode[i] != "" && isDataExistMsg (arrDataCode[i], msgGR_First) == -1)
                                  flag = false;
                                  
                           if (arrDataCode[i] != "" && isDataExistMsg (arrDataCode[i], msgGR_Next) == -1)
                                  flag = false; 
                                  
                           if (arrDataCode[i] != "" )
                                  countSeperateChar ++;
                        }
                 } 
                 // verify Seperate Char
                 if (isExistSeperateChar ( lib_const.const_SeperateChar, msgGR_First) != (countSeperateChar-1))    
                        flag = false;    
                if (flag == false)             
                        Log.Warning("verifyPresentationMode: "+flag);
                else
                        Log.Message("verifyPresentationMode: "+flag); 
        }
        return flag;
} 

/*
  *@function 
  *@param arrCode {Array}  
*/ 
function verifyCombination_MatchCode(arrCode)
{  
       Indicator.PushText(" VERIFY COMBINATION OR MATCH CODE:" + arrCode);
       Indicator.PopText();
       lib_button.clickOpenConsoleTab();
       lib_button.ui_PlayAndPause(6000, false);
       var flag = true;
       var arrDataCode = new Array ();
       arrDataCode = codeDataList( arrCode);
       //get msgExpected
       var msgExpected = "";
       if (arrDataCode.length == arrCode.length)
       {
              for (var i = 0;  i < arrCode.length ; i ++)
              {
                  Log.Message( arrCode[i] + ":" + arrDataCode[i]); 
                  msgExpected += arrDataCode[i];
              }
       }
       // get msgResult
       lib_button.clickOpenConsoleTab();
       //verify transmitted message
        var consoleTab = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1);
        var numMsg = consoleTab.ChildCount; 
        var msgResult = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", numMsg - 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
        msgExpected =  "<STX>" + msgExpected  + "\n" ;// msgResult has more 1 char '\n'   
  
        if ( msgExpected != msgResult) 
        {
              flag = false;   
              Log.Message("msgExpected :"+msgExpected.length);
              Log.Message("msgResult:    "+msgResult.length);     
        }          
         if (flag == false)
             Log.Warning("verifyCombination_MatchCode: "+flag); 
        return flag;
} 

/*
  *@function 
  *@param arrCode {Array}  
*/ 
function verifyCollectionMode(arrCode)
{  
       Indicator.PushText(" VERIFY COLLECTTION:" + arrCode);
       Indicator.PopText();
       var flag = true;
       //play UI and Pause to get messages
       lib_button.clickAdvancedSetup(); 
       //play and Pause in configuration
       lib_button.ui_PlayAndPause(6000, false);       
       //get datacode
       var arrDataCode = new Array ( );
       arrDataCode = codeDataList( arrCode);
       
       // get msgResult and verify transmitted message
        Sys.Process("DL.CODE").Refresh();
        lib_button.clickOpenConsoleTab();
        
        var consoleTab = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1);
        var numMsg = consoleTab.ChildCount; 
        var msgResult = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", numMsg - 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
        
//        Log.Message("R:"+msgResult);       
        //get msgExpected
        var countSeperateChar = 0;
         if (arrDataCode.length == arrCode.length)
         {
                for (var i = 0;  i < arrCode.length ; i ++)
                {                  
                   if (arrDataCode[i] != "" && isDataExistMsg (arrDataCode[i], msgResult) == -1)
                   {
                          Log.Warning(arrDataCode[i])  ;
                          Log.Warning(msgResult)  ;   
                          flag = false;
                   }
                   if (arrDataCode[i] != "" )
                          countSeperateChar ++;
                }
         } 
         // verify Seperate Char
         if (isExistSeperateChar ( lib_const.const_SeperateChar, msgResult) != (countSeperateChar-1))    
                flag = false;
        if (flag == false)
             Log.Warning("verifyCollectionMode: "+flag); 
        return flag;
} 
 
/*
  *@function 
  *@param char {String}  
  *@param strMsg {String}  
*/ 
function isExistSeperateChar( char,strMsg )// VERIFY SEPERATE CHARACTER IN COLLECTION MODE => Num chars = Num decoded codes - 1
{ 
      var count = 0;
      for (var i = 0; i < strMsg.length ; i++)
      { if ( char == strMsg[i]) //found
          count ++;
      }      
      return count; 
}

/*
  *@function 
  *@param subStr {String}  
  *@param strMsg {String}  
*/
function isDataExistMsg (subStr, strMsg) //subStr = sub String; strMsg = parents string 
{         
        var Res = aqString.Find(strMsg, subStr);
        if ( Res == -1 ) //found
          Log.Message("There are no occurrences of '" + subStr  );         
//        else
//           Log.Message(  subStr + "' was found'" + "' at position " + Res);
        return Res;
}



/*
  *require:  cosole tab is expanded +   set preriodics time 
  *@function 
  *@param PeriodicsTime {Interger}   
*/
function verifyPeriodicsTime (PeriodicsTime)
{
        Indicator.PushText("Verify message with trigger = Periodics ");
        Indicator.PopText();
        var time = PeriodicsTime * 5;
        var flag =  true;
        lib_button.clickOpenConsoleTab();
        lib_button.ui_PlayAndPause(time, false); 
        delay (2000);   
        //verify transmitted message
        var consoleTab =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1);
        var numMsg = consoleTab.ChildCount; 
        //verify 3 last messages
        for (var i =  numMsg -1 ; i > numMsg - 4  ; i-- )
        {
            var timePrev = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", i -1 ).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
            var timeLast = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", i ).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
            var expTime = "0:00:00:0" +PeriodicsTime/1000;        
            var result = getPeriodics(timePrev,timeLast );
            if ( result != expTime)        
            {
                  Log.Message("expTime:" + expTime);
                  Log.Message("result:" + result);
                  flag = false;                   
            }
        }  
        if (flag == false)
              Log.Warning("Verify PeriodicsTime:" + flag);
        else
              Log.Message("Verify PeriodicsTime:" + flag);       
        return flag;            
} 



/* 
  *@function 
  *@param timePrev {Interger}   
  *@param timeLast {Interger}   
*/
function getPeriodics( timePrev, timeLast) 
{  
      timeLast = stringToDate(timeLast);
      timePrev = stringToDate (timePrev);      //  Log.Message(a);    //  Log.Message(b); 

      var datePrev =  aqConvert.StrToDateTime(timePrev);
      var dateLast =  aqConvert.StrToDateTime(timeLast);     //  Log.Message(a);    //  Log.Message(b); 
  
      var Difference = aqDateTime.TimeInterval(dateLast, datePrev);     //  Log.Message(Difference);  
      var diff =  aqConvert.TimeIntervalToStr( Difference);
      return diff;
  
}

/* 
  *@function 
  *@param date {String}     
*/
function stringToDate(date) // cause msg has ' AM >' 
{   
    // replace   ' > ' 
    var the_date = aqString.Replace(date, " > ", "");       
    var arrDate = the_date.split(" ");
    var the_date = arrDate[0];
    var the_time = arrDate[1];        
    var arrTime = the_time.split(":");
    //format to date format
    var newStr = the_date + " " + arrTime[0] + ":" + arrTime[1] + ":" +arrTime[2] +" "+ arrDate[2 ];    //    Log.Message(msg);//    Log.Message(newStr); 
    return newStr;
}

/* 
  *@function  
*/
function codeList ()// no correctly when has filter + CR
{
      var arrCode = new Array(); 
      lib_button.clickAdvancedSetup();
      lib_button.clickOpenResultTab();
       
      var treeViewItemCodes = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1);
      if (treeViewItemCodes.IsExpanded == false)
      {
          treeViewItemCodes.set_IsExpanded ( true); 
          treeViewItemCodes.Refresh ();     
      }     
      var childCount =  treeViewItemCodes.ChildCount;      
      for (var i = 0; i< childCount - 2; i ++)
      {   
            arrCode[i] = treeViewItemCodes.WPFObject("TreeViewItem", "", i + 2).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                       
      }
      Log.Message("Code List has total:" + arrCode.length + "codes");
      return arrCode;
 
}

/* 
  *@function 
  *@param arrCode {Array}     
*/
function codeDataList( arrCode)// not play UI
{  
      var arrDataCode = new Array();
      lib_button.clickAdvancedSetup();  
      lib_button.clickOpenResultTab();
      var treeViewItemCodes = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1);
                              
      if (treeViewItemCodes.IsExpanded == false)
      {
          treeViewItemCodes.set_IsExpanded ( true); 
          treeViewItemCodes.Refresh ();     
      }           
      
      for (var i = 0; i < arrCode.length ; i ++)
      {   
            var data = ""
            arrCode[i] = treeViewItemCodes.WPFObject("TreeViewItem", "", i + 2).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
            treeViewItemCodes.WPFObject("TreeViewItem", "", i + 2).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).Click();            
            delay (lib_const.const_delay_2000);           
            var dataGrid = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("StatisticResult", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Expander", "Code Settings", 2).WPFObject("DataGrid", "", 1);
            for (var k = 1; k <= dataGrid.wRowCount; k ++)
            {
                var row = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("StatisticResult", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Expander", "Code Settings", 2).WPFObject("DataGrid", "", 1).WPFObject("DataGridRow", "", k);
                var code = row.WPFObject("DataGridCell", "*", 2).WPFObject("TextBlock", "*", 1).WPFControlText;
                var numChar = row.WPFObject("DataGridCell", "*", 4).WPFObject("TextBlock", "*", 1).WPFControlText;
                if (arrCode[i] == code || (arrCode[i] == "DMECC200" && code == "DATAMATRIX GS1")  || (arrCode[i] == "QR" && code == "QR GS1"))
                {
                     for (var l = 1; l <= numChar ; l ++)
                     {
                            data   +=   row.WPFObject("DataGridCell", "*", 3).WPFObject("ContentPresenter", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", l).WPFObject("TextBlock", "*", 1).WPFControlText;
                     }
                }                 
            }                      
            arrDataCode[i] = data;      
       }  
      return arrDataCode; 
}

 