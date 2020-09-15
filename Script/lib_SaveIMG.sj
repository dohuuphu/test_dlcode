//USEUNIT lib_button
//USEUNIT lib_const
//USEUNIT lib_SaveJob
//USEUNIT lib_OpenJob
 

/** 
  *Last updated 1.6.0 rc02
  *@function
*/
function clickSaveImageButton_Monitor()// add all 4 types: bmp, jpeg, jpg,tiff
{
  //aqTestCase.Begin("clickSaveImageButton_Monitor");
         Log.AppendFolder("func: clickSaveImageButton_Monitor");
//         if ( ! lib_validate.isDLCODERunning())
        lib_common.launchUI(); 
         var ext = [ lib_const.const_BMP  ,lib_const.const_JPEG  ,lib_const.const_GIF   ,lib_const.const_TIF    ];      
              
         if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress ) ==lib_err.err_FUNC_SUCCESS)
         { 
                 
                   var path =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1);    
                    //DEVICE IS M300||M410||M450               
                   if(  (lib_deviceInfo.const_Device_Model == lib_const.const_M300 )|| 
                        (lib_deviceInfo.const_Device_Model == lib_const.const_M410 )||
                        (lib_deviceInfo.const_Device_Model == lib_const.const_M450 ) )
                   {
                        //edit path from 1.4.1
                         path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1).Click();
                   }
                   //DEVICE IS M210|| M220 (not POE)      
                   if(  lib_deviceInfo.const_Device_Model == lib_const.const_M210 || 
                        lib_deviceInfo.const_Device_Model == lib_const.const_M220     )
                   {
                        //edit path from 1.4.1
                         path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1).Click();
                   }
                   //DEVICE IS M210    
                   if(  lib_deviceInfo.const_Device_Model == lib_const.const_M120 )
                   {
                       //edit path from 1.4.1
                        path.WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_Monitor - 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock",lib_label.const_lb_MonitorDevice , 1).Click();
                   }                    
                  lib_button.clickMenuMonitor(); 
                  lib_button.ui_PlayAndPause( 3000, true);
                  for (var i = ext.length ; i >= 1 ; i --)
                  { 
                            var name = lib_deviceInfo.const_Device_Model + lib_SaveJob.randomJobName();
                            clickSaveImageButton(name  , ext[i-1] ,lib_deviceInfo.const_fileName_SaveIMG, true);
                  }            
                
        }  
//        lib_common.terminateUI();
        Log.PopLogFolder();
 //       aqTestCase.End();
}


/** 
  *Last updated 1.6.0 rc02
  *@function
*/
function clickSaveImageButton_Configuration()// add all 4 types: bmp, jpeg, jpg,tiff
{
  aqTestCase.Begin("SaveImageConfiguration");
         Log.AppendFolder("func: clickSaveImageButton_Configuration");
//         if ( ! lib_validate.isDLCODERunning())
         lib_common.launchUI(); 
         var ext = [ lib_const.const_BMP  ,lib_const.const_JPEG  ,lib_const.const_GIF   ,lib_const.const_TIF    ];           
         if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress ) ==lib_err.err_FUNC_SUCCESS)
         { 
                 if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                 {                         
                          lib_button.ui_PlayAndPause( 3000, false); 
                 
                          for (var i = ext.length ; i >= 1 ; i --)
                          { 
                                    var name = lib_deviceInfo.const_Device_Model + lib_SaveJob.randomJobName();
                                    clickSaveImageButton(name  , ext[i-1] ,lib_deviceInfo.const_fileName_SaveIMG, false);
                          }          
                 }    
        }  
//        lib_common.terminateUI();
        Log.PopLogFolder();
        aqTestCase.End();
}

/** 
  *Last updated 1.6.0 rc02
  *@function
  *@param {String} name
  *@param {String} fileFormat
  *@param {String} path
  *@param {String} isMonitor
*/
function clickSaveImageButton (name ,fileFormat , path , isMonitor)
{      
      try
      {
            Log.AppendFolder("func: clickSaveImageButton");
            var flag = lib_err.err_FUNC_FAILED;
            //validate
            if ( name == null || name =="")
            {
                  Log.Error(lib_err.err_NOT_NULL);
                  return flag;
            } 
            aqFileSystem.CreateFolder(path);
            // Obtains information on the folder
            var FolderInfo = aqFileSystem.GetFolderInfo(path);   
            // Checks whether the folder still exists
            if (FolderInfo.Exists)
            {
                  // Save job
                  //click button save image
                  if (isMonitor == false)
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("controlToolBar").WPFObject("Grid", "", 1).WPFObject("ToolBar", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Border", "", lib_const.const_bbt_SaveImage).WPFObject("Button", "", 1).ClickButton();
                  else
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Button", "", 4).ClickButton();
 
                      
                  var arrPro = ["WndClass", "ChildCount"];
                  var arrVal = ["ComboBox", 0];
                  var fileFormatCbb = Sys.Process("DL.CODE").Window("#32770", "Save As", 1).FindChild(arrPro, arrVal, 1000);
                  fileFormatCbb.Click();
                  fileFormatCbb.ClickItem(fileFormat);
                       
                  var editBar = Sys.Process("DL.CODE").Window("#32770", "Save As", 1).Window("DUIViewWndClassName", "", 1).UIAObject("Explorer_Pane").Window("FloatNotifySink", "", 1).Window("ComboBox", "", 1).Window("Edit", "", 1);  
                  editBar.SetText(path + "\\" + name);
                  Sys.Process("DL.CODE").Window("#32770", "Save As", 1).Window("Button", "&Save", 1).ClickButton(); 
                  //confirm replace 
                  var  txtReplace = "Do you want to replace it?"; 
                       
                  if ( Sys.Process("DL.CODE").WaitWindow("#32770", "*", 1 , lib_const.const_delay_1000).Exists)
                  { 
                           var str =   Sys.Process("DL.CODE").Window("#32770", "*", 1).Window("Static", "*", 2).WndCaption;
                          if (aqString.Find(str, txtReplace) != -1)
                          {
                                Sys.Process("DL.CODE").Window("#32770", "*", 1).Window("Button", "&Yes", 1).ClickButton(); 
                          }                   
                  }     
                
                 while (!Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1)["WaitWPFObject"]("Border", "", 1, lib_const.const_delay_1000).Exists)
                 {
                      Delay(lib_const.const_delay_3000);
                      Sys.Process("DL.CODE").Refresh();                
                 }
                   //validate UnExpectedWindow
                 if (lib_validate.isUnExpectedWindow() == true)
                 {
                        lib_common.proccessUnexpectedWindow();
                        flag = false;
                        return flag;
                 } else
                       flag = lib_err.err_FUNC_SUCCESS;
            }
            else// folder can not found
            {
                  Log.Error(lib_err.err_FILE_NOFOUND);
                  flag = lib_err.err_FILE_NOFOUND;
            }
            Log.PopLogFolder();
            return flag;
      }
      catch (e)
      {
            Log.Error(lib_err.err_FUNC_EXCEPTION);   
      } 
}

/** 
  *Last updated 1.6.0 rc02
  *@function verify Image Resolution
  *@param {String} path
  *@param {String} imageName
  *@param {String} device
  *@param {String} model
*/
function verify_SaveCurrentIMG (path, imageName , device, model)
{

      Log.AppendFolder("func: verify_SaveCurrentIMG");
      var flag = true;
      var arr_Device  = lib_deviceInfo.const_Simulator_Device;
      var arr_Model   = lib_deviceInfo.const_Simulator_Model; 
      var arr_Resolution_W = lib_deviceInfo.const_Resolution_Width;
      var arr_Resolution_H = lib_deviceInfo.const_Resolution_Height;
      //verify picture
      var Pict ;
      // Creates a new empty Picture object
      Pict = Utils.Picture; 
      // Loads the image from a file and posts it to the log
      if (Pict.LoadFromFile(path + "\\" +aqString.Trim(imageName, aqString.stAll) + ".bmp"))
      {
              for (var i = 0; i < arr_Device.length ; i ++)
              {
        //            Log.Message(i);
                    if (arr_Device[i] == device && arr_Model[i] == model)
                    {
                          if ( Pict.Size.Width != arr_Resolution_W[i])
                          {
                                flag = false;
                                Log.Warning(device + "-" + model);
                                Log.Warning(lib_err.msg_ERR_Resolution_Width );
                          }
                          if ( Pict.Size.Height != arr_Resolution_H[i])
                          {
                                flag = false;
                                Log.Warning(lib_err.msg_ERR_Resolution_Height);
                          }
                    }
              }  
      }
      Log.PopLogFolder();
      return flag; 
}

/** 
  *Last updated 1.6.0 rc02
  *@function verify Image Resolution
  *@param {String} path
  *@param {String} imageName
  *@param {String} device
  *@param {String} model
*/
function saveCurrentIMG (path, imageName , device , model)
{
      Log.AppendFolder("func: saveCurrentIMG"); 
      lib_button.ui_PlayAndPause(3000, false);
      var visionControl      =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 2).WPFObject("VisionControl");
      visionToolRoiControl=  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 2).WPFObject("VisionControl").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("PART_MainScrollViewer").WPFObject("ContentViewbox").WPFObject("ImageGrid").WPFObject("Canvas", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("PART_DefaultToolsPresenter").WPFObject("ContentPresenter", "", 1).WPFObject("Canvas", "", 1).WPFObject("visionToolRoiControl").WPFObject("border")          
      visionToolRoiControl.ClickR(301, 190);
      visionControl.PopupMenu.Click(lib_label.lb_Image);   
      visionControl.PopupMenu.Click(lib_label.lb_Image + "|" + lib_label.lb_SaveCurrentImage );  
      if  (Sys.Process("DL.CODE")["WaitWindow"]("#32770", "Save As",1, lib_const.const_delay_1000).Exists)
      {      
              var editBar =Sys.Process("DL.CODE")["Window"]("#32770", "Save As", 1)["Window"]("DUIViewWndClassName", "", 1).UIAObject("Explorer_Pane")["Window"]("FloatNotifySink", "", 1)["Window"]("ComboBox", "", 1)["Window"]("Edit", "", 1)  
              editBar.Keys(path + "\\" + aqString.Trim(imageName, aqString.stAll));
              editBar.Keys("[Enter]");
              
               //confirm replace 
              var  txtReplace = "Do you want to replace it?";
              if ( Sys.Process("DL.CODE")["WaitWindow"]("#32770", "*", 1 , lib_const.const_delay_1000).Exists)
              { 
                      var str = Sys.Process("DL.CODE")["Window"]("#32770", "Save As", 1)["Window"]("Static", "*", 2).WndCaption;
                      if (aqString.Find(str, txtReplace)!= -1)
                      {
                            Sys.Process("DL.CODE")["Window"]("#32770", "Save As", 1)["Window"]("Button", "&Yes", 1).ClickButton();
                      }                   
              }  
      } 
      //verify resolution
      var resolution = verify_SaveCurrentIMG(path,imageName , device,  model)
      Log.Message("verify_SaveCurrentIMG: " +resolution );
      Log.PopLogFolder();
      return resolution;
}


function clickSaveImageButton_FilterNotFilter(isFilter)// add all 4 types: bmp, jpeg, jpg,tiff
{
         Log.AppendFolder("func: clickSaveImageButton_Configuration");
         var arrPathImageReturn = new Array();
//         if ( ! lib_validate.isDLCODERunning())
         lib_common.launchUI(); 
         var ext = [ lib_const.const_BMP  ,lib_const.const_JPEG  ,lib_const.const_GIF   ,lib_const.const_TIF    ];           
         if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress ) ==lib_err.err_FUNC_SUCCESS)
         { 
                 if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                 {                         
                          lib_button.ui_PlayAndPause( 3000, false);
                          
                          var treeViewItemCodes = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1);
                          var childCount = treeViewItemCodes.ChildCount; 
                          lib_button.clickAddFilter(childCount-1);
                          for (var i = ext.length ; i >= 1 ; i --)
                          { 
                                    var name = lib_deviceInfo.const_Device_Model + lib_SaveJob.randomJobName();
                                    RightClickSaveImageFilterNotFilter(name  , ext[i-1] ,lib_deviceInfo.const_fileName_SaveIMG, false, isFilter);
                                    if(i==4) tag = ".tif";
                                    else if (i==3) tag = ".gif";
                                    else if(i==2) tag = ".jpg";
                                    else if (i==1) tag = ".bmp";
                                    arrPathImageReturn.push(lib_deviceInfo.const_fileName_SaveIMG + "\\" + name+tag);
                          }          
                 }    
        }  
//        lib_common.terminateUI();
        Log.PopLogFolder();
        return arrPathImageReturn;
}
function RightClickSaveImageFilterNotFilter(name ,fileFormat , path , isMonitor, isFilter)
{
  try
      {
            var flag = lib_err.err_FUNC_FAILED;
            //validate
            if ( name == null || name =="")
            {
                  Log.Error(lib_err.err_NOT_NULL);
                  return flag;
            } 
            aqFileSystem.CreateFolder(path);
            // Obtains information on the folder
            var FolderInfo = aqFileSystem.GetFolderInfo(path);   
            // Checks whether the folder still exists
            if (FolderInfo.Exists)
            {
                  // Save job
                  //click button save image
                  if (isMonitor == false)
                  {
                    visionControl =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 2).WPFObject("VisionControl");
                    screenImage = Sys.Process("DL.CODE").FindChild("WPFControlName", "visionToolRoiControl", 1000);
                    screenImage.HoverMouse();
                    screenImage.ClickR();
                    if(isFilter)
                    {
                      visionControl.PopupMenu.Click("Image|[2]|Filtered");
                      delay(1000);
                      aqObject.CheckProperty(Sys.Process("DL.CODE").Window("#32770", "Save As", 1).Window("DUIViewWndClassName", "", 1).UIAObject("Explorer_Pane").Window("FloatNotifySink", "", 1).Window("ComboBox", "", 1).Window("Edit", "", 1), "wText", cmpContains, "filtered");
                    }
                    else
                    {
                      visionControl.PopupMenu.Click("Image|[2]|Not Filtered");
                      delay(1000);
                      aqObject.CheckProperty(Sys.Process("DL.CODE").Window("#32770", "Save As", 1).Window("DUIViewWndClassName", "", 1).UIAObject("Explorer_Pane").Window("FloatNotifySink", "", 1).Window("ComboBox", "", 1).Window("Edit", "", 1), "wText", cmpNotContains, "filtered");
                    }
                    
                  }
                  else
                  {                    
                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Button", "", 4).ClickButton();
                    
                  }
                      
 
                  arrPro = ["ChildCount", "WndClass"]     ;
                  arrVal = [0, "ComboBox"];
                  var fileFormatCbb = Sys.Process("DL.CODE").Window("#32770", "Save As", 1).FindChild(arrPro, arrVal, 1000);
                  fileFormatCbb.Click();
                  fileFormatCbb.ClickItem(fileFormat);
                       
                  var editBar = Sys.Process("DL.CODE").Window("#32770", "Save As", 1).Window("DUIViewWndClassName", "", 1).UIAObject("Explorer_Pane").Window("FloatNotifySink", "", 1).Window("ComboBox", "", 1).Window("Edit", "", 1);  
                  editBar.Keys(path + "\\" + name);
                  Sys.Process("DL.CODE").Window("#32770", "Save As", 1).Window("Button", "&Save", 1).ClickButton(); 
                  //confirm replace 
                  var  txtReplace = "Do you want to replace it?"; 
                       
                  if ( Sys.Process("DL.CODE").WaitWindow("#32770", "*", 1 , lib_const.const_delay_1000).Exists)
                  { 
                           var str =   Sys.Process("DL.CODE").Window("#32770", "*", 1).Window("Static", "*", 2).WndCaption;
                          if (aqString.Find(str, txtReplace) != -1)
                          {
                                Sys.Process("DL.CODE").Window("#32770", "*", 1).Window("Button", "&Yes", 1).ClickButton(); 
                          }                   
                  }     
                
                 while (!Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1)["WaitWPFObject"]("Border", "", 1, lib_const.const_delay_1000).Exists)
                 {
                      Delay(lib_const.const_delay_3000);
                      Sys.Process("DL.CODE").Refresh();                
                 }
                   //validate UnExpectedWindow
                 if (lib_validate.isUnExpectedWindow() == true)
                 {
                        lib_common.proccessUnexpectedWindow();
                        flag = false;
                        return flag;
                 } else
                       flag = lib_err.err_FUNC_SUCCESS;
            }
            else// folder can not found
            {
                  Log.Error(lib_err.err_FILE_NOFOUND);
                  flag = lib_err.err_FILE_NOFOUND;
            }
            Log.PopLogFolder();
            return flag;
      }
      catch (e)
      {
            Log.Error(lib_err.err_FUNC_EXCEPTION);   
      }
}

function tsss()
{
  visionControl =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 2).WPFObject("VisionControl");
  screenImage = Sys.Process("DL.CODE").FindChild("WPFControlName", "visionToolRoiControl", 1000);
  screenImage.HoverMouse();
  screenImage.ClickR();
  //visionControl.PopupMenu.Click(lib_label.lb_Image);
  //visionControl.PopupMenu.Click(lib_label.lb_Image+ "|" + "Clean");
  //visionControl.PopupMenu.Click(lib_label.lb_Image+"|"+"Save Image");
  visionControl.PopupMenu.Click("Image|[2]|Not Filtered");
  //visionControl.PopupMenu.Click(lib_label.lb_Image|lib_label.lb_SaveCurrentImage|"Not Filtered");
//  visionControl.PopupMenu.PopupMenu.Click(lib_label.lb_SaveCurrentImage);   
//  visionControl.PopupMenu.PopupMenu.PopupMenu.Click("Not Filtered");
}