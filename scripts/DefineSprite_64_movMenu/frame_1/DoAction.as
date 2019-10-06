stop();
btnAbout.debugtxt.text = "About";
btnAbout.onRelease = function()
{
   _parent.attachMovie("movAbout","dialog",2,{_x:51,_y:84});
};
btnHelp.debugtxt.text = "Help";
btnHelp.onRelease = function()
{
   _parent.attachMovie("movInstructions","dialog",2,{_x:51,_y:34});
};
btnPlay.onRelease = function()
{
   _parent.statemachine("game");
};
