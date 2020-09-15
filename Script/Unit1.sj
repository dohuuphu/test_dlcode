function a(){
var p, w;
p = Sys.Process("notepad");
w = p.Window("Notepad", "Untitled - Notepad", 0);
w = w.Window("Edit", "", 0);
w.Drag(30, 40, 50, 0);
}