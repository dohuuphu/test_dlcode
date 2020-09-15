//USEUNIT lib_common
//USEUNIT lib_const
//USEUNIT lib_deviceInfo
//USEUNIT lib_label
//USEUNIT lib_messageLog
//USEUNIT lib_OpenJob
//USEUNIT lib_deviceInfo

//****enviroment function: open job and control device 

/*
  *@function 
  *use Objects checkpoint
*/
function webMonitorSecuritySettings ()
{

   if ( ! lib_validate.isDLCODERunning())
          lib_common.launchUI();  
   try
   {           
           var device = lib_deviceInfo.const_Device_Model;
           var ip = lib_deviceInfo.const_Device_IP_Adress;           
 
           gettingStarted();
           Sys.Process("DL.CODE").Refresh(); 
        
           if (lib_common.connectToDevice(ip))
           {   
               //*************************************************************************************************************************
               //: CONNECTING_DEVICE
               Log.Message(lib_messageLog.msg_CONNECTING_DEVICE);                
               if (lib_OpenJob.openOnDevice( lib_const.const_DefaultJob,lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y) == false)
                       return ;
               var IvsMenu =Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu");               
               IvsMenu.WPFMenu.Click(lib_label.const_lb_Device + "|" +  lib_label.const_lb_Settings  + "|" +  lib_label.const_lb_WebMonitorSecuritySettings);    
               //check maim menu                  
               // check content expander
               if (!Sys.Process("DL.CODE").WaitWPFObject("HwndSource: PopupWindow",lib_const.const_delay_1000).Exists)
                        return;
               
               //linhtnguyen comment
               var path = Sys.Process("DL.CODE").WPFObject("HwndSource: PopupWindow").WPFObject("PopupWindow").WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("StackPanel", "", 1).WPFObject("ContentExpander", "Web Monitor Settings", 1);
               // verify labels  -- linhtnguyen updated     
               Objects.Text_EnableProtection.Check(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "Enable Protection", 1));
               Objects.Text_Username.Check(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("TextBlock", "Username", 1));
               Objects.Text_Password.Check(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 3).WPFObject("TextBlock", "Password", 1));
               Objects.Text_PasswordMustContainBetween8And32C.Check(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 4).WPFObject("TextBlock", "Password must contain between 8 and 32 characters, at least one uppercase letter, one lowercase letter and one number.", 1));
               Objects.Text_ConfirmPassword.Check(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 5).WPFObject("TextBlock", "Confirm Password", 1));
               
               
               Objects.cbEnableProtection.Check(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("CheckBox", "", 1));
               Objects.TxtUsername.Check(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 2).WPFObject("TxtUsername"));
               Objects.TxtPasswordBox.Check(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 3).WPFObject("TxtPasswordBox"));
               Objects.TxtConfirmPasswordBox.Check(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 5).WPFObject("TxtConfirmPasswordBox")); 
               
               //giang.ha 20200304
               if (existOPCUA (device) == false)
               {
                     Objects.ButtonCancel.Check(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 6).WPFObject("Button", "Cancel", 1));
                     Objects.ButtonOk.Check(path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 6).WPFObject("buttonOK"));   
                     path.WPFObject("Grid", "", 1).WPFObject("Grid", "", 6).WPFObject("Button", "Cancel", 1).ClickButton();
                 
               }else               
               {
                   Log.Message("M220/320 device : OPCA");
                   //OPC UA Settings
                   var proTxtBlockArr = ["WPFControlText", "ClrClassName", "Enabled" ];
                   var valTxtBlockArr = ["OPC UA Settings" , "TextBlock"  ,true ];   
                   var label = Sys.Process("DL.CODE").FindChild(proTxtBlockArr, valTxtBlockArr, 100);
                   if (label.Exists)
                   {
                          aqObject.CheckProperty( label, "WPFControlText", cmpEqual, "OPC UA Settings");
                          aqObject.CheckProperty( label, "Enabled",        cmpEqual,true);
                   }else Log.Warning("cannot found this control");
                   
                   var proArr = ["WPFControlText", "ClrClassName" ];
                   var valArr = ["OPC UA Settings" , "ContentExpander"   ];                   
                   var opcUAExp = Sys.Process("DL.CODE").FindChild(proArr, valArr,100);
                   if (opcUAExp.Exists)
                   {
                         if (opcUAExp.IsExpanded == false)
                             opcUAExp.set_IsExpanded(true);
                         
                          var parents = opcUAExp.Parent;
                         aqObject.CheckProperty(parents.FindChild ("WPFControlText", "Enable Protection",100 ), "Enabled", cmpEqual, true);
                         var proChkbox = ["ClrClassName" , "IsChecked" , "IsEnabled" ];
                         var valChkbox = ["CheckBox" , true, true];
                         var chkBox =  Sys.Process("DL.CODE").FindChild(proChkbox, valChkbox,100);
                         if (chkBox.Exists)
                         {
                               aqObject.CheckProperty(chkBox, "Enabled", cmpEqual, true);
                               aqObject.CheckProperty(chkBox, "IsChecked", cmpEqual, true); 
                         }else Log.Warning("cannot found this control");
                         //username
                         aqObject.CheckProperty(parents.FindChild ("WPFControlText", "Username" ,100 ), "Enabled", cmpEqual, true);
                         var proUserTxt = ["WPFControlName" ,   "IsEnabled" ];
                         var valUserTxt = ["OPCUAUsername" ,  true ];
                         var userTxt =  Sys.Process("DL.CODE").FindChild(proUserTxt, valUserTxt,100);
                         if (userTxt.Exists)
                         {  
                               aqObject.CheckProperty(userTxt, "WPFControlName", cmpEqual, "OPCUAUsername");
                               aqObject.CheckProperty(userTxt, "IsEnabled", cmpEqual, true); 

                         } else Log.Warning("cannot found this control");  
                     
                         //password
                         aqObject.CheckProperty(parents.FindChild ("WPFControlText", "Password" ,100 ), "Enabled", cmpEqual, true);
                         var proPassTxt = ["WPFControlName" ,   "Enabled"    ];
                         var valPassTxt = ["OPCUAPasswordBox" ,  true   ];
                         var passTxt =  Sys.Process("DL.CODE").FindChild(proPassTxt, valPassTxt,100);
                         if (passTxt.Exists)
                         {          
                               aqObject.CheckProperty(passTxt, "WPFControlName", cmpEqual, "OPCUAPasswordBox");
                               aqObject.CheckProperty(passTxt, "IsEnabled", cmpEqual, true); 
                           
                               if (passTxt.DataContext.ConfirmPasswordToolTip != "Please confirm Password")
                                        Log.Error(userTxt.DataContext.ConfirmPasswordToolTip );
                         }else Log.Warning("cannot found this control");
                     
                          //confirm Password 
                         aqObject.CheckProperty(parents.FindChild ("WPFControlText", "Confirm Password",100  ), "Enabled", cmpEqual, true);
                         var proConfirmPassTxt = ["WPFControlName" ,   "Enabled"  ];
                         var valConfirmPassTxt = ["OPCUAConfirmPasswordBox" ,  true ];
                         var confirmPassTxt =  Sys.Process("DL.CODE").FindChild(proConfirmPassTxt, valConfirmPassTxt,100);
                         if (confirmPassTxt.Exists)
                         {          
                               aqObject.CheckProperty(confirmPassTxt, "WPFControlName", cmpEqual, "OPCUAConfirmPasswordBox");
                               aqObject.CheckProperty(confirmPassTxt, "IsEnabled", cmpEqual, true); 
                           
                               if (confirmPassTxt.DataContext.ConfirmPasswordToolTip != "Please confirm Password")
                                        Log.Error(userTxt.DataContext.ConfirmPasswordToolTip );
                         } else Log.Warning("cannot found this control");
                         //apply button
                         var proApplyBtt = ["WPFControlName" , "ClrClassName", "Enabled"  ];
                         var valApplyBtt = ["OPCUAbuttonOK" ,  "Button" ,false ];
                         var applyBtt =  Sys.Process("DL.CODE").FindChild(proApplyBtt, valApplyBtt,100);
                         if (applyBtt.Exists)
                         {  
                               aqObject.CheckProperty(applyBtt, "WPFControlName", cmpEqual, "OPCUAbuttonOK");
                               aqObject.CheckProperty(applyBtt, "ClrClassName", cmpEqual, "Button"); 
                               aqObject.CheckProperty(applyBtt, "Enabled", cmpEqual,  false); 
                         }else Log.Warning("cannot found this control");
                     
                         aqObject.CheckProperty(parents.FindChild ("WPFControlText", "Password must contain between 8 and 32 characters, at least one uppercase letter, one lowercase letter and one number." ,100 ), "Enabled", cmpEqual, true);
                     
                       }else Log.Warning("cannot found this control");
                       
                       
                       //SFTP Client Settings
                       
                       
                       proTxtBlockArr = ["WPFControlText", "ClrClassName", "Enabled" ];
                       valTxtBlockArr = ["SFTP Client Settings" , "TextBlock"  ,true ];   
                       label = Sys.Process("DL.CODE").FindChild(proTxtBlockArr, valTxtBlockArr, 100);
                       if (label.Exists)
                       {
                              aqObject.CheckProperty( label, "WPFControlText", cmpEqual, "SFTP Client Settings");
                              aqObject.CheckProperty( label, "Enabled",        cmpEqual,true);
                       }else Log.Warning("cannot found this control");
                       var proSFTPArr = ["WPFControlText", "ClrClassName" ];
                       var valSFTPArr = ["SFTP Client Settings" , "ContentExpander"   ];
                   
                       var sFTPExp = Sys.Process("DL.CODE").FindChild(proSFTPArr, valSFTPArr,100);
                       if (sFTPExp.Exists)
                       { 
                           
                               if (sFTPExp.IsExpanded == false)
                                   sFTPExp.set_IsExpanded(true);
                               parents = sFTPExp.Parent;
                               
                               var bttProArr = ["WPFControlText", "Enabled", "ClrClassName"];
                               var bttValArr = ["Generate Public and Private Keys", true, "Button"];
                               var btt = parents.FindChild(bttProArr, bttValArr, 100);
                               if (btt.Exists)
                               {
                                    aqObject.CheckProperty(btt, "WPFControlText", cmpEqual, "Generate Public and Private Keys");
                                    aqObject.CheckProperty(btt, "Enabled", cmpEqual, true);
                                    aqObject.CheckProperty(btt, "ClrClassName", cmpEqual, "Button");
                               }else Log.Warning("cannot found this control");
                     
                   } else Log.Warning("cannot found this control");
                   //////////////////////////////////////////////////////////////////////  
                   Sys.Process("DL.CODE").WPFObject("HwndSource: PopupWindow").WPFObject("PopupWindow").WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Close", 1).ClickButton();
               }  
           } 
   }
   catch (e)
   {
     Log["Warning"](lib_err.err_FUNC_EXCEPTION);
   }     
 }
  