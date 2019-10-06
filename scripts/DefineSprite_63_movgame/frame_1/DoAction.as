function randRange(min, max)
{
   var _loc1_ = Math.floor(Math.random() * (max - min + 1)) + min;
   return _loc1_;
}
function shuffle(a)
{
   var _loc3_ = undefined;
   var _loc2_ = undefined;
   i = 0;
   while(i < a.length)
   {
      _loc2_ = randRange(0,a.length - 1);
      _loc3_ = a[i];
      a[i] = a[_loc2_];
      a[_loc2_] = _loc3_;
      i++;
   }
}
function manhattandist(r1, c1, r2, c2)
{
   return Math.abs(r1 - r2) + Math.abs(c1 - c2);
}
function buildboard()
{
   row = 0;
   while(row <= 7)
   {
      col = 0;
      while(col <= 7)
      {
         var _loc2_ = row * 8 + col;
         sqref = this.attachMovie("square","sq" + row + col,_loc2_,{_x:40 + col * 40,_y:40 + row * 40,row:row,col:col});
         sqref.onRelease = clickcell;
         sqref.attachMovie("flagstone","flag" + row + col,sqref.getNextHighestDepth(),{_x:20,_y:20,_rotation:quadrants[(row + col) % 4]});
         boardarr[row][col] = sqref;
         col++;
      }
      row++;
   }
   this.attachMovie("base","baseclip",this.getNextHighestDepth());
   this.attachMovie("dude","dudeclip",this.getNextHighestDepth());
   this.attachMovie("treasure","treasureclip",this.getNextHighestDepth());
   this.attachMovie("ghost","ghostclip",this.getNextHighestDepth());
}
function resetmaze()
{
   wallcount = 112;
   row = 0;
   while(row <= 7)
   {
      col = 0;
      while(col <= 7)
      {
         if(boardarr[row][col].treasureroom != undefined)
         {
            boardarr[row][col].treasureroom.removeMovieClip();
         }
         boardarr[row][col].resetcell();
         col++;
      }
      row++;
   }
}
function carvestep()
{
   resetmaze();
   startrow = randRange(0,7);
   startcol = randRange(0,7);
   boardarr[startrow][startcol].see();
   carved.push([startrow,startcol]);
   var _loc3_ = [];
   var _loc1_ = undefined;
   var _loc2_ = undefined;
   while(carved.length > 0)
   {
      var _loc4_ = undefined;
      _loc4_ = randRange(0,carved.length - 1);
      _loc1_ = carved[_loc4_][0];
      _loc2_ = carved[_loc4_][1];
      _loc3_ = [];
      if(_loc1_ > 0 and boardarr[_loc1_ - 1][_loc2_].seen == false)
      {
         _loc3_.push("n");
      }
      if(_loc1_ < 7 and boardarr[_loc1_ + 1][_loc2_].seen == false)
      {
         _loc3_.push("s");
      }
      if(_loc2_ > 0 and boardarr[_loc1_][_loc2_ - 1].seen == false)
      {
         _loc3_.push("w");
      }
      if(_loc2_ < 7 and boardarr[_loc1_][_loc2_ + 1].seen == false)
      {
         _loc3_.push("e");
      }
      if(_loc3_.length == 0)
      {
         carved.splice(_loc4_,1);
      }
      else
      {
         shuffle(_loc3_);
         switch(_loc3_[0])
         {
            case "n":
               boardarr[_loc1_][_loc2_].breakwall("n");
               boardarr[_loc1_ - 1][_loc2_].breakwall("s");
               boardarr[_loc1_ - 1][_loc2_].see();
               carved.push([_loc1_ - 1,_loc2_]);
               break;
            case "e":
               boardarr[_loc1_][_loc2_].breakwall("e");
               boardarr[_loc1_][_loc2_ + 1].breakwall("w");
               boardarr[_loc1_][_loc2_ + 1].see();
               carved.push([_loc1_,_loc2_ + 1]);
               break;
            case "s":
               boardarr[_loc1_][_loc2_].breakwall("s");
               boardarr[_loc1_ + 1][_loc2_].breakwall("n");
               boardarr[_loc1_ + 1][_loc2_].see();
               carved.push([_loc1_ + 1,_loc2_]);
               break;
            case "w":
               boardarr[_loc1_][_loc2_].breakwall("w");
               boardarr[_loc1_][_loc2_ - 1].breakwall("e");
               boardarr[_loc1_][_loc2_ - 1].see();
               carved.push([_loc1_,_loc2_ - 1]);
         }
         wallcount--;
      }
   }
   i = 0;
   while(i <= 14)
   {
      viable = 0;
      do
      {
         _loc1_ = randRange(0,7);
         _loc2_ = randRange(0,7);
         side = sides[randRange(0,3)];
         if(_loc1_ == 0 and side == "n" or _loc1_ == 7 and side == "s" or _loc2_ == 0 and side == "w" or _loc2_ == 7 and side == "e")
         {
            viable = 0;
         }
         else if(side == "n" and boardarr[_loc1_][_loc2_].n == 0 or side == "e" and boardarr[_loc1_][_loc2_].e == 0 or side == "s" and boardarr[_loc1_][_loc2_].s == 0 or side == "w" and boardarr[_loc1_][_loc2_].w == 0)
         {
            viable = 0;
         }
         else
         {
            viable = 1;
         }
      }
      while(viable == 0);
      
      switch(side)
      {
         case "n":
            boardarr[_loc1_][_loc2_].breakwall("n");
            boardarr[_loc1_ - 1][_loc2_].breakwall("s");
            break;
         case "e":
            boardarr[_loc1_][_loc2_].breakwall("e");
            boardarr[_loc1_][_loc2_ + 1].breakwall("w");
            break;
         case "s":
            boardarr[_loc1_][_loc2_].breakwall("s");
            boardarr[_loc1_ + 1][_loc2_].breakwall("n");
            break;
         case "w":
            boardarr[_loc1_][_loc2_].breakwall("w");
            boardarr[_loc1_][_loc2_ - 1].breakwall("e");
      }
      wallcount--;
      i++;
   }
   initialize();
}
function taketurn(ref)
{
   rowdelta = ref.row - playerrow;
   coldelta = ref.col - playercol;
   if(baserow < 0)
   {
      baserow = ref.row;
      playerrow = ref.row;
      basecol = ref.col;
      playercol = ref.col;
      dudeclip._x = ref._x;
      dudeclip._y = ref._y;
      dudeclip._visible = true;
      baseclip._x = ref._x;
      baseclip._y = ref._y;
      baseclip._visible = true;
      do
      {
         treasurerow = randRange(0,7);
         treasurecol = randRange(0,7);
      }
      while(manhattandist(playerrow,playercol,treasurerow,treasurecol) < 6);
      
      soundqueue.push("tik");
   }
   else if(endingturn == true or Math.abs(rowdelta) == 1 and Math.abs(coldelta) == 0 or Math.abs(rowdelta) == 0 and Math.abs(coldelta) == 1)
   {
      if(rowdelta == -1 and boardarr[ref.row][ref.col].s == 1)
      {
         boardarr[ref.row][ref.col].showwall("s");
         boardarr[ref.row + 1][ref.col].showwall("n");
         usedsteps = maxsteps;
         soundqueue.push("hitawall");
      }
      else if(rowdelta == 1 and boardarr[ref.row][ref.col].n == 1)
      {
         boardarr[ref.row][ref.col].showwall("n");
         boardarr[ref.row - 1][ref.col].showwall("s");
         usedsteps = maxsteps;
         soundqueue.push("hitawall");
      }
      else if(coldelta == -1 and boardarr[ref.row][ref.col].e == 1)
      {
         boardarr[ref.row][ref.col].showwall("e");
         boardarr[ref.row][ref.col + 1].showwall("w");
         usedsteps = maxsteps;
         soundqueue.push("hitawall");
      }
      else if(coldelta == 1 and boardarr[ref.row][ref.col].w == 1)
      {
         boardarr[ref.row][ref.col].showwall("w");
         boardarr[ref.row][ref.col - 1].showwall("e");
         usedsteps = maxsteps;
         soundqueue.push("hitawall");
      }
      else
      {
         playerrow = ref.row;
         playercol = ref.col;
         usedsteps = usedsteps + 1;
         soundqueue.push("tik");
         if(dragonrow < 0 and manhattandist(playerrow,playercol,treasurerow,treasurecol) <= 3)
         {
            dragonrow = treasurerow;
            dragoncol = treasurecol;
            soundqueue.push("ghostawakes");
         }
         if(playerrow == treasurerow and playercol == treasurecol)
         {
            if(carrying == false)
            {
               soundqueue.push("foundtreasure");
               carrying = true;
               maxsteps = 4;
               usedsteps = 4;
               if(ref.treasureroom == undefined)
               {
                  ref.attachMovie("treasure","treasureroom",20,{_x:0,_y:0});
                  ref.treasureroom._alpha = 30;
               }
            }
         }
         if(playerrow == dragonrow and playercol == dragoncol and (playerrow != baserow or playercol != basecol))
         {
            lives = lives - 1;
            playerrow = baserow;
            playercol = basecol;
            maxsteps = maxsteplist[lives];
            usedsteps = 0;
            carrying = false;
            soundqueue.push("ghostattacks");
         }
         if(carrying == true and playerrow == baserow and playercol == basecol)
         {
            lives = 0;
            soundqueue.push("youwin");
         }
      }
      if(usedsteps == maxsteps or endingturn == true)
      {
         if(dragonrow >= 0 and lives > 0)
         {
            if(playerrow == baserow and playercol == basecol)
            {
               if(dragonrow != treasurerow or dragoncol != treasurecol)
               {
                  soundqueue.push("ghostmoves");
               }
               if(dragonrow < treasurerow)
               {
                  dragonrow++;
               }
               if(dragonrow > treasurerow)
               {
                  dragonrow--;
               }
               if(dragoncol < treasurecol)
               {
                  dragoncol++;
               }
               if(dragoncol > treasurecol)
               {
                  dragoncol--;
               }
            }
            else
            {
               if(dragonrow != playerrow or dragoncol != playercol)
               {
                  soundqueue.push("ghostmoves");
               }
               if(dragonrow < playerrow)
               {
                  dragonrow++;
               }
               if(dragonrow > playerrow)
               {
                  dragonrow--;
               }
               if(dragoncol < playercol)
               {
                  dragoncol++;
               }
               if(dragoncol > playercol)
               {
                  dragoncol--;
               }
            }
            if(dragonrow == playerrow and dragoncol == playercol)
            {
               if(!(playerrow == baserow and playercol == basecol))
               {
                  if(carrying == true and !(playerrow == treasurerow and playercol == treasurecol))
                  {
                     lives = 0;
                     soundqueue.push("ghostattacks");
                  }
                  else
                  {
                     lives = lives - 1;
                     playerrow = baserow;
                     playercol = basecol;
                     maxsteps = maxsteplist[lives];
                     carrying = false;
                     soundqueue.push("ghostattacks");
                  }
               }
            }
         }
         usedsteps = 0;
         endingturn = false;
      }
      if(lives == 0)
      {
         soundqueue.push("gameover");
      }
   }
   else
   {
      soundqueue.push("no");
   }
   printsteps();
}
function printsteps()
{
   if(soundqueue.length > 0)
   {
      soundplaying = true;
      var _loc1_ = soundqueue[0];
      soundqueue.shift();
      beep.attachSound(soundprefix + _loc1_ + ".wav");
      beep.onSoundComplete = printsteps;
      beep.start();
      bub.bubbletxt.text = soundcaptions[_loc1_];
      bub._visible = true;
      bub.gotoAndPlay(1);
   }
   else
   {
      soundplaying = false;
      bub._visible = false;
   }
   dudecountdown.gotoAndStop(lives + 1);
   stepcountdown.gotoAndStop(maxstepframes[maxsteps] - usedsteps);
   dudeclip._x = playercol * 40 + 40;
   dudeclip._y = playerrow * 40 + 40;
   treasureclip._x = dudeclip._x + 16;
   treasureclip._y = dudeclip._y - 22;
   if(carrying)
   {
      treasureclip._visible = true;
   }
   else
   {
      treasureclip._visible = false;
   }
}
function initialize()
{
   playerrow = -1;
   playercol = -1;
   baserow = -1;
   basecol = -1;
   treasurerow = -1;
   treasurecol = -1;
   dragonrow = -1;
   dragoncol = -1;
   ghostrow = -1;
   ghostcol = -1;
   baseclip._visible = false;
   dudeclip._visible = false;
   treasureclip._visible = false;
   ghostclip._x = 400;
   ghostclip._y = 215;
   lives = 3;
   usedsteps = 0;
   maxsteps = 8;
   carrying = false;
   endingturn = false;
   dudecountdown.gotoAndStop(1);
   bub._visible = false;
}
function clickcell()
{
   if(soundplaying == false)
   {
      if(lives > 0)
      {
         taketurn(this);
      }
   }
}
stop();
var beep = new Sound();
var quadrants = [0,90,180,270];
var maxsteplist = [0,4,6,8];
var maxstepframes = new Object();
maxstepframes[8] = 28;
maxstepframes[6] = 17;
maxstepframes[4] = 6;
maxstepframes[0] = 1;
var boardarr = [[],[],[],[],[],[],[],[]];
var carved = [];
var wallcount = 115;
var sides = ["n","e","s","w"];
var soundqueue = [];
var soundplaying = false;
var endingturn = false;
var soundprefix = "sayit-";
var soundcaptions = {tik:"Tick.",no:"No.",hitawall:"Ouch.",ghostmoves:"Ghost moves.",ghostawakes:"Ghost awakes!",ghostattacks:"Ghost attacks!",gameover:"Game over.",youwin:"You win!",foundtreasure:"Found treasure!"};
buildboard();
carvestep();
var playerrow;
var playercol;
var baserow;
var basecol;
var treasurerow;
var treasurecol;
var dragonrow;
var dragoncol;
var ghostrow;
var ghostcol;
var lives;
var usedsteps;
var maxsteps;
var carrying;
btnReset.debugtxt.text = "Reset";
btnReset.onRelease = carvestep;
btnExit.debugtxt.text = "Exit";
btnExit.onRelease = function()
{
   _parent.statemachine("menu");
};
btnEndturn.onRelease = function()
{
   if(soundplaying == false)
   {
      if(lives > 0 and baserow > -1 and basecol > -1)
      {
         endingturn = true;
         taketurn(boardarr[playerrow][playercol]);
      }
   }
};
voiceswitch.onRelease = function()
{
   if(soundprefix == "nat-")
   {
      soundprefix = "sayit-";
      voiceswitch.gotoAndStop(1);
   }
   else
   {
      soundprefix = "nat-";
      voiceswitch.gotoAndStop(2);
   }
};
var keyListener = new Object();
keyListener.onKeyDown = function()
{
   switch(Key.getCode())
   {
      case 32:
         if(soundplaying == false and lives > 0)
         {
            btnEndturn.onRelease();
         }
         break;
      case 8:
         if(soundplaying == false)
         {
            carvestep();
         }
         break;
      case 37:
         if(soundplaying == false and lives > 0 and playercol > 0)
         {
            taketurn(boardarr[playerrow][playercol - 1]);
         }
         break;
      case 38:
         if(soundplaying == false and lives > 0 and playerrow > 0)
         {
            taketurn(boardarr[playerrow - 1][playercol]);
         }
         break;
      case 39:
         if(soundplaying == false and lives > 0 and playercol < 7)
         {
            taketurn(boardarr[playerrow][playercol + 1]);
         }
         break;
      case 40:
         if(soundplaying == false and lives > 0 and playerrow < 7)
         {
            taketurn(boardarr[playerrow + 1][playercol]);
         }
         break;
      case 68:
         if(ghostcol != -1 && ghostcol < 8)
         {
            ghostclip._x = ghostclip._x + 40;
            ghostcol = ghostcol + 1;
         }
         break;
      case 65:
         if(ghostcol != -1 && ghostcol > 1)
         {
            ghostclip._x = ghostclip._x - 40;
            ghostcol = ghostcol - 1;
         }
         break;
      case 83:
         if(ghostrow != -1 && ghostrow < 8)
         {
            ghostclip._y = ghostclip._y + 40;
            ghostrow = ghostrow + 1;
         }
         break;
      case 87:
         if(ghostrow != -1 && ghostrow > 1)
         {
            ghostclip._y = ghostclip._y - 40;
            ghostrow = ghostrow - 1;
         }
   }
};
Key.addListener(keyListener);
ghostclip.onPress = function()
{
   this.startDrag();
};
ghostclip.onRelease = function()
{
   this.stopDrag();
   if(this._x > 20 and this._x < 340 and this._y > 20 and this._y < 340)
   {
      ghostcol = Math.floor((this._x + 20) / 40);
      this._x = ghostcol * 40;
      ghostrow = Math.floor((this._y + 20) / 40);
      this._y = ghostrow * 40;
   }
   else
   {
      this._x = 400;
      this._y = 215;
      ghostrow = -1;
      ghostcol = -1;
   }
};
