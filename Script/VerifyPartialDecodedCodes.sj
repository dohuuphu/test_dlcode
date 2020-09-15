//USEUNIT lib_button
//USEUNIT lib_common
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo


/*
   gha add 1.9.0A11
   from VL:VL5.14.10U.50331646.10
   All of images are decoded in this VL
*/
function VerifyPartialDecodedCodes()
{
  aqTestCase.Begin("Verify Partial Decoded Codes");
  Log.Message("All of images are decoded in VL VL5.14.10U.50331646.10")
  lib_common.launchUI();
  if(!lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
  {
    Log.Error("Can not connect to device");
    aqTestCase.End();
    return;
  }
  if(!lib_OpenJob.openOnDevice( lib_const.const_DefaultJob ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
  {
    Log.Error("Can not open job on device");
    aqTestCase.End();
    return;
  }  
   
  var flag = true; //return value
  
  lib_button.clickAdvancedSetup();
  // expand image setting if not
  arrPro = ["WPFControlText", "ClrClassName"];
  arrVal = ["Code Settings", "TextBlock"];
  tempObj = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000).Parent;
  tempObj = tempObj.WPFObject("TreeViewItem", "", 1);  
  if(!tempObj.get_IsExpanded())  tempObj.ExpandSubtree();
  
  // click on General Settings - Code Grading
  arrPro = ["WPFControlText", "ClrClassName"];
  arrVal = ["General Settings - Code Grading", "TextBlock"];
  var generalSetting =   Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  generalSetting.Click();
  
  // Verify Partial Decoded Codes Label and checkbox default
  arrPro = ["WPFControlText", "ClrClassName"];
  arrVal = ["Partially Decoded Codes", "TextBlock"];
  var patialCodesLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000)
  if (patialCodesLabel.Exists)
  {
      //label
      aqObject.CheckProperty(patialCodesLabel, "WPFControlText", cmpEqual, "Partially Decoded Codes");
      //checkbox
      var parentPath = patialCodesLabel.Parent;      
      arrPro = ["ClrClassName"];
      arrVal = ["CheckBox"];
      var partialCodesChkbox = parentPath.FindChild(arrPro, arrVal, 1000);
      if (partialCodesChkbox.Exists)
      {
        aqObject.CheckProperty(partialCodesChkbox, "IsChecked", cmpEqual,false); //default: false
        //check this control
        partialCodesChkbox.set_IsChecked (true);
      }
      
      //Good Read Setup
      lib_button.clickGoodReadSetup();
      arrPro = ["WPFControlText", "ClrClassName"];
      arrVal = ["Partial Read", "TextBlock"];
      var patialRead = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000)
      if (patialRead.Exists)
      {
          //label
          aqObject.CheckProperty(patialRead, "WPFControlText", cmpEqual, "Partial Read");
          //checkbox
          var parentPath = patialRead.Parent;      
          arrPro = ["ClrClassName"];
          arrVal = ["ComboBox"];
          var partialReadCbbx = parentPath.FindChild(arrPro, arrVal, 1000);
          if (partialReadCbbx.Exists)
          {
            aqObject.CheckProperty(partialReadCbbx, "Text", cmpEqual, "[1, Treat as No Read]");
            //enable Partial Read            
           partialReadCbbx.set_Text ("[0, Enabled]") ;            
          }
      }
      
      //Data Formatting
      lib_button.clickDataFortmating2();
      arrPro = ["WPFControlText", "ClrClassName"];
      arrVal = ["Partial Read", "TextBlock"];
      var patialReadEvent = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000)
      if (patialReadEvent.Exists)
      {
          //find Message 3 (Partial) and click
          aqObject.CheckProperty(patialReadEvent, "WPFControlText", cmpEqual, "Partial Read");
          patialReadEvent.Click();
          
          //add and focus on Expected Code
          addCodeRelatedField();  
          arrPro = ["WPFControlText", "ClrClassName"];
          arrVal = ["Local Partial Read", "Hyperlink"];
          var localPartialReadLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
          if (localPartialReadLabel.Exists)
          {
              aqObject.CheckProperty(localPartialReadLabel, "WPFControlText", cmpEqual, "Local Partial Read"); //value Default
              arrPro = ["WPFControlName", "ClrClassName"];
              arrVal = ["rtbText", "RichTextBox"];
              var subPath = localPartialReadLabel.Parent.Parent; 
              var localPartialReadTxtbox = subPath.FindChild (arrPro, arrVal, 1000);
              if (localPartialReadTxtbox.Exists)
              {
                   arrPro = ["WPFControlText", "ClrClassName"];
                   arrVal = ["*", "Run"];                    
                   var  starChar  = localPartialReadTxtbox.FindChild (arrPro, arrVal, 1000);
                   if (starChar.Exists)
                      aqObject.CheckProperty(starChar, "WPFControlText", cmpEqual, "*");        //Default: *                 
              }                        
          }   
      }
  }
  
  //verify Images and Data  
  var Excel = Sys.OleObject("Excel.Application"); 
  var ExcelWorkbookObj = Excel.Workbooks.Open(Project.Path + "PartiallyDecodedCodes\\PartialDecodedCodes.xlsx");
  var ExcelSheet = ExcelWorkbookObj.Sheets.Item("Sheet1");
  
  var rowCountSheetIndex = ExcelSheet.UsedRange.Rows.Count; 
  
  var imgName, codeName, typeOfPartial;
  for(var i = 1; i<= rowCountSheetIndex; i++)
  {
     //get information from xls
     imgName       = (VarToString(ExcelSheet.Cells.Item(i, 1)));
     codeName      = (VarToString(ExcelSheet.Cells.Item(i, 2)));
     typeOfPartial = (VarToString(ExcelSheet.Cells.Item(i, 3)));
     Log.Message(imgName + "|" + codeName + "|" + typeOfPartial );
     
     //action load image      
     lib_button.clickAdvancedSetup();
     visionControl =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 2).WPFObject("VisionControl");
     screenImage = Sys.Process("DL.CODE").FindChild("WPFControlName", "visionToolRoiControl", 1000);
     screenImage.HoverMouse();
     screenImage.ClickR();
     visionControl.PopupMenu.Click("Image|Clean");
     delay(700);
     screenImage.ClickR();
     visionControl.PopupMenu.Click("Image|Load");
     Sys.Process("DL.CODE").Window("#32770", "Open", 1).Window("ComboBoxEx32", "", 1).Window("ComboBox", "", 1).Window("Edit", "", 1).SetText(Project.Path + "PartiallyDecodedCodes\\" + imgName);
     Sys.Process("DL.CODE").Window("#32770", "Open", 1).Window("Button", "&Open", 1).ClickButton();
     delay(5000);   
     
     //verify loading image completely
     var arrPros = ["ClrClassName", "WPFControlText"] ;
     var arrVals = ["TextBlock", imgName] ;
     while (visionControl.FindChild (arrPros, arrVals, 1000).Exists == false)
     {
       delay(3000); 
     }
     aqObject.CheckProperty(visionControl.FindChild (arrPros, arrVals, 1000), "WPFControlText", cmpEqual,imgName); 
     
     // verify codeName
     arrPro = ["WPFControlText", "ClrClassName"];
     arrVal = ["General Settings - Code Grading", "TextBlock"];
     var generalSetting =   Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
     var grandPaPath = generalSetting.Parent.Parent.Parent;
 
     var childcount = grandPaPath.ChildCount;
     if (childcount==3)
     {
       arrPro = ["WPFControlText", "ClrClassName"];
       arrVal = [codeName, "TextBlock"];
       codeExist = grandPaPath.FindChild(arrPro, arrVal , 1000);
       if (codeExist.Exists == false)
       {
         lib_button.clickDeleteCode (childcount -1);
         lib_button.clickAddCode (lib_label.lb_CodeType1D, codeName);
       }  
       else
          codeExist.Click (); //focus on code
     }
     
     //get Result      
    lib_button.clickOpenResultTab();
    delay (lib_const.const_delay_2000); 
    
    var data = "";
    arrPros = ["WPFControlText" , "ClrClassName"];
    arrVals = ["Code Settings" , "Expander"];
    codeSettings = Sys.Process("DL.CODE").FindChild(arrPros, arrVals, 1000);   
    if (codeSettings.Exists)
    {        
        if (codeSettings.IsExpanded == false)
            codeSettings.set_IsExpanded(true);
        delay (3000);
        var dataGrid = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("StatisticResult", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Expander", "Code Settings", 2).WPFObject("Border", "", 1).WPFObject("DataGrid", "", 1);
         
        for (var k = 1; k <= dataGrid.wRowCount; k ++)
        {
           var row = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("StatisticResult", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Expander", "Code Settings", 2).WPFObject("Border", "", 1).WPFObject("DataGrid", "", 1).WPFObject("DataGridRow", "", k);
           var code = row.WPFObject("DataGridCell", "*", 2).WPFObject("TextBlock", "*", 1).WPFControlText; 
           var numChar = row.WPFObject("DataGridCell", "*", 4).WPFObject("TextBlock", "*", 1).WPFControlText;
           if ( codeName == code  )
           {
                 for (var l = 1; l <= numChar ; l ++)
                 {
                        data = data + row.WPFObject("DataGridCell", "*", 3).WPFObject("ContentPresenter", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", l).WPFObject("TextBlock", "*", 1).WPFControlText;
                 }
           }    
        } 
    }
    
    //compare data and xls
    if(data == "")
    {
        Log.Error("Code isn't decoded by VL");
        flag = false;
    }
       
    
    if (data != typeOfPartial )
    {
       Log.Error(data +"!=" + typeOfPartial );
       flag = false;
    }        
    else
        Log.Message(imgName + ": OK");    
  }   
  ExcelWorkbookObj.Close();

  ExcelWorkbookObj = null;
  ExcelSheet = null;
  Excel = null; 
   Log.Message("This function is: " + flag);
  aqTestCase.End(); 
  return flag;
} 
 
 

function addCodeRelatedField()
{
          var arrPro = ["ClrClassName" ];
          var arrVal = ["ToolBar" ];
          var  toolBar = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000)
          if (toolBar.Exists)
          {
            var path = toolBar.WPFObject("Grid", "", 11);
            var    arrImg = new Array ();
            arrImg=  path.FindAllChildren("ClrClassName" , "Image", 1000).toArray(); 
            for (var i = 0; i <arrImg.length ; i++)
            {
               
              if (arrImg[i].ToolTip.WPFControlText == "Code Related Field")
              {
                  arrImg[i].Click()
                  break;
              }
            }
          }          
}