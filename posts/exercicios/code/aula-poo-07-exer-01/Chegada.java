import greenfoot.*;  // (World, Actor, GreenfootImage, Greenfoot and MouseInfo)

public class Chegada extends Actor
{
    public void act()
    {
        if(isTouching(Corredor.class)){
            Corredor c = (Corredor)getOneIntersectingObject(Corredor.class);
            getWorld().showText(c.getTipo() + " Ganhou", 100, 100);
            Greenfoot.stop();
        }
    }
}
