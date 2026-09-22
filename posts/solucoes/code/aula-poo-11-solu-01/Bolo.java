import greenfoot.*;

public class Bolo extends Doce
{
    public Bolo()
    {
        GreenfootImage img = new GreenfootImage(20, 20);
        img.setColor(Color.PINK);
        img.fillOval(0, 0, 20, 20);
        setImage(img);
    }
}
