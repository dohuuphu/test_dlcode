//USEUNIT lib_button
//USEUNIT lib_const
//USEUNIT lib_DeleteJob

/*
  *@function
  *@param jobList1{Array}
  *@param jobList2{Array} 
*/
function compare2JobList ( jobList1, jobList2)
{
        var flag  = true;
        if (jobList1.length != jobList2.length)
        {       
                Log.Message( "compare2JobList_length: fail ");
                flag = false;
                return flag;
        }else
        {
                 for (var i = 0; i < jobList1;  i ++)
                {
                       if ( jobList1[i] != jobList2[i])
                       {
                                Log.Message( "compare2JobList_name: fail ");
                                flag = false;
                                return flag;
                       }
                }
          }
          return flag;
} 
  
//update 1.5.0
/*
  *@function 
*/
function getJobList ()
{
        var array = new Array(); 
        try{
        
              if (Sys["Process"]("DL.CODE")["WaitWPFObject"]("HwndSource: JobListDialogWindow", "*", lib_const.const_delay_1000).Exists)
              {
                       //get jobList Name
                       var jobList =  Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "*").WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JobListBox");
                       var itemCount = jobList.wItemCount; 
                       var Vscroll = jobList.VScroll;
                       var max = Vscroll.Max;
                      // Vscroll.Pos = max;  
                       var itemCount = jobList.wItemCount;
   
                       var isInputNameExits = false;
                       for ( var k = 0; k <= max; k++)
                       {
                          // Log.Message("k:"+k);
                           Vscroll.Pos = k;
                           jobList.Refresh();
                           var itemPresenter =Sys.Process("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "Open Device Configuration").WPFObject("JobListDialogWindow", "Open Device Configuration", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("StackPanel", "", 1).WPFObject("JobListBox").WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1);
                           var childCount = itemPresenter.ChildCount;
                          
                           for (var j = 1 ; j <= childCount; j ++ )
                           {  
                                    var name =         jobList.WPFObject("Bd").WPFObject("ScrollViewer", "", 1).WPFObject("ItemsPresenter", "", 1).WPFObject("ListBoxItem", "", j).WPFObject("Border").WPFObject("ContentPresenter", "", 1).WPFObject("Grid", "", 1).WPFObject("TextBlock", "*", 1).WPFControlText;
                                     if (lib_validate.isExistedInArray(name, array) === false)                                                 
                                          array.push(name);
                                 
                           } 
                       }
                       Sys["Process"]("DL.CODE").WPFObject("HwndSource: JobListDialogWindow", "*").WPFObject("JobListDialogWindow", "*", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("Button", "Cancel", 2).ClickButton();
              }         
        }
        catch(e)
        {
          Log.Message(lib_err.err_FUNC_EXCEPTION);
        }
        return array; 
}