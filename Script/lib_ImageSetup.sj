//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_messageLog




//add 2 IMG Setup
//add CR
//Change params of IM Setting
//if have "Focus Autolearn" --> add Reading Distance 
function config_IMGSetting (device, objDefault)
{
        var obj = new Object();   
        var path = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 3)["WPFObject"]("Grid", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("PropertiesPresenter")["WPFObject"]("UserControl")["WPFObject"]("StackPanel", "", 1)["WPFObject"]("ContentExpander", "Image Quality", 1); 
        if (device != lib_const.const_M120)        
              path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 4)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("CheckBox", "", 1).ClickButton(cbChecked); ;
        //config Exposure Time  
        path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 5)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ExplicitUpdateIntegerUpDown", "", 1)["WPFObject"]("Spinner")["WPFObject"]("TextBox").Keys("^a[Del]");
        path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 5)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ExplicitUpdateIntegerUpDown", "", 1)["WPFObject"]("Spinner")["WPFObject"]("TextBox").Keys(  StrToInt(objDefault.ExposureTime) + 10);
        aqObject.CheckProperty(path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 5)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ExplicitUpdateIntegerUpDown", "", 1)["WPFObject"]("Spinner")["WPFObject"]("TextBox"), "Text", cmpEqual,  StrToInt(objDefault.ExposureTime) + 10);
        //config Gain
        path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 6)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ExplicitUpdateIntegerUpDown", "", 1)["WPFObject"]("Spinner")["WPFObject"]("TextBox").Keys("^a[Del]");
        path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 6)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ExplicitUpdateIntegerUpDown", "", 1)["WPFObject"]("Spinner")["WPFObject"]("TextBox").Keys( StrToInt(objDefault.Gain) + 10);
        aqObject.CheckProperty(path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 6)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ExplicitUpdateIntegerUpDown", "", 1)["WPFObject"]("Spinner")["WPFObject"]("TextBox"), "Text", cmpEqual,  StrToInt(objDefault.Gain) + 10);
        if (device == lib_const.const_M120) 
        {   
               lib_common.cbb_NonLogicalAdornerDecorator(path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 7)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ComboBox", "", 1) , "X3");
               lib_common.cbb_NonLogicalAdornerDecorator(path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ComboBox", "", 1) , "High-Power Strobed");
        }
        if (device == lib_const.const_M210) 
        {
               lib_common.cbb_NonLogicalAdornerDecorator(path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 7)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ComboBox", "", 1) , "X10");
               lib_common.cbb_NonLogicalAdornerDecorator(path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ComboBox", "", 1) , "High-Power Strobed");
        }
        if (device == lib_const.const_M300) 
        {
               lib_common.cbb_NonLogicalAdornerDecorator(path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 7)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ComboBox", "", 1) , "X10");
               lib_common.cbb_NonLogicalAdornerDecorator(path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ComboBox", "", 1) , "High-Power Strobed");
        }
        if (device == lib_const.const_M450) 
        {
               lib_common.cbb_NonLogicalAdornerDecorator(path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 7)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ComboBox", "", 1) , "X4");
               lib_common.cbb_NonLogicalAdornerDecorator(path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ComboBox", "", 1) , "High-Power Strobed");
        }
}

function get_display_IMGPropetiesDefault (device)
{
        var obj = new Object ();        
        obj = getIMGPropeties(device);
        displayIMGPropeties(device , obj);
        return obj;
}

function displayIMGPropeties (device , obj) 
{
        if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).IsFocused == false)
                Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).Click();
        if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).IsFocused == true)
        { 
              if (device != lib_const.const_M120)     
                     Log.Message("obj.IMG_Polary_Inversion: " + obj.IMG_Polary_Inversion);
              Log.Message("obj.ExposureTime: " + obj.ExposureTime);
              Log.Message("obj.Gain: " + obj.Gain)
              Log.Message("obj.GainMultiple: " + obj.GainMultiple);         
              Log.Message("obj.Lighting:" + obj.Lighting);
              if (device == lib_const.const_M300)
              {         
                     displayM300Sector(obj);
              }
              if (device == lib_const.const_M210)
              {
                     displayM210Sector(obj);
              }
        }
}
function displayM210Sector (obj)
{              
        var text ="[0, " + lib_label.lb_M210N_InteralLighting[0] +"]" ;
        if (obj.Lighting != text) 
        {
              Log.Message(" obj.Sector_Top:" + obj.M210Sector.Sector_Top   ) ;
              Log.Message("obj.Sector_Bottom :" + obj.M210Sector.Sector_Bottom   ) ;
              Log.Message(" obj.Sector_Left:" +   obj.M210Sector.Sector_Left ) ;
              Log.Message(" obj.Sector_Right:" + obj.M210Sector.Sector_Right   ) ;
        }                   
        return obj;         
}
function displayM300Sector (obj)
{        
        var text ="[0, " + lib_label.lb_M300N_InteralLighting[0] +"]" ;
        Log.Message(" obj.LEDGroup:" + obj.LEDGroup   ) ;
        if (obj.Lighting!= text) 
        {
              if (obj.LEDGroup == "[2, Internal]") 
              {
                  Log.Message(" obj.Sector_TopLeft:" +  obj.M300Sector.Sector_TopLeft  ) ;
                  Log.Message(" obj.Sector_TopRight :" +   obj.M300Sector.Sector_TopRight  ) ;
                  Log.Message(" obj.Sector_BottomLeft:" +   obj.M300Sector.Sector_BottomLeft ) ;
                  Log.Message(" obj.Sector_BottomRight:" + obj.M300Sector.Sector_BottomRight   ) ;                     
              }
              else
              {      
                  Log.Message(" obj.Sector_Top:" + obj.M300Sector.Sector_Top   ) ;
                  Log.Message("obj.Sector_Bottom :" + obj.M300Sector.Sector_Bottom   ) ;
                  Log.Message(" obj.Sector_Left:" +   obj.M300Sector.Sector_Left ) ;
                  Log.Message(" obj.Sector_Right:" + obj.M300Sector.Sector_Right   ) ;
                  
              }
        }          
        return obj;         
}

function getIMGPropeties (device)
{
        var obj = new Object();
            
        if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).IsFocused == false)        
        {
                Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).Click();
                Delay(lib_const.const_delay_1000);
                Sys.Process("DL.CODE").Refresh();
        }
//        if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).IsFocused == true)
//        {   
                var path = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 3)["WPFObject"]("Grid", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("PropertiesPresenter")["WPFObject"]("UserControl")["WPFObject"]("StackPanel", "", 1)["WPFObject"]("ContentExpander", "Image Quality", 1); 
                if (device != lib_const.const_M120)        
                      obj.IMG_Polary_Inversion   = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 4)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("CheckBox", "", 1).IsChecked ;
                obj.ExposureTime           = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 5)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ExplicitUpdateIntegerUpDown", "", 1)["WPFObject"]("Spinner")["WPFObject"]("TextBox").Text;
                obj.Gain                   = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 6)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ExplicitUpdateIntegerUpDown", "", 1)["WPFObject"]("Spinner")["WPFObject"]("TextBox").Text;
                obj.GainMultiple           = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 1)["WPFObject"]("ContentPresenter", "", 7)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ComboBox", "", 1).wText;
                obj.Lighting               = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ComboBox", "", 1).wText;        
                if (device == lib_const.const_M300)
                {
                       obj.LEDGroup               = getM300LEDGroup(device);
                       obj.M300Sector             = getM300Sector (obj);
                }
                if (device == lib_const.const_M210)
                {
                      obj.M210Sector = getM210Sector (obj);
                }
//        }
        return obj;        
}

function getM300LEDGroup(device)
{ 
        var LEDGroup = null;
        //only M300N has LED Group
        if (device == lib_const.const_M300)
        {
                var path = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 3)["WPFObject"]("Grid", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("PropertiesPresenter")["WPFObject"]("UserControl")["WPFObject"]("StackPanel", "", 1)["WPFObject"]("ContentExpander", "Image Quality", 1);
                LEDGroup = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 2)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ComboBox", "", 1).wText;
        }
        return LEDGroup;
}

function getM300Sector (object)
{         
        var obj = new Object();
        var path = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 3)["WPFObject"]("Grid", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("PropertiesPresenter")["WPFObject"]("UserControl")["WPFObject"]("StackPanel", "", 1)["WPFObject"]("ContentExpander", "Image Quality", 1);
        var text ="[0, " + lib_label.lb_M300N_InteralLighting[0] +"]" ;
        if (object.Lighting!= text) 
        {
              if (object.LEDGroup == "[2, Internal]")  
              {
                  obj.Sector_TopLeft        = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("ParamSetControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("CheckBox", "Top-Left", 1).IsChecked ;
                  obj.Sector_TopRight       = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("ParamSetControl", "", 1)["WPFObject"]("ContentPresenter", "", 2)["WPFObject"]("Grid", "", 1)["WPFObject"]("CheckBox", "Top-Right", 1).IsChecked ;
                  obj.Sector_BottomLeft     = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("ParamSetControl", "", 1)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("Grid", "", 1)["WPFObject"]("CheckBox", "Bottom-Left", 1).IsChecked ;
                  obj.Sector_BottomRight    = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("ParamSetControl", "", 1)["WPFObject"]("ContentPresenter", "", 4)["WPFObject"]("Grid", "", 1)["WPFObject"]("CheckBox", "Bottom-Right", 1).IsChecked ;
              }
              else
              {     
                  obj.Sector_Top    = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("ParamSetControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("CheckBox", "Top", 1).IsChecked;
                  obj.Sector_Bottom = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("ParamSetControl", "", 1)["WPFObject"]("ContentPresenter", "", 2)["WPFObject"]("Grid", "", 1)["WPFObject"]("CheckBox", "Bottom", 1).IsChecked;
                  obj.Sector_Left   = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("ParamSetControl", "", 1)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("Grid", "", 1)["WPFObject"]("CheckBox", "Left", 1).IsChecked;
                  obj.Sector_Right  = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("ParamSetControl", "", 1)["WPFObject"]("ContentPresenter", "", 4)["WPFObject"]("Grid", "", 1)["WPFObject"]("CheckBox", "Right", 1).IsChecked;
              }
        }          
        return obj;         
}

function getM210Sector (object)
{        
        var obj = new Object();
        var path = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 3)["WPFObject"]("Grid", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("PropertiesPresenter")["WPFObject"]("UserControl")["WPFObject"]("StackPanel", "", 1)["WPFObject"]("ContentExpander", "Image Quality", 1);
        var text ="[0, " + lib_label.lb_M210N_InteralLighting[0] +"]" ;
        if (object.Lighting != text) 
        {
              obj.Sector_Top    = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("ParamSetControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("CheckBox", "Top", 1).IsChecked;
              obj.Sector_Bottom = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("ParamSetControl", "", 1)["WPFObject"]("ContentPresenter", "", 2)["WPFObject"]("Grid", "", 1)["WPFObject"]("CheckBox", "Bottom", 1).IsChecked;
              obj.Sector_Left   = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("ParamSetControl", "", 1)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("Grid", "", 1)["WPFObject"]("CheckBox", "Left", 1).IsChecked;
              obj.Sector_Right  = path["WPFObject"]("StackPanel", "", 1)["WPFObject"]("GenericPropertiesViewControl", "", 2)["WPFObject"]("ContentPresenter", "", 3)["WPFObject"]("ParamControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("ContentControl", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("ScrollViewer", "", 1)["WPFObject"]("ParamSetControl", "", 1)["WPFObject"]("ContentPresenter", "", 4)["WPFObject"]("Grid", "", 1)["WPFObject"]("CheckBox", "Right", 1).IsChecked;
        }                   
        return obj;         
}


//****************************************************************************************************************************
function IS_AddImageSetting(num_IMGSetitng)
{
        var flag = false;
        //get list before
        var list_Current , list_After ;
        list_Current = get_numberIMGSetting();
        //click btt to add IMG setting
        if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).IsFocused == false)
                Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).Click();
        if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).IsFocused == true)
        {        
                  for (var i = 0; i < num_IMGSetitng ; i ++)
                  {
                          var root = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("AbstractTaskTreeControl")["WPFObject"]("TreeViewItem", "", 2);
                          var btt_AddIMG = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("JobContentPresenter")["WPFObject"]("ImageParametersJobContent", "", 1)["WPFObject"]("AddIarActionButton", "", 1);
                          if (root.Visible && btt_AddIMG.Enabled)
                          {
                                  btt_AddIMG.Click();                         
                          }
                  } 
        }
        //get list after     
        list_After = get_numberIMGSetting();
        //verify
        if (list_After - list_Current == num_IMGSetitng)
                flag = true;
//        Log.Message("list_After: " + list_After);
//        Log.Message("list_Current: " + list_Current);
        Log.Message("IS_AddImageSetting: " + flag);
        return flag;
}
function get_numberIMGSetting ()
{
        var number = 1; // cause job always has 1 IMG setting
        Sys["Process"]("DL.CODE").Refresh();
        if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).IsFocused == false)
                Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).Click();
        if (Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 2)["WPFObject"]("CollapsedExpander")["WPFObject"]("Grid", "", 1)["WPFObject"]("StackPanel", "", 1)["WPFObject"]("JcmExpanderUserControl")["WPFObject"]("Grid", "", 1)["WPFObject"]("StepsPanelScrollViewer")["WPFObject"]("Grid", "", 1)["WPFObject"]("border")["WPFObject"]("Grid", "", 1)["WPFObject"]("ItemsControl", "", 1)["WPFObject"]("ContentPresenter", "", 1)["WPFObject"]("ExpanderStepSubItemButton", "", 1).IsFocused == true)
        {        
                  var root = Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("AbstractTaskTreeControl")["WPFObject"]("TreeViewItem", "", 2);
                  if (root.Visible )
                  {
                         var number = root.ChildCount  - 1 ;                        
                  }
        }        
        //verify 
//        Log.Message("get_numberIMGSetting: " + number);
        if (number == 1 )
        {
                  aqObject.CheckProperty(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("JobContentPresenter")["WPFObject"]("ImageParametersJobContent", "", 1)["WPFObject"]("AddIarActionButton", "", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("JobContentPresenter")["WPFObject"]("ImageParametersJobContent", "", 1)["WPFObject"]("DeleteIarActionButton", "", 1), "Enabled", cmpEqual, false);
        }
        if (number == 10 )
        {
                  aqObject.CheckProperty(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("JobContentPresenter")["WPFObject"]("ImageParametersJobContent", "", 1)["WPFObject"]("AddIarActionButton", "", 1), "Enabled", cmpEqual, false);
                  aqObject.CheckProperty(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("JobContentPresenter")["WPFObject"]("ImageParametersJobContent", "", 1)["WPFObject"]("DeleteIarActionButton", "", 1), "Enabled", cmpEqual, true);
        }      
        if (number > 1 && number < 10 )
        {
                  aqObject.CheckProperty(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("JobContentPresenter")["WPFObject"]("ImageParametersJobContent", "", 1)["WPFObject"]("AddIarActionButton", "", 1), "Enabled", cmpEqual, true);
                  aqObject.CheckProperty(Sys["Process"]("DL.CODE")["WPFObject"]("HwndSource: Shell", lib_deviceInfo.const_firmware)["WPFObject"]("Shell", lib_deviceInfo.const_firmware, 1)["WPFObject"]("Border", "", 1)["WPFObject"]("DockPanel", "", 1)["WPFObject"]("Grid", "", 2)["WPFObject"]("ContentPlaceholder")["WPFObject"]("UserControl")["WPFObject"]("LayoutRoot")["WPFObject"]("Border", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("Border", "", 1)["WPFObject"]("TabControl", "", 1)["WPFObject"]("Grid", "", 1)["WPFObject"]("JobContentPresenter")["WPFObject"]("ImageParametersJobContent", "", 1)["WPFObject"]("DeleteIarActionButton", "", 1), "Enabled", cmpEqual, true);
        }           
        return number ;
}