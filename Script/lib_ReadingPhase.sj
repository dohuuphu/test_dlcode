﻿//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_OpenJob
//USEUNIT lib_button 


/*
 *@function
 *@param strPlace{String}
 *@param nameChannel{String}
*/
function RP_DeleteChannel(strPlace , nameChannel )
{
    try
    {
    
          var rootPath = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot");
          
          var path;
          var subPath ;
          var flag = false;
          var count = getNumChannel(strPlace , nameChannel);
          if (strPlace == lib_const.const_ReadingPhase_Channel)
          {
                  path = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_ReadingPhase_Channel, "", 1);
                  subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab3Border").WPFObject("ScrollViewer", "", 1).WPFObject("OperatingModeCanvas");
          }
          if (strPlace == lib_const.const_DataFormatting_Channel)
          {
                  path = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_DataFormatting_Channel, "", 1);
                  subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("ResultCollectionCanvas");
          }
          if (strPlace == lib_const.const_OutputSetup_Channel)
          {
                  path = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_OutputSetup_Channel, "", 1);
                  subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab6Border").WPFObject("ScrollViewer", "", 1).WPFObject("OutputSetupCanvas"); 
          }   
          
          var channel = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Channel_Index);        
          if (channel.IsExpanded == false )
          {
              channel.set_IsExpanded (true);
              Sys.Process("DL.CODE").Refresh();
          }
          var totalItems =   channel.ChildCount - 1;
          for (var i = 1 ; i<= totalItems; i++ )// delete the first channel
          { 
                var txt  = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Channel_Index).WPFObject("TreeViewItem", "", i).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                var txt1 = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Channel_Index).WPFObject("TreeViewItem", "", i).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 3).WPFControlText;
                      
                if (txt == nameChannel)
                {
                        rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Channel_Index).WPFObject("TreeViewItem", "", i).Click();
                        lib_button.clickDeleteItem(strPlace); 
                        Sys.Process("DL.CODE").Refresh();
                        var newChildCount =   channel.ChildCount - 1;
                        if (totalItems - newChildCount == 1)
                        {       
                                      flag =true;
                                      return flag;
                                
                        } 
                }
          } 
          return flag;                       
                
           
    }
    catch (e)
    {
        Log.Message(lib_err.err_FUNC_EXCEPTION);
    }            
}


//updated 1.5.0
/*
 *@function 
*/
function add_delete_Max_All_Channel()
{
  aqTestCase.Begin("add_delete_Max_All_Channel");
  //open UI
//  if ( ! lib_validate.isDLCODERunning())
   lib_common.launchUI();    
   // Reading Phase - DataFormatting - Output Setup      
   var arr_place = [  lib_const.const_ReadingPhase_Channel  , lib_const.const_DataFormatting_Channel , lib_const.const_OutputSetup_Channel ] ;
   var arr_channel ;
   // list channel depend on place
   var arr_RP_OS_Channel = [lib_label.const_lb_MatrixTCPServer, lib_label.const_lb_MatrixTCPClient,lib_label.const_lb_MatrixUDPClient ];
   var arr_DF_Channel    = [lib_label.const_lb_MatrixTCPServer, lib_label.const_lb_MatrixTCPClient,lib_label.const_lb_MatrixUDPClient ,lib_label.const_lb_MatrixFTPClient,lib_label.const_lbID_Net];
   
   for (var i = 1; i <= arr_place.length ; i++ )// fetch the place
//   for (var i = 1; i <= 1 ; i++ )// fetch the place
   {
           if (arr_place[i-1] == lib_const.const_DataFormatting_Channel )
                    arr_channel = arr_DF_Channel;
           else   
                    arr_channel = arr_RP_OS_Channel;
                    
           if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
           {         
                  if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                  {          
                          for (var j = 1; j <= arr_channel.length ; j++ )//fecth the channel
                          {
                                  for (var l = 1; l <= lib_const.const_Channel +1 ; l++ )// max channel can add 5
                                  {
                                        Log.Message(RP_AddChannel( arr_place[i-1], arr_channel[j-1]));
                                        
                                  } 
                                  lib_button.clickPlay(false);
                                  delay (lib_const.const_delay_2000);
                                  lib_button.clickPause(false);
                                  for (var l = 1; l <= lib_const.const_Channel +1 ; l++ )// max channel can add 5
                                  {
                                        Log.Message(RP_DeleteChannel( arr_place[i-1], arr_channel[j-1]));
                                  } 
                                  lib_button.clickPlay(false);
                                  delay (lib_const.const_delay_2000);
                                  lib_button.clickPause(false); 
                                     
                          }
                  }
           }
   }
       
    //terminateUI(); 
    aqTestCase.End();
}

//updated 1.5.0
/*
 *@function 
*/
function add_Max_All_Channel_Together()
{
  //open UI
  if ( ! lib_validate.isDLCODERunning())
        lib_common.launchUI();    
   // Reading Phase - DataFormatting - Output Setup      
   var arr_place = [  lib_const.const_ReadingPhase_Channel  , lib_const.const_DataFormatting_Channel , lib_const.const_OutputSetup_Channel ] ;
   var arr_channel ;
   // list channel depend on place
   var arr_RP_OS_Channel = [lib_label.const_lb_MatrixTCPServer, lib_label.const_lb_MatrixTCPClient,lib_label.const_lb_MatrixUDPClient ];
   var arr_DF_Channel    = [lib_label.const_lb_MatrixTCPServer, lib_label.const_lb_MatrixTCPClient,lib_label.const_lb_MatrixUDPClient ,lib_label.const_lb_MatrixFTPClient,lib_label.const_lbID_Net];
   
   for (var i = 1; i <= arr_place.length ; i++ )// fetch the place
   {
           if (arr_place[i-1] == lib_const.const_DataFormatting_Channel )
                    arr_channel = arr_DF_Channel;
           else   
                    arr_channel = arr_RP_OS_Channel;
                    
           if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
           {         
                  if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                  {          
                          for (var j = 1; j <= arr_channel.length ; j++ )//fecth the channel
                          {
                                  for (var l = 1; l <= lib_const.const_Channel +1 ; l++ )// max channel can add 5
                                  {
                                        Log.Message(RP_AddChannel( arr_place[i-1], arr_channel[j-1]));
                                  }  
                                  lib_button.clickPlay(false);
                                  delay (lib_const.const_delay_2000);
                                  lib_button.clickPause(false);
                          }
                  }
           }
   }
       
    //terminateUI(); 
}

/*
 *@function
 *@param strPlace{String}
 *@param nameChannel{String}
*/
function getNumChannel( strPlace, nameChannel)
{

    try
    {
          var count = 0;              
          if (strPlace == lib_const.const_ReadingPhase_Channel)
                  lib_button.clickReadingPhase();
          if (strPlace == lib_const.const_DataFormatting_Channel)
                  lib_button.clickDataFortmating();
          if (strPlace == lib_const.const_OutputSetup_Channel)
                  lib_button.clickOutputSetup(); 
          Sys.Process("DL.CODE").Refresh();   
          var rootPath = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot");
          var channel = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Channel_Index);        
          if (channel.IsExpanded == false )
              channel.set_IsExpanded (true);
          var totalItems =   channel.ChildCount - 1;
          for (var i = 1 ; i<= totalItems; i++ )
          { 
                var txt = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Channel_Index).WPFObject("TreeViewItem", "", i).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                if (txt == nameChannel)
                    count ++; 
          }  
          return count;
           
    }
    catch (e)
    {
        Log.Message(lib_err.err_FUNC_EXCEPTION);
    }    

}


 



function  testFuncGetNumChannel ()
{
      Log.Message(getNumChannel(lib_const.const_ReadingPhase_Channel, "Reader TCP Server"));
      Log.Message(getNumChannel(lib_const.const_DataFormatting_Channel, "Reader TCP Client"));
      Log.Message(getNumChannel(lib_const.const_OutputSetup_Channel, "Reader UDP Channel"));
}




function  testFuncGetFieldbus ()
{
      
       var arr_RP_OS_Channel = ["Ethernet/IP", "Modbus Client", "SLMP", "Profinet IO", "HMS Fieldbus"  ];
       
      Log.Message(getNumFieldbus(lib_const.const_ReadingPhase_Channel, "Ethernet/IP"));
//      Log.Message(getNumFieldbus(lib_const.const_ReadingPhase_Channel, "Ethernet/IP"));
//      Log.Message(getNumFieldbus(lib_const.const_ReadingPhase_Channel, "Ethernet/IP"));
}

/*
 *@function
 *@param strPlace{String}
 *@param nameFieldbus{String}
 *@return {Interger} number of nameFieldbus in RD/DF/OS
*/
function getNumFieldbus( strPlace, nameFieldbus)
{

    try
    {
          var count = 0;              
          if (strPlace == lib_const.const_ReadingPhase_Channel)
                  lib_button.clickReadingPhase();
          if (strPlace == lib_const.const_DataFormatting_Channel)
                  lib_button.clickDataFortmating();
          if (strPlace == lib_const.const_OutputSetup_Channel)
                  lib_button.clickOutputSetup(); 
          Sys.Process("DL.CODE").Refresh();      
          var rootPath =  Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot");
          var fieldbus = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Fieldbus_Index); 
          if (fieldbus.IsExpanded == false )
              fieldbus.set_IsExpanded (true);
          var totalItems =   fieldbus.ChildCount  ;
          for (var i = 1 ; i<= totalItems; i++ )
          { 
                var txt = fieldbus.WPFObject("TreeViewItem", "", i).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;        
                if (txt == nameFieldbus)
                    count ++; 
          }  
          return count;
           
    }
    catch (e)
    {
        Log.Message(lib_err.err_FUNC_EXCEPTION);
    }    

}

/*
 *@function
 *@param strPlace{String}
 *@param nameChannel{String}
 *device has aldready connected and in configuration mode
*/
function RP_AddChannel(strPlace , nameChannel)
{
//    try
//    {
    
          var rootPath = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot");
          var path;
          var subPath ;
          var flag = false;
          var count = getNumChannel(strPlace , nameChannel);
          if (strPlace == lib_const.const_ReadingPhase_Channel)
          {
                  path = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_ReadingPhase_Channel, "", 1);
                  subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab3Border").WPFObject("ScrollViewer", "", 1).WPFObject("OperatingModeCanvas");
          }
          if (strPlace == lib_const.const_DataFormatting_Channel)
          {
                  path = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_DataFormatting_Channel, "", 1);
                  subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("ResultCollectionCanvas");
          }
          if (strPlace == lib_const.const_OutputSetup_Channel)
          {
                  path = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_OutputSetup_Channel, "", 1);
                  subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab6Border").WPFObject("ScrollViewer", "", 1).WPFObject("OutputSetupCanvas"); 
          } 
          var addChannelActionButton = path.WPFObject("AddChannelActionButton", "", 1);
              
          addChannelActionButton.Click();
          addChannelActionButton.PopUpMenu.Click(nameChannel); 
                            
          if (Sys["Process"]("DL.CODE")["WaitWPFObject"]("HwndSource: PopupMessage", "Warning",lib_const.const_delay_1000).Exists)
          {
              aqObject.CheckProperty(Sys["Process"]("DL.CODE").WPFObject("HwndSource: PopupMessage", "Warning").WPFObject("PopupMessage", "Warning", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "Cannot add or number is greater than the maximum allowable", 1), "Enabled", cmpEqual, true);
              Sys["Process"]("DL.CODE").WPFObject("HwndSource: PopupMessage", "Warning").WPFObject("PopupMessage", "Warning", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 1).ClickButton();
              flag = true;
              return flag;
          }
          else
          {  
                var channel = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Channel_Index);        
                if (channel.IsExpanded == false )
                    channel.set_IsExpanded (true);
                var totalItems =   channel.ChildCount - 1;
                for (var i = 1 ; i<= totalItems; i++ )
                { 
                      var txt  = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Channel_Index).WPFObject("TreeViewItem", "", i).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                      var txt1 = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Channel_Index).WPFObject("TreeViewItem", "", i).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 3).WPFControlText;
                      
                      if (txt == nameChannel && txt1 == count +1)
                      {
                              aqObject.CheckProperty(rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Channel_Index).WPFObject("TreeViewItem", "",  i).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", nameChannel , 1), "Enabled", cmpEqual, true); 
                              aqObject.CheckProperty(rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Channel_Index).WPFObject("TreeViewItem", "",  i).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", i, 3), "Enabled", cmpEqual, true);                
                               //verify graphic
                              var childCount = subPath.childCount - 4;
                              for (var j = 1; j <= childCount ; j ++ )
                              {
//                                    var t  = subPath.WPFObject("DesignerItem", "", j).WPFObject("PART_ContentPresenter").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "", 1).WPFObject("Run", "*", 1).WPFControlText;
//                                    var t2 = subPath.WPFObject("DesignerItem", "", j).WPFObject("PART_ContentPresenter").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "", 1).WPFObject("Run", "*", 3).WPFControlText;
//                                    if (t == nameChannel  && t2 == count + 1)
//                                    {
                                              var str = txt + " "+j; 
                                              aqObject.CheckProperty(subPath.WPFObject("DesignerItem", "", j).WPFObject("PART_ContentPresenter").WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "", 2), "WPFControlText",  cmpEqual, str);
                                              aqObject.CheckProperty(subPath.WPFObject("DesignerItem", "", j), "Enabled", cmpEqual, true);
                                              flag = true;
                                              return flag;
//                                    }
                              }
                      }
                } 
                return flag;                       
          }                            
                      
           
//    }
//    catch (e)
//    {
//        Log.Message(lib_err.err_FUNC_EXCEPTION);
//    }            
}



//updated 1.5.0
/*
 *@function 
*/
function ssss()
{
  
   lib_common.launchUI();    
   // Reading Phase - DataFormatting - Output Setup      
   var arr_place = [  lib_const.const_ReadingPhase_Channel  , lib_const.const_DataFormatting_Channel , lib_const.const_OutputSetup_Channel ] ;
  
   // list channel depend on place
   var arr_fb;
   
   if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress))
   {              
          if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
          {
                  for (var i = 1; i <= arr_place.length ; i++ )// fetch the place
                  { 
                             
                        arr_fb = getFieldbusList (lib_const.const_ReadingPhase_Channel);
                        for (var j = 1; j <= arr_fb.length ; j++ )//fecth the channel
                        {
                              Log.Message(RP_AddFieldbus( arr_place[i-1], arr_fb[j-1]));
                              Log.Message(RP_AddFieldbus( arr_place[i-1], arr_fb[j-1]));  
                              lib_button.ui_PlayAndPause(2000, false);
                              Log.Message(RP_DeleteFieldbus( arr_place[i-1], arr_fb[j-1]));
                        }  
                                     
                          
                  }
           }
   }
       
    //terminateUI(); 
}
 
function getFieldbusList (strPlace)
{ 
              var rootPath = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot");
              var path;
              var subPath ;
              var flag = false; 
              //click RD/DF/OS button
              if (strPlace == lib_const.const_ReadingPhase_Channel)
                      lib_button.clickReadingPhase();
              if (strPlace == lib_const.const_DataFormatting_Channel)
                      lib_button.clickDataFortmating();
              if (strPlace == lib_const.const_OutputSetup_Channel)
                      lib_button.clickOutputSetup(); 
              //get path to get index of FB btt        
              if (strPlace == lib_const.const_ReadingPhase_Channel)
              {
                      path = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_ReadingPhase_Channel, "", 1);
                      subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab3Border").WPFObject("ScrollViewer", "", 1).WPFObject("OperatingModeCanvas");
              }
              if (strPlace == lib_const.const_DataFormatting_Channel)
              {
                      path = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_DataFormatting_Channel, "", 1);
                      subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("ResultCollectionCanvas");
              }
              if (strPlace == lib_const.const_OutputSetup_Channel)
              {
                      path = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_OutputSetup_Channel, "", 1);
                      subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab6Border").WPFObject("ScrollViewer", "", 1).WPFObject("OutputSetupCanvas"); 
              } 

              var addFieldbusActionButton = path.WPFObject("AddFieldbusActionButton", "", 1);              
              addFieldbusActionButton.Click();
              //get FB list
              var itemCount = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1).Items.Count;
              var arr  = [];              
              for (i = 0; i <= itemCount -1; i++)
              {
                    arr.push (Sys.Process("DL.CODE").WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("Decorator", "", 1).WPFObject("NonLogicalAdornerDecorator", "", 1).WPFObject("ContextMenu", "", 1).WPFObject("MenuItem", "*", i+1).WPFControlText);
              }              
              for (i = 0; i <= arr.length -1 ; i++)
              {
                    Log.Message(arr[i]);
              }
              return arr;
//              addFieldbusActionButton.PopUpMenu.Click(nameFieldbus);  

}

function testAddFB()
{

Log.Message( RP_AddFieldbus (lib_const.const_ReadingPhase_Channel , "HMS Fieldbus"));
Log.Message( RP_AddFieldbus (lib_const.const_ReadingPhase_Channel , "Ethernet/IP"));
Log.Message( RP_DeleteFieldbus (lib_const.const_ReadingPhase_Channel , "HMS Fieldbus"));
}

function testAddChannel()
{

Log.Message( RP_AddChannel (lib_const.const_ReadingPhase_Channel , lib_label.const_lb_MatrixTCPServer));
Log.Message( RP_AddChannel (lib_const.const_ReadingPhase_Channel , lib_label.const_lb_MatrixTCPServer));
Log.Message( RP_DeleteChannel (lib_const.const_ReadingPhase_Channel , lib_label.const_lb_MatrixTCPServer));
}

function testgetFieldbusList()
{
getFieldbusList (lib_const.const_ReadingPhase_Channel)
}

/*
 *@function
 *@param strPlace{String}
 *@param nameFieldbus{String}
*/

function RP_AddFieldbus(strPlace , nameFieldbus)
{
    try
    {
    
          var rootPath = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot");
          var path;
          var subPath ;
          var flag = false;
          var count = getNumFieldbus(strPlace , nameFieldbus);
          
         
          if (strPlace == lib_const.const_ReadingPhase_Channel)
          {
                  path    = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_ReadingPhase_Channel, "", 1);
                  subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab3Border").WPFObject("ScrollViewer", "", 1).WPFObject("OperatingModeCanvas");
          }
          if (strPlace == lib_const.const_DataFormatting_Channel)
          {
                  path    = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_DataFormatting_Channel, "", 1);
                  subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("ResultCollectionCanvas");
          }
          if (strPlace == lib_const.const_OutputSetup_Channel)
          {
                  path = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_OutputSetup_Channel, "", 1);
                  subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab6Border").WPFObject("ScrollViewer", "", 1).WPFObject("OutputSetupCanvas"); 
          } 

          var addFieldbusActionButton = path.WPFObject("AddFieldbusActionButton", "", 1);
              
          addFieldbusActionButton.Click();
          addFieldbusActionButton.PopUpMenu.Click(nameFieldbus);           
          //warning for HMS FB
          if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: Window", lib_const.const_delay_1000).Exists)
          { 
                    var msg =   Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText").WPFControlText;
                    if (msg == lib_label.lb_Waring_HMS_BF)   
                    {
                            Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnYes").ClickButton();
                            flag = true;
                            return flag;
                    }
                    else Log.Warning(msg);         
          }
                            
          if (Sys["Process"]("DL.CODE")["WaitWPFObject"]("HwndSource: PopupMessage", "Warning",lib_const.const_delay_1000).Exists)
          {
              //case 1
              var msg =  Sys["Process"]("DL.CODE").WPFObject("HwndSource: PopupMessage", "Warning").WPFObject("PopupMessage", "Warning", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
              if (msg == lib_label.lb_Waring_Add_FB_Channel) 
              {
                      Sys["Process"]("DL.CODE").WPFObject("HwndSource: PopupMessage", "Warning").WPFObject("PopupMessage", "Warning", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 1).ClickButton();
                      flag = true;
                      return flag;
              }
              else Log.Warning(msg);
              

          }    
           
    }
    catch (e)
    {
        Log.Message(lib_err.err_FUNC_EXCEPTION);
    }            
}


/*
 *@function
 *@param strPlace{String}
 *@param nameFieldbus{String}
*/
function RP_DeleteFieldbus(strPlace , nameFieldbus )
{
    try
    {
    
         var rootPath = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot");
          var path;
          var subPath ;
          var flag = false;
          var count = getNumFieldbus(strPlace , nameFieldbus); 
          if (strPlace == lib_const.const_ReadingPhase_Channel)
          {
                  path    = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_ReadingPhase_Channel, "", 1);
                  subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab3Border").WPFObject("ScrollViewer", "", 1).WPFObject("OperatingModeCanvas");
          }
          if (strPlace == lib_const.const_DataFormatting_Channel)
          {
                  path    = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_DataFormatting_Channel, "", 1);
                  subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("ScrollViewer", "", 1).WPFObject("Grid", "", 1).WPFObject("ResultCollectionCanvas");
          }
          if (strPlace == lib_const.const_OutputSetup_Channel)
          {
                  path = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("JobContentPresenter").WPFObject(lib_const.const_OutputSetup_Channel, "", 1);
                  subPath = rootPath.WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Tab6Border").WPFObject("ScrollViewer", "", 1).WPFObject("OutputSetupCanvas"); 
          } 
          
          var fieldbus = rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Fieldbus_Index);
          if (fieldbus.IsExpanded == false )
          {
              fieldbus.set_IsExpanded (true);
              Sys.Process("DL.CODE").Refresh();
          }
          var totalItems =   fieldbus.ChildCount ;
          for (var i = 1 ; i<= totalItems; i++ )// delete the first channel
          { 
                var txt  = fieldbus.WPFObject("TreeViewItem", "", i).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                var txt1 = fieldbus.WPFObject("TreeViewItem", "", i).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 3).WPFControlText;
                      
                if (txt == nameFieldbus)
                {
                        rootPath.WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", lib_const.const_RD_DT_OS_Fieldbus_Index).WPFObject("TreeViewItem", "", i).Click();
                        lib_button.clickDeleteItem(strPlace); 
                        Sys.Process("DL.CODE").Refresh();
                        var newChildCount =   totalItems - 1;
                        if (totalItems - newChildCount == 1)
                        {       
                                      flag =true;
                                      return flag; 
                        } 
                }
          } 
          return flag;         
    }
    catch (e)
    {
        Log.Message(lib_err.err_FUNC_EXCEPTION);
    }            
}
 
