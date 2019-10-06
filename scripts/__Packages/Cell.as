class Cell extends MovieClip
{
   function Cell()
   {
      super();
      this.nclip = this.attachMovie("wall","northwall",0,{_x:20,_y:0});
      this.eclip = this.attachMovie("wall","eastwall",1,{_x:40,_y:20,_rotation:-90});
      this.sclip = this.attachMovie("wall","southwall",2,{_x:20,_y:40});
      this.wclip = this.attachMovie("wall","westwall",3,{_x:0,_y:20,_rotation:-90});
      this.resetcell();
   }
   function buildwall(wallname)
   {
      switch(wallname)
      {
         case "n":
            this.n = 1;
            break;
         case "e":
            this.e = 1;
            break;
         case "s":
            this.s = 1;
            break;
         case "w":
            this.w = 1;
      }
   }
   function breakwall(wallname)
   {
      switch(wallname)
      {
         case "n":
            this.n = 0;
            this.hidewall("n");
            break;
         case "e":
            this.e = 0;
            this.hidewall("e");
            break;
         case "s":
            this.s = 0;
            this.hidewall("s");
            break;
         case "w":
            this.w = 0;
            this.hidewall("w");
      }
   }
   function showwall(wallname)
   {
      switch(wallname)
      {
         case "n":
            this.nclip._visible = true;
            this.nclip._alpha = 100;
            break;
         case "e":
            this.eclip._visible = true;
            this.eclip._alpha = 100;
            break;
         case "s":
            this.sclip._visible = true;
            this.sclip._alpha = 100;
            break;
         case "w":
            this.wclip._visible = true;
            this.wclip._alpha = 100;
      }
   }
   function ghostwall(wallname)
   {
      switch(wallname)
      {
         case "n":
            this.nclip._visible = true;
            this.nclip._alpha = 10;
            break;
         case "e":
            this.eclip._visible = true;
            this.eclip._alpha = 10;
            break;
         case "s":
            this.sclip._visible = true;
            this.sclip._alpha = 10;
            break;
         case "w":
            this.wclip._visible = true;
            this.wclip._alpha = 10;
      }
   }
   function hidewall(wallname)
   {
      switch(wallname)
      {
         case "n":
            this.nclip._visible = false;
            break;
         case "e":
            this.eclip._visible = false;
            break;
         case "s":
            this.sclip._visible = false;
            break;
         case "w":
            this.wclip._visible = false;
      }
   }
   function see()
   {
      this.seen = true;
   }
   function resetcell()
   {
      this.buildwall("n");
      this.hidewall("n");
      this.buildwall("e");
      this.hidewall("e");
      this.buildwall("s");
      this.hidewall("s");
      this.buildwall("w");
      this.hidewall("w");
      this.seen = false;
      this.debugtxt.text = "";
   }
   function toString()
   {
      var _loc2_ = "id" + this.row.toString() + this.col.toString() + " n" + this.n + " e" + this.e + " s" + this.s + " w" + this.w + " seen" + this.seen;
      return _loc2_;
   }
}
