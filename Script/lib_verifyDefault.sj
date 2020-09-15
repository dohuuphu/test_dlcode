//USEUNIT lib_ImageSetup
function verifyDefaultJob ()
{

      var flag = true;
      if (lib_ImageSetup.get_numberIMGSetting() != 1)
            flag = false;
            
      Log.Message(   " verifyDefaultJob : " + flag);
      
}
