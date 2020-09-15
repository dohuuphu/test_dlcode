//USEUNIT lib_button
//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_err
//USEUNIT lib_ImageSetup
//USEUNIT lib_OpenJob
 
/*
  *@function : Simulator devices -> opened Default job -> add all of Postal codes
 */
function simulator_Postal ()//US_14, US_33, US_25
{
       var arr = [   lb_AustraliaPost,  lb_RoyalMail ,  lb_KIXCode ,  lb_JapanPost , lb_PLANET  ,  lb_POSTNET  ,  lb_IntelligentMail  ,lb_SwedishPostal,  lb_FinnishPost   ]; //add new Finnish Post
 
       lib_button.clickDeleteCode(2);                    
       for (var i = 1; i <= arr.length ; i++)
       {
            //US_14
            lib_button.clickAddCode (lib_label.lb_CodeTypePostal, arr[i-1]);
            if (i == arr.length)
            {
                   var childCount = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).ChildCount;
                   for (var j = childCount ; j >2 ; j --)
                   {
                            //US_33  
                            lib_CodeSetup.editCodeSize (j-1, 100,100,100,100);
                            //US_25
                            lib_button.clickDeleteCode(j-1);
                   }
            }
                              
       }
                 
}

/*
  *@function : Simulator devices -> opened Default job -> add all of 2D codes
 */
function simulator_twoD ()//US_14, US_33, US_25
{
       var arr = [    lb_DMECC200  ,  lb_QR        ,  lb_MICROQR    ,  lb_AZTEC     ,  lb_MAXICODE ,lb_DOTCODE  ,lb_DOTCODE    ]; 
       lib_button.clickDeleteCode(2);                    
       for (var i = 1; i <= arr.length ; i++)
       {
            //US_14                       
            lib_button.clickAddCode (lib_label.lb_CodeType2D, arr[i-1]);
            if (i == arr.length)
            {
                   var childCount = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).ChildCount;
                   for (var j = childCount ; j >2 ; j --)
                   {
                            //US_33                                 
                            lib_CodeSetup.editCodeSize (j-1, 100,100,100,100);
                             //US_25
                            lib_button.clickDeleteCode(j-1);
                   }
            }
                              
       }
         
}

/*
  *@function : Simulator devices -> opened Default job -> add all of 1D codes
 */
function simulator_oneD ()//US_14, US_33, US_25
{
        var arr = [  lb_PDF417 ,     lb_MICROPDF,    lb_CODE128 ,     lb_GS1_128 ,     lb_CODE39  ,     lb_INT2OF5 ,    
                     lb_PHARMA ,     lb_MSI     ,    lb_PLESSEY ,     lb_STD2OF5 ,     lb_MTX2OF5 ,     lb_CODABAR ,     lb_GS1EXP   ,   
                     lb_GS1EXPSTK,   lb_GS1LIM  ,    lb_GS1     ,     lb_GS1STK  ,     lb_CODE93 ,      lb_EAN13  ,    
                     lb_EAN8   ,     lb_UPCA  ,      lb_UPCE        ]; //total : 21 code        
       lib_button.clickDeleteCode(2);                    
       for (var i = 1; i <= arr.length ; i++)
       {
            if (i == 11 || i == 21)
            {
                   var childCount = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).ChildCount;
                   for (var j = childCount ; j > 2 ; j --)
                   {        
                            //US_33                                        
                            lib_CodeSetup.editCodeSize (j-1, 100,100,100,100);
                             //US_25
                            lib_button.clickDeleteCode(j-1);
                   }
            }
            //US_14
            lib_button.clickAddCode (lib_label.lb_CodeType1D, arr[i-1]);                              
       }                 
}

 
/*
  *@function : real devices
 */
function addDelete_AllCodePostal ()//US_14, US_33, US_25
{
  aqTestCase.Begin("Add Delete all Postal Code");
        var arr = [   lb_AustraliaPost,  lb_RoyalMail ,  lb_KIXCode ,  lb_JapanPost , lb_PLANET  ,  lb_POSTNET  ,  lb_IntelligentMail  ,lb_SwedishPostal ,lb_FinnishPost   ]; //add new Finnish Post

        if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
        {         
                if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                {
                         lib_button.clickDeleteCode(2);                    
                         for (var i = 1; i <= arr.length ; i++)
                         {
                              //US_14
                              lib_button.clickAddCode (lib_label.lb_CodeTypePostal, arr[i-1]);
                              if (i == arr.length)
                              {
                                     var childCount = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).ChildCount;
                                     for (var j = childCount ; j >2 ; j --)
                                     {
                                              //US_33  
                                              lib_CodeSetup.editCodeSize (j-1, 100,100,100,100);
                                              //US_25
                                              lib_button.clickDeleteCode(j-1);
                                     }
                              }
                              
                         }
                }   
        } 
        aqTestCase.End();
}

/*
  *@function : real devices
 */
function addDelete_AllCode2D ()//US_14, US_33, US_25
{
  aqTestCase.Begin("addDelete_AllCode2D");
        var arr = [    lb_DMECC200  ,  lb_QR        ,  lb_MICROQR    ,  lb_AZTEC     ,  lb_MAXICODE,  lb_DOTCODE     ]; //total : 6 codes

        if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
        {         
                if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                {
                         lib_button.clickDeleteCode(2);                    
                         for (var i = 1; i <= arr.length ; i++)
                         {
                              //US_14                       
                              lib_button.clickAddCode (lib_label.lb_CodeType2D, arr[i-1]);
                              if (i == arr.length)
                              {
                                     var childCount = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).ChildCount;
                                     for (var j = childCount ; j >2 ; j --)
                                     {
                                              //US_33                                 
                                              lib_CodeSetup.editCodeSize (j-1, 100,100,100,100);
                                               //US_25
                                              lib_button.clickDeleteCode(j-1);
                                     }
                              }
                              
                         }
                }   
        } 
        aqTestCase.End();
}

/*
  *@function : real devices
*/
function addDelete_AllCode1D ()//US_14, US_33, US_25
{
  aqTestCase.Begin("addDelete_AllCode1D");
        var arr = [  lb_PDF417 ,     lb_MICROPDF,    lb_CODE128 ,     lb_GS1_128 ,     lb_CODE39  ,     lb_INT2OF5 ,    
                     lb_PHARMA ,     lb_MSI     ,    lb_STD2OF5 ,     lb_MTX2OF5 ,     lb_CODABAR ,     lb_GS1EXP   ,   
                     lb_GS1EXPSTK,   lb_GS1LIM  ,    lb_GS1     ,     lb_GS1STK  ,     lb_CODE93 ,      lb_EAN13  ,    
                     lb_EAN8   ,     lb_UPCA  ,      lb_UPCE        ]; //total : 21 code

        if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
        {         
                if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                {
                         lib_button.clickDeleteCode(2);                    
                         for (var i = 1; i <= arr.length ; i++)
                         {
                              if (i == 11 || i == 21)
                              {
                                     var childCount = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).ChildCount;
                                     for (var j = childCount ; j >2 ; j --)
                                     {        
                                              //US_33                                        
                                              lib_CodeSetup.editCodeSize (j-1, 100,100,100,100);
                                               //US_25
                                              lib_button.clickDeleteCode(j-1);
                                     }
                              }
                              //US_14
                              lib_button.clickAddCode (lib_label.lb_CodeType1D, arr[i-1]);
                              
                         }
                }   
        }
        aqTestCase.End(); 
}

 

//add 1.5.0 
/*
  *@function 
  *@param string {String}
  *only liquid lens M210 and M300 LQL + M200
*/
function editReadingDistance (string)// 
{
 

      // Focus on Code Setup
      var isGerIMGSetting = existsGeneralImageSettings(lib_deviceInfo.const_Device_Model);
      
      var tempObj = Sys.Process("DL.CODE").FindChild("WPFControlText", "General Image Settings", 1000);
      if(tempObj.Exists)
      {
              
              // focus on general image settings                
              if(tempObj.Visible)
              {
                delay(1000);
                Sys.Process("DL.CODE").FindChild("WPFControlText", "General Image Settings", 1000).Click();
                if (isGerIMGSetting == false)
                   Log.Error("This device must support this control");
              }
              else
              {
                if (isGerIMGSetting == true)
                   Log.Error("This device must NOT support this control");
                delay(2000);
                var proArr = ["WPFControlText" , "ClrClassName"];
                var valArr = [ "Image Settings ", "TextBlock"];
                var btt = Sys.Process("DL.CODE").FindChild(proArr,valArr, 1000);
                aqObject.CheckProperty(btt, "Visible", cmpEqual, true);
                btt.Click();
              }
                  
      }
      else
      {
           if (isGerIMGSetting == true)
                   Log.Error("This device dont support this control");
          delay(2000);
          var proArr = ["WPFControlText" , "ClrClassName"];
          var valArr = [ "Image Settings ", "TextBlock"];
          var btt = Sys.Process("DL.CODE").FindChild(proArr,valArr, 1000);
          aqObject.CheckProperty(btt, "Visible", cmpEqual, true);
          btt.Click();
      }
                  
      var arrPro = ["WPFControlText", "ClrClassName", "ChildCount", "Visible"];
      var arrVal = ["Reading Distance (mm)", "TextBlock", 1, true];
      var btt = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      var count = 20;
      while(count > 0)
      {
        btt = btt.Parent;
        if(btt.FindChild("ClrClassName", "WatermarkTextBox", 10).Exists)
        {
          btt = btt.FindChild("ClrClassName", "WatermarkTextBox", 10);
          break;
        }
        count --;
        delay(1000);
      }
      if(!btt.Exists)
      {
        Log.Error("Can not find Reading distance text box");
        return;
      }
      btt.Keys("^a"+string +"[Enter]");
      if (string < lib_const.const_ReadingDistance_Min)
              aqObject.CheckProperty(btt, "Text", cmpEqual, aqConvert.IntToStr(lib_const.const_ReadingDistance_Min));
      if (string > lib_const.const_ReadingDistance_Max)
              aqObject.CheckProperty(btt, "Text", cmpEqual, aqConvert.IntToStr(lib_const.const_ReadingDistance_Max));
      if (string >=  lib_const.const_ReadingDistance_Min && string <= lib_const.const_ReadingDistance_Max)        
              aqObject.CheckProperty(btt, "Text", cmpEqual, string);    
}

 
/*
  *@function  random from 200 to 300
*/
function randomReadingDistance ()
{
       
        var x =  Math.floor((Math.random() * 200) + 1)+100; 
        Log.Message(x);
        return x;
}
//add 1.5.0 
/*
  *@function  
  *@param Left {Interger}
  *@param Top {Interger}
  *@param Width {Interger}
  *@param Height {Interger}
*/
function editCroppingRegion (Left , Top, Width, Height)
{
        lib_button.clickIMGSetting();
        if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Cropping Region Area", 1).Enabled == true)
        {
                var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Cropping Region Area", 1);
                if (path.IsExpanded == false)
                      path.set_IsExpanded(true);
                if (path.IsExpanded == true)
                {      
                      path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("StackPanel", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a"+Width +"[Enter]");                  
                      path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4).WPFObject("StackPanel", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a"+Height+"[Enter]");
                      path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ExplicitUpdateDoubleUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a"+Left  +"[Enter]");
                      path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("StackPanel", "", 1).WPFObject("ExplicitUpdateDoubleUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a"+Top   +"[Enter]");                  
                
                } 
        }else Log.Warning("Please enable CR");
      
}

/*
  *@function  
  *@param device {String} 
*/
function configJob(device)
{
  while (!(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WaitWPFObject"]("CollapsedExpander", "", lib_const.const_delay_1000).Exists))
  {
          Delay(lib_const.const_delay_3000);
          Sys["Process"]("DL.CODE").Refresh();
  }
  if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WaitWPFObject"]("CollapsedExpander", "", lib_const.const_delay_1000).Exists)
  {
          lib_button.clickPlay();
          Delay(lib_const.const_delay_3000);
          lib_button.clickPause();
          lib_button.clickCapture();  
          // click on Image Setting button
          var settingMenu = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander");
        
          //click on code setup
          settingMenu["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 2).Click();
          //add 1D code 128
          Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", "*")["WPFObject"]("Shell", "*", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("JobContentPresenter")["WPFObject"]("ControlJobContent", "", 1)["WPFObject"]("Add1DecoderTool", "", 1)["WPFObject"]("Image", "", 1).Click();
          Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: PopupRoot", "")["WPFObject"]("PopupRoot", "", 1)["WPFObject"]("Decorator", "", 1)["WPFObject"]("NonLogicalAdornerDecorator", "", 1)["WPFObject"]("ContextMenu", "", 1)["WPFObject"]("MenuItem", "CODE128", 3).Click();
          lib_ImageSetup.IS_AddImageSetting(1);
          Log.Message(i + "_ obj :------ " );
          var obj = new Object();
          obj = getIMGPropeties(device);
          lib_ImageSetup.displayIMGPropeties(device, obj);
          lib_ImageSetup.config_IMGSetting(device , obj);    
          Log.Message(i + "_ obj_new : ------" );
          var obj_new = new Object();
          obj_new =  getIMGPropeties(device);                             
          lib_ImageSetup.displayIMGPropeties(device, obj_new);
      
  }
  
}
//updated 1.5.0
/*
  *@function   
*/
function add_verify_IMG_AutoSetup_Static()
{
      var flag = true;
      if ( Sys["Process"]("DL.CODE")["WaitWPFObject"]("HwndSource: PhotometryAutolearnDialogWindow","Self Tune", lib_const.const_delay_1000).Exists)
      {
            var autolearnDialog = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: PhotometryAutolearnDialogWindow", "*")["WPFObject"]("PhotometryAutolearnDialogWindow", "*", 1);
            autolearnDialog["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("RadioButton", "Static", 1).Click();
            autolearnDialog["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 3)["WPFObject"]("Button", "Start", 1).ClickButton();
            while(autolearnDialog["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 3)["WaitWPFObject"]("Button", "Apply", 3).Enabled == false)
            {
                  delay( lib_const.const_delay_3000);
                  Sys["Process"]("DL.CODE").Refresh();
                  //Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: PhotometryAutolearnDialogWindow", "Self Tune")["WPFObject"]("PhotometryAutolearnDialogWindow", "Self Tune", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("TextBlock", "Cannot find optimal configuration for image parameters.", 4) 
            }                   
            if(autolearnDialog["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 3)["WaitWPFObject"]("Button", "Apply", 3).Enabled)
              autolearnDialog["WPFObject"]("Grid", "", 1)["WPFObject"]("Grid", "", 3)["WPFObject"]("Button", "Apply", 3).ClickButton();
      }
      
      return flag;
}
////************************************************************************************************************************************************

/*
  *@function   
*/
function simulator_add_verify_AddCode ()
{
        var flag = true;
        if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WaitWPFObject"]("CollapsedExpander", lib_const.const_delay_2000).Exists)
        {
              if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 2)["WPFObject"]("ExpanderStepSubItemButton", "", 1).IsFocused == false)
                      Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 2)["WPFObject"]("ExpanderStepSubItemButton", "", 1).Click();
              if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 2)["WPFObject"]("ExpanderStepSubItemButton", "", 1).IsFocused == true)
              {
                    var path = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell",lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("JobContentPresenter")["WPFObject"]("ControlJobContent", "", 1);
                    //add 1D code 128
                    path["WPFObject"]("Add1DecoderTool", "", 1).Click();
                    Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: PopupRoot", "")["WPFObject"]("PopupRoot", "", 1)["WPFObject"]("Decorator", "", 1)["WPFObject"]("NonLogicalAdornerDecorator", "", 1)["WPFObject"]("ContextMenu", "", 1)["WPFObject"]("MenuItem", "CODE128", 3).Click();
                     //add 2D QR
                    path["WPFObject"]("Add2DecoderTool", "", 1).Click();
                    Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: PopupRoot", "")["WPFObject"]("PopupRoot", "", 1)["WPFObject"]("Decorator", "", 1)["WPFObject"]("NonLogicalAdornerDecorator", "", 1)["WPFObject"]("ContextMenu", "", 1)["WPFObject"]("MenuItem", "QR", 2).Click();
                    //add Postal
                    path["WPFObject"]("AddPostalToolDecoder", "", 1).Click();
                    Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: PopupRoot", "")["WPFObject"]("PopupRoot", "", 1)["WPFObject"]("Decorator", "", 1)["WPFObject"]("NonLogicalAdornerDecorator", "", 1)["WPFObject"]("ContextMenu", "", 1)["WPFObject"]("MenuItem", "KIX Code", 3).Click();
          
              }
        }
        return flag; 
}

/*
  *@function  
  *@param device {String} 
*/
function simulatorConfigJob_410_XRF(device)
{
      while (!(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WaitWPFObject"]("CollapsedExpander",  lib_const.const_delay_1000).Exists))
      {
              Delay(lib_const.const_delay_3000);
              Sys["Process"]("DL.CODE").Refresh();
      }
      if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WaitWPFObject"]("CollapsedExpander", lib_const.const_delay_1000).Exists)
      {
              lib_button.clickPlay();
              Delay(lib_const.const_delay_3000);
              lib_button.clickPause();
              lib_button.clickCapture();
              lib_ImageSetup.IS_AddImageSetting(1);
              Log.Message(i + "_ obj :------ " );
              var obj = new Object();
              obj =  lib_ImageSetup.getIMGPropeties(device);
              lib_ImageSetup.displayIMGPropeties(device, obj);
              lib_ImageSetup.config_IMGSetting(device , obj);    
              Log.Message(i + "_ obj_new : ------" );
              var obj_new = new Object();
              obj_new =   lib_ImageSetup.getIMGPropeties(device);                             
              lib_ImageSetup.displayIMGPropeties(device, obj_new);
      
      }
}

/*
  *@function  
  *@param device {String} 
*/
function simulatorConfigJob(device)
{
      while (!(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WaitWPFObject"]("CollapsedExpander", lib_const.const_delay_1000).Exists))
      {
              Delay(lib_const.const_delay_3000);
              Sys["Process"]("DL.CODE").Refresh();
      }
      if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WaitWPFObject"]("CollapsedExpander",  lib_const.const_delay_1000).Exists)
      {
              lib_button.clickPlay();
              Delay(lib_const.const_delay_3000);
              lib_button.clickPause();
              lib_button.clickCapture();
              simulator_add_verify_AddCode();
              lib_button.clickPlay();
              Delay(lib_const.const_delay_5000);
              lib_button.clickPause();
              lib_button.clickCapture(); 
              lib_ImageSetup.IS_AddImageSetting(3);
              //get and display obj
              var obj = new Object();
              obj =  lib_ImageSetup.get_display_IMGPropetiesDefault(device);
              //config IMG Setting
              lib_ImageSetup.config_IMGSetting(device , obj);    
              //get and display obj
              var obj_new = new Object();
              obj_new =  lib_ImageSetup.get_display_IMGPropetiesDefault(device);
      
      }
}

 


//add 1.5.0 
/*
  *@function  
  *@param index {Interger} 
  *@param X {Interger} 
  *@param Y {Interger} 
  *@param Width {Interger} 
  *@param Height {Interger} 
*/
function editCodeSize (index , X , Y, Width, Height)
{
        lib_button.clickAdvancedSetup();
        //open Image Stt TreeViewItem
        if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).IsExpanded == false)
               Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).set_IsExpanded(true);

        //focus code
        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", index).Click();
        
        if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Localization Box", 4).Enabled == true)
        {
                var path = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Localization Box", 4);
                if (path.IsExpanded == false)
                      path.set_IsExpanded(true);
                if (path.IsExpanded == true)
                {      
                      path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a"+Width+"[Enter]");                  
                      path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a"+Height+"[Enter]");
                      path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateDoubleUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a"+X  +"[Enter]");
                      path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ExplicitUpdateDoubleUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a"+Y   +"[Enter]");
                      
                      
                      
                      aqObject.CheckProperty(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ExplicitUpdateDoubleUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Text", cmpEqual, aqConvert.IntToStr(X));
                      aqObject.CheckProperty(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ExplicitUpdateDoubleUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Text", cmpEqual, aqConvert.IntToStr(Y));
                      aqObject.CheckProperty(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 3).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Text", cmpEqual, aqConvert.IntToStr(Width));
                      aqObject.CheckProperty(path.WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 4).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox"), "Text", cmpEqual, aqConvert.IntToStr(Height));
                                        
                
                } 
        }else Log.Warning("Object doesn't exists");
      
}

/*
  *@function  
  *@param index {Interger}  
*/
function changeCodeType (index)
{
        lib_button.clickAdvancedSetup();
        //open Image Stt TreeViewItem
        if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 1).IsExpanded == false)
               Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 1).set_IsExpanded(true);

        //focus code
        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", index).Click();
                
        //verify code type
        var cbb =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Symbology Setup", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1);
        lib_validate.verifyCodeType (cbb, Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", index).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText);
        //get number codes in CodeType 
        combobox.Click();
        var countItems = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).ChildCount -2 ;
        combobox.Click();
        
        for (var i = 1; i <= countItems ; i ++)
        {
                 combobox.Click();
                 var code = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "", selectedItem+1).WPFObject("TextBlock", "*", 1).WPFControlText;
                 Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ComboBoxItem", "",i).Click ();
                 aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpContains, code);
                 aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", index).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, code);
        }       
        
          
}