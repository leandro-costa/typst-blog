public void act(){
  moveAndTurn();
  eat();
}
public void moveAndTurn(){
  move(4);
  if (Greenfoot.isKeyDown("left")){
    turn(-3);
  }
  if (Greenfoot.isKeyDown("right")){
    turn(3);
  }
}
public void eat(){
  if (isTouching(Worm.class)) {
      removeTouching(Worm.class);
  }
}
