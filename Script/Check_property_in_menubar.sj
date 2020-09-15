//function check()
//{
//		app = Sys.Process("DL.CODE");
//		/*prop = "DL_CODE.WPFObject("HwndSource: Shell", "DL.CODE 1.9.0.60").WPFObject("Shell", "DL.CODE 1.9.0.60", 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu").WPFObject("MenuItem", "Device", 3)";*/
//		if (aqObject.CheckProperty(DL_CODE.WPFObject("HwndSource: Shell", "DL.CODE 1.9.0.60").WPFObject("Shell", "DL.CODE 1.9.0.60", 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("Grid", "", 1).WPFObject("IvsMenu").WPFObject("MenuItem", "Device", 3),))
//			 Log.Message("niceee");
//       }

function GettingPropertyValue()
{

  // Launches notepad.exe with the C:\Hello.txt command line parameter
  //WshShell.Run("notepad.exe", SW_NORMAL);
  
  // Specifies an object that corresponds
  // to notepad's window
  var wndNotepad = Sys.Process("notepad").Window("Notepad", "abc.txt - Notepad", 1)
  var Obj = wndNotepad.Window("Edit", "", 1);
  
  var PropValue = aqObject.GetPropertyValue(Obj, "wText");
  
  // Posts the value of the specified property to the test log
  Log.Message(PropValue);
   
  // Closes notepad's window
  aqObject.CallMethod(wndNotepad, "Close");
  
}