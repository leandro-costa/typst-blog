public void moveAndTurn(){
  move(4);
  if(Greenfoot.getRandomNumber(100) < 10){
    turn(Greenfoot.getRandomNumber(90)-45);
  }
}
