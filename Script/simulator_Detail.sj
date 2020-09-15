//USEUNIT lib_CodeSetup
//USEUNIT lib_common
//USEUNIT lib_connection
//USEUNIT lib_const
//USEUNIT lib_DeleteJob
//USEUNIT lib_deviceInfo
//USEUNIT lib_ImageSetup
//USEUNIT lib_OpenJob
//USEUNIT lib_SaveIMG
//USEUNIT lib_validate
//USEUNIT lib_button
//USEUNIT setupInternalNetwork
//USEUNIT simulator_common
//USEUNIT lib_ReadingPhase
  
/*
  add new from 1.9.0 B1 for commanline TC
*/

function simulator_M320 ()
{
  aqTestCase.Begin("simulator_M320");
  simulatorDetail(11);
  aqTestCase.End(); 
}

function simulator_M120()
{
  aqTestCase.Begin("simulator_M120");
  simulatorDetail (0);
  aqTestCase.End();
}

function simulator_M210N()
{
  aqTestCase.Begin("simulator_M210N");
  simulatorDetail(1);
  aqTestCase.End();
  
}

function simulator_M220_POE()
{
  aqTestCase.Begin("simulator_M220_POE");
  //M220 POE
  simulatorDetail(7) ;
  aqTestCase.End();
}

function simulator_M220_DPM()
{
   aqTestCase.Begin("simulator_M220_DPM");
   //M220 DPM 
   simulatorDetail (8);  
   aqTestCase.End();
}


function simulator_M300N()
{
  aqTestCase.Begin("simulator_M300N");
  simulatorDetail(2); 
  aqTestCase.End();
}
 
function simulator_M300N_712_010()
{   
  aqTestCase.Begin("simulator_M300N_712_010");
  simulatorDetail(10);
  aqTestCase.End(); 
}
 
function simulator_M300N_772_010()
{   
  aqTestCase.Begin("simulator_M300N_772_010");
  simulatorDetail(9);
  aqTestCase.End(); 
}

function simulator_M410N()
{
  
  aqTestCase.Begin("simulator_M410N");
  //M410 500
  simulatorDetail (3); 
  aqTestCase.End(); 
  
}
function simulator_M410_2MP()
{ 
  aqTestCase.Begin("simulator_M410_2MP");
  //M410 700
  simulatorDetail (4);  
  aqTestCase.End(); 
}
function simulator_XRF()
{   
  aqTestCase.Begin("simulator_XRF");
  //M410 XRF
  simulatorDetail (5);
  aqTestCase.End();  
}

function simulator_M450N()
{
  aqTestCase.Begin("simulator_M450N");
  simulatorDetail (6);
  aqTestCase.End();
}

/*add new 1.6.0 RC02*/ 
/**
  *@function
*/
function verifyM220_LedGroup (index)
{
       try
       {
                Log.AppendFolder("verifyM220_LedGroup") ;  
                var arr_Device  = lib_deviceInfo.const_Simulator_Device;
                var arr_Model   = lib_deviceInfo.const_Simulator_Model;
                var arr_Model_Detail   = lib_deviceInfo.const_Simulator_Model_Detail;    
                // only for 2 devices M220 
                 Log.Message( "**verifyM220_LedGroup********************************************");
                 Log.Message(arr_Device[index] + "-" + arr_Model[index] );                  
                 var flag = simulator_common.connectToSimulator(arr_Device[index] , arr_Model[index]);
                 if (flag == lib_err.err_FUNC_SUCCESS)
                 {
                          //open job               
                          if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                          { 
                                 if (arr_Model[index] == "355-040")
                                       verify_M220_NonPolarized();
                                 if (arr_Model[index] == "382-010") 
                                       verify_M220_Polarized();
                          }
                 }                
                Log.PopLogFolder();
                //lib_common.terminateUI();
      }catch (e)
      {
        return lib_err.err_FUNC_EXCEPTION;
      } 
}


function simulatorDetail(index)
{

               Log.AppendFolder("func: verifyStandaloneSimulators");                 
               lib_common.launchUI();  
               var arr_Device  = lib_deviceInfo.const_Simulator_Device;
               var arr_Model   = lib_deviceInfo.const_Simulator_Model;
               var arr_Model_Detail   = lib_deviceInfo.const_Simulator_Model_Detail;    
               Log.Message ("Step 1:delete and create folder contain image ");
               //delete and create folder contain image 
               lib_connection.Deleting_AddingFolder (lib_deviceInfo.const_fileName_SaveIMG); 
               //verify LED group if device = M220
               if (arr_Device == "M220")
                          verifyM220_LedGroup(index);
               verifySimulators(arr_Device, arr_Model, arr_Model_Detail, index);
               setupInternalNetwork.testSuite_659_SimulatorSetupInternalNetwork (index);
               
}

function simulatorAddFielbus(index)
{

               Log.AppendFolder("func: verifyStandaloneSimulators");                 
               lib_common.launchUI();  
               var arr_Device  = lib_deviceInfo.const_Simulator_Device;
               var arr_Model   = lib_deviceInfo.const_Simulator_Model;
               var arr_Model_Detail   = lib_deviceInfo.const_Simulator_Model_Detail;    
              Log.Message(arr_Device[index] + "-" + arr_Model[index] );
               
                
               //verify Standalone device
               Log.Message( "*******Step 3: open - save - delete - save IMG & verify-------------------");
               var flag = connectToSimulator(arr_Device[index] , arr_Model[index]);
               
               var arr_place = [  lib_const.const_ReadingPhase_Channel  , lib_const.const_DataFormatting_Channel , lib_const.const_OutputSetup_Channel ] ;
               var arr_fb;
   
               if (flag == lib_err.err_FUNC_SUCCESS)
               {
                        //open job               
                        if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
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
}

function testAddFB ()
{
        for (var i = 10; i >= 0 ; i--)
         simulatorAddFielbus (i);

}

   
/**
  *@function
*/
function verifySimulators(arr_Device, arr_Model, arr_Model_Detail, index)
{
       try
       {              
               Log.Message(arr_Device[index] + "-" + arr_Model[index] );
               
               //verify icon toolbar
               Log.Message("******* Step 2: verify Icon Toolbar **********************************************");                 
               simulator_IconToolbar (arr_Device[index] , arr_Model[index], false );
               //verify Standalone device
               Log.Message( "*******Step 3: open - save - delete - save IMG & verify-------------------");
               var flag = connectToSimulator(arr_Device[index] , arr_Model[index]);
               if (flag == lib_err.err_FUNC_SUCCESS)
               {
                        //open job               
                        if (lib_OpenJob.openOnDevice(lib_const.const_DefaultJob, lib_const.const_isDefaultJob_Y,lib_const.const_isOpenViaButton_Y))
                        { 
                              //save IMG & verify resolution                          
                              lib_SaveIMG.saveCurrentIMG (lib_deviceInfo.const_fileName_SaveIMG, arr_Model_Detail[index],arr_Device[index] , arr_Model[index]); 
                              clickAdvancedSetup();
                              var treeViewItemCodes = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", lib_deviceInfo.const_firmware).WPFObject("Shell", lib_deviceInfo.const_firmware, 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("TabControl", "", 1).WPFObject("Grid", "", 1).WPFObject("AbstractTaskTreeControl").WPFObject("TreeViewItem", "", 3).WPFObject("TreeViewItem", "", 1);
                              var childCount = treeViewItemCodes.ChildCount;
                              var resultAddFilter = lib_button.clickAddFilter(childCount - 1);
                              Log.Message(resultAddFilter); 
                              lib_button.clickEnableCroppingRegion(true);  
                              simlulator_addDelete_AllCode2D ();                                                                      
                              var flagSaveJob = lib_SaveJob.saveOnDevice(lib_const.const_typeSaveOnDevice_N,  arr_Model_Detail[i], lib_const.const_isDefaultJob_Y, lib_const.isMonitorMode_N)
                              lib_button.clickIVSMonitorButton();
                              lib_button.ui_PlayAndPause(6000, true);
                              lib_button.clickIVSMonitorButton();                                        
                              lib_button.clickRemoveCroppingRegion(true);  
                              Log.Message(lib_DeleteJob.deleteOnDevice( arr_Model_Detail[index]));  
                        }
               }
 
                Log.PopLogFolder();
      }catch (e)
      {
        return lib_err.err_FUNC_EXCEPTION;
      } 
}

  

 