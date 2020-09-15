//USEUNIT BenchmarkTest
//USEUNIT lib_ChangeIP
//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_validate


/*
  *@function 
*/
function testOldFirmware_newGUI()
{

//    if ( ! lib_validate.isDLCODERunning())
        lib_common.launchUI();     
    var ip = lib_deviceInfo.const_Device_IP_Adress; 
   
    if (lib_common.connectToDevice(ip))
    {         
      if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
      {   
          var result =   codeAutolearn(false);
          Log.Message("codeAutolearn:" + result);
          
          //add Filter to last code 
          clickAdvancedSetup();
          var treeViewItemCodes = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 1);
          var childCount = treeViewItemCodes.ChildCount;
          var resultAddFilter = lib_button.clickAddFilter(childCount - 1);
          Log.Message("add Filter:" + resultAddFilter);
          ui_PlayAndPause(3000, false);
      }
    }   
    //lib_common.terminateUI();
} 



 
/*
  *@function only perform Code autolearn and replace, verify
*/
function tc_codeAutolearn_Postal()
{
//    if ( ! lib_validate.isDLCODERunning())
        lib_common.launchUI();     
    var ip = lib_deviceInfo.const_Device_IP_Adress; 
   
    if (lib_common.connectToDevice(ip))
    {         
      if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
      {
          var result =   codeAutolearn(true);
          Log.Message("codeAutolearn:" + result);
      }
    }   
    //lib_common.terminateUI();
}

/*
  *@function only perform Code autolearn and replace, verify
*/
function tc_codeAutolearn_1D_2D()
{
//    if ( ! lib_validate.isDLCODERunning())
        lib_common.launchUI();     
    var ip = lib_deviceInfo.const_Device_IP_Adress; 
   
    if (lib_common.connectToDevice(ip))
    {         
      if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
      {
          var result =   codeAutolearn(false);
          Log.Message("codeAutolearn:" + result);
      }
    }   
    //lib_common.terminateUI();
}

/*
  *@function 
*/
function performCodeAutolearn_Add_Replace_Discard()
{
     aqTestCase.Begin("performCodeAutolearn_Add_Replace_Discard");
//    if ( ! lib_validate.isDLCODERunning())
    lib_common.launchUI();     
    var ip = lib_deviceInfo.const_Device_IP_Adress; 
   
    if (lib_common.connectToDevice(ip))
    {         
      if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
      {
          if(!lib_deviceInfo.const_isPPI_device) lib_button.clickIMG_AutoSetup_Static(true);          
          if(!lib_deviceInfo.const_isPPI_device) lib_button.clickIMG_FocusAutolearn(true);
          Log.Message(lib_label.lb_CodeAutolearn_Add     + ":" +performCodeAutolearn (lib_label.lb_CodeAutolearn_Add));
          Log.Message(lib_label.lb_CodeAutolearn_Discard + ":" +performCodeAutolearn (lib_label.lb_CodeAutolearn_Discard));
          Log.Message(lib_label.lb_CodeAutolearn_Replace + ":" +performCodeAutolearn (lib_label.lb_CodeAutolearn_Replace));

      }
    }   
    //lib_common.terminateUI();
    aqTestCase.End();
}

/*
  *@function 
  *@param action{String}
*/
function performCodeAutolearn (action)
{

      var arr_Code = new Array();
      var flag = false;  
      
      lib_button.clickAdvancedSetup();
      //Edit Decoding time
      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", 1).Click();
      //1.8.0 changed interface -- linhtnguyen comment
      //Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").    .WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a[Del]"+lib_const.const_MAX_DECODINGTIME +"[Enter]");

      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a[Del]"+lib_const.const_MAX_DECODINGTIME +"[Enter]");

      //Image AutoSetup
      lib_button.clickIMG_AutoSetup_Static(true);
      // Focus on Code Setup
//      lib_button.clickAdvancedSetup();  
                              
      var treeViewItemCodes = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1);
      if (treeViewItemCodes.IsExpanded == false)
      {
          treeViewItemCodes.set_IsExpanded ( true);  
          treeViewItemCodes.Refresh ();
          
      }         
      var childCount =   treeViewItemCodes.ChildCount;
      Log.Message("Code Autolearn- " + action + "before has codes:" + childCount); 
      
      //click on Code Autolearn button       
      lib_button.clickCodeAutolearnBtt();
     //click on Continue until Finish btt enable
      processCodeAutolearn(arr_Code, action);
      
      if (treeViewItemCodes.IsExpanded == false)
      {
          treeViewItemCodes.set_IsExpanded ( true); 
          treeViewItemCodes.Refresh ();     
      }     
      var newChildCount =  treeViewItemCodes.ChildCount;
//      Log.Message(newChildCount);
        
      if (action == lib_label.lb_CodeAutolearn_Replace)
      { 
              if ((newChildCount -2) ==  arr_Code.length)
              {
                    flag = true;
              }
      }
      if (action == lib_label.lb_CodeAutolearn_Discard)
      { 
              if (newChildCount ==  childCount)
              {
                    flag = true;
              }
      }
      if (action == lib_label.lb_CodeAutolearn_Add)
      { 
              if (newChildCount  ==  (arr_Code.length + childCount))
              {
                    flag = true;
              }
      }
      if (flag == false)
      {
          Log.Message("code autolearn fail " + flag) ;
      }
      return flag;
      
      
}


/*
  *@function 
  *@param isPostal{boolean} 
*/
function codeAutolearn (isPostal)
{

      var arr_Code = new Array();
      var flag = true;     
      //Edit Decoding time
      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", 1).Click();
      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a[Del]"+lib_const.const_MAX_DECODINGTIME +"[Enter]");
      
      // Focus on Advanced Setup
      lib_button.clickAdvancedSetup();
      //perform Acquire PPI / Focus Autolearn
      if(lib_deviceInfo.const_isPPI_device == true)
              lib_button.clickAcquirePPIBtt();
      else lib_button.clickIMG_FocusAutolearn(true);
      // Focus on Code Setup
      lib_button.clickAdvancedSetup();
      //click on Code Autolearn button       
      lib_button.clickCodeAutolearnBtt();
     //click on Continue until Finish btt enable
      processCodeAutolearn(arr_Code, lib_label.lb_CodeAutolearn_Replace);
      //verify 1D&2D or Postal 
      if (isPostal == true)//code is Postal
      {
            for (j = 1; j <= arr_Code.length ; j++)
            {
                  if ( (lib_validate.is1DCode(arr_Code[j-1])== true)  ||(lib_validate.is2DCode(arr_Code[j-1])== true)       )
                  {      Log.Warning(lib_err.msg_ERR_CODE_IS_NOT_POSTAL);
                         flag = false;                         
                  }
            }
      }
      else//code is 1D and 2D and Digimarc
      {
            for (j = 1; j <= arr_Code.length ; j++)
            {
                  if ( (lib_validate.isPostal(arr_Code[j-1])== true)   )
                  {      Log.Warning(lib_err.msg_ERR_CODE_IS_NOT_1D_2D);
                         flag = false;                         
                  }
            }
      }
      
      if (flag == false)
      {
            Log.Warning(lib_err.msg_ERR_CODE);
            return flag;
      }
      
      //verify       
      var treeViewItemCodes = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1);
      if (arr_Code.length > 0)
      {
              for (j = 1; j <= arr_Code.length ; j++)
              {   
                    Log.Message(arr_Code[j-1]);
                  
                  //Postal
                  if (arr_Code[j-1] == lib_label.lb_AustraliaPost      ||   arr_Code[j-1] == lib_label.lb_RoyalMail          || 
                      arr_Code[j-1] == lib_label.lb_KIXCode            ||   arr_Code[j-1] == lib_label.lb_JapanPost          ||
                      arr_Code[j-1] == lib_label.lb_PLANET             ||   arr_Code[j-1] == lib_label.lb_POSTNET           ||  
                      arr_Code[j-1] == lib_label.lb_IntelligentMail    ||   arr_Code[j-1] == lib_label.lb_SwedishPostal             )
                  {                  
                      treeViewItemCodes.WPFObject("TreeViewItem", "", j+1).Click();
                      Sys.Process("DL.CODE").Refresh();
                      aqObject.CheckProperty(treeViewItemCodes.WPFObject("TreeViewItem", "", j+1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, arr_Code[j-1]);
                      aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpContains, arr_Code[j-1]);                        
                      
                  }else//1D and 2D
                  {   
                       treeViewItemCodes.WPFObject("TreeViewItem", "", j+1).Click();
                       delay (lib_const.const_delay_2000);
                       Sys.Process("DL.CODE").Refresh();                       
                       if (isDigimarc(arr_Code[j-1]))
                            aqObject.CheckProperty( treeViewItemCodes.WPFObject("TreeViewItem", "", j+1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, arr_Code[j-1]);
                           
                       else
                            aqObject.CheckProperty(treeViewItemCodes.WPFObject("TreeViewItem", "", j+1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, arr_Code[j-1]);
                        
                  }
                  //verify code type
                   Delay(1000); 
                   if (isDigimarc(arr_Code[j-1]))
                   {
                            var cbb = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Symbology Setup", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 1).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1);
                            lib_validate.verifyCodeType (cbb, arr_Code[j-1]);
                   }else
                   {                           
                             var cbb = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Code Symbology Setup", 1).WPFObject("StackPanel", "", 1).WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ComboBox", "", 1);
                             lib_validate.verifyCodeType (cbb, arr_Code[j-1]);
                   }
                   //end verify code type
                   aqObject.CheckProperty(Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TextBlock", "*", 1), "WPFControlText", cmpContains, arr_Code[j-1]);
                       
              } 
      }
      //get Data
      var str = getData(arr_Code);  
      
      if (str != "" || str != null)
          str = "<STX>"+ str+"\n";//cause messages has "\n"
      else 
      { 
          flag = false;
          return flag;
      }    
      //focus on Console Tab
      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("BottomTabItem4").Click();
      for (var o = 1; o <= lib_const.time_CodeAutolearn ; o++)
      {
              //click on Play butt
              //Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("controlToolBar").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "", 1).ClickButton();
              lib_button.clickPlay(false);
              delay(lib_const.const_delay_2000);
              //Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("controlToolBar").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "", 2).ClickButton();
              lib_button.clickPause(false);
              Sys.Process("DL.CODE").Refresh();
              //verify transmitted message
                               
              var consoleTab = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("Terminal", "", 1).WPFObject("MainScrollViewer").WPFObject("ItemsControl", "", 1);
              var numMsg = consoleTab.ChildCount; 
              var txt = consoleTab.WPFObject("ContentPresenter", "", numMsg - 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 2).WPFControlText;
              if (str != txt)
              {
                    flag = false; 
                    Log.Warning("##### Time" + o+ ":" + flag );
                    Log.Message("result :"+str);
                    Log.Message("console:"+txt);
                    
              } 
      } 
      return flag;
}

/*
  *@function 
  *@param arrayCode{Array}
*/
function getData( arrayCode)
{  
      var data = "";
       //click on Play butt
      lib_button.clickPlay(false);
      delay(lib_const.const_delay_2000);
      lib_button.clickPause(false);
      Sys.Process("DL.CODE").Refresh();
      lib_button.clickOpenResultTab();
      delay (lib_const.const_delay_2000);
      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1).WPFObject("StackPanel", "", 1).WPFObject("TextBlock", "Image Settings ", 1).Click();
      delay (lib_const.const_delay_2000);
      if (Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("StatisticResult", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Expander", "Code Settings", 2).WPFObject("Border", "", 1).WaitWPFObject("DataGrid", "", lib_const.const_delay_3000).Exists)
      {
          delay (3000);
          var dataGrid = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("StatisticResult", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Expander", "Code Settings", 2).WPFObject("Border", "", 1).WPFObject("DataGrid", "", 1);
          if (arrayCode.length ==dataGrid.wRowCount )
          {
                  for (var i = 1; i<=arrayCode.length ; i++ )
                  { 
                      for (var k = 1; k <= dataGrid.wRowCount; k ++)
                      {
                         var row = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("BottomBorder").WPFObject("BottomTabControl").WPFObject("StatisticResult", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Expander", "Code Settings", 2).WPFObject("Border", "", 1).WPFObject("DataGrid", "", 1).WPFObject("DataGridRow", "", k);
                         var code = row.WPFObject("DataGridCell", "*", 2).WPFObject("TextBlock", "*", 1).WPFControlText; 
                         var numChar = row.WPFObject("DataGridCell", "*", 4).WPFObject("TextBlock", "*", 1).WPFControlText;
                         if (arrayCode[i-1] == code || (arrayCode[i-1] == "DMECC200" && code == "DATAMATRIX GS1")  || (arrayCode[i-1] == "QR" && code == "QR GS1"))
                         {
                               for (var l = 1; l <= numChar ; l ++)
                               {
                                      data = data + row.WPFObject("DataGridCell", "*", 3).WPFObject("ContentPresenter", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ContentPresenter", "", l).WPFObject("TextBlock", "*", 1).WPFControlText;
                               }
                         }
                         
                      }
                  } 
          } else Log.Warning(lib_err.msg_ERR_CODE_AUTOLEARN);
      }
      Log.Message(data);   
      return data;
      
}



/*
  *@function 
  *@param arr_Code{Array}
  *@param action{String}
*/
function processCodeAutolearn (arr_Code ,action)
{

//arr_Code : array code is found after perform code autolearn
//action : Add/Replace/Discard
      delay(5000);
      
      if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: CodeAutolearnDialogWindow", "Code Autolearn",lib_const.const_delay_1000).Exists )
      { 
              var bttCont   = Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDialogWindow", "Code Autolearn").WPFObject("CodeAutolearnDialogWindow", "Code Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "Continue", 2);
              var bttStop   = Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDialogWindow", "Code Autolearn").WPFObject("CodeAutolearnDialogWindow", "Code Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "Stop", 1);
              var bttFinish = Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDialogWindow", "Code Autolearn").WPFObject("CodeAutolearnDialogWindow", "Code Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "Finish", 3);
              while (  (bttCont.IsEnabled == true && bttStop.IsEnabled == false) ||
                       (bttCont.IsEnabled == false && bttStop.IsEnabled == true)) 
              { 
                  if (bttCont.IsEnabled == true)
                        bttCont.ClickButton();
                  while (bttStop.IsEnabled==true)
                  {
                        Delay(lib_const.const_delay_3000);
                        Sys.Process("DL.CODE").Refresh();
                        if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: PopupMessage", "Warning",lib_const.const_delay_1000).Exists )
                        {
                             var txt = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupMessage", "Warning").WPFObject("PopupMessage", "Warning", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                             if (txt == "Autolearn didn't find any result. Please be sure selected image includes at least one code.")
                             {
                                    Sys.Process("DL.CODE").WPFObject("HwndSource: PopupMessage", "Warning").WPFObject("PopupMessage", "Warning", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 1).ClickButton();
                                    Log.Warning(txt);
                                    return;
                             }
                        }
                  }
                  Sys.Process("DL.CODE").Refresh();
              }
              if (bttCont.IsEnabled == false &&   bttStop.IsEnabled==false)
              { 
                  var codeList = Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDialogWindow", "Code Autolearn").WPFObject("CodeAutolearnDialogWindow", "Code Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("codes");
                  for (var i = 1; i <= codeList.ChildCount ; i++)
                  { 
                      
                       var strDelete = "Code "+i+" :  "  ;                
                       var code = Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDialogWindow", "Code Autolearn").WPFObject("CodeAutolearnDialogWindow", "Code Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("codes").WPFObject("ContentPresenter", "", i).WPFObject("TextBlock", "", 1).WPFControlText;
                       arr_Code.push (lib_common.subString(code,strDelete ));
                          
                  }
                  bttFinish.ClickButton();
              }
               //select Replace
              
              if (action == lib_label.lb_CodeAutolearn_Add)
              {
                    Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDialogWindow", "Code Autolearn").WPFObject("CodeAutolearnDialogWindow", "Code Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("Grid", "", 1).WPFObject("RadioButton", "Add to Current Configuration", 1).ClickButton();
              }
              if (action == lib_label.lb_CodeAutolearn_Replace)
              {
                    Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDialogWindow", "Code Autolearn").WPFObject("CodeAutolearnDialogWindow", "Code Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("Grid", "", 1).WPFObject("RadioButton", "Replace Current Configuration", 2).ClickButton();
              }
              if (action == lib_label.lb_CodeAutolearn_Discard)
              {
                   Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDialogWindow", "Code Autolearn").WPFObject("CodeAutolearnDialogWindow", "Code Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("Grid", "", 1).WPFObject("RadioButton", "Discard Autolearn Result", 3).ClickButton();
              }
              
              Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDialogWindow", "Code Autolearn").WPFObject("CodeAutolearnDialogWindow", "Code Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("Button", "OK", 1).ClickButton();
              return arr_Code;
            
      }
      else
      {
        Sys.Process("DL.CODE").WPFObject("HwndSource: PopupMessage", "Warning").WPFObject("PopupMessage", "Warning", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 1).ClickButton();
        Log.Warning("Autolearn didn't find any result. Please be sure selected image includes at least one code.");
        return;
      }
}
function processCodeAutolearn2(arr_Code ,action)
{
  
}
//remove 1.5.0
//function DPM (action)
//{
//      var flag = false;    
//      var isFilter = false; 
//      //Edit Decoding time
//      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", 1).Click();
//      Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("GenericPropertiesViewControl", "", 1).WPFObject("ContentPresenter", "", 2).WPFObject("ParamControl", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ContentControl", "", 1).WPFObject("ExplicitUpdateIntegerUpDown", "", 1).WPFObject("Spinner").WPFObject("TextBox").Keys("^a[Del]"+lib_const.const_MAX_DECODINGTIME +"[Enter]");
//      //Image AutoSetup
//      lib_button.clickIMG_AutoSetup_Static(true);
//      // Focus on Code Setup
//      lib_button.clickAdvancedSetup();      
//      //click on DPM button             
//      lib_button.clickDPMBtt();
//      flag = processDPM(action);      
//      return flag;
//       
//}
 

//function processDPM (action )
//{  
//      //action : Add/Replace/Discard
//      var flag = false;    
//               
//      while (!Sys.Process("DL.CODE").WaitWPFObject("HwndSource: CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn",lib_const.const_delay_1000).Exists )
//      { 
//            delay (lib_const.const_delay_5000);
//      }
//      if (Sys.Process("DL.CODE").WaitWPFObject("HwndSource: CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn",lib_const.const_delay_1000).Exists )
//      { 
//             
//              var bttCancel = Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn").WPFObject("CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 4).WPFObject("Button", "Cancel", 3);
//              var bttOK     = Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn").WPFObject("CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Button", "OK", 1);
//                              
//              while (  bttCancel.Visible == true  && bttCancel.Enabled == true) 
//              { 
//                  Delay(lib_const.const_delay_5000);
//                    
//                  
//                  if (lib_validate.isUnExpectedWindowExists()== true)
//                  {
//                            var txt = Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("MessageText").WPFControlText;
//                            if ( txt == lib_label.const_DPM_CANNOTFOUND)
//                            {                
//                                  Log.Warning(lib_label.const_DPM_CANNOTFOUND);    
//                                  Sys.Process("DL.CODE").WPFObject("HwndSource: Window").WPFObject("Window").WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("ButtonPanel").WPFObject("btnOK").ClickButton();                  
//                                  return lib_label.const_DPM_CANNOTFOUND;
//                            }
//                  } else 
//                            Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn").Refresh(); 
//              }
//              
//              if (bttOK.Enabled == true   )
//              { 
//                    if (action == lib_label.lb_CodeAutolearn_Add)
//                    {
//                          Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn").WPFObject("CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 3).WPFObject("Grid", "", 1).WPFObject("RadioButton", "Add to Current Configuration", 1).ClickButton();
//                    }
//                    if (action == lib_label.lb_CodeAutolearn_Replace)
//                    {
//                          Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn").WPFObject("CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 3).WPFObject("Grid", "", 1).WPFObject("RadioButton", "Replace Current Configuration", 2).ClickButton();
//                    }
//                    if (action == lib_label.lb_CodeAutolearn_Discard)
//                    {
//                         Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn").WPFObject("CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 3).WPFObject("Grid", "", 1).WPFObject("RadioButton", "Discard Autolearn Result", 3).ClickButton();
//                    }
//                    //Does exist Filter?
//                    var txt = Sys.Process("DL.CODE").WPFObject("HwndSource: CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn").WPFObject("CodeAutolearnDpmDialogWindow", "Datamatrix DPM Autolearn", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 3).WPFObject("TextBlock", "*", 3).WPFControlText;
//                    txt = lib_common.subString(txt,"Number of Filters: " );
//                    if (txt == 1)
//                    {
//                          Log.Warning("Filter is existed");      
//                    }
//                    //select OK btt
//                    bttOK.ClickButton();
//                    flag = true;
//              }  
//      }
//      return flag;
//}
//
//function performDPM ()
//{
//      if ( ! lib_validate.isDLCODERunning())
//        lib_common.launchUI();     
//      var ip = lib_deviceInfo.const_Device_IP_Adress; 
//   
//      if (lib_common.connectToDevice(ip))
//      {         
//        if (lib_OpenJob.openOnDevice( "Default",lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
//        {
//            Log.Message(lib_label.lb_CodeAutolearn_Add     + ":" +DPM (lib_label.lb_CodeAutolearn_Add));
//            Log.Message(lib_label.lb_CodeAutolearn_Discard + ":" +DPM (lib_label.lb_CodeAutolearn_Discard));
//            Log.Message(lib_label.lb_CodeAutolearn_Replace + ":" +DPM (lib_label.lb_CodeAutolearn_Replace));
//        }
//      }   
//      lib_common.terminateUI();
//      
//      
//}