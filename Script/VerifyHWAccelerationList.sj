//USEUNIT lib_button
//USEUNIT lib_common
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo
function VerifyHWAccelerationList()
{
  aqTestCase.Begin("Verify HW Acceleration list");
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
  lib_button.clickAdvancedSetup();
  
  // expand image setting if not
  arrPro = ["WPFControlText", "ClrClassName"];
  arrVal = ["Code Settings", "TextBlock"];
  tempObj = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000).Parent;
  tempObj = tempObj.WPFObject("TreeViewItem", "", 1);  
  if(!tempObj.get_IsExpanded())  tempObj.ExpandSubtree();
  
  // click on General Settings - Code Grading
  arrPro = ["WPFControlText", "ClrClassName"];
  arrVal = ["General Settings - Code Grading", "TextBlock"];
  Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000).Click();
  // find the HW Acceleration Label
  arrPro = ["ClrClassName", "WPFControlText", "Visible"];
  arrVal = ["TextBlock", "HW Acceleration", true];
  HWAccelerationLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);  
  // find the combobox HW Acceleration
  HWAccelerationCbx = HWAccelerationLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000);
  aqObject.CheckProperty(HWAccelerationCbx, "wItemCount", cmpEqual, 2);
  // verify default value of combo box HW Acceleration is Disable
  aqObject.CheckProperty(HWAccelerationCbx.WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, "Disabled");
  // change HW Acceleration to Enabled
  HWAccelerationCbx.ClickItem(1);
  // read info HW Acceleration Subtype from text fle
  var M320_HW_Acceleration_AllSubTypes = aqFile.ReadWholeTextFIle(Project.Path + "M320_HW_Acceleration_SubTypes.csv", aqFile.ctANSI);
  aqString.ListSeparator = ";";
  var HW_Acceleration_AllSubTypesCount = aqString.GetListLength(M320_HW_Acceleration_AllSubTypes);

  // find the HW Acceleration Subtype Label
  arrPro = ["ClrClassName", "WPFControlText", "Visible"];
  arrVal = ["TextBlock", "HW Acceleration Subtype", true];
  HWAccelerationSubtypeLbl = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
  // find the combobox HW Acceleration Subtype
  HWAccelerationSubtypeCbx = HWAccelerationSubtypeLbl.Parent.FindChild("ClrClassName", "ComboBox", 1000);
  aqObject.CheckProperty(HWAccelerationSubtypeCbx, "wItemCount", cmpEqual, HW_Acceleration_AllSubTypesCount);
  // verify default value of HWAccelerationSubtypeCbx is DPM PCB
  aqObject.CheckProperty(HWAccelerationSubtypeCbx.WPFObject("TextBlock", "*", 1), "WPFControlText", cmpEqual, "DPM PCB");
  // loop for all values --> choose --> save job
  var HWAccSubtype; 
  for(i=0;i<HW_Acceleration_AllSubTypesCount;i++)
  {
    HWAccSubtype = aqString.GetListItem(M320_HW_Acceleration_AllSubTypes, i);
    lib_common.cbb_NonLogicalAdornerDecorator(HWAccelerationSubtypeCbx,HWAccSubtype);
    lib_button.clickPlay2()  ;
    delay(5000);
    lib_button.clickPause2()  ;
    lib_SaveJob.saveJobOnDevice2(lib_deviceInfo.const_firmware_version + "HW_AccelerationSubType_" +  HWAccSubtype);
  }
  aqTestCase.End();
}