//USEUNIT lib_button
//USEUNIT lib_const
//USEUNIT lib_SaveJob
//USEUNIT lib_OpenJob
//USEUNIT lib_SaveIMG
function LoadImagesFilterAndNoFilter()// add all 4 types: bmp, jpeg, jpg,tiff
{
//         if ( ! lib_validate.isDLCODERunning())
         arrImage = lib_SaveIMG.clickSaveImageButton_FilterNotFilter(false);
         arrImageFilter = lib_SaveIMG.clickSaveImageButton_FilterNotFilter(true);
         lib_common.launchUI(); 
         var ext = [ lib_const.const_BMP  ,lib_const.const_JPEG  ,lib_const.const_GIF   ,lib_const.const_TIF    ];           
         if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress ) ==lib_err.err_FUNC_SUCCESS)
         { 
                 if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                 {                         
                          lib_button.ui_PlayAndPause( 3000, false);
                          
                         for(var i = 0;i<arrImage.length;i++)
                         {
                          visionControl =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 2).WPFObject("VisionControl");
                          screenImage = Sys.Process("DL.CODE").FindChild("WPFControlName", "visionToolRoiControl", 1000);
                          screenImage.HoverMouse();
                          screenImage.ClickR();
                          visionControl.PopupMenu.Click("Image|Clean");
                          delay(700);
                          screenImage.ClickR();
                          visionControl.PopupMenu.Click("Image|Load");
                          Sys.Process("DL.CODE").Window("#32770", "Open", 1).Window("ComboBoxEx32", "", 1).Window("ComboBox", "", 1).Window("Edit", "", 1).SetText(arrImage[i]);
                          Sys.Process("DL.CODE").Window("#32770", "Open", 1).Window("Button", "&Open", 1).ClickButton();
                          delay(5000);
                         }  
                         
                         for(var i = 0;i<arrImageFilter.length;i++)
                         {
                          visionControl =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware ).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("CentralBorder").WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ContentControl", "", 2).WPFObject("VisionControl");
                          screenImage = Sys.Process("DL.CODE").FindChild("WPFControlName", "visionToolRoiControl", 1000);
                          screenImage.HoverMouse();
                          screenImage.ClickR();
                          visionControl.PopupMenu.Click("Image|Clean");
                          delay(700);
                          screenImage.ClickR();
                          visionControl.PopupMenu.Click("Image|Load");
                          Sys.Process("DL.CODE").Window("#32770", "Open", 1).Window("ComboBoxEx32", "", 1).Window("ComboBox", "", 1).Window("Edit", "", 1).SetText(arrImageFilter[i]);
                          Sys.Process("DL.CODE").Window("#32770", "Open", 1).Window("Button", "&Open", 1).ClickButton();
                          delay(5000);
                         }   
                            
                 }    
        }  
//        lib_common.terminateUI();
        Log.PopLogFolder();
}