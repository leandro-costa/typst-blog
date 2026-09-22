public void act(){
  move(4);
  if (Greenfoot.isKeyDown("left")){
    turn(-3);
  }
  if (Greenfoot.isKeyDown("right")){
    turn(3);
  }
}
