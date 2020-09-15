//USEUNIT string
var DLCode = Sys.Process("DL.CODE").WPFObject("HwndSource: Shell", "DL.CODE 1.9.0.60");
var Dataformat = DLCode.WPFObject("Shell", "DL.CODE 1.9.0.60", 1).WPFObject("Border", "", 1).WPFObject("DockPanel", "", 1).WPFObject("Grid", "", 2).WPFObject("ContentPlaceholder").WPFObject("UserControl").WPFObject("LayoutRoot").WPFObject("Border", "", 3).WPFObject("Grid", "", 1).WPFObject("TabControl", "", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("PropertiesPresenter").WPFObject("UserControl").WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1);
  
function Message(stt)
{
  if (stt == "Success"){
//************ Find Separator *********
    var Separator_PropArr = ["WPFControlName", "Visible"];
    var Separator_ValArr = ["CollectionSeparatorParamControl" , true ];
    var Separator = Dataformat.FindChild(Separator_PropArr, Separator_ValArr, 2000); 
    // Find Separetor box
    var SeparatorBox_PropArr = ["WPFControlName", "Visible"];
    var SeparatorBox_ValArr = ["rtbText" , true ];
    var label = Separator.FindChild(SeparatorBox_PropArr, SeparatorBox_ValArr, 2000);
  
    if(label.Exists == true){
          Log.Message("fill Separator");
          label.DblClick();
          label.Keys(Separato_Str);
    }
    else
        Log.Message("Can't find Saparator box!!!");
  }
      
//************ Find Custom Field *********
  var CustomField = Dataformat.WPFObject("ItemsControl", "", 1).FindChild("Name","WPFObject(\"ContentPresenter\", \"\", 1)",2000); 
  var CustomStringbox = CustomField.FindChild("WPFControlName","rtbText", 2000);  // find CustomString box
  if(CustomStringbox.Exists == true){
     Log.Message("Fill CustomString");
     CustomStringbox.DblClick();
     if (stt == "Success") CustomStringbox.Keys(CustomStringbox_Str);
     if (stt == "Failure") CustomStringbox.Keys(CustomStringbox_Fail_Str);
  }
  else
      Log.Message("Can't find CustomString box");

//************ Find Filling Mode *********    
  var FillingMode_PropArr = ["Name", "ChildCount"];
  var FillingMode_ValArr = ["WPFObject(\"ComboBox\", \"\", 1)" , "1" ];    
  var FillingMode = CustomField.FindChild(FillingMode_PropArr,FillingMode_ValArr,2000);
  if(FillingMode.Exists == true){
    Log.Message("Filling mode is changing...");
    FillingMode.ClickItem(1); // change to Fixed length
    
  }
  else
      Log.Message("Can't change to Fixed length");
 
//************ Find Filling Pattern *********
  var FillingPartern = CustomField.FindChild("Name","WPFObject(\"StackPanel\", \"\", 1)",2);
  var FillingParternbox_PropArr = ["WPFControlName", "Visible"];
  var FillingParternbox_ValArr = ["rtbText" , true ];
  var FillingParternbox = FillingPartern.FindChild(FillingParternbox_PropArr, FillingParternbox_ValArr, 2000);
  if(FillingPartern.Exists == true){
    Log.Message("Filling pattern");
    FillingParternbox.DblClick();
    FillingParternbox.Keys(FillingParternbox_Str);
    }
  else
    Log.Message("Can't find FillingPartern Box");
    
    
//************ Find Field Justification *********
  if (stt == "Success"){
    var FieldJustification = CustomField.FindChild("Name","WPFObject(\"ParamControl\", \"\", 4)",200);
    var FieldJustificationbox = FieldJustification.FindChild("Name","WPFObject(\"ComboBox\", \"\", 1)",200);
    if(FieldJustificationbox.Exists == true){
      Log.Message("Field Justificationbox is changing...");
      FieldJustificationbox.ClickItem(1); // change to Right Aligned
    
    }
    else
        Log.Message("Can't change to Right Aligned");
  }
      
}
// *********************** Sellect Mode *****************************
function Sellect_Mode(tool){
  var ControlToolBar = DLCode.FindChild("WPFControlName","controlToolBar",200);
  var CodeRelatedTool = ControlToolBar.FindChild("Name","WPFObject(\"ListBoxItem\", \"\", 1)",200);
  var CodeQualityTool = ControlToolBar.FindChild("Name","WPFObject(\"ListBoxItem\", \"\", 4)",200);
  var GlobalStatisticsTool = ControlToolBar.FindChild("Name","WPFObject(\"ListBoxItem\", \"\", 5)",200);
  var GlobalReadingTool = ControlToolBar.FindChild("Name","WPFObject(\"ListBoxItem\", \"\", 6)",200);
  var CustomFieldTool = ControlToolBar.FindChild("Name","WPFObject(\"ListBoxItem\", \"\", 7)",200);
  var DiagnosticsTool = ControlToolBar.FindChild("Name","WPFObject(\"ListBoxItem\", \"\", 8)",200);
  if(tool == "CodeRelatedTool") CodeRelatedTool.Click();
  if(tool == "CodeQuality") CodeQualityTool.Click();
  if(tool == "GlobalStatisticsTool") GlobalStatisticsTool.Click();
  if(tool == "GlobalReadingTool") GlobalReadingTool.Click();
  if(tool == "CustomFieldTool") CustomFieldTool.Click();
  if(tool == "DiagnosticsTool") DiagnosticsTool.Click();
}

function Click_Mess2(){
  var OutputMessage = DLCode.FindChild("WPFControlName","AbstractTaskTreeControl",200);
  var Message2 = OutputMessage.WPFObject("TreeViewItem", "", 4).WPFObject("TreeViewItem", "", 2).WPFObject("TreeViewItem", "", 2);
  Message2.Click();
  
}

//*********************** Field Edit Control *****************************
function initialization_FieldEditControl_Var(act_place){
  var FieldEditControl = DLCode.FindChild("WPFControlName","FieldEditingControl",200);
  var Edit = [FieldEditControl.WPFObject("ListBoxItem", "", 1),
              FieldEditControl.WPFObject("ListBoxItem", "", 2),
              FieldEditControl.WPFObject("ListBoxItem", "", 3),
              FieldEditControl.WPFObject("ListBoxItem", "", 4)];
  return Edit[act_place-1];

}
            
function DragEdit(act_place, new_place){
  var Edit_Drag = initialization_FieldEditControl_Var(act_place);
  var Heightbox = aqObject.GetPropertyValue(Edit_Drag,"Height");
  var Widthbox = aqObject.GetPropertyValue(Edit_Drag,"Width");
  var Centerbox = [Heightbox/2, Widthbox/2];
  Log.Message(Centerbox[0]);
  Log.Message(Centerbox[1]);
  var step = act_place - new_place;
  if(act_place >= new_place) 
  {Edit_Drag.Drag(Centerbox[0],Centerbox[1],-(step*Widthbox),0);
   Log.Message("forward");}                                                             
  if(act_place < new_place) 
  {Edit_Drag.Drag(Centerbox[0],Centerbox[1],-((step-1)*Widthbox),0);
  Log.Message("backward");}
}

function clickEdittool(place){
  Edit[place-1].Click();
}

function test(){
  var CustomField = Dataformat.WPFObject("ItemsControl", "", 1).FindChild("Name","WPFObject(\"ContentPresenter\", \"\", 1)",2000); 
  var FillingMode_PropArr = ["Name", "ChildCount"];
  var FillingMode_ValArr = ["WPFObject(\"ComboBox\", \"\", 1)" , "1" ];    
  var FillingMode = CustomField.FindChild(FillingMode_PropArr,FillingMode_ValArr,2000);
  if(FillingMode.Exists == true){
    Log.Message("Filling mode is changing...");
    FillingMode.ClickItem(1); // change to Fixed length
    
  }
  else
      Log.Message("Can't change to Fixed length");
}
