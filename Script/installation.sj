//USEUNIT lib_const 
//USEUNIT lib_common
//USEUNIT  lib_updateConfig

/*
   @function: uninstall DL.CODE and all of drivers
   then run CCclearner
*/
function TC_uninstall_cleanPC()
{
      Log.Message (mainFunUnInstall());
      runCCleaner2();
      Delay(3000); 
}


/*
   @function: uninstall -> clean PC -> re-install
*/
function TC_un_inStlGUI()
{

      Log.Message (mainFunUnInstall());
      runCCleaner2();
      Delay(3000); 
      instDL_Latest();
}

/*
    @function: clean PC
*/
function runCCleaner ()
{
              var flag = false;
              Indicator.PushText("Install");
              Indicator.PopText();  
              NameMapping.Sys.Keys("[Hold][Win]r[Release]");
              explorer = Aliases.explorer;
              dlgRun = explorer.dlgRun;
              dlgRun.cbxOpen.SetText(pathCCleaner );
              dlgRun.btnOK.ClickButton(); 
              Delay(3000);
              Sys.Process("CCleaner64", 2).Window("#32770", "CCleaner", 1).Window("Button", "&No", 2).ClickButton();
              Delay(3000);
 
              
              Sys.Process("CCleaner64", 2).Window("PiriformCCleaner", "CCleaner - FREE FOR HOME USE", 1).Window("#32770", "", 1).Window("Button", "&Analyze", 1).ClickButton();
              if (Sys.Process("CCleaner64", 2).WaitWindow("#32770", "", 1, 1000).Exists)
                  { 
                      var txt = Sys.Process("CCleaner64", 2).Window("#32770", "", 1).Window("Edit", "", 1).wText;
                      if (aqString.Contains(txt, "Do you want CCleaner to close" , 0, true) != -1  )
                      {
                             Sys.Process("CCleaner64", 2).Window("#32770", "", 1).Window("Button", "Yes", 1).ClickButton();
                             Delay(10000);                             
                             Sys.Process("CCleaner64", 2).Window("#32770", "", 1).Window("Button", "&Yes", 1).ClickButton();   
                      }
                  }
              while (Sys.Process("CCleaner64", 2).Window("PiriformCCleaner", "CCleaner - FREE FOR HOME USE", 1).Window("#32770", "", 1).Window("Button", "&Run Cleaner", 2).Enabled == false)
              {
                  Delay(3000);
                  
              }
              Sys.Process("CCleaner64", 2).Window("PiriformCCleaner", "CCleaner - FREE FOR HOME USE", 1).Window("#32770", "", 1).Window("Button", "&Run Cleaner", 2).ClickButton();
              Delay(3000);
              Sys.Process("CCleaner64", 2).Window("#32770", "", 1).Window("Button", "Continue", 1).ClickButton();
              while (Sys.Process("CCleaner64", 2).Window("PiriformCCleaner", "CCleaner - FREE FOR HOME USE", 1).Window("#32770", "", 1).Window("Button", "&Run Cleaner", 2).Enabled == false)
                   Delay(3000);
                   
                   
              Sys.Process("CCleaner64", 2).Window("PiriformCCleaner", "CCleaner - FREE FOR HOME USE", 1).Window("Button", "Re&gistry", 3).ClickButton();
              Sys.Process("CCleaner64", 2).Window("PiriformCCleaner", "CCleaner - FREE FOR HOME USE", 1).Window("#32770", "", 1).Window("Button", "&Scan for Issues", 1).ClickButton();
              delay (60000);
              if (Sys.Process("CCleaner64", 2).Window("PiriformCCleaner", "CCleaner - FREE FOR HOME USE", 1).Window("#32770", "", 1).Window("Button", "&Fix selected Issues...", 2).Enabled == true)
              { 
                    Sys.Process("CCleaner64", 2).Window("PiriformCCleaner", "CCleaner - FREE FOR HOME USE", 1).Window("#32770", "", 1).Window("Button", "&Fix selected Issues...", 2).ClickButton();
                    Delay(2000);
                    Sys.Process("CCleaner64", 2).Window("#32770", "CCleaner", 1).Window("Button", "&No", 2).ClickButton();
                    Delay(2000);
              
                    Sys.Process("CCleaner64", 2).Window("#32770", "", 1).Window("Button", "Fix All Selected Issues", 4).ClickButton();
                    while (Sys.Process("CCleaner64", 2).Window("#32770", "", 1).Window("Button", "Close", 5).Enabled == false ||
                          Sys.Process("CCleaner64", 2).Window("#32770", "", 1).Window("Button", "Close", 5).Visible == false ||
                          Sys.Process("CCleaner64", 2).Window("#32770", "", 1).Window("Button", "Close", 5).VisibleOnScreen == false)
                          Delay(3000);
                    Sys.Process("CCleaner64", 2).Window("#32770", "", 1).Window("Button", "Close", 5).ClickButton();
                    Sys.Process("CCleaner64", 2).Window("PiriformCCleaner", "CCleaner - FREE FOR HOME USE", 1).Close(); 
              }
 

} 


/*
    @function: install DL.CODE and drivers
*/



function initCurrVersion()
{
      var Build = new Object();
      Build.pathGUIsetup = lib_updateConfig.pathCurrGUIsetup;
      Build.versionBuild = lib_updateConfig.versionCurrBuild;
      Build.guiVersion = lib_updateConfig.guiCurrVersion
      Build.exeBuild = lib_updateConfig.exeCurrBuild;
      return  Build; 
}


function initLastOffVersion()
{
      var Build = new Object();
      Build.pathGUIsetup = lib_updateConfig.pathLstUIsetup;
      Build.versionBuild = lib_updateConfig.versionLstBuild;
      Build.guiVersion = lib_updateConfig.guiLstVersion
      Build.exeBuild = lib_updateConfig.exeLstBuild;
      return  Build; 
}


function instDL_Latest()
{ 
        var currVersion = new Object();
        currVersion = initLatestBuildInformation();
        //installation(currVersion, true);
        Install(currVersion, true);
}

function instDL_1_7_0()
{ 
        var currVersion = new Object();
        currVersion = initLastOffVersion();
        //installation(currVersion, false);
        Install(currVersion, true);
}

function runCCleaner2 ()
{
  while (Sys.WaitProcess("CCleaner*").Exists)
  {
    Sys.Process("CCleaner*").Terminate();
    delay(2000);
  }
  var flag = false;
  Indicator.PushText("Install");
  Indicator.PopText();  
  NameMapping.Sys.Keys("[Hold][Win]r[Release]");
  explorer = Aliases.explorer;
  dlgRun = explorer.dlgRun;
  dlgRun.cbxOpen.SetText(pathCCleaner );
  dlgRun.btnOK.ClickButton(); 
  var cCleanerObject, cCleanerUpgradePopUp, closePopUp, waitPopUp, confirmPopUp; 
  var stop = false, check = false;
  var count =2;
  while(!stop)
  {
    cCleanerObject = GetObjectWindow("CCleaner*", "CCleaner*", "PiriformCCleaner" , 1);
    if(cCleanerObject.Exists)
    {
      stop = true;
    }
  }
  stop = false;
  //while(!stop)
  {   
    cCleanerUpgradePopUp = GetObjectWindow("CCleaner*", "CCleaner*", "#32770" , 1);
    while(!cCleanerUpgradePopUp.Exists && count >0) 
    {
      cCleanerUpgradePopUp = GetObjectWindow("CCleaner*", "CCleaner*", "#32770" , 1);
      count --;
    }
    if(cCleanerUpgradePopUp.Exists)
    {
      cCleanerUpgradePopUp.Window("Button", "&No", 2).ClickButton();     
    }
    delay(1000);
    cCleanerObject.Window("#32770", "", 1).Window("Button", "&Analyze", 1).ClickButton();
    closePopUp = GetObjectWindow("CCleaner*", "", "#32770" , 1);
    count = 10;
    while(!closePopUp.Exists && count >0) 
    {
      closePopUp = GetObjectWindow("CCleaner*", "", "#32770" , 1);
      count--;
    }
    if(closePopUp.Exists)
    {
      closePopUp.Window("Button", "Yes", 1).ClickButton(); 
      count =100;     
    }
    else
    {
      count = -1;
    }
    waitPopUp = GetObjectWindow("CCleaner*", "", "#32770" , 3);
    while(!waitPopUp.Exists && count >0) 
    { 
      count --;
      // wait popup 3 display: mean that popup 1 display first then it change index to 2 then to 3      
      waitPopUp = GetObjectWindow("CCleaner*", "", "#32770" , 3);
      while(waitPopUp.Exists && count >0)
      {
        // popup 3 display later and it change to index 1
        waitPopUp = GetObjectWindow("CCleaner*", "", "#32770" , 1);
        // popup3 (index 1) now visible, then click, find again popup1 (index3)
        waitPopUp.Window("Button", "&Yes", 1).ClickButton();  
        waitPopUp = GetObjectWindow("CCleaner*", "", "#32770" , 3);  
        count--;                
      }
    }
    count = 10;
    while(!cCleanerObject.Window("#32770", "", 1).Window("Button", "&Run Cleaner", 2).Enabled){}
    if(cCleanerObject.Window("#32770", "", 1).Window("Button", "&Run Cleaner", 2).Enabled)
    {
      cCleanerObject.Window("#32770", "", 1).Window("Button", "&Run Cleaner", 2).ClickButton();
      confirmPopUp = GetObjectWindow("CCleaner*", "", "#32770" , 1); 
      while(!confirmPopUp.Exists && count>0)
      {
        confirmPopUp = GetObjectWindow("CCleaner*", "", "#32770" , 1); 
        count--;
      }
      if(confirmPopUp.Exists)
      {
        confirmPopUp.Window("Button", "Continue", 1).ClickButton();
      }
      while(!cCleanerObject.Window("#32770", "", 1).Window("Button", "&Run Cleaner", 2).Enabled) {}
    }
    
    cCleanerObject.Window("Button", "Re&gistry", 3).ClickButton();
    cCleanerObject.Window("#32770", "", 1).Window("Button", "&Scan for Issues", 1).ClickButton();
    while(!cCleanerObject.Window("#32770", "", 1).WaitWindow("Button", "&Scan for Issues", 1).Exists) {}
    if(cCleanerObject.Window("#32770", "", 1).Window("Button", "&Fix selected Issues...", 2).Enabled)
    {
      cCleanerObject.Window("#32770", "", 1).Window("Button", "&Fix selected Issues...", 2).ClickButton();
    // confirm step 1
      confirmPopUp = GetObjectWindow("CCleaner*", "CCleaner", "#32770" , 1); 
      while(!confirmPopUp.Exists)
      {
        confirmPopUp = GetObjectWindow("CCleaner*", "CCleaner", "#32770" , 1); 
      }
      if(confirmPopUp.Exists)
      {
        confirmPopUp.Window("Button", "&No", 2).ClickButton();
      }
      // confirm step 2
      confirmPopUp = GetObjectWindow("CCleaner*", "", "#32770" , 1); 
      while(!confirmPopUp.Exists)
      {
        confirmPopUp = GetObjectWindow("CCleaner*", "", "#32770" , 1);
      }
      if(confirmPopUp.Window("Button", "Fix All Selected Issues", 4).Visible)
      {
        confirmPopUp.Window("Button", "Fix All Selected Issues", 4).ClickButton();
      }
      else
      {
        confirmPopUp.Window("Button", "Fix Issue", 3).ClickButton();
      }
      while(confirmPopUp.Window("Button", "Fix All Selected Issues", 4).Enabled || 
      confirmPopUp.Window("Button", "Fix Issue", 3).Enabled) {}    
      confirmPopUp.Window("Button", "Close", 5).ClickButton();      
    }
    Sys.Process("CCleaner*").Terminate();
  }
  
 
}
function findProc(name) 
{
   return Sys.FindAllChildren(["ProcessName"],[name],1).toArray();
}
function GetObjectWindow(process, WndCaption, WndClass, indexOfObject)
{
  var stop = false;
  var arrProcess = findProc(process);
  var windowObject;
  for(var i = 0; i< arrProcess.length; i++)
  {
    var fullName = arrProcess[i].FullName;
    var index = aqString.Find(fullName, ",");
    if(index ==-1)    
    {
      index = fullName.length - 15;
    }
    else
    {
      index  = fullName.length - 13 - (fullName.length - index) -1;
    }
    
    try
    {
      fullName = aqString.SubString(fullName, 13, index);
      var obj = Sys.WaitProcess(fullName, 1000, arrProcess[i].Index);
      if(obj.Exists)
      {
        windowObject = Sys.Process(fullName, arrProcess[i].Index).WaitWindow(WndClass, WndCaption, indexOfObject);
      }
      
    }
    catch (ex)
    {
     // do nothing 
    }
    
    //if(windowObject.ChildCount != -1)
    if(windowObject.Exists)
    {
      break;
    }
    
  }
  return windowObject;
}
function Install(build, isDriver)
{
  var process = "DL.CODE*";
  var WndClass1 = "WixStdBA";
  var WndCaption1 = "*";
  var count = 0;
  var stop =false;
  if (isExistPrg(build.guiVersion) != "")
  {
    Log.Message(build.guiVersion + "  is installed");
    return;
  }
  else
  {
    Indicator.PushText("Install");
    Indicator.PopText(); 
    NameMapping.Sys.Keys("[Hold][Win]r[Release]");
    explorer = Aliases.explorer;
    dlgRun = explorer.dlgRun;
    //dlgRun.cbxOpen.SetText(build.pathGUIsetup + "\\" + build.versionBuild +"\\"  +  build.exeBuild );
    dlgRun.cbxOpen.SetText(build.pathGUIsetup + "\\" +  build.exeBuild );
    dlgRun.btnOK.ClickButton();
    delay(15000);
    var object1;
    while(!stop)
    {
      object1 = GetObjectWindow(process, WndCaption1, WndClass1, 1);
      count++;
      delay(500);
      if(object1.Exists == true)
      {
        stop = true;
      }
      if(count>20)
      {
        break;
      }      
    }
    stop = false;
    if(count>20)
    {
      return "Can not find the installation file for DL.CODE";
    }
    else
    {
      if(isDriver)
      {
        object1.Window("Button", "USB Driver", 2).Click();
      }
      else
      {
        // do nothing
      }
      object1.Window("Button", "&Install", 3).ClickButton();
      var object2, object3;
      var WndClass2 = "MsiDialogCloseClass";
      var WndCaption2 = "USBCOMInstaller";
      var WndClass3 = "MsiDialogCloseClass";
      var WndCaption3 = "DL.CODE*";      
      while(!stop)
      {
        delay(500);
        object2 = GetObjectWindow(process, WndCaption2, WndClass2, 1);
        object3 = GetObjectWindow(process, WndCaption3, WndClass3, 1);
        if(object2.Exists == true)
        {
          stop = true;
        }
        if(object3.Exists == true)
        {
          stop = true;
          object2 = null;
          break;
        }
      }
      stop = false;
      if(object2 !=null)
      {
        object2.Window("Button", "&Next >", 1).ClickButton();
        while(!object2.WaitWindow("Button", "&Next >", 1).Exists) {}
        object2.Window("Button", "&Next >", 1).ClickButton();
        //delay(1500);
        while(!object2.WaitWindow("Button", "&Next >", 1).Exists) {}
        object2.Window("Button", "&Next >", 1).ClickButton();
        //delay(1500);
        while(!object2.WaitWindow("Button", "MsiRadioButtonGroup", 1).Window("Button", "I &Agree", 2).Exists) {}
        object2.Window("Button", "MsiRadioButtonGroup", 1).Window("Button", "I &Agree", 2).ClickButton();
        while(!object2.WaitWindow("Button", "&Next >", 4).Exists) {}
        object2.Window("Button", "&Next >", 4).ClickButton();
        while(!object2.WaitWindow("Button", "&Close", 1).Exists) {}
        object2.Window("Button", "&Close", 1).ClickButton();
        
        while(!stop)
        {
          object3 = GetObjectWindow(process, WndCaption3, WndClass3, 1);
          if(object3.Exists)
          {
            stop= true;
          }
        }
        while(!object3.WaitWindow("Button", "&Next", 1).Exists){}
        object3.Window("Button", "&Next", 1).ClickButton(); 
        object3.Window("Button", "I &accept the terms in the License Agreement", 1).Click(); 
        while(!object3.WaitWindow("Button", "&Next", 4).Exists){}
        object3.Window("Button", "&Next", 4).ClickButton();
        while(!object3.WaitWindow("Button", "&Next", 1).Exists){}
        object3.Window("Button", "&Next", 1).ClickButton();
        while(!object3.WaitWindow("Button", "&Install", 1).Exists){}
        object3.Window("Button", "&Install", 1).ClickButton();                        
      }
      else
      {
        while(!object3.WaitWindow("Button", "&Next", 1).Exists){}
        object3.Window("Button", "&Next", 1).ClickButton();         
        delay(1000);
        object3.Window("Button", "I &accept the terms in the License Agreement", 1).Click(); 
        while(!object3.WaitWindow("Button", "&Next", 4).Exists){}
        object3.Window("Button", "&Next", 4).ClickButton();
        while(!object3.WaitWindow("Button", "&Next", 1).Exists){}
        object3.Window("Button", "&Next", 1).ClickButton();
        object3.Window("Button", "&Install", 1).ClickButton();   
      }
      while(!object3.WaitWindow("Button", "&Finish", 1).Exists){}
      //delay(1000);
      object3.Window("Button", "&Finish", 1).ClickButton();
      while(!object1.WaitWindow("Button", "&Close", 17).Visible) {}
      //delay(1000);
      if(aqString.Contains(object1.Window("Static", "*", 27).Name,"successfully"))
      {
        Log.Checkpoint("Install with no problem");
      }
      object1.Window("Button", "&Close", 17).ClickButton();
      var flag = false;
      if ( aqFileSystem.Exists( pathPrgData + "\\" + build.guiVersion + "\\" + "DevicePackages") &&
             aqFileSystem.Exists( pathPrgData + "\\" + build.guiVersion + "\\" + "DeviceScripts") &&
             aqFileSystem.Exists( pathPrgData + "\\" + build.guiVersion + "\\" + "Documentation") &&
             aqFileSystem.Exists( pathPrgData + "\\" + build.guiVersion + "\\" + "Simulator") &&
             isExistPrg(build.guiVersion) != "")
             {
               if(isDriver)
               {
                 if(isExistPrg("USBCOMInstaller") != "")
                 {
                   flag = true;
                 }
                 else
                 {
                   flag = false;
                 }
               }
               else
               {
                 flag = true;
               }
             }
             
        Log.Message("Install GUI & drivers:" + flag); 
        
    }
  }
  
}
function installation  (Build , isDriver)
{       
        //if (isExistPrg(Build.guiVersion) != "")
        {
              Log.Message(Build.guiVersion + "  is installed");
              //return false;
        }
        var flag = false; 
        Indicator.PushText("Install");
        Indicator.PopText(); 
        NameMapping.Sys.Keys("[Hold][Win]r[Release]");
        explorer = Aliases.explorer;
        dlgRun = explorer.dlgRun;
        dlgRun.cbxOpen.SetText(Build.pathGUIsetup + "\\" + Build.versionBuild +"\\"  +  Build.exeBuild );
        dlgRun.btnOK.ClickButton();
        delay (3000);        
        // find all dlcode processs
        var arr = findProc("DL.CODE*");
        var check = false;
        var w1, w2;
        while(!check && arr.length !=0)  
        {
         for(var i = 0;i<arr.length;i++) 
         {
           var FullName = arr[i].FullName;
           var position = aqString.Find(FullName, ",")
           if(position == -1)
           {
             position = FullName.length - 15;
           }
           else
           {
             position = FullName.length - 13 - (FullName.length - position) - 1;
           }
           FullName = aqString.SubString(FullName,13, position );
           w1 = Sys.Process(FullName, arr[i].Index).Window("WixStdBA", "*", 1) ;
           if(w1.Exists)
          {
            check = true;
            break;            
          }
         }          
        }
        
        check= false;
        if (isDriver == true)
        {
          w1.Window("Button", "USB Driver", 2).Click();
          
        }
        w1.Window("Button", "&Install", 3).ClickButton();
        if (isDriver == true)
        {
          
          while(!check && arr.length !=0)  
          {
            arr = findProc("DL.CODE*");
          for(var i = 0;i<arr.length;i++) 
          {
               
           var FullName = arr[i].FullName;
           var position = aqString.Find(FullName, ",")
           if(position == -1)
           {
             position = FullName.length - 15;
           }
           else
           {
             position = FullName.length - 13 - (FullName.length - position) -1;
           }
           FullName = aqString.SubString(FullName,13, position);
           w2 = Sys.Process(FullName, arr[i].Index).Window("MsiDialogCloseClass", "USBCOMInstaller", 1);
           if(w2.Exists)
            {
              check = true;
              break;            
            }
          }          
          }
          check = false;
          w2.Window("Button", "&Next >", 1).ClickButton();
        }
        
        while (Sys.Process("DL.CODE*", 2).WaitWindow("WixStdBA", "*", 1, 1000).Exists == false)
               Delay(3000); 
        if (Sys.Process("DL.CODE*", 2).WaitWindow("WixStdBA", "*", 1, 1000).Exists)
        {   
                if (isDriver == true)
                {        Sys.Process("DL.CODE*", 2).Window("WixStdBA", "DL.CODE*", 1).Window("Button", "USB Driver", 2).Click();
                         delay (1000);
                }
                Sys.Process("DL.CODE*", 2).Window("WixStdBA", "DL.CODE*", 1).Window("Button", "&Install", 3).ClickButton();
                delay (1000);
        }
        if (isDriver == true)
        {
                while(Sys.Process("DL.CODE*").WaitWindow("MsiDialogCloseClass", "USBCOMInstaller", 1, 1000).Exists== false)
                {
                      delay (3000);
                }
                if(Sys.Process("DL.CODE*").WaitWindow("MsiDialogCloseClass", "USBCOMInstaller", 1, 1000).Exists)
                {
                      Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "USBCOMInstaller", 1).Window("Button", "&Next >", 1).ClickButton();
                      Delay(3000);
                      Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "USBCOMInstaller", 1).Window("Button", "&Next >", 1).ClickButton();
                      Delay(3000);
                      Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "USBCOMInstaller", 1).Window("Button", "&Next >", 1).ClickButton(); 
                      Delay(3000);
                      Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "USBCOMInstaller", 1).Window("Button", "MsiRadioButtonGroup", 1).Window("Button", "I &Agree", 2).ClickButton();
                      Delay(3000);
                      Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "USBCOMInstaller", 1).Window("Button", "&Next >", 4).ClickButton(); 
                      Delay(3000);
                      while ( Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "USBCOMInstaller", 1).Window("Button", "&Close", 1).Visible == false)
                             delay (3000);
                      if (Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "USBCOMInstaller", 1).Window("Button", "&Close", 1).Visible )
                             Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "USBCOMInstaller", 1).Window("Button", "&Close", 1).ClickButton();   
                 }
        } 
        while (Sys.Process("DL.CODE*").WaitWindow("MsiDialogCloseClass", "DL.CODE*", 1, 1000).Exists == false)    
               delay (3000);
        if (Sys.Process("DL.CODE*").WaitWindow("MsiDialogCloseClass", "DL.CODE*", 1, 1000).Exists)   
        {
              Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "DL.CODE*", 1).Window("Button", "&Next", 1).Click();            
              delay (3000);             
              Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "DL.CODE*", 1).Window("Button", "I &accept the terms in the License Agreement", 1).Click(); 
              delay (3000);               
              Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "DL.CODE*", 1).Window("Button", "&Next", 4).ClickButton();
              delay (3000);
              Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "DL.CODE*", 1).Window("Button", "&Next", 1).ClickButton();
              delay (3000);
              Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "DL.CODE*", 1).Window("Button", "&Install", 1).ClickButton();           
              delay (3000); 
              while (Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "*", 1).WaitWindow("Button", "&Finish", 1, 1000).Exists == false) 
              { 
                    Delay(3000);
              }                     
              var bttFinish = Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "*", 1).Window("Button", "&Finish", 1);
              while (bttFinish.Visible == false  || bttFinish.VisibleOnScreen == false ||  bttFinish.Enabled == false ) 
              Delay(3000); 
              if (Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "*", 1).Window("Button", "&Finish", 1).Visible == true  )  
                    Sys.Process("DL.CODE*").Window("MsiDialogCloseClass", "*", 1).Window("Button", "&Finish", 1).ClickButton(); 
              Delay(3000);          
              Sys.Process("DL.CODE*", 2).Window("WixStdBA", "*", 1).Window("Button", "&Close", 17).Click();    
               
        }      
        if ( aqFileSystem.Exists( pathPrgData + "\\" + Build.guiVersion + "\\" + "DevicePackages") &&
             aqFileSystem.Exists( pathPrgData + "\\" + Build.guiVersion + "\\" + "DeviceScripts") &&
             aqFileSystem.Exists( pathPrgData + "\\" + Build.guiVersion + "\\" + "Documentation") &&
             aqFileSystem.Exists( pathPrgData + "\\" + Build.guiVersion + "\\" + "Simulator")              )  
             flag = true;
        Log.Message("Install GUI & drivers:" + flag); 
        return flag;
}


function mainFunUnInstall ()
{
     
     //step 1: uninstall GUI
     unIstAllGUI();
     //step 2: delete folder
     delFolder();      
     //step3: uninstall driver
     unIstUSBCOMInstaller();
     unIstCdcecmInstaller(); 
     unIstUpgrade_x64();
     MicrosoftSercuritiesX64();
     //step 4: verify Total uninstall GUI &drivers:
     var flag =  verifyTotalUnInstall();
     Log.Message("Total uninstall GUI &drivers:" + flag);
     return flag; 
}


function delFolder ()
{
        var flag = true;        
        if ( aqFileSystem.Exists(pathPrgData))  
                flag = aqFileSystem.DeleteFolder(pathPrgData, true);
//              Log.Message("Del_1:"+  aqFileSystem.DeleteFolder(pathPrgData, true)); 
        if ( aqFileSystem.Exists(pathUsrConfig))          
                falg = aqFileSystem.DeleteFolder(pathUsrConfig, true);
//              Log.Message("Del_2:"+aqFileSystem.DeleteFolder(pathUsrConfig, true)); 
        return flag;
} 


/* 
    @function: unintall all DLCODE (1.7.0 & 1.8.0)
*/
function unIstAllGUI ()
{ 
   if (Sys.WaitProcess("DL.CODE",3000).Exists)
        lib_common.terminateUI();        
     
    //index of the first DL.CODE    
    var   index = "";
    index = isExistPrg("DL.CODE 1");    
    while  (index != "")
    {
          //click to uninstall 
          unIstGUI (index);
          //get index of other DL.CODE
          index = "";
          index = isExistPrg("DL.CODE 1");       
    }
}

/* 
    @function: unintall GUI by index and verify folder
    @return: true/false (failed)
*/
function unIstGUI (index)
{       
        var flag = false;
        launchControlPanel(); //lhoang comment
        Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Refresh();
        var ctrpnl = Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Window("ShellTabWindowClass", "Programs and Features", 1).Window("DUIViewWndClassName", "", 1).Window("DirectUIHWND", "", 1).Window("CtrlNotifySink", "", 1).Window("SHELLDLL_DefView", "ShellView", 1).Window("SysListView32", "FolderView", 1);
        var countItems = ctrpnl.SelectItem(index);
        var versionGUI  = countItems.wSelectedItems;
        Delay(1000);
        ctrpnl.DblClickItem(index, 0);
        Log.Message("uninstall DL.CODE");
        delay (3000);
        if (Sys.WaitProcess("DL.CODE*",3000).Exists)
        {
                if (Sys.Process("DL.CODE*", 2).WaitWindow("WixStdBA", "*",1, 1000).Exists)
                {
                        Sys.Process("DL.CODE*", 2).Window("WixStdBA", "*", 1).Window("Button", "&Uninstall ", 13).ClickButton(); 
               
                        delay (1000);
                        var bttClose = Sys.Process("DL.CODE*", 2).Window("WixStdBA", "*", 1).Window("Button", "&Close", 17) ;
                        var bttCancel =Sys.Process("DL.CODE*", 2).Window("WixStdBA", "*", 1).Window("Button", "&Cancel", 6);
                        while (bttClose.Visible == false || bttClose.VisibleOnScreen == false)
                        {
                              delay (3000);
                              Sys.Process("DL.CODE*", 2).Window("WixStdBA", "*", 1).Refresh();
                        }
                        if (bttClose.Visible == true && bttClose.VisibleOnScreen == true)
                               bttClose.ClickButton();  
                       
                        //verify folder on Program x86
                        if ( aqFileSystem.Exists(pathPrgFile + "\\" + versionGUI))  
                        {       
                              Log.Error("pls check  " + pathPrgFile) ;    
                              return flag;
                        }  
                        // verify folder Pogram Data 
                        if ( aqFileSystem.Exists(pathPrgData + "\\" + versionGUI + "\\" + "DevicePackages") ==false  &&
                             aqFileSystem.Exists(pathPrgData + "\\" + versionGUI + "\\" + "DeviceScripts")  ==false  && 
                             aqFileSystem.Exists(pathPrgData + "\\" + versionGUI + "\\" + "Documentation")  ==false  &&
                             aqFileSystem.Exists(pathPrgData + "\\" + versionGUI + "\\" + "Simulator")      ==false     )         
                            flag = true;
                        else Log.Error() ("pls check  " + pathPrgData)      ;
                                
                } 
        }
        ctrpnl.Refresh();  
        Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Close();
        return flag;
}

/*
    @function: unIstCdcecmInstaller 
*/
function unIstCom0Com ()
{
 
        //index of the first DL.CODE    
        var   index = "";
        index = isExistPrg("cdcecmInstaller");    
        if (index != "")
        { 
                Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Refresh();
                var ctrpnl = Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Window("ShellTabWindowClass", "Programs and Features", 1).Window("DUIViewWndClassName", "", 1).Window("DirectUIHWND", "", 1).Window("CtrlNotifySink", "", 1).Window("SHELLDLL_DefView", "ShellView", 1).Window("SysListView32", "FolderView", 1);
                var countItems = ctrpnl.SelectItem(index);
                Delay(1000);
                ctrpnl.DblClickItem(index, 0);
                delay (3000);         
                ctrpnl.Refresh();          
        }
}
/*
    @function: unIstUSBCOMInstaller 
*/
function unIstUSBCOMInstaller ()
{
 
        //index of the first DL.CODE    
        var   index = "";
        index = isExistPrg("USBCOMInstaller");    
        if (index != "")
        { 
                launchControlPanel();
                Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Refresh();
                var ctrpnl = Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Window("ShellTabWindowClass", "Programs and Features", 1).Window("DUIViewWndClassName", "", 1).Window("DirectUIHWND", "", 1).Window("CtrlNotifySink", "", 1).Window("SHELLDLL_DefView", "ShellView", 1).Window("SysListView32", "FolderView", 1);
                var countItems = ctrpnl.SelectItem(index);
                Log.Message(index);
                Delay(1000);
                ctrpnl.DblClickItem(index, 0);
                delay(1000);
                if(Sys.Process("explorer").WaitWindow("#32770", "Programs and Features", 1, 1000).Exists)
                {
                  Sys.Process("explorer").Window("#32770", "Programs and Features", 1).Window("DirectUIHWND", "", 1).Window("CtrlNotifySink", "", 7).Window("Button", "&Yes", 1).Click();
                }
                Log.Message("unIstUSBCOMInstaller");
                delay (3000);         
                ctrpnl.Refresh();    
                Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Close();      
        }
        
}

/*
    @function: unIstCdcecmInstaller 
*/
function unIstCdcecmInstaller ()
{
 
        //index of the first DL.CODE    
        var   index = "";
        index = isExistPrg("cdcecmInstaller");    
        if (index != "")
        { 
                launchControlPanel();
                Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Refresh();
                var ctrpnl = Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Window("ShellTabWindowClass", "Programs and Features", 1).Window("DUIViewWndClassName", "", 1).Window("DirectUIHWND", "", 1).Window("CtrlNotifySink", "", 1).Window("SHELLDLL_DefView", "ShellView", 1).Window("SysListView32", "FolderView", 1);
                var countItems = ctrpnl.SelectItem(index);
                Delay(1000);
                ctrpnl.DblClickItem(index, 0);
                
                delay(1000);
                if(Sys.Process("explorer").WaitWindow("#32770", "Programs and Features", 1, 1000).Exists)
                {
                  Sys.Process("explorer").Window("#32770", "Programs and Features", 1).Window("DirectUIHWND", "", 1).Window("CtrlNotifySink", "", 7).Window("Button", "&Yes", 1).Click();                  
                }
                
                Log.Message("unIstCdcecmInstaller");
                delay (3000);         
                ctrpnl.Refresh();     
                Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Close();     
        }
}

function unIstUpgrade_x64 ()
{
 
        //index of the first DL.CODE    
        var   index = "";
        index = isExistPrg("upgrade_x64");    
        if (index != "")
        { 
                launchControlPanel();
                Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Refresh();
                var ctrpnl = Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Window("ShellTabWindowClass", "Programs and Features", 1).Window("DUIViewWndClassName", "", 1).Window("DirectUIHWND", "", 1).Window("CtrlNotifySink", "", 1).Window("SHELLDLL_DefView", "ShellView", 1).Window("SysListView32", "FolderView", 1);
                var countItems = ctrpnl.SelectItem(index);
                Delay(1000);
                ctrpnl.DblClickItem(index, 0);
                Delay(2000);
                Sys.Process("upgrade_x64", 2).Window("WixStdBA", "upgrade_x64 Setup", 1).Window("Button", "&Uninstall", 15).ClickButton();
                delay (5000); 
                Sys.Process("upgrade_x64", 2).Window("WixStdBA", "upgrade_x64 Setup", 1).Window("Button", "&Close", 19).Click();
                Log.Message("upgrade_x64");
                delay (3000);         
                ctrpnl.Refresh();     
                Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Close();     
        }
}

function MicrosoftSercuritiesX64 ()
{
 
        //index of the first DL.CODE    
        var   index = "";
        index = isExistPrg("DL.CODE MicrosoftSecurityUpdates x64");    
        if (index != "")
        { 
                launchControlPanel();
                Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Refresh();
                var ctrpnl = Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Window("ShellTabWindowClass", "Programs and Features", 1).Window("DUIViewWndClassName", "", 1).Window("DirectUIHWND", "", 1).Window("CtrlNotifySink", "", 1).Window("SHELLDLL_DefView", "ShellView", 1).Window("SysListView32", "FolderView", 1);
                var countItems = ctrpnl.SelectItem(index);
                Delay(1000);
                ctrpnl.DblClickItem(index, 0);
                Delay(2000);
                Sys.Process("DL.CODE_MicrosoftSecurityUpdates_x64", 2).Window("WixStdBA", "DL.CODE MicrosoftSecurityUpdates x64 Setup", 1).Window("Button", "&Uninstall", 15).ClickButton();
                delay (5000); 
                Sys.Process("DL.CODE_MicrosoftSecurityUpdates_x64", 2).Window("WixStdBA", "DL.CODE MicrosoftSecurityUpdates x64 Setup", 1).Window("Button", "&Close", 19).ClickButton();
                Log.Message("upgrade_x64");
                delay (3000);         
                ctrpnl.Refresh();     
                Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Close();     
        }
}
/*
    @function: verify Ctlpnl and drivers  
    @return: true (uninstall succeesful)/ false
*/
function verifyTotalUnInstall()
{

    var flag = true;  
    //verify control panel
    launchControlPanel();
    var ctrpnl = Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Window("ShellTabWindowClass", "Programs and Features", 1).Window("DUIViewWndClassName", "", 1).Window("DirectUIHWND", "", 1).Window("CtrlNotifySink", "", 1).Window("SHELLDLL_DefView", "ShellView", 1).Window("SysListView32", "FolderView", 1);
    var countItems = ctrpnl.wItemCount;
    for (var i = 0; i < countItems - 1; i ++ )
    { 
         ctrpnl.SelectItem(i);
         //verify ctrlpnl list has DL.CODE  and drivers
         if ( aqString.Contains(ctrpnl.wSelectedItems, "cdcecmInstaller" , 0, true) != -1 ||
              aqString.Contains(ctrpnl.wSelectedItems, "USBCOMInstaller" , 0, true) != -1 ||
              aqString.Contains(ctrpnl.wSelectedItems, "DL.CODE" , 0, true) != -1  )
         {
             flag = false;
         }      
     }
     //verify folder on prgFile & prfData
     if ( aqFileSystem.Exists(pathPrgData))  
            flag = false;
     if ( aqFileSystem.Exists(pathUsrConfig))  
            flag = false;
     Log.Message("Uninstall GUI and drivers:"+  flag);
     Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Close();
     return flag; 
}

 

/*
    @funtion: return the selectedItem index of prgName on Ctrlpnl
    @prgName: Name of application
    @return: "" if not exists/ index(Interger)
*/
function isExistPrg (prgName)
{
        var index = ""; 
        launchControlPanel(); 
        var ctrpnl = Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Window("ShellTabWindowClass", "Programs and Features", 1).Window("DUIViewWndClassName", "", 1).Window("DirectUIHWND", "", 1).Window("CtrlNotifySink", "", 1).Window("SHELLDLL_DefView", "ShellView", 1).Window("SysListView32", "FolderView", 1);
        var countItems = ctrpnl.wItemCount;
        for (var i = 0; i < countItems; i ++ )
        { 
             ctrpnl.SelectItem(i);
             if ( aqString.Contains(ctrpnl.wSelectedItems, prgName , 0, true) != -1  )
             { 
             
               Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Close(); //lhoang commented
               return i;
             }      
         }
        Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Close();                
        return index;
}
/*
     @function: to launch Control Panel
*/
function launchControlPanel_old ()
{
        Indicator.PushText("Launch ControlPanel");
        Indicator.PopText(); 
        //cmd is opening
        if(Sys.WaitProcess("cmd",1000).Exists)  
               Sys.Process("cmd").Window("ConsoleWindowClass", "Administrator: C:\\Windows\\system32\\cmd.exe", 1).SetFocus();
        else
        {     // launch new cmd
              TestedApps.Items(3).Run(); 
              delay (lib_const.const_delay_3000);
              Sys.Process("cmd").Window("ConsoleWindowClass", "Administrator: C:\\Windows\\system32\\cmd.exe", 1).SetFocus();
        }
        if(Sys.WaitProcess("cmd",1000).Exists) 
        {
              //launch CtlPl from cmd
              var wndConsoleWindowClass; 
              wndConsoleWindowClass = Sys.Process("cmd").Window("ConsoleWindowClass", "Administrator: C:\\Windows\\system32\\cmd.exe", 1);        
              wndConsoleWindowClass.Keys("control c[Enter]"); 
              delay (3000);
              while (Sys.Process("explorer").WaitWindow("CabinetWClass", "Programs and Features", 1,1000).Exists == false)
                   Delay(3000);
        } 
 
}


function launchControlPanel()
{ 
if(Sys.Process("explorer").WaitWindow("CabinetWClass", "Programs and Features", 1, 1000).Exists)
{
  Sys.Process("explorer").Window("CabinetWClass", "Programs and Features", 1).Close();
}
              NameMapping.Sys.Keys("[Hold][Win]r[Release]");
              explorer = Aliases.explorer;
              dlgRun = explorer.dlgRun;
              dlgRun.cbxOpen.SetText("appwiz.cpl");
              dlgRun.btnOK.ClickButton();
              //delay (3000);
              
              while (Sys.Process("explorer").WaitWindow("CabinetWClass", "Programs and Features", 1,1000).Exists == false)
                  delay(3000);

}



var LatestBuildSW_Version          = "";
var SWLastOfficialBuild_SW_Version= "";
var LatestLoader                  = "";
var LastOfficialLoader            = "";
var LatestGUI                     = "";
var LastOfficicalGUI              = "";
var PathBuilds                    = "";
var ProgramData                   = "";
var ProgramFile                   = "";
var UserConfig                    = "";
var Ccleaner                      = "";
function ReadDataFromExcel()
 {
  var Excel = Sys.OleObject("Excel.Application");
//  Excel.Workbooks.Open("C:\\Users\\" + Sys.UserName + "\\Desktop\\ConfigTestCompleteAuto.xlsx");
   Excel.Workbooks.Open( lib_deviceInfo.const_fileNameJob_Path + "\\ConfigTestCompleteAuto.xlsx");
 
  var RowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
  var ColumnCount = Excel.ActiveSheet.UsedRange.Columns.Count;
  var s = new Array();
  for (var i = 1; i <= RowCount; i++)
  {
    
    s[i]= (VarToString(Excel.Cells.Item(i, 2)));
    Log.Message(s[i]);
  }

  LatestBuildSW_Version          = s[1];
  SWLastOfficialBuild_SW_Version = s[2];
  LatestLoader                   = s[3];
  LastOfficialLoader             = s[4];
  LatestGUI                      = s[5];
  LastOfficicalGUI               = s[6];
  PathBuilds                     = s[7];
  //PathBuilds = aqFileSystem.ExcludeTrailingBackSlash(PathBuilds);
  //PathBuilds = aqFileSystem.GetFileFolder(PathBuilds)  ;
  //PathBuilds = PathBuilds + "GUI_Package";
  ProgramData                    = s[8];
  ProgramFile                    = s[9];
  UserConfig                     = s[10];
  Ccleaner                       = s[11];
  //initLatestBuildInformation();
  Excel.Quit();
 }
 
function initLatestBuildInformation()
{
      if(LatestBuildSW_Version == "")
      {
        ReadDataFromExcel();
      }      
      var Build = new Object();
      var prefix = aqString.SubString(LatestBuildSW_Version, 0, 3);
      var prefix2 = aqString.SubString(LatestBuildSW_Version, 0, 5);
      var suffix = "";
      for(var i = LatestGUI.length -1; i > -1;i--)
      {
        if(LatestGUI[i] == "\r")
        {
          LatestGUI = aqString.Remove(LatestGUI, i, 1);
        }
        if(LatestGUI[i] == "\n")
        {
          LatestGUI = aqString.Remove(LatestGUI, i, 1);
        }
        if(LatestGUI[i] == ".")
        {
          suffix = aqString.Insert(LatestGUI, "-", i);
          suffix = aqString.Remove(suffix, i+1, 1);
          break;
        }
      }
      suffix = aqString.Replace(suffix, ".", "_");
      suffix = aqString.Replace(suffix, " ", "_");
      //Build.pathGUIsetup =  PathBuilds + "\\" + "IVS UI " + prefix + "\\" + "DL.CODE " + prefix2 + "\\" + suffix ;
      spath = PathBuilds + "\\" + "IVS UI " + prefix + "\\" + "DL.CODE " + prefix2 + "\\";
      var pattern = "*" + suffix + "*";
      Log.Message(suffix);
      var foundFolders, aFolder;
      foundFolders = aqFileSystem.FindFolders("D:\\Builds\\tags\\release\\IVS UI 1.8\\DL.CODE 1.8.2",pattern);
      
      if (foundFolders != null)
      {
        while (foundFolders.HasNext())
        {
          aFolder = foundFolders.Next();
          Build.pathGUIsetup = aFolder.Path;
        }
      }
      else
      {
        Log.Error("No folders were found.");
      }
    
    
      Build.versionBuild = LatestBuildSW_Version;
      Build.guiVersion = "DL.CODE " + aqString.SubString(LatestBuildSW_Version, 0, 5);
      Build.exeBuild = Build.guiVersion + "_Setup.exe";
      Log.Message(Build.pathGUIsetup);
      Log.Message(Build.versionBuild);
      Log.Message(Build.guiVersion);
      Log.Message(Build.exeBuild);
      return  Build; 
}
function initLastOfficialBuildInformation()
{
      if(LatestBuildSW_Version == "")
      {
        ReadDataFromExcel();
      }      
      var Build = new Object();
      var prefix = aqString.SubString(SWLastOfficialBuild_SW_Version, 0, 3);
      var prefix2 = aqString.SubString(SWLastOfficialBuild_SW_Version, 0, 5);
      var suffix = "";
      for(var i = LastOfficicalGUI.length -1; i > -1;i--)
      {
        if(LastOfficicalGUI[i] == "\r")
        {
          LastOfficicalGUI = aqString.Remove(LastOfficicalGUI, i, 1);
        }
        if(LastOfficicalGUI[i] == "\n")
        {
          LastOfficicalGUI = aqString.Remove(LastOfficicalGUI, i, 1);
        }
        if(LastOfficicalGUI[i] == ".")
        {
          suffix = aqString.Insert(LastOfficicalGUI, "-", i);
          suffix = aqString.Remove(suffix, i+1, 1);
          break;
        }
      }
      suffix = aqString.Replace(suffix, ".", "_");
      suffix = aqString.Replace(suffix, " ", "_");
      //Build.pathGUIsetup =  PathBuilds + "\\" + "IVS UI " + prefix + "\\" + "DL.CODE " + prefix2 + "\\" + suffix ;
      spath = PathBuilds + "\\" + "IVS UI " + prefix + "\\" + "DL.CODE " + prefix2 + "\\";
      var pattern = "*" + suffix + "*";
      Log.Message(suffix);
      var foundFolders, aFolder;
      foundFolders = aqFileSystem.FindFolders(spath,pattern);
      
      if (foundFolders != null)
      {
        while (foundFolders.HasNext())
        {
          aFolder = foundFolders.Next();
          Build.pathGUIsetup = aFolder.Path;
        }
      }
      else
      {
        Log.Error("No folders were found.");
      }
    
    
      Build.versionBuild = SWLastOfficialBuild_SW_Version;
      Build.guiVersion = "DL.CODE " + aqString.SubString(SWLastOfficialBuild_SW_Version, 0, 5);
      Build.exeBuild = Build.guiVersion + "_Setup.exe";
      Log.Message(Build.pathGUIsetup);
      Log.Message(Build.versionBuild);
      Log.Message(Build.guiVersion);
      Log.Message(Build.exeBuild);
      return  Build; 
    
}