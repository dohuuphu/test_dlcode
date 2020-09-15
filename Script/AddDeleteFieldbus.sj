﻿//USEUNIT lib_common
//USEUNIT lib_OpenJob
//USEUNIT lib_button

function AddDeleteFieldbusThenSaveJob()
{
  if (lib_common.connectToDevice(lib_deviceInfo.const_Device_IP_Adress) == lib_err.err_FUNC_FAILED) return;
  lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_N);
  lib_button.clickReadingPhase2();
  arrFieldbusList = ["Ethernet/IP", "Modbus Client", "Modbus Server", "SLMP", "Profinet IO", "HMS Fieldbus"];
  fieldbusChannelContextList = ["EthernetIpChannelType", "ModbusClientChannelType" , "ModbusServerChannelType", "SlmpChannelType", "ProfinetIOChannelType", "HmsFieldbusChannelType"];
  
  for(var j=0;j<1;j++)
  {
    addFieldbus(arrFieldbusList[j], fieldbusChannelContextList[j])  ;
  }
}

function addFieldbus(fieldbus, fieldbusChannelContext)
{    
    addFieldbusObj = Sys.Process("DL.CODE").FindChild("ToolTip", "Add New Fieldbus", 1000);
    addFieldbusObj.Click();
    addFieldbusObj.PopupMenu.Click(fieldbus);

    if(Sys.Process("DL.CODE").FindChild("ClrFullClassName", "UIController.Controls.MessageBox", 1000).Exists)        
    {
      popup = Sys.Process("DL.CODE").FindChild("ClrFullClassName", "UIController.Controls.MessageBox", 1000);
      popup.FindChild("WPFControlName","btnYes", 1000).Click();
    }
    leftPanel = Sys.Process("DL.CODE").FindChild("ClrClassName", "SetContinuousOneShotOpModeTypeActionButton", 1000).Parent;
    leftPanel = leftPanel.Parent;
    leftPanel = leftPanel.Parent;
    leftPanelFieldbusAdd = leftPanel.FindChild("WPFControlText", fieldbus, 1000).Parent;    
    aqObject.CheckProperty(leftPanelFieldbusAdd, "Visible", cmpEqual, true);
    leftPanelFieldbusAdd = leftPanelFieldbusAdd.Parent;
    aqObject.CheckProperty(leftPanelFieldbusAdd.Parent, "Visible", cmpEqual, true);
    centralBorder = Sys.Process("DL.CODE").FindChild("WPFControlName", "CentralBorder", 1000);
    centralPanelFieldbusAdd = centralBorder.FindChild("DataContext.ClrClassName", fieldbusChannelContext, 1000);
    aqObject.CheckProperty(centralPanelFieldbusAdd, "Visible", cmpEqual, true);
    
    rightPanelLabelFieldbus = Sys.Process("DL.CODE").FindChild("WPFControlText", "Reading Phase :  " + fieldbus + " ", 1000);
    aqObject.CheckProperty(rightPanelLabelFieldbus, "Visible", cmpEqual, true);
    arrPro = ["ChildCount", "WPFControlText"];
    var arrComboBox;
    if(fieldbus == "Ethernet/IP")
    {
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Keep Read Item"];
      labelKeepReadItem = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(labelKeepReadItem, "Visible", cmpEqual, true);
      aqObject.CheckProperty(labelKeepReadItem.Parent, "Visible", cmpEqual, true);
      cbxKeepReadItem = labelKeepReadItem.Parent.FindChild("ClrClassName", "ComboBox", 1000);
      aqObject.CheckProperty(cbxKeepReadItem, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxKeepReadItem, "Text" , cmpEqual, "[1, Discard After Connection]");
      
      arrComboBox = ["Keep Always" , "Discard After Read" , "Discard After Connection"];
      aqObject.CheckProperty(cbxKeepReadItem, "wItemCount" , cmpEqual, arrComboBox.length);
      for(i = 0; i < arrComboBox.length; i++)
      {
        lib_common.cbb_NonLogicalAdornerDecorator(cbxKeepReadItem,arrComboBox[i]);
      }
      
    
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Word Addressing"];
      labelWordAddressing = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(labelWordAddressing, "Visible", cmpEqual, true);
      aqObject.CheckProperty(labelWordAddressing.Parent, "Visible", cmpEqual, true);
      cbxWordAddressing = labelWordAddressing.Parent.FindChild("ClrClassName", "CheckBox", 1000);
      aqObject.CheckProperty(cbxWordAddressing, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxWordAddressing, "wState" , cmpEqual, 0);
    }
    else if(fieldbus == "Modbus Client")
    {
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Start Register"];
      labelStartRegister = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(labelStartRegister, "Visible", cmpEqual, true);
      aqObject.CheckProperty(labelStartRegister.Parent, "Visible", cmpEqual, true);      
      cbxStartRegister = labelStartRegister.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxStartRegister, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxStartRegister, "Text" , cmpEqual, "0");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Number of Registers"];
      labelNumberRegister = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(labelNumberRegister, "Visible", cmpEqual, true);
      aqObject.CheckProperty(labelNumberRegister.Parent, "Visible", cmpEqual, true);
      
      cbxNumberRegister = labelNumberRegister.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxNumberRegister, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxNumberRegister, "Text" , cmpEqual, "20");
      
    
      labelRemoteAddress = Sys.Process("DL.CODE").FindChild("WPFControlText", "Remote Address", 1000);
      aqObject.CheckProperty(labelRemoteAddress, "Visible", cmpEqual, true);
      ipBoxRemoteAddress = Sys.Process("DL.CODE").FindChild("ClrClassName", "IpAddressControl", 1000);
      aqObject.CheckProperty(ipBoxRemoteAddress, "Visible", cmpEqual, true);
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Remote Port"];
      labelRemotePort = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(labelRemotePort, "Visible", cmpEqual, true);
      aqObject.CheckProperty(labelRemotePort.Parent, "Visible", cmpEqual, true);
      cbxRemotePort = labelRemotePort.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxRemotePort, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxRemotePort, "Text" , cmpEqual, "502");

      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Remote Unit ID"];
      labelRemoteUnitID = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(labelRemoteUnitID, "Visible", cmpEqual, true);
      aqObject.CheckProperty(labelRemoteUnitID.Parent, "Visible", cmpEqual, true);
      cbxRemoteUnitID = labelRemoteUnitID.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxRemoteUnitID, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxRemoteUnitID, "Text" , cmpEqual, "1");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Connection Retry Time"];
      labelConnectionRetryTime = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(labelConnectionRetryTime, "Visible", cmpEqual, true);
      aqObject.CheckProperty(labelConnectionRetryTime.Parent, "Visible", cmpEqual, true);
      cbxConnectionRetryTime = labelConnectionRetryTime.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxConnectionRetryTime, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxConnectionRetryTime, "Text" , cmpEqual, "3000");
      
    }
    else if (fieldbus == "Modbus Server")
    {
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Remote Port"];
      labelRemotePort = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(labelRemotePort, "Visible", cmpEqual, true);
      aqObject.CheckProperty(labelRemotePort.Parent, "Visible", cmpEqual, true);
      cbxRemotePort = labelRemotePort.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxRemotePort, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxRemotePort, "Text" , cmpEqual, "502");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Start Register"];
      labelStartRegister = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(labelStartRegister, "Visible", cmpEqual, true);
      aqObject.CheckProperty(labelStartRegister.Parent, "Visible", cmpEqual, true);      
      cbxStartRegister = labelStartRegister.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxStartRegister, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxStartRegister, "Text" , cmpEqual, "0");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Number of Registers"];
      labelNumberRegister = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(labelNumberRegister, "Visible", cmpEqual, true);
      aqObject.CheckProperty(labelNumberRegister.Parent, "Visible", cmpEqual, true);
      
      cbxNumberRegister = labelNumberRegister.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxNumberRegister, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxNumberRegister, "Text" , cmpEqual, "20");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Buffering queue depth"];
      labelBufferingQueueDepth = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(labelBufferingQueueDepth, "Visible", cmpEqual, true);
      aqObject.CheckProperty(labelBufferingQueueDepth.Parent, "Visible", cmpEqual, true);
      
      cbxBufferingQueueDepth = labelBufferingQueueDepth.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxBufferingQueueDepth, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxBufferingQueueDepth, "Text" , cmpEqual, "1");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Keep last data"];
      labelKeepLastData = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(labelKeepLastData, "Visible", cmpEqual, true);
      aqObject.CheckProperty(labelKeepLastData.Parent, "Visible", cmpEqual, true);
      
      cbxKeepLastData = labelKeepLastData.Parent.FindChild("ClrClassName", "ComboBox", 1000);
      aqObject.CheckProperty(cbxKeepLastData, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxKeepLastData, "Text" , cmpEqual, "[0, Disabled]");
      arrComboBox = ["Enabled" , "Disabled"];
      aqObject.CheckProperty(cbxKeepLastData,"wItemCount", cmpEqual, arrComboBox.length); 
      for(i = 0; i < arrComboBox.length; i++)
      {
        lib_common.cbb_NonLogicalAdornerDecorator(cbxKeepLastData,arrComboBox[i]);
      }
      
    }
    else if (fieldbus == "SLMP")
    {
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Network Number"];
      networkNumberLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(networkNumberLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(networkNumberLabel.Parent, "Visible", cmpEqual, true);
      cbxNetworkNumber = networkNumberLabel.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxNetworkNumber, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxNetworkNumber, "Text" , cmpEqual, "0");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Node Number"];
      nodeNumberLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(nodeNumberLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(nodeNumberLabel.Parent, "Visible", cmpEqual, true);
      cbxNodeNumber = nodeNumberLabel.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxNodeNumber, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxNodeNumber, "Text" , cmpEqual, "255");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Processor Number"];
      processorNumberLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(processorNumberLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(processorNumberLabel.Parent, "Visible", cmpEqual, true);
      cbxProcessorNumber = processorNumberLabel.Parent.FindChild("ClrClassName", "ComboBox", 1000);
      aqObject.CheckProperty(cbxProcessorNumber, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxProcessorNumber, "Text" , cmpEqual, "[8, SLMP_CPU_DEFAULT]");
      
      arrComboBox = ["CPU ACTIVE" , "CPU STANDBY" , "CPU TYPE A", "CPU TYPE B", "CPU 1", "CPU 2", "CPU 3", "CPU 4" , "CPU DEFAULT"];
      aqObject.CheckProperty(cbxProcessorNumber,"wItemCount", cmpEqual, arrComboBox.length); 
      for(i = 0; i < arrComboBox.length; i++)
      {
        lib_common.cbb_NonLogicalAdornerDecorator(cbxProcessorNumber,arrComboBox[i]);
      }
      
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Polling Interval (ms)"];
      pollingIntervalLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(pollingIntervalLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(pollingIntervalLabel.Parent, "Visible", cmpEqual, true);
      cbxPollingInterval = pollingIntervalLabel.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxPollingInterval, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxPollingInterval, "Text" , cmpEqual, "100");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Remote Port"];
      remotePortLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(remotePortLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(remotePortLabel.Parent, "Visible", cmpEqual, true);
      cbxremotePort = remotePortLabel.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxremotePort, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxremotePort, "Text" , cmpEqual, "8192");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Number of Input Devices"];
      numberOfInputDeviceLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(numberOfInputDeviceLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(numberOfInputDeviceLabel.Parent, "Visible", cmpEqual, true);
      cbxNumberOfInputDevice = numberOfInputDeviceLabel.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxNumberOfInputDevice, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxNumberOfInputDevice, "Text" , cmpEqual, "16");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Input Offset"];
      inputOffsetLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(inputOffsetLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(inputOffsetLabel.Parent, "Visible", cmpEqual, true);
      cbxInputOffset = inputOffsetLabel.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxInputOffset, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxInputOffset, "Text" , cmpEqual, "100");
      
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Number of Output Devices"];
      numberOfOutputDevicesLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(numberOfOutputDevicesLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(numberOfOutputDevicesLabel.Parent, "Visible", cmpEqual, true);
      cbxnumberOfOutputDevices = numberOfOutputDevicesLabel.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxnumberOfOutputDevices, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxnumberOfOutputDevices, "Text" , cmpEqual, "32");
     
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Output Offset"];
      outputOffsetLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(outputOffsetLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(outputOffsetLabel.Parent, "Visible", cmpEqual, true);
      cbxOutputOffset = outputOffsetLabel.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxOutputOffset, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxOutputOffset, "Text" , cmpEqual, "228");
       
    }
    
    else if(fieldbus == "Profinet IO")
    {
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Data Flow Control"];
      dataFlowControlLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(dataFlowControlLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(dataFlowControlLabel.Parent, "Visible", cmpEqual, true);
      cbxDataFlowControl = dataFlowControlLabel.Parent.FindChild("ClrClassName", "ComboBox", 1000);
      aqObject.CheckProperty(cbxDataFlowControl, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxDataFlowControl, "Text" , cmpEqual, "[0, Disabled]");
      
      arrComboBox = ["DAD Flow Control", "Disabled"];
      aqObject.CheckProperty(cbxDataFlowControl,"wItemCount", cmpEqual, arrComboBox.length); 
      for(i = 0; i < arrComboBox.length; i++)
      {
        lib_common.cbb_NonLogicalAdornerDecorator(cbxDataFlowControl,arrComboBox[i]);
      }
      
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Input Exchange Area Size"];
      inputExchangeAreaSizeLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(inputExchangeAreaSizeLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(inputExchangeAreaSizeLabel.Parent, "Visible", cmpEqual, true);
      cbxInputExchangeAreaSize = inputExchangeAreaSizeLabel.Parent.FindChild("ClrClassName", "ComboBox", 1000);
      aqObject.CheckProperty(cbxInputExchangeAreaSize, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxInputExchangeAreaSize, "Text" , cmpEqual, "[3, 64 Byte]");
      arrComboBox = ["8 Byte", "16 Byte", "32 Byte", "64 Byte", "128 Byte"];
      aqObject.CheckProperty(cbxInputExchangeAreaSize,"wItemCount", cmpEqual, arrComboBox.length); 
      for(i = 0; i < arrComboBox.length; i++)
      {
        lib_common.cbb_NonLogicalAdornerDecorator(cbxInputExchangeAreaSize,arrComboBox[i]);
      }
      
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Output Exchange Area Size"];
      outputExchangeAreaSizeLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(outputExchangeAreaSizeLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(outputExchangeAreaSizeLabel.Parent, "Visible", cmpEqual, true);
      cbxOutputExchangeAreaSize = outputExchangeAreaSizeLabel.Parent.FindChild("ClrClassName", "ComboBox", 1000);
      aqObject.CheckProperty(cbxOutputExchangeAreaSize, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxOutputExchangeAreaSize, "Text" , cmpEqual, "[0, 8 Byte]");
      arrComboBox = ["8 Byte", "16 Byte", "32 Byte", "64 Byte", "128 Byte"];
      aqObject.CheckProperty(cbxOutputExchangeAreaSize,"wItemCount", cmpEqual, arrComboBox.length); 
      for(i = 0; i < arrComboBox.length; i++)
      {
        lib_common.cbb_NonLogicalAdornerDecorator(cbxOutputExchangeAreaSize,arrComboBox[i]);
      }
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Digital IO Conditioning"];
      digitalIOConditioningLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(digitalIOConditioningLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(digitalIOConditioningLabel.Parent, "Visible", cmpEqual, true);
      cbxDigitalIOConditioning = digitalIOConditioningLabel.Parent.FindChild("ClrClassName", "CheckBox", 1000);
      aqObject.CheckProperty(cbxDigitalIOConditioning, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxDigitalIOConditioning, "IsChecked" , cmpEqual, true);          
    }
    
    else if(fieldbus == "HMS Fieldbus")
    {
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Data Flow Control"];
      dataFlowControlLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(dataFlowControlLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(dataFlowControlLabel.Parent, "Visible", cmpEqual, true);
      cbxDataFlowControl = dataFlowControlLabel.Parent.FindChild("ClrClassName", "ComboBox", 1000);
      aqObject.CheckProperty(cbxDataFlowControl, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxDataFlowControl, "Text" , cmpEqual, "[0, Disabled]");
      arrComboBox = ["DAD Flow Control", "Disabled"];
      aqObject.CheckProperty(cbxDataFlowControl,"wItemCount", cmpEqual, arrComboBox.length); 
      for(i = 0; i < arrComboBox.length; i++)
      {
        lib_common.cbb_NonLogicalAdornerDecorator(cbxDataFlowControl,arrComboBox[i]);
      }
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Input Exchange Area Size"];
      inputExchangeAreaSizeLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(inputExchangeAreaSizeLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(inputExchangeAreaSizeLabel.Parent, "Visible", cmpEqual, true);
      cbxInputExchangeAreaSize = inputExchangeAreaSizeLabel.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxInputExchangeAreaSize, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxInputExchangeAreaSize, "Text" , cmpEqual, "8");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Output Exchange Area Size"];
      outputExchangeAreaSizeLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(outputExchangeAreaSizeLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(outputExchangeAreaSizeLabel.Parent, "Visible", cmpEqual, true);
      cbxOutputExchangeAreaSize = outputExchangeAreaSizeLabel.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxOutputExchangeAreaSize, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxOutputExchangeAreaSize, "Text" , cmpEqual, "8");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Digital IO Conditioning"];
      digitalIOConditioningLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(digitalIOConditioningLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(digitalIOConditioningLabel.Parent, "Visible", cmpEqual, true);
      cbxDigitalIOConditioning = digitalIOConditioningLabel.Parent.FindChild("ClrClassName", "CheckBox", 1000);
      aqObject.CheckProperty(cbxDigitalIOConditioning, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxDigitalIOConditioning, "IsChecked" , cmpEqual, true);
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "Fieldbus Type"];
      fieldbusTypeLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(fieldbusTypeLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(fieldbusTypeLabel.Parent, "Visible", cmpEqual, true);
      cbxFieldbusType = fieldbusTypeLabel.Parent.FindChild("ClrClassName", "ComboBox", 1000);
      aqObject.CheckProperty(cbxFieldbusType, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxFieldbusType, "Text" , cmpEqual, "[0, Profibus]");
      arrComboBox = ["DeviceNet", "EtherNet/IP", "CC-Link", "CANOpen", "PROFINET-IO", "Modbus TCP", "EtherCAT", "PROFIBUS-DP"];
      aqObject.CheckProperty(cbxFieldbusType,"wItemCount", cmpEqual, arrComboBox.length); 
      for(i = 0; i < arrComboBox.length; i++)
      {
        lib_common.cbb_NonLogicalAdornerDecorator(cbxFieldbusType,arrComboBox[i]);
      }
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "PROFIBUS-DP Baud Rate"];
      profibusDPBaudRateLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(profibusDPBaudRateLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(profibusDPBaudRateLabel.Parent, "Visible", cmpEqual, true);
      cbxProfibusDPBaudRate = profibusDPBaudRateLabel.Parent.FindChild("ClrClassName", "ComboBox", 1000);
      aqObject.CheckProperty(cbxProfibusDPBaudRate, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxProfibusDPBaudRate, "Text" , cmpEqual, "[0, BaudRateAuto]");
      
      arrPro = ["ChildCount", "WPFControlText"];
      arrVal = [1, "PROFIBUS-DP Node Address"];
      profibusDPNodeAddressLabel = Sys.Process("DL.CODE").FindChild(arrPro, arrVal, 1000);
      aqObject.CheckProperty(profibusDPNodeAddressLabel, "Visible", cmpEqual, true);
      aqObject.CheckProperty(profibusDPNodeAddressLabel.Parent, "Visible", cmpEqual, true);
      cbxProfibusDPNodeAddress = profibusDPNodeAddressLabel.Parent.FindChild("ClrClassName", "WatermarkTextBox", 1000);
      aqObject.CheckProperty(cbxProfibusDPNodeAddress, "Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxProfibusDPNodeAddress, "Text" , cmpEqual, "0");
    }
    for(i=1;i<=8;i++)
    {
      centralPanelFieldbusAdd.WPFObject("ContentPresenter", "", i).Click();
      aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("WPFControlText" , "Input Bit    " + (i-1), 1000),"Visible", cmpEqual, true);
      aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("WPFControlText" , "Input Name", 1000),"Visible", cmpEqual, true);
      arrVal = [1, "Active State"];
      activeStateLable = Sys.Process("DL.CODE").FindChild(arrPro , arrVal, 1000);
      aqObject.CheckProperty(activeStateLable, "Visible", cmpEqual, true);
      cbxActiveState = activeStateLable.Parent.FindChild("ClrClassName", "ComboBox", 1000);
      //aqObject.CheckProperty(Sys.Process("DL.CODE").FindChild("Text" , "[0, Active Closed]", 1000),"Visible", cmpEqual, true);
      aqObject.CheckProperty(cbxActiveState,"Visible", cmpEqual, true);
      arrComboBox = ["Active Open", "Active Closed"];
      aqObject.CheckProperty(cbxActiveState,"wItemCount", cmpEqual, arrComboBox.length);  
      for(k = 0;k < arrComboBox.length; k++)
      {
        lib_common.cbb_NonLogicalAdornerDecorator(cbxActiveState,arrComboBox[k]);
      }
      
      arrVal = [1, "Debounce Filter"];
      debounceFilterLabel = Sys.Process("DL.CODE").FindChild(arrPro , arrVal, 1000);
      aqObject.CheckProperty(debounceFilterLabel,"Visible", cmpEqual, true);
      cbxDebounceFilter = debounceFilterLabel.Parent.FindChild("ClrClassName", "ComboBox", 1000);
      aqObject.CheckProperty(cbxDebounceFilter,"Visible", cmpEqual, true);     
      
      arrComboBox = ["Disabled", "0.1 ms", "0.5 ms", "1 ms", "5 ms", "10 ms"];
      aqObject.CheckProperty(cbxDebounceFilter,"wItemCount", cmpEqual, arrComboBox.length);  
      for(k = 0; k < arrComboBox.length; k++)
      {
        lib_common.cbb_NonLogicalAdornerDecorator(cbxDebounceFilter,arrComboBox[k]);
      }
      
      
    }
    // save
    lib_SaveJob.saveJobOnDevice2(lib_deviceInfo.const_firmware_version + "_"+ fieldbusChannelContext);
    //detele
    Sys.Process("DL.CODE").FindChild("ToolTip", "Delete Selected Item", 1000).Click();
    Sys.Process("DL.CODE").WPFObject("HwndSource: Window").FindChild("WPFControlName", "btnYes", 1000).Click();
}

function test()
{
  fieldbus = "Ethernet/IP";
  rightPanelLabelFieldbus = Sys.Process("DL.CODE").FindChild("WPFControlText", "Reading Phase :  Ethernet/IP ", 1000);
  aqObject.CheckProperty(rightPanelLabelFieldbus, "Visible", cmpEqual, true);
}