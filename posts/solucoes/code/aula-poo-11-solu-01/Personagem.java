import greenfoot.*;
public class Personagem extends Actor
{
    private int energia;
    public void act()
    {
        move(4);
        if(Greenfoot.isKeyDown("left")){
            turn(-3);
        }
        if(Greenfoot.isKeyDown("right")){
            turn(3);
        }
        if(isTouching(Comestivel.class)){
            Comestivel c = (Comestivel)getOneIntersectingObject(Comestivel.class);
            energia+= c.preparo();
            removeTouching(Comestivel.class);
            getWorld().showText(String.valueOf(energia), 50, 50);
        }
    }
}
