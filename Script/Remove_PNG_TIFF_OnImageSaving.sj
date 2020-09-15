﻿//USEUNIT lib_button
//USEUNIT lib_common
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo

function Remove_PNG_TIFF_OnImageSaving()
{
  aqTestCase.Begin("Verify PNF TIFF removed on M320");
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
  
  lib_button.clickDataFortmating2();
  //add image saving condition
  Sys.Process("DL.CODE").FindChild("ToolTip", "Add Image Saving Condition", 1000).Click();
  // find the label Image Format
  arrPro = ["ClrClassName", "WPFControlText", "Visible"];
  arrVal = ["TextBlock", "Image Format", true];
  
  ImageFormatLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  aqObject.CheckProperty(ImageFormatLbl, "Visible", cmpEqual, true);
  // find the combo box image format
  ImageFormatCbx = ImageFormatLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000);
  aqObject.CheckProperty(ImageFormatCbx, "wItemCount", cmpEqual,3);
  arrFortmatType = ["Raw", "Bmp", "Jpeg"];
  for(var i=0;i<arrFortmatType.length;i++)
  {
    lib_common.cbb_NonLogicalAdornerDecorator(ImageFormatCbx,arrFortmatType[i]);  
  }
  // find the Image Destination Label
  arrPro = ["ClrClassName", "WPFControlText", "Visible"];
  arrVal = ["TextBlock", "Image Destination", true];
  ImageDestinationLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  aqObject.CheckProperty(ImageDestinationLbl, "Visible", cmpEqual, true);
  // find the Image Destination Cbx
  ImageDestinationCbx = ImageDestinationLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000);
  aqObject.CheckProperty(ImageDestinationCbx, "wItemCount", cmpEqual, 2);
  ImageDestinationCbx.ClickItem(0);
  
  /*--------AGAIN VERIFY WITH Remote Destination -----*/
  // find the label Image Format
  arrPro = ["ClrClassName", "WPFControlText", "Visible"];
  arrVal = ["TextBlock", "Image Format", true];
  
  ImageFormatLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  aqObject.CheckProperty(ImageFormatLbl, "Visible", cmpEqual, true);
  // find the combo box image format
  ImageFormatCbx = ImageFormatLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000);
  aqObject.CheckProperty(ImageFormatCbx, "wItemCount", cmpEqual,3);
  arrFortmatType = ["Raw", "Bmp", "Jpeg"];
  for(var i=0;i<arrFortmatType.length;i++)
  {
    lib_common.cbb_NonLogicalAdornerDecorator(ImageFormatCbx,arrFortmatType[i]);  
  }
  aqTestCase.End();
  
}
