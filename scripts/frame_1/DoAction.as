function statemachine(currentstate)
{
   switch(currentstate)
   {
      case "menu":
         attachMovie("movMenu","attachedmov",1);
         break;
      case "game":
         attachMovie("movGame","attachedmov",1,{diff:difficulty});
         break;
      case "lose":
         attachMovie("movLose","attachedmov",1);
         break;
      case "win":
         attachMovie("movWin","attachedmov",1);
   }
}
stop();
difficulty = 0;
currentstate = "menu";
statemachine(currentstate);
