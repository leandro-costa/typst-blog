public void moveAndTurn(){
  move(4);
  if (Greenfoot.isKeyDown("q")){
    turn(-3);
  }
  if (Greenfoot.isKeyDown("w")){
    turn(3);
  }
}
