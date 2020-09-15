//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_err
//USEUNIT lib_label
//USEUNIT lib_validate


/*
  *@function 
*/
function launch_Config_TM()
{
      launchTestMatrix();
      configTestMatrix();       
}

 

//add new from 1.5.1 Beta 02
/*
  *@function 
*/
function launchTestMatrix ()
{   
    // Launch the application    
    var flag = lib_err.err_FUNC_SUCCESS;       
    if ( !Sys.WaitProcess("TestMatrix", lib_const.const_delay_1000, true).Exists)//TestMatrix doesn't exist
    {
          Indicator.PushText("Launch new TestMatrix");	     
           TestedApps.Items(1).Run(); 
          delay (lib_const.const_delay_3000);
          Indicator.PopText();        
    }else//TestMatrix existed
    { 
                  Indicator.PushText("TestMatrix is running -> Close and Re-launch ");	     
                  terminateTestMatrix();
                  delay (lib_const.const_delay_3000);
                  TestedApps.Items(1).Run(); 
                  delay (lib_const.const_delay_3000);
                  Indicator.PopText();     
    } 
    return flag;    
}

/*
  *@function 
*/
function terminateTestMatrix()
{
      // Obtains the notepad.exe process
      var p = Sys["FindChild"]("ProcessName", "TestMatrix");
      // Iterates through all the instances of the notepad.exe process
      // until all of them are closed
      while (p["Exists"])
      {
          p["Close"]();
          // Waits until the process is closed
          var isClosed = p["WaitProperty"]("Exists", false);
          // Checks whether the process has been closed successfully
          if (! isClosed)
            // Terminates the process
             {
             p.Terminate();
             //break;
             }

          // Obtains another instance of the notepad.exe process
          p = Sys["FindChild"]("ProcessName", "TestMatrix");
     }
}

/*
  *@function 
*/
function configTestMatrix()
{        
        //lib_deviceInfo.const_Device_IP_Adress = "191.169.122.13";
        var arr = ipToString(lib_deviceInfo.const_Device_IP_Adress);
        //Step 1: input device IP 
        var devIPAdd = Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("ipAddressControl_deviceIPAddress");
        devIPAdd.FieldControl0.Keys("^a");
        devIPAdd.FieldControl0.SetText(arr[0]);
               
        devIPAdd.FieldControl1.Keys("^a");
        devIPAdd.FieldControl1.SetText(arr[1]);

        devIPAdd.FieldControl2.Keys("^a");
        devIPAdd.FieldControl2.SetText(arr[2]);
        
        devIPAdd.FieldControl3.Keys("^a");
        devIPAdd.FieldControl3.SetText(arr[3]);
        
        //Step 2: click on Tab Generate Signals
        Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("tabControl1").ClickTab("Generate Signals");
        //Step 3: checked Digital I/O
//        Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("tabControl1").WinFormsObject("tabPage_generateSignals").WinFormsObject("tabControl3").WinFormsObject("tabPage_generation_phaseGen").WinFormsObject("groupBox_generation_phaseLine").WinFormsObject("checkBox_generation_phaseLineIO").set_Checked(true);
        Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("tabControl1").WinFormsObject("tabPage_generateSignals").WinFormsObject("tabControl3").WinFormsObject("tabPage_generation_phaseGen").WinFormsObject("checkBox_generation_phaseMode").set_Checked(true);
        //Step 4: Input Device/Port/Line
        Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("tabControl1").WinFormsObject("tabPage_generateSignals").WinFormsObject("tabControl3").WinFormsObject("tabPage_generation_phaseGen").WinFormsObject("groupBox_generation_phaseLine").WinFormsObject("groupBox_generation_phaseLineIO").WinFormsObject("comboBox_generation_phaseDevice").set_SelectedIndex(0);
        Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("tabControl1").WinFormsObject("tabPage_generateSignals").WinFormsObject("tabControl3").WinFormsObject("tabPage_generation_phaseGen").WinFormsObject("groupBox_generation_phaseLine").WinFormsObject("groupBox_generation_phaseLineIO").WinFormsObject("comboBox_generation_phasePort").set_SelectedIndex(0);
        Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("tabControl1").WinFormsObject("tabPage_generateSignals").WinFormsObject("tabControl3").WinFormsObject("tabPage_generation_phaseGen").WinFormsObject("groupBox_generation_phaseLine").WinFormsObject("groupBox_generation_phaseLineIO").WinFormsObject("comboBox_generation_phaseLine").set_SelectedIndex(0);
        
        
} 

function ipToString (ip)
{
      var arr =  ip .split(".");     
//      for (var i = 0; i< arr.length ; i ++)
//      {
//          Log.Message(i + ":" + arr[i] );
//      }
      return arr;
}
/*
  *@function 
*/
function clickStartbtt()
{
       Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("button_startTest").ClickButton();
       delay (1000);
       if (aqObject.CheckProperty(Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("button_startTest"), "Enabled", cmpEqual, false)== true)
             aqObject.CheckProperty(Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("button_stopTest"), "Enabled", cmpEqual, true);
}

/*
  *@function 
*/
function clickStopbtt()
{
       Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("button_stopTest").ClickButton();
       delay (3000);
       if (aqObject.CheckProperty(Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("button_startTest"), "Enabled", cmpEqual, true)== true)
              aqObject.CheckProperty(Sys.Process("TestMatrix").WinFormsObject("MainForm").WinFormsObject("button_stopTest"), "Enabled", cmpEqual, false);
}

