var NotOverlapWindow = true;
function OnOverlappingWindow_OnOverlappingWindow(Sender, Window, OverlappingWindow, LogParams)
{
//  if(NotOverlapWindow)
//  {
//    return;
//  }
//  else
//  {
//    Runner.Stop(true);
//    return;
//  }
   Log.Message("the message from event handler");
}

function OnOverlappingWindow_OnUnexpectedWindow(Sender, Window, LogParams)
{
  Log.Message("the message from event handler");
}