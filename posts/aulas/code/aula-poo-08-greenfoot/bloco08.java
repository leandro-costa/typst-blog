public void eat(){
  if (isTouching(Worm.class)) {
      removeTouching(Worm.class);
      Greenfoot.playSound("eating.wav");
  }  
}
