//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_OpenJob
//USEUNIT lib_button
//USEUNIT lib_ReadingPhase

/*
 *@function
*/
function add_MaxImageSetting()
{
 
       lib_common.launchUI();    
       if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
       {         
              if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
              {                
                    //add maximum 10 IMG Savings
                    for (var i = 1; i <= 11; i++)
                    {     
                          Log.Message (addImageSaving());
                          lib_button.clickPlay(false);
                          delay (lib_const.const_delay_2000);
                          lib_button.clickPause(false); 
                    }                  
              }
       }   
}

/*
 *@function
 *still dont verify graphic panel
*/
function addImageSaving ()
{

        var flag = false;
        lib_button.clickDataFortmating();
        var proArr = [ "WPFControlText","ClrClassName" , "Enabled"];
        var valArr = ["Images Saving Conditions", "TextBlock" ,true];
        var label = Sys.Process("DL.CODE").FindChild(proArr, valArr, 2000);
        if (label.Exists)
        {
                    aqObject.CheckProperty(label, "WPFControlText", cmpEqual, "Images Saving Conditions");            
                    aqObject.CheckProperty(label, "Enabled", cmpEqual,true); 
                    label.Click(); 
                    //verify Label On Images Saving Conditions
                    verifyLabelOnImagesSavingConditions();
                    
                    //
                    var imgSavingTab = label.Parent;        
                    if (imgSavingTab.IsExpanded == false)
                          imgSavingTab.set_IsExpanded (true);   
                    
                    var count = imgSavingTab.ChildCount -1;
                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("DataFormattingJobContent", "", 1).WPFObject("AddImageDestination", "", 1).Click();
                    if (Sys["Process"]("DL.CODE")["WaitWPFObject"]("HwndSource: PopupMessage", "Warning",lib_const.const_delay_1000).Exists)
                    {
                            aqObject.CheckProperty(Sys["Process"]("DL.CODE").WPFObject("HwndSource: PopupMessage", "Warning").WPFObject("PopupMessage", "Warning", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "Cannot add or number is greater than the maximum allowable", 1), "Enabled", cmpEqual, true);
                            Sys["Process"]("DL.CODE").WPFObject("HwndSource: PopupMessage", "Warning").WPFObject("PopupMessage", "Warning", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 1).ClickButton();
                            flag = true;
                            return flag;
                    }
                    else
                    { 
        
                            Sys.Process("DL.CODE").Refresh();
                            var newCount = imgSavingTab.ChildCount -1;
                            if (newCount - count  == 1)
                            {
                                   //verify configuration panel
                                   aqObject.CheckProperty(imgSavingTab.WPFObject("TreeViewItem", "", newCount).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, "Images Saving");
                                   if (newCount >1)      
                                         aqObject.CheckProperty(imgSavingTab.WPFObject("TreeViewItem", "", newCount).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 3), "WPFControlText", cmpEqual, newCount);
                                   else 
                                         aqObject.CheckProperty(imgSavingTab.WPFObject("TreeViewItem", "", newCount).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 3), "WPFControlText", cmpEqual, "");
                                   flag = true;
                            }
                    }
        }        
        
        return flag; 

}

// author: lhoang
function addImageSaving2 ()
{
  addImageSavingBtn = Sys.Process("DL.CODE").FindChild("ToolTip", "Add Image Saving Condition", 1000);
  addImageSavingBtn.Click();
}

/*
 *@function
 *still dont verify graphic panel
*/
function addDiagnostics ()
{

        var flag = false;
        lib_button.clickDataFortmating();
                             
        var diagnosticsTab = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 4).WPFObject("TreeViewItem", "", lib_const.const_DF_DiagnosticsTab);
        if (diagnosticsTab.IsExpanded == false)
              diagnosticsTab.set_IsExpanded (true);
        var count = diagnosticsTab.ChildCount; 
        var btt =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("DataFormattingJobContent", "", 1).WPFObject("AddMessageActionButton", "", 1);
        if (btt.Enabled == true)
        {
            btt.Click();
            Sys.Process("DL.CODE").Refresh();
            var newCount = diagnosticsTab.ChildCount ;
            if (newCount - count  == 1)
            {
                   //verify configuration panel
                   aqObject.CheckProperty(diagnosticsTab.WPFObject("TreeViewItem", "", newCount).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, "Message");
                   flag = true;
            }
        }
        else
              Log.Message(lib_messageLog.msg_Button_Invisible);  
        return flag; 
}

/*
 *@function
 *still dont verify graphic panel
*/
function addPasthrough () 
{

        var flag = false;
        lib_button.clickDataFortmating();
        var PassthroughTab = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_DF_PassthroughTab);
        if (PassthroughTab.IsExpanded == false)
              PassthroughTab.set_IsExpanded (true);
        var count = PassthroughTab.ChildCount;
        Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject("DataFormattingJobContent", "", 1).WPFObject("AddPassthrougConfig", "", 1).Click();
        if (Sys["Process"]("DL.CODE")["WaitWPFObject"]("HwndSource: PopupMessage", "Warning",lib_const.const_delay_1000).Exists)
        {
                aqObject.CheckProperty(Sys["Process"]("DL.CODE").WPFObject("HwndSource: PopupMessage", "Warning").WPFObject("PopupMessage", "Warning", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "Cannot add or number is greater than the maximum allowable", 1), "Enabled", cmpEqual, true);
                Sys["Process"]("DL.CODE").WPFObject("HwndSource: PopupMessage", "Warning").WPFObject("PopupMessage", "Warning", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 1).ClickButton();
                flag = true;
                return flag;
        }
        else
        { 
        
                Sys.Process("DL.CODE").Refresh();
                var newCount = PassthroughTab.ChildCount;
                if (newCount - count  == 1)
                {
                       //verify configuration panel
                       aqObject.CheckProperty(PassthroughTab.WPFObject("TreeViewItem", "", newCount).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, "Passthrough");
                       if (newCount >1)      
                             aqObject.CheckProperty(PassthroughTab.WPFObject("TreeViewItem", "", newCount).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 3), "WPFControlText", cmpEqual, newCount);
                       else 
                             aqObject.CheckProperty(PassthroughTab.WPFObject("TreeViewItem", "", newCount).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 3), "WPFControlText", cmpEqual, "");
                       flag = true;
                }
        }
        return flag; 
}

// author: lhoang
function addFTP()
{
  addChanelBtn = Sys.Process("DL.CODE").FindChild("ToolTip", "Add New Channel", 1000);
  addChanelBtn.Click();
  addChanelBtn.PopupMenu.Click("Reader FTP Client");
      
  tempObj = Sys.Process("DL.CODE").FindChild("WPFControlText", "Data Formatting :  Reader FTP Client ", 1000);
  tempObj = tempObj.Parent;
  tempObj = tempObj.Parent;
  
  ipAdress2 = tempObj.FindChild("ClrClassName", "IpAddressControl", 1000);
  ipAdress2.SetIpAddress(GetSystemIpAddress());
}

// author: lhoang
function changeImageSavingRemote(channel)
{
  tempObj = Sys.Process("DL.CODE").FindChild("WPFControlText", "Image Destination", 1000);
  tempObj = tempObj.Parent;
  comboBoxImageResouce = tempObj.FindChild("ClrClassName", "ComboBox", 1000);
  comboBoxImageResouce.ClickItem(0);
  delay(1000);
  
  if(channel == "FTP")
  {
    tempObj = Sys.Process("DL.CODE").FindChild("WPFControlText", "Data Formatting :  Images Saving ", 1000);
    tempObj = tempObj.Parent;
    tempObj = tempObj.Parent;
    resouceChannel = tempObj.FindChild("WPFControlName", "SelectedChannelCB", 1000);
    resouceChannel.ClickItem(1);
  }
}
// author: lhoang
function GetSystemIpAddress()
{
  var strQuery = "select * from Win32_NetworkAdapterConfiguration where IPEnabled=True"
  var objectsList = GetObject("winmgmts:").ExecQuery(strQuery)
  if (objectsList.Count > 0)
  {
  eObjectsList = new Enumerator(objectsList);
  for (; !eObjectsList.atEnd(); eObjectsList.moveNext())
  {
    item = eObjectsList.item();
    if(aqString.Contains(item.IPAddress(0), "10.84") != -1)
    {
      return item.IPAddress(0);
    }
  }
}
}

/*
    giang.ha add new 20200305 
    M320 -> Pixel Sub
    Others -> Scaling Factor
*/
function verifyLabelOnImagesSavingConditions ()
{ 
         var proArr = ["ClrClassName" , "WPFControlText" ,   "Enabled"];
         var valArr = ["TextBlock" , "Data Formatting :  Images Saving Conditions " ,   true];
         var imgSavConditions = Sys.Process("DL.CODE").FindChild(proArr, valArr, 2000);
         if (imgSavConditions.Exists)
         {
                   aqObject.CheckProperty(imgSavConditions, "WPFControlText", cmpEqual, "Data Formatting :  Images Saving Conditions ");  
                   var path = imgSavConditions.Parent.Parent;
                   
                   //verify Maximum Depth
                   Log.Message("Maximum Depth");
                   proArr = ["ClrClassName" , "WPFControlText" ,   "Enabled"];
                   valArr = ["Hyperlink" , "Maximum Depth" ,   true];
                   var maxDepth = path.FindChild(proArr, valArr, 2000);                   
                   if (maxDepth.Exists)
                   {
                         aqObject.CheckProperty(maxDepth, "WPFControlText", cmpEqual, "Maximum Depth");  
                               
                         proArr = ["ClrClassName" ,      "Enabled"];                               
                         valArr = ["WatermarkTextBox" ,    true];
                         var pathSub = maxDepth.Parent.Parent;
                         var maxDepthTxt = pathSub.FindChild(proArr, valArr, 2000);
                         if (maxDepthTxt.Exists)
                         {
                               aqObject.CheckProperty(maxDepthTxt, "WPFControlName", cmpEqual, "TextBox");  
                               if (maxDepthTxt.DataContext.DefaultMaxValue != 3000 ||
                                   maxDepthTxt.DataContext.DefaultMinValue != 1 ||
                                   maxDepthTxt.DataContext.DefaultValueInt != 50)
                                      Log.Error("Wrong value");
                         }else Log.Error("cannot found this control");
                   }else Log.Error("cannot found this control"); 
                   
                   //verify Scaling Factor or Pixel Sub...  
                   //call function existsScalingFactor -> only M320 has Pixel Sub....                     
                   if (existsScalingFactor(lib_deviceInfo.const_Device_Model ) == true)
                   {
                         //verify Scaling Factor
                         Log.Message("Scaling Factor"); 
                         proArr = ["ClrClassName" , "WPFControlText" ,   "Enabled"];
                         valArr = ["Hyperlink" , "Scaling Factor" ,   true];
                         var scalingFactor = path.FindChild(proArr, valArr, 2000);
                         if (scalingFactor.Exists)
                         {
                               aqObject.CheckProperty(scalingFactor, "WPFControlText", cmpEqual, "Scaling Factor");  
                               
                               proArr = ["ClrClassName" ,      "Enabled"];                               
                               valArr = ["WatermarkTextBox" ,    true];
                               var pathSub = scalingFactor.Parent.Parent;
                               var scalingFactorTxt = pathSub.FindChild(proArr, valArr, 2000);
                               if (scalingFactorTxt.Exists)
                               {
                                     aqObject.CheckProperty(scalingFactorTxt, "WPFControlName", cmpEqual, "TextBox");  
                                     if (scalingFactorTxt.DataContext.DefaultMaxValue != 100 ||
                                         scalingFactorTxt.DataContext.DefaultMinValue != 5 ||
                                         scalingFactorTxt.DataContext.DefaultValue != 100)
                                            Log.Error("Wrong value");
                               }else Log.Error("cannot found this control"); 
                         }else Log.Error("cannot found this control"); 
                   } else
                   {
                         //verify Pixel
                         Log.Message("Pixel Sub...");
                         proArr = ["ClrClassName" , "WPFControlText" ,   "Enabled"];
                         valArr = ["Hyperlink" , "Pixel Subsampling" ,   true];
                         var pixel = path.FindChild(proArr, valArr, 2000);
                         if (pixel.Exists)
                         {
                               aqObject.CheckProperty(pixel, "WPFControlText", cmpEqual, "Pixel Subsampling");  
                               
                               proArr = ["ClrClassName" ,      "Enabled"];                               
                               valArr = ["WatermarkTextBox" ,    true];
                               var pathSub = pixel.Parent.Parent;
                               var pixelTxt = pathSub.FindChild(proArr, valArr, 2000);
                               if (pixelTxt.Exists)
                               {
                                     aqObject.CheckProperty(pixelTxt, "WPFControlName", cmpEqual, "TextBox");  
                                     if (pixelTxt.DataContext.DefaultMaxValue != 8 ||
                                         pixelTxt.DataContext.DefaultMinValue != 1 ||
                                         pixelTxt.DataContext.DefaultValue != 1)
                                            Log.Error("Wrong value");
                               }else Log.Error("cannot found this control"); 
                         }else Log.Error("cannot found this control"); 
                   }
         }
           
}