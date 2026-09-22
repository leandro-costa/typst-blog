public class Decapoda extends Actor
{
    private int quantidade = 0;
    private String keyLeft = "left";
    private String keyRight = "right";
    private int showTextX = 10;
    private int showTextY = 10;
    
    public Decapoda(String keyLeft, String keyRight, int showTextX , int showTextY ){
        this.keyLeft = keyLeft;
        this.keyRight = keyRight;
        this.showTextX = showTextX;
        this.showTextY = showTextY;
    }
    
    public void act(){
      moveAndTurn();
      eat();
    }
    public void moveAndTurn(){
      move(4);
      if (Greenfoot.isKeyDown(keyLeft)){
        turn(-3);
      }
      if (Greenfoot.isKeyDown(keyRight)){
        turn(3);
      }
    }
    public void eat(){

      if (isTouching(Worm.class)) {
        removeTouching(Worm.class);
        Greenfoot.playSound("eating.wav");
        quantidade++;
        getWorld().showText(String.valueOf(quantidade), showTextX, showTextY);
      }
    }       
}
