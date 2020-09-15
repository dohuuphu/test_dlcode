//USEUNIT lib_validate
//USEUNIT lib_OpenJob
//USEUNIT lib_common
//USEUNIT lib_validate
//USEUNIT lib_err
//USEUNIT lib_button
//USEUNIT lib_CodeSetup

/*
  *@function  
*/
function StressTest_Laucnh_CloseUI ()  
{
         var ip    = lib_deviceInfo.const_Device_IP_Adress;            
         var times = 50;          
         for (var i = 1 ; i<= times; i ++)
         {
               Log.Message("Times:"+i); 
               lib_common.launchUI();        
               if (lib_common.connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
               {    
                      if( lib_OpenJob.openOnDevice( lib_const.const_DefaultJob ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
                      {
                           lib_button.clickClose();
                      }           
               }
         }
}


/*
  *@function  
*/
function StressTest () /*Implementation: 13393*/ 
{
         aqTestCase.Begin("STRESS TEST");
         var ip    = lib_deviceInfo.const_Device_IP_Adress;            
         var times = 5;
         if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI();     
         if (lib_common.connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
         {      
              if( lib_OpenJob.openOnDevice( lib_const.const_DefaultJob ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
//              if( lib_OpenJob.openOnDevice( "aaa" ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
              {
                      for (var i = 1 ; i<= times; i ++)
                      {
                            Log.Message("Time:" + i ) ;
                            for (var j = 1; j <= times ; j++)
                            {
                                lib_button.clickAdvancedSetup();
                                lib_button.clickPlay(false);                         
                                lib_button.clickPause(false);  
                            }
                            for (var m = 1; m <= times ; m++)
                            {
                                     lib_button.clickCapture();
                            }
                            
                            lib_button.clickIVSMonitorButton();
                            for (var n = 1; n <= times ; n++)
                            {
                                lib_button.clickPlay(true);                          
                                lib_button.clickPause(true);  
                            }
                            lib_button.clickIVSMonitorButton();      
                      }
              }  
        }  
        aqTestCase.End();
        //lib_common.terminateUI();
}

/*
  *@function  
*/
function StressTest_IVSMenuToolbar()// switch to monitor/configuration on IVS menu toolbar
{
         var ip    = lib_deviceInfo.const_Device_IP_Adress;   
         var time = 10;         

         if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI();     
         if (lib_common.connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
         {      
              if( lib_OpenJob.openOnDevice( lib_const.const_DefaultJob ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
              {
              
                      for (var i = 1 ; i<= time ;i ++)
                      {
                            Log.Message("Time:" + i ) ;
                            Delay(5000);//linhtnguyen comment
                            var controlToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("controlToolBar");
                            for (var j = 1; j <= time ; j++)
                            {
                                    lib_button.clickAdvancedSetup();
                                    lib_button.clickPlay(false);                         
                                    lib_button.clickPause(false);
                                    
                            }
                            for (var m = 1; m <= time ; m++)
                            {
                                    lib_button.clickCapture();
                            }
                            //switch to monitor mode       
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1).Click();
                            for (var n = 1; n <= time ; n++)
                            {
                                 
                                    lib_button.clickPlay(true);                          
                                    lib_button.clickPause(true);    
                            }
                            //switch to Configuration mode
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1).Click();                    
                                               
                      }
              }  
        }  
        //lib_common.terminateUI();
}

/*
  *@function  
*/
function StressTest_Direct_Implementation()// old
{

         
         var time1 = 1;
         var time2 = 1;

   
         var ip    = lib_deviceInfo.const_Device_IP_Adress;            

         if ( ! lib_validate.isDLCODERunning())
           lib_common.launchUI();     
         if (lib_common.connectToDevice(ip) == lib_err.err_FUNC_SUCCESS)
         {      
              if( lib_OpenJob.openOnDevice(  lib_const.const_DefaultJob ,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == true)
              {
                      Log.Message("Add INT2OF5");
                      lib_button.clickAddCode (lib_label.lb_CodeType1D, lb_INT2OF5);   
                      for (var i = 1 ; i<= time1 ;i ++)
                      {
                            
                            var t =1;
                            while (!Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WaitWPFObject("controlToolBar", 100).Exists)
                            {
                                    Log.Warning("waiting:" + i);
                                    if (lib_validate.isUnExpectedWindowExists () == true)
                                    {   
                                              Log.Warning("isUnExpectedWindow = true");                     
                                              return;
                                    }
                                    delay (100);
                                    if (t>=5)
                                         return;
                                    else 
                                         t++;
                                    
                            
                            } 
                            Indicator.PushText("Time:" + i);	 
                            Log.Message("Time:" + i ) ;                            
                            var controlToolbar = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("controlToolBar");
                            lib_CodeSetup.editCodeSize (3, 100,100,100,100);
//                            editConfigurationSettingsWindow();
                            for (var j = 1; j <= time2 ; j++)
                            {
                                    controlToolbar.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "", 1).ClickButton();   
                                    delay(200);                      
                                    controlToolbar.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "", 2).ClickButton();
                                    
                            }
                            for (var m = 1; m <= time2 ; m++)
                            {
                                    controlToolbar.WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Button", "", 1).ClickButton();
                            }
                            //switch to monitor mode       
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1).Click();
                            if (lib_validate.isUnExpectedWindowExists () == true)
                            { 
                                      Log.Warning("isUnExpectedWindow = true");                              
                                      return;
                            }
                            for (var n = 1; n <= time2 ; n++)
                            {
                                    
                                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Button", "", 1).ClickButton();                    
                                    Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 2).WPFObject("Button", "", 2).ClickButton();  
                            }
                            //switch to Configuration mode
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Border", "", 1).WPFObject("IvsToolBar").WPFObject("ContentPresenter", "", lib_const.const_btt_Monitor).WPFObject("Grid", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1).Click();                   
                            Indicator.PopText();           
                      }
              }  
        }  

}

/*
  *@function  
*/
function randomValue ()
{
        
        var x =  Math.floor((Math.random() * 41) + 1);    
        return x;
}

/*
  *@function  
*/
function editConfigurationSettingsWindow()
{

  var time = 200;
  var dl_code;
  var grid;
  Aliases.DL_CODE.HwndSource_Shell11.Shell.Border.DockPanel.Grid2.Border.Grid.IvsMenu.WPFMenu.Click("Device|Settings|Configuration Settings");
  delay(time);
  if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: ConfigurationSettingsWindow", "Configuration Settings", lib_const.const_delay_1000).Exists)
  {
          var statistic = Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationSettingsWindow", "Configuration Settings").WPFObject("ConfigurationSettingsWindow", "Configuration Settings", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Statistics", 2);
          if ( statistic.IsExpanded == false)
                statistic.set_IsExpanded(true); 
          var path = Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationSettingsWindow", "Configuration Settings").WPFObject("ConfigurationSettingsWindow", "Configuration Settings", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Statistics", 2).WPFObject("StackPanel", "", 1).WPFObject("ParamControl", "", 2).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("Border", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("ParamSetControl", "", 1);
          for (var i = 1; i<= 20; i++)
          {
                var index = randomValue();
                var status = path.WPFObject("ContentPresenter", "", index).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).get_IsChecked();
                if (status == false)
                    path.WPFObject("ContentPresenter", "", index).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).ClickButton(cbChecked);
                else 
                    path.WPFObject("ContentPresenter", "", index).WPFObject("Grid", "", 1).WPFObject("CheckBox", "*", 1).ClickButton(cbUnchecked);
          }
          Sys.Process("DL.CODE").WPFObject("HwndSource: ConfigurationSettingsWindow", "Configuration Settings").WPFObject("ConfigurationSettingsWindow", "Configuration Settings", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 2).ClickButton();
          delay(time);
          Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();
          delay(time);
  }  

}
/*
  *@function  
*/ 
function editINT2OF5()
{
  Log.Message("start edit int20f5");
  var grid;
  var contentExpander;
  var stackPanel;
  var genericPropertiesViewControl;
  grid = Aliases.DL_CODE.HwndSource_Shell11.Shell.Border.DockPanel.Grid.ContentPlaceholder.UserControl.LayoutRoot;
//  grid.Border2.Grid.Border.TabControl.Grid.AbstractTaskTreeControl.TreeViewItem.TreeViewItem.TreeViewItem.Click(143, 14);
  contentExpander = grid.Border3.Grid.TabControl.Grid.Border.Grid.ScrollViewer.PropertiesPresenter.UserControl.StackPanel.ContentexpanderCodeSymbologySetup;
  stackPanel = contentExpander.StackPanel;
  genericPropertiesViewControl = stackPanel.GenericPropertiesViewControl;
  genericPropertiesViewControl.ContentPresenter3.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemInt.ComboBox.ClickItem(Math.floor((Math.random() * 3)));
  genericPropertiesViewControl.ContentPresenter3.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemInt.ComboBox.ClickItem(Math.floor((Math.random() * 3)));
  
  if (genericPropertiesViewControl.ContentPresenter5.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemBoo.CheckBox.get_IsChecked() == false)
      genericPropertiesViewControl.ContentPresenter5.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemBoo.CheckBox.ClickButton(cbChecked);
  else
      genericPropertiesViewControl.ContentPresenter5.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemBoo.CheckBox.ClickButton(cbUnchecked);
      
  if (genericPropertiesViewControl.ContentPresenter6.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemBoo.CheckBox.get_IsChecked() == false)
      genericPropertiesViewControl.ContentPresenter6.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemBoo.CheckBox.ClickButton(cbChecked);
  else
      genericPropertiesViewControl.ContentPresenter6.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemBoo.CheckBox.ClickButton(cbUnchecked);
      
  if (genericPropertiesViewControl.ContentPresenter7.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemBoo.CheckBox.get_IsChecked() == false)
      genericPropertiesViewControl.ContentPresenter7.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemBoo.CheckBox.ClickButton(cbChecked);
  else
      genericPropertiesViewControl.ContentPresenter7.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemBoo.CheckBox.ClickButton(cbUnchecked);
    
  genericPropertiesViewControl.ContentPresenter2.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemInt.ComboBox.ClickItem(Math.floor((Math.random() * 2)));
  stackPanel.GenericPropertiesViewControl2.ContentPresenter.ParamControl.Grid.ContentControl.ContentcontrolDomainobjectsParam1SystemInt.ComboBox.ClickItem(Math.floor((Math.random() * 7)));
  
  Log.Message("end edit int20f5");
}