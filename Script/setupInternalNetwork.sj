//USEUNIT lib_common 
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_DeviceSelectedDetail
//USEUNIT lib_OpenJob
//USEUNIT lib_SaveJob
//USEUNIT lib_validate
//USEUNIT simulator_common


 
/* for all of devicesx
  *add new 1.6.0 RC02
  *@function 
*/
function testSuite_659_SimulatorSetupInternalNetwork (index)
{    
     Log.AppendFolder("simulator_EnterMulti_Sync_Packtrack_Config");  
     var arr_Device  = lib_deviceInfo.const_Simulator_Device;
     var arr_Model   = lib_deviceInfo.const_Simulator_Model;
     var arr_Model_Detail   = lib_deviceInfo.const_Simulator_Model_Detail;  
     simulator_VerifySetupInteralNetworkWindow(arr_Device, arr_Model, arr_Model_Detail, index);
     simulator_EnterMulti_Sync_Packtrack_Config(arr_Device, arr_Model, arr_Model_Detail, index);
}




/*
  *@function 
*/
function simulator_EnterMulti_Sync_Packtrack_Config(arr_Device, arr_Model, arr_Model_Detail, i)
{
         
         if (i == 0)
              return;
         lib_common.launchUI();  
         Log.AppendFolder("simulator_EnterMulti_Sync_Packtrack_Config");   
         Log.Message(i);
         //length mean there are 2-3 configs: muilti.sync.packtrack  
         var length = 0;     
          //M410 XRF  
         var m410XRF = false;
         if ( arr_Device[i] == lib_const.const_M410 &&  arr_Model[i] == "XRF-H2x")
             m410XRF = true  ;                      
         if (arr_Device[i] == lib_const.const_M210 ||
             arr_Device[i] == lib_const.const_M220 ||
             arr_Device[i] == lib_const.const_M320 ||
             m410XRF == true   ) 
             length = 2;
         else
             length = 3; 
         for (var j= 1; j<= length; j ++)
         {
                  var flag = connectToSimulator(arr_Device[i] , arr_Model[i]);
                  if (flag == lib_err.err_FUNC_SUCCESS)
                  {        
                        //get role
                        var role = lib_DeviceSelectedDetail.getDeviceRole();   
                        //device M220 no POE
                        var m220_355_040 =  false;
                        if (arr_Device[i] == lib_const.const_M220 &&  arr_Model[i] == "355-040")
                             m220_355_040 = true;   
                             
                                    
                        if (arr_Device[i] != lib_const.const_M120  && m220_355_040 != true)
                        {     
                              Delay(5000);
                              if (m410XRF == true)
                                       Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork -1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").ClickButton();
                              else            
                                       Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").ClickButton();
                           
                              //Slave
                              Delay(5000);
                              if (role == lib_label.const_lb_Slave )
                              { 
                                  for (var m = 1; m <= 2; m++)
                                  var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1); 
              
                                  if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", 1000).Exists)
                                  { 
                                     aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, lib_label.lb_SetupInternalNetwork);
                                     if (m == 1)
                                            Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnCancel").ClickButton();
                                     else
                                            Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();
                                  }
                              }
                              delay (3000);                                     
                              if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                              {
                                      while (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                                      {
                                               Delay(4000);
                                      }
                                      var path =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1);
                                      var typeConfig = path.WPFObject("ListBoxItem", "",j+ 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                                      Delay(2000);
                                      path.WPFObject("ListBoxItem", "",j+ 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").ClickButton();
                                      Delay(2000);
                                      // wait Progress bar is collapsed
                                      while (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("BusyIndicator", "", 1).Visibility == "Visible")
                                      { 
                                           delay (5000);
                                           Sys.Process("DL.CODE").Refresh();
                                      }
                                      while (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WaitWPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice, 5000).Exists == false)
                                      {
                                           delay (5000);
                                      }
                                      delay (5000);
                                      if(Objects.bttSaveOnDevice (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", 6).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1)))
                                      {
                                            
                                      delay (5000);
                                              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1).Click();
                                              if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device", 2000).Exists)
                                              {
                                                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 2), "WPFControlText", cmpEqual, lib_label.const_lb_SaveOnSlaveDevice);
                                                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 3), "WPFControlText", cmpEqual, lib_label.const_lb_CloneMasterConfigurationSlaves);
                                                    Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
                                              }
                                              lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, typeConfig , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);
                                      }                              
                                      
                              }
                              
                          } 
                  }
         }
        
        Log.PopLogFolder();
}


/*
  *@function 
*/
function simulator_VerifySetupInteralNetworkWindow(arr_Device, arr_Model, arr_Model_Detail, i)
{
        Log.AppendFolder("simulator_VerifySetupInteralNetworkWindow");
        if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI();      
 
         Log.Message(i+ "**********************************************");
         Log.Message(arr_Device[i] + "-" + arr_Model[i] );                  
         var flag = connectToSimulator(arr_Device[i] , arr_Model[i]);
         if (flag == lib_err.err_FUNC_SUCCESS)
         {
                                   
              //get role
              var role = lib_DeviceSelectedDetail.getDeviceRole();   
              var m410XRF = false;
              if ( arr_Device[i] == lib_const.const_M410 &&  arr_Model[i] == "XRF-H2x")
                   m410XRF = true  ;  
                   
              var m220_355_040 =  false;
              if (arr_Device[i] == lib_const.const_M220 &&  arr_Model[i] == "355-040")
                   m220_355_040 = true;      
              if ( arr_Device[i] != lib_const.const_M120 &&  m220_355_040 != true) 
              {     Delay(3000) ;
                    if (m410XRF == true)
                             Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork -1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").ClickButton();
                    else            
                             Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").ClickButton();
                           
                    //Slave
                    Delay(3000);
                    if (role == lib_label.const_lb_Slave )
                    { 
                        for (var j = 1; j <= 2; j++)
                        var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1); 
              
                        if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", 1000).Exists)
                        { 
                           aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, lib_label.lb_SetupInternalNetwork);
                           if (j == 1)
                                  Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnCancel").ClickButton();
                           else
                                  Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();
                        }
                    }
                    delay (3000);
                    if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                    {
                            while (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                            {
                                     Delay(4000);
                            }
                    }
                    while(!Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("NewSlaveDropPlaceholder").WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Button", "Right Click to add a Device", 1).Visible)
                    {
                    }
                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("NewSlaveDropPlaceholder").WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Button", "Right Click to add a Device", 1).ClickR();
                    Sys.Process("DL.CODE").Refresh();
                    delay(2000);

                    //verify label         
                    simulator_VerifySetupInteralNetworkWindow_Default(arr_Device[i], arr_Model[i]);
                    //start/stop autonet
                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Start Net Autoset", 1).Click();
                   
                    //cancel
                       
                    if(Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset",500).Exists)
                    { 
                          Sys.Process("DL.CODE").WPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset").WPFObject("NetworkAutosetWindow", "Network Autoset", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 1).ClickButton();
                          delay (2000); 
                    }
  
                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Start Net Autoset", 1).Click();
                    if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                    {
                            while (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                            {
                                     Delay(4000);
                            }
                    }
                      
                    //add 31 Simulator Slaves
                    for (var l = 1; l <= 31 ; l ++)
                    {               
                          Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("NewSlaveDropPlaceholder").WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Button", "Right Click to add a Device", 1).ClickR();
                          Sys.Process("DL.CODE").Refresh();
                          delay(2000);
                    }
                    //delete 31 Simulators Slaves
                    for (var m = 1; m <= 31 ; m ++)
                    {               
                          Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("SlavesItemsControl").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("dropGrid").WPFObject("StackPanel", "", 2).WPFObject("RemoveButton").WPFObject("Image", "", 1).Click();
                          Sys.Process("DL.CODE").Refresh();
                          delay(2000);
                    }              
              }  
      } 
          Log.PopLogFolder();
}


 
/*
  *add new 1.6.0 RC02
  *update 1.9.0A7 20200220
  *@function 
*/
function testSuite_659_SetupInternalNetwork ()
{     
     aqTestCase.Begin("Setup Internal Network");
     verifySetupInteralNetworkWindow();
     enterMulti_Sync_Packtrack_Config();     
     //Verify that Overwrite existing Configuration on cluster will overwrite selected configuration on Master and create a new configuration with selected name (if not already present)
     // => call this function again to save overwrite
     //giang.ha update 20200220
     enterMulti_Sync_Packtrack_Config();     
     aqTestCase.End();
     
}

/*
  *@function 
*/
function enterMulti_Sync_Packtrack_Config()
{
         Log.AppendFolder("enterMulti_Sync_Packtrack_Config");
         lib_common.launchUI();  
         var ip = lib_deviceInfo.const_Device_IP_Adress;
         
         var length = 0;
         var functionLabel = ["Set Default Multidata Configuration","Set Default Synchronized Phase Mode Configuration","Set Default Synchronized PackTrack Configuration"];   
         
         if (lib_deviceInfo.const_Device_Model == lib_const.const_M120)
              return;
         if (lib_deviceInfo.const_Device_Model == lib_const.const_M210 ||
             lib_deviceInfo.const_Device_Model == lib_const.const_M220) 
             length = 2;
         else
             length = 3; 
         
         for (var i= 1; i<= length; i ++)
         {
                 if (lib_common.connectToDevice(ip))
                 {         
                        //get role
                        var role = lib_DeviceSelectedDetail.getDeviceRole();            
                        if (lib_deviceInfo.const_Device_Model != lib_const.const_M120 )
                        {                
                              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").ClickButton();
                           
                              //Slave
                              if (role == lib_label.const_lb_Slave )
                              {  
                                    var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1); 
              
                                    if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", 1000).Exists)
                                    { 
                                       aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, lib_label.lb_SetupInternalNetwork);
                                       if (m == 1)
                                              Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnCancel").ClickButton();
                                       else
                                              Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();
                                    } 
                              }
                              delay (3000);
                              if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                              {
                                      while (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                                      {
                                               Delay(4000);
                                      }
                              }
                              
                              //to make sure GUI Enter Cluster View 
                              var itemsPresenter = Sys.Process("DL.CODE").FindChild("ClrClassName", "ItemsPresenter", 2000);
                              if  (itemsPresenter.Exists  )
                              {
                                   while (itemsPresenter.Enabled ==false)                                   
                                   {
                                       delay (6000);
                                       itemsPresenter.Refesh(); 
                                   }
                              }                              
                              var funcButton  = Sys.Process("DL.CODE").FindChild("WPFControlText",functionLabel[i-1] , 2000);
                              if  (funcButton.Exists  )
                              {
                                   while (funcButton.Enabled == false)                                   
                                   {
                                       delay (6000);
                                       funcButton.Refesh(); 
                                   }
                                   
                                   var configName  = functionLabel[i-1];
                                   funcButton.Click();
                                   delay (2000);
                                  // wait Progress bar is collapsed
                                  while (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("BusyIndicator", "", 1).Visibility == "Visible")
                                  { 
                                       delay (5000);
                                       Sys.Process("DL.CODE").Refresh();
                                  }
                              
                                  while (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WaitWPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice, 1000).Exists == false)
                                  {
                                       delay (3000);
                                       Sys.Process("DL.CODE").Refresh();
                                  }
                                  delay(5000);
                                  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_SaveOnDevice).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).ClickButton();
                                  if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device", 2000).Exists)
                                  {
                                        //Verify -Clone Master configuration to Slave- option available on Multidata mode
                                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 2), "WPFControlText", cmpEqual, lib_label.const_lb_SaveOnSlaveDevice);
                                        aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 3), "WPFControlText", cmpEqual, lib_label.const_lb_CloneMasterConfigurationSlaves);
                                        Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Save Configuration on Device").WPFObject("JobListDialogWindow", "Save Configuration on Device", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
                                  }
                                  lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N, configName , lib_const.const_isDefaultJob_N, lib_const.isMonitorMode_N);   
                              }  
                          } 
                  }
         } 
        Log.PopLogFolder();
}

/*
  *@function 
*/
function verifySetupInteralNetworkWindow()
{
         Log.AppendFolder("verifySetupInteralNetworkWindow");
//         if ( ! lib_validate.isDLCODERunning())
         lib_common.launchUI();  
         var ip = lib_deviceInfo.const_Device_IP_Adress; 
         if (lib_common.connectToDevice(ip))
         {         
                //get role
                var role = lib_DeviceSelectedDetail.getDeviceRole();            
                if (lib_deviceInfo.const_Device_Model != lib_const.const_M120 )
                {                
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("Border1").WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", lib_const.const_treeview_InternalNetwork).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").ClickButton();
                      delay (3000);     
                      //Slave
                      if (role == lib_label.const_lb_Slave )
                      { 
                          for (var i = 1; i <= 2; i++)
                          var gridList =   Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 6).WPFObject("Grid", "", 1).WPFObject("DropPlaceholder").WPFObject("Grid", "", 1).WPFObject("ContentExpander", "Selected Device Details", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1); 
              
                          if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", 1000).Exists)
                          { 
                             aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText"), "WPFControlText", cmpEqual, lib_label.lb_SetupInternalNetwork);
                             if (i == 1)
                                    Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnCancel").ClickButton();
                             else
                                    Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();
                          }
                      }
                      delay (3000);
                      if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                      {
                              while (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                              {
                                       Delay(4000);
                              }
                      }
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("NewSlaveDropPlaceholder").WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Button", "Right Click to add a Device", 1).ClickR();
                      Sys.Process("DL.CODE").Refresh();
                      delay(2000);

                      //verify label         
                      verifySetupInteralNetworkWindow_Default();  
                      //start/stop autonet
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Start Net Autoset", 1).Click();
                   
                      //cancel                       
                      if(Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset",500).Exists)
                      { 
                            Sys.Process("DL.CODE").WPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset").WPFObject("NetworkAutosetWindow", "Network Autoset", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 1).ClickButton();
                            delay (2000); 
                      }
  
                      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Start Net Autoset", 1).Click();
                      if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                      {
                              while (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: NetworkAutosetWindow", "Network Autoset", 4000).Exists)
                              {
                                       Delay(4000);
                              }
                      }
                      
                      //add 31 Simulator Slaves
                      for (var i = 1; i <= 31 ; i ++)
                      {               
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("NewSlaveDropPlaceholder").WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Button", "Right Click to add a Device", 1).ClickR();
                            Sys.Process("DL.CODE").Refresh();
                            delay(2000);
                      }
                      //delete 31 Simulators Slaves
                      for (var i = 1; i <= 31 ; i ++)
                      {               
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("SlavesItemsControl").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("dropGrid").WPFObject("StackPanel", "", 2).WPFObject("RemoveButton").WPFObject("Image", "", 1).Click();
                            Sys.Process("DL.CODE").Refresh();
                            delay(2000);
                      }              
                }  
          }
       
          //lib_common.terminateUI();
          Log.PopLogFolder();
}

/*
  *@function 
  *@param device{String}
  *@param devModel{String}
*/

function simulator_VerifySetupInteralNetworkWindow_Default (device, devModel )
{         
              //left panel
              if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WaitWPFObject("ClusterNetworkSetupView", "", 1, 3000).Exists == false)
                    delay (4000);
              var path =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1);
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 3).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 4).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "Enabled", cmpEqual, true);
              //device doesnt have Packtrack: M210 & M220
              if (device != lib_const.const_M210 && device != lib_const.const_M220  && device != lib_const.const_M320 && devModel !="XRF-H2x" )    
                    aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 5).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "Enabled", cmpEqual, true);
 
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_StartNetAutoset );
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_ManageConfiguration);
              
              if (device == lib_const.const_M410 && devModel =="XRF-H2x"  )// M410 XRF
              {
              
                      aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 3).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultSynchronizedPhaseMode);
                      aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 4).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultSynchronizedPackTrack);
                      
              }
              else
              {
                       if (device == lib_const.const_M220 &&  devModel == "355-040")//M220 355-040
                               return;
                      //for all dev
                      aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 3).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultMultidata);
                      aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 4).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultSynchronizedPhaseMode);
                      //dev has packtrack
                      if (existPackTrackMode (device) ) 
                      {   
                               aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 5).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultSynchronizedPackTrack );
                      }
 
              }

              
              //center panel 
              var arr = [lib_label.lb_Status , lib_label.lb_Type ,lib_label.lb_InternalNetworkRole, lib_label.lb_IPAddress_2, lib_label.lb_SerialNumber,lib_label.lb_DeviceDescription ]
              for (var i = 1; i <= arr.length ; i ++)
              { 
                    if (i < 5)               
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", i).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, arr[i-1]);
                    if(i>=5)
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", i+1).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, arr[i-1]);
                                           
              }
              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("NewSlaveDropPlaceholder").WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Button", "*", 1), "WPFControlText", cmpEqual, lb_RightClickAddDevice);
              //open other window 
              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Manage Configuration", 1).Click();
              if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration", 1000).Exists)
              {                    
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration").WPFObject("MultiDataManageConfigurationPopup", "Manage Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_PleaseSelect);
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration").WPFObject("MultiDataManageConfigurationPopup", "Manage Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("RadioButton", "*", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_CloneMasterConfiguration);
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration").WPFObject("MultiDataManageConfigurationPopup", "Manage Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("RadioButton", "*", 2).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultMultidata);
                    aqObject.CheckProperty( Sys.Process("DL.CODE").WPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration").WPFObject("MultiDataManageConfigurationPopup", "Manage Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("RadioButton", "*", 3).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultSynchronizedPhaseMode);
                    if ( existPackTrackMode( device ))    
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration").WPFObject("MultiDataManageConfigurationPopup", "Manage Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("RadioButton", "*", 4).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultSynchronizedPackTrack );
                    Sys.Process("DL.CODE").WPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration").WPFObject("MultiDataManageConfigurationPopup", "Manage Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "Cancel", 2).ClickButton();
 
              }

}

/*
  *@function  
*/
function verifySetupInteralNetworkWindow_Default ( )
{         
              //left panel
              if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WaitWPFObject("ClusterNetworkSetupView", "", 1, 3000).Exists == false)
                    delay (4000);
              var path =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1);
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 3).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 4).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "Enabled", cmpEqual, true);

              if (lib_deviceInfo.const_Device_Model!= lib_const.const_M220 && lib_deviceInfo.const_Device_Model != lib_const.const_M220)    
                    aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 5).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button"), "Enabled", cmpEqual, true);
 
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 1).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_StartNetAutoset );
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_ManageConfiguration);
              
              
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 3).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultMultidata);
              aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 4).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultSynchronizedPhaseMode);
               
              if (lib_deviceInfo.const_Device_Model!= lib_const.const_M210 && lib_deviceInfo.const_Device_Model != lib_const.const_M220)    
                    aqObject.CheckProperty(path.WPFObject("ListBoxItem", "", 5).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultSynchronizedPackTrack );
 
             
              
              //center panel 
              var arr = [lib_label.lb_Status , lib_label.lb_Type ,lib_label.lb_InternalNetworkRole, lib_label.lb_IPAddress_2, lib_label.lb_SerialNumber,lib_label.lb_DeviceDescription ]
              for (var i = 1; i <= arr.length ; i ++)
              {
                    if (i < 5)               
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", i).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, arr[i-1]);
                    if(i>=5)
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", i+1).WPFObject("TextBlock", "", 1), "WPFControlText", cmpEqual, arr[i-1]);
                                           
              }
              aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("NewSlaveDropPlaceholder").WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("Button", "*", 1), "WPFControlText", cmpEqual, lb_RightClickAddDevice);
              //open other window 
              Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("ClusterNetworkSetupView", "", 1).WPFObject("LayoutRoot").WPFObject("CentralPanel").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("ListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", 2).WPFObject("Bd").WPFObject("ContentPresenter", "", 1).WPFObject("Button").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Manage Configuration", 1).Click();
              if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration", 1000).Exists)
              {                    
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration").WPFObject("MultiDataManageConfigurationPopup", "Manage Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_PleaseSelect);
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration").WPFObject("MultiDataManageConfigurationPopup", "Manage Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("RadioButton", "*", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_CloneMasterConfiguration);
                    aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration").WPFObject("MultiDataManageConfigurationPopup", "Manage Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("RadioButton", "*", 2).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultMultidata);
                    aqObject.CheckProperty( Sys.Process("DL.CODE").WPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration").WPFObject("MultiDataManageConfigurationPopup", "Manage Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("RadioButton", "*", 3).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultSynchronizedPhaseMode);
                    if (lib_deviceInfo.const_Device_Model!= lib_const.const_M210 && lib_deviceInfo.const_Device_Model != lib_const.const_M220)    
                          aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration").WPFObject("MultiDataManageConfigurationPopup", "Manage Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("RadioButton", "*", 4).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, lib_label.lb_SetDefaultSynchronizedPackTrack );
                    Sys.Process("DL.CODE").WPFObject("HwndSource: MultiDataManageConfigurationPopup", "Manage Configuration").WPFObject("MultiDataManageConfigurationPopup", "Manage Configuration", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "Cancel", 2).ClickButton();
 
              }

}