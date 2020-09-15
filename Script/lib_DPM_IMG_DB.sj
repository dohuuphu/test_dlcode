//USEUNIT lib_common
//USEUNIT lib_deviceInfo
//USEUNIT lib_messageLog
//USEUNIT lib_validate
//USEUNIT lib_const
//USEUNIT lib_button
//USEUNIT lib_OpenJob

//add from 1.5.0 Alpha 3
function  testRecord ()
{       
       if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI();  
       var ip = lib_deviceInfo.const_Device_IP_Adress;
       var arr_Actions = [lib_label.lb_CodeAutolearn_Discard,lib_label.lb_AddIMGDB, lib_label.lb_SaveIMGonLocalDB ]
       if (lib_common.connectToDevice(ip))
       {                     
            if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
            {
                  for (var i = 1; i <= arr_Actions.length ; i ++)
                  {
                          emptyDPM_IMG_DB();
                          processTestRecord(arr_Actions[i-1], lib_const.const_delay_6000 );
                  }
            }                
      }  
      lib_common.terminateUI();
}
function emptyDPM_IMG_DB ()
{
          lib_button.clickOpenDPM_IMG_DB();
          Sys.Process("DL.CODE").Refresh();
          var itemPrster = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", "DL.CODE 1.5.0.29").WPFObject("Shell", "DL.CODE 1.5.0.29", 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("DpmTrainControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PART_ImagesListBox").WPFObject("Border", "", 1).WPFObject("ItemsPresenter", "", 1);
          var childCount = itemPrster.ChildCount;
          
          for (var i = 1; i <= childCount ; i++)
          {
                Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", "DL.CODE 1.5.0.29").WPFObject("Shell", "DL.CODE 1.5.0.29", 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("DpmTrainControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PART_ImagesListBox").WPFObject("Border", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
                
          }
          Sys.Process("DL.CODE").Refresh();
          if (itemPrster.ChildCount == 0)
                  return true;
          else 
                  return false;
                    
}
function processTestRecord(action, time)
{         lib_button.clickAdvancedSetup();
          lib_button.clickTestRecord();          
          var numSuccess ;
          var numFailure ;
          var flag = false;
          if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: ConfigurationTestPopup", lib_label.lb_ConfigurationTestRunning, lib_const.const_delay_1000).Exists)
          {
                  var path = Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationTestPopup", lib_label.lb_ConfigurationTestRunning).WPFObject("ConfigurationTestPopup", lib_label.lb_ConfigurationTestRunning, 1);
                  delay ( time );
                  path.WPFObject("Grid", "", 1).WPFObject("Button", "OK", 1).ClickButton();
                  if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: PopupMessage", "Information", lib_const.const_delay_1000).Exists)
                  {
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: PopupMessage", "Information").WPFObject("PopupMessage", "Information", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "Test Successful, no failed images!", 1), "Enabled", cmpEqual, false);
                  }else
                  {           
                          numSuccess = path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 5).WPFControlText; 
                          numFailure    = path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 7).WPFControlText; //
                          numSuccess = aqString.GetListItem(numSuccess, 0);
                          numFailure = aqString.GetListItem(numFailure, 0) ; 
                          Log.Message("Failure:" + numFailure);                  
                          Log.Message("Success:" + numSuccess );          
                          if (action == lib_label.lb_CodeAutolearn_Discard)
                          {
                                  path.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("RadioButton", "Discard failure images", 3).ClickButton();
                                  path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "OK", 1).ClickButton();
                  
                                  flag = true;
                                  return flag;
                          }
                          if (action == lib_label.lb_AddIMGDB)
                          {
                                  path.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("RadioButton", "Add Failure images to DB", 1).ClickButton();
                                  path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "OK", 1).ClickButton();
                  
                                  Sys.Process("DL.CODE").Refresh();
                                  lib_button.clickOpenDPM_IMG_DB();
                                  var itemPrster = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", "DL.CODE 1.5.0.29").WPFObject("Shell", "DL.CODE 1.5.0.29", 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("DpmTrainControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PART_ImagesListBox").WPFObject("Border", "", 1).WPFObject("ItemsPresenter", "", 1);
                                  var childCount = itemPrster.ChildCount;
                                  numSuccess = aqString.GetListItem(numSuccess, 0);
                                  numFailure = aqString.GetListItem(numFailure, 0) ;
                                  if ( (numFailure > 10 && childCount == 10 ) || (numFailure <=10  && numFailure == childCount )    )
                                  {
                                        Log.Message( "Test Record OK");
                                        flag = true;
                                        return flag;
                                  }
                  
                     
                          }
                          if (action == lib_label.lb_SaveIMGonLocalDB)
                          {
                                  path.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("RadioButton", "Save Failure Images on Local DB", 2).ClickButton();
                                  path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "OK", 1).ClickButton();
                                  if (Sys.Process("DL.CODE").WaitWindow("#32770", "Browse For Folder",-1, lib_const.const_delay_1000).Exists)
                                  {
                                          var sysTreeView32;   
                                          sysTreeView32 = Sys.Process("DL.CODE").Window("#32770", "Browse For Folder", 1).Window("SHBrowseForFolder ShellNameSpace Control", "", 1).Window("SysTreeView32", "Tree View", 1);
                                          sysTreeView32.ExpandItem("|Desktop|Computer");
                                          sysTreeView32.ExpandItem("|Desktop|Computer|Local Disk (G:)"); 
                                          sysTreeView32.ExpandItem("|Desktop|Computer|Local Disk (G:)|DL.CODE"); 
                                          sysTreeView32.ExpandItem("|Desktop|Computer|Local Disk (G:)|DL.CODE|AutomationTestComplete");
                                          sysTreeView32.ClickItem("|Desktop|Computer|Local Disk (G:)|DL.CODE|AutomationTestComplete|FailureImages");
                                          Sys.Process("DL.CODE").Window("#32770", "Browse For Folder", 1).Window("Button", "OK", 2).ClickButton(); 
                                  }
                          }
                  }
          }
          
          return flag; 
          
}